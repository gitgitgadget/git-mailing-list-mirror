From: Holger Eitzenberger <holger@my-eitzenberger.de>
Subject: Re: git: problems in read-only trees
Date: Thu, 04 Aug 2005 22:38:36 +0200
Message-ID: <42F27CCC.5050103@my-eitzenberger.de>
References: <20050803074241.A2D1D3535F9@atlas.denx.de> <20050804201125.GB24479@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Wolfgang Denk <wd@denx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 22:44:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0mYP-0002RQ-4e
	for gcvg-git@gmane.org; Thu, 04 Aug 2005 22:43:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262675AbVHDUmV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 16:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbVHDUjo
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 16:39:44 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:54998 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262653AbVHDUih (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2005 16:38:37 -0400
Received: from p54A3A6FD.dip0.t-ipconnect.de [84.163.166.253] (helo=[192.168.11.11])
	by mrelayeu.kundenserver.de with ESMTP (Nemesis),
	id 0MKxQS-1E0mU73mXa-00050O; Thu, 04 Aug 2005 22:38:35 +0200
User-Agent: Debian Thunderbird 1.0.2 (X11/20050715)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050804201125.GB24479@pasky.ji.cz>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:8548cd0e00552bb75411ff34ad15700a
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:

>>-> cg-diff 
>>fatal: unable to create new cachefile
>>fatal: unable to create temp-file
>>
>>It would be nice if there was at least a way to specify  some  TMPDIR
>>instead of the current directory in such a situation.

> This is a bug in git-diff-* (producing the second error message; the first
> error message means failed git-update-cache --refresh but that isn't
> fatal). Any reason why prep_temp_blob() works in . instead of $TMPDIR?

I do not know about the first message (cachefile), but the 2nd one is 
trivial to fix.  I implemented a function called git_mkstemp() (path.c 
and so in libgit) which places the tmpfiles in $TMPDIR and if it's not 
set in /tmp.  The is close to what other programs do.

There are other references to mkstemp() in git where one or two of them 
may use git_mkstemp() instead, but not in sha1_file.c, since it 
hardlinks  it later on.

/holger
