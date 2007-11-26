From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [RFC/PATCH] Making ce_path_match() more useful by accepting
	globs
Date: Mon, 26 Nov 2007 20:56:59 +0100
Message-ID: <20071126195659.GC3675@steel.home>
References: <7vsl2ujc6x.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 20:57:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iwk56-0006LI-Rm
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 20:57:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754451AbXKZT5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 14:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754417AbXKZT5E
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 14:57:04 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:56604 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753947AbXKZT5B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 14:57:01 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBg79ik=
Received: from tigra.home (Fcbf4.f.strato-dslnet.de [195.4.203.244])
	by post.webmailer.de (mrclete mo32) (RZmta 14.3)
	with ESMTP id V0025fjAQFTrwW ; Mon, 26 Nov 2007 20:56:59 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id C661E277AE;
	Mon, 26 Nov 2007 20:56:59 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id A8AB256D22; Mon, 26 Nov 2007 20:56:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vsl2ujc6x.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66104>

Junio C Hamano, Sun, Nov 25, 2007 21:35:18 +0100:
> Currently, these do not work:
> 
>    git diff-files 't/*.sh'
>    git diff-index HEAD 'xdiff/*.c'
>    git update-index -g 'Documentation/howto/*.txt'
> 
> This is because ce_path_match(), the underlying function that is used to
> see if a cache entry matches the set of pathspecs, only understands
> leading directory match.
> 
> This teaches ce_path_match() to use the match_pathspec() used in
> git-ls-files, which knows about glob patterns.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  [SORRY FOR A RESEND -- I screwed up the To: field of the previous message]
> 
>  * Having two different behaviours of pathspec matching has been
>    bothering me for quite some time.  The changes here look trivially
>    correct and the result passes all the tests, but this is quite close
>    to the core part of the system, and would benefit greatly from extra
>    set of eyes.

How about doing the same what was done with recursive directory
walker (no, I'm not confusing pathname filters with paths)? Always
have the glob expansion for porcelain (git-diff, git-log, git-show),
and add a command-line option to activate for plumbing?

(Well, the oldtimers as yourself will probably find it hard to
separate git-diff-tree from git-diff).
