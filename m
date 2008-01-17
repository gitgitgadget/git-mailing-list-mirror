From: Charles Bailey <charles@hashpling.org>
Subject: Re: Be more careful about updating refs
Date: Thu, 17 Jan 2008 10:56:35 +0000
Message-ID: <20080117105635.GA12285@hashpling.org>
References: <alpine.LFD.1.00.0801151546560.2806@woody.linux-foundation.org> <alpine.LFD.1.00.0801151600140.2806@woody.linux-foundation.org> <7vodblpmyc.fsf@gitster.siamese.dyndns.org> <20080117091558.GA8341@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 11:57:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFSR7-0000wG-A7
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 11:57:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbYAQK5B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 05:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbYAQK5A
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 05:57:00 -0500
Received: from pih-relay06.plus.net ([212.159.14.133]:45021 "EHLO
	pih-relay06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbYAQK5A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 05:57:00 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay06.plus.net with esmtp (Exim) id 1JFSQI-0000Hg-R1; Thu, 17 Jan 2008 10:56:39 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m0HAuZ8S012721;
	Thu, 17 Jan 2008 10:56:35 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m0HAuZSu012720;
	Thu, 17 Jan 2008 10:56:35 GMT
Content-Disposition: inline
In-Reply-To: <20080117091558.GA8341@hashpling.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70845>

On Thu, Jan 17, 2008 at 09:15:58AM +0000, Charles Bailey wrote:
> 
> c3b0dec509fe136c5417422f31898b5a4e2d5e02 is first bad commit
> 
> I just thought I should warn you that this seems (git bisect tells me
> so) to have caused a failure in t9301-fast-export.sh on my Mac OS X
> 10.4.11 machine although I haven't yet had the time to investigate
> why.
> 

Further to this, the first problem is that the 'fast-export |
fast-import' test is failing.

As far as I can tell, fast-export is behaving no differently, the
generated export file looks identical in shape.  It seems that
fast-import is creating a bad temporary packfile for itself.

The error that I'm getting is:

fatal: unknown object type 0 in
.git/objects/pack/pack-6be2b92c2d7485fd5cefbb0d9a68827e4c23d548.pack
fast-import: dumping crash report to .git/fast_import_crash_12317

which seems to come from the unpack_entry function in sha1_file.c.

I haven't got much deeper into how the refs.c change has caused the
issue, or why on earth it seems to be a Mac only issue.
