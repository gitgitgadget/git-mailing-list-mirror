From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: .git/info/refs
Date: Thu, 25 Jan 2007 09:13:53 -0800
Message-ID: <45B8E551.9020808@zytor.com>
References: <45B70D06.3050506@zytor.com> <ep78r0$h2u$1@sea.gmane.org> <45B7818F.6020805@zytor.com> <Pine.LNX.4.63.0701241658490.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45B78836.5080508@zytor.com> <Pine.LNX.4.63.0701241731400.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45B78C55.2030204@zytor.com> <ep83m2$mts$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 25 18:14:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HA8Al-00058c-VQ
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 18:14:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030457AbXAYROA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 12:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030460AbXAYROA
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 12:14:00 -0500
Received: from terminus.zytor.com ([192.83.249.54]:33040 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030457AbXAYRN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 12:13:59 -0500
Received: from [172.27.0.16] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id l0PHDrTo010966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 25 Jan 2007 09:13:54 -0800
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
In-Reply-To: <ep83m2$mts$1@sea.gmane.org>
X-Virus-Scanned: ClamAV 0.88.7/2489/Thu Jan 25 04:35:24 2007 on terminus.zytor.com
X-Virus-Status: Clean
X-Spam-Status: No, score=0.6 required=5.0 tests=AWL,BAYES_00,
	DATE_IN_FUTURE_96_XX,RCVD_IN_SORBS_DUL autolearn=no version=3.1.7
X-Spam-Checker-Version: SpamAssassin 3.1.7 (2006-10-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37743>

Jakub Narebski wrote:
> 
> I don't think it can be easily expanded. .git/info/refs is meant for
> http-fetch, and it mimics git-ls-remote / git-peek-remote output.

For heaven's sake, in computer science we can *NEVER* use the same 
feature for *MORE THAN ONE THING*.  If it doesn't work format-wise 
that's fine, but "it's only supposed to be used by dumb transports" is 
ridiculous.

> BTW. putting the info of git-for-each-ref into .git/info/refs-details
> would mean that instead of "24175 calls to git" one would need to
> read 24175 files. Perhaps the whole info needed to generate projects
> index page should be pre-generated on push (update), instead of per
> project (per repository) .git/info/refs-details

No, it should be one file per repository, not one file per ref.  Why? 
Obviously we don't want 24175 files to be accessed.  However, a push can 
only affect files for which the repository owner has permission and 
which resides in the repository filespace, so it should stay inside that 
  space.

On kernel.org, this would reduce the load from 24175 calls to git to 
reading 250 files.  Although the latter is still expensive (and will 
probably need post-generation caching) the files should be small and 
cacheable by the kernel, and the resulting I/O load should be quite small.

Anyway, as far as git-update-server-index is concerned, I'm *very* 
concerned that there be a single command that updates all the cached 
information across the repository.  Telling everyone to update their 
hooks every time we want to add cached information is silly.  Right now, 
git-update-server-index is the command to update cached information, and 
for usability reasons there should be a single entry point.

	-hpa
