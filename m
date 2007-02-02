From: Eric Wong <normalperson@yhbt.net>
Subject: Re: precise keyword matching for pretty switch
Date: Fri, 2 Feb 2007 05:17:53 -0800
Message-ID: <20070202131752.GA32248@localdomain>
References: <20070201224339.GA29666@hermes.lan.home.vilz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Nicolas Vilz <niv@iaglans.de>
X-From: git-owner@vger.kernel.org Fri Feb 02 14:18:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCyIg-0003wB-FY
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 14:17:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423026AbXBBNRz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 08:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423045AbXBBNRz
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 08:17:55 -0500
Received: from hand.yhbt.net ([66.150.188.102]:50051 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423026AbXBBNRz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 08:17:55 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 53EFB7DC094;
	Fri,  2 Feb 2007 05:17:53 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 02 Feb 2007 05:17:53 -0800
Content-Disposition: inline
In-Reply-To: <20070201224339.GA29666@hermes.lan.home.vilz.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38496>

Nicolas Vilz <niv@iaglans.de> wrote:
> hi,
> 
> i noticed today, that the pretty-switch in git-log -diff and many other
> tools triggers to "oneline" if you just type an "o" after --pretty=
> 
> so, not only 
> 
> git log --pretty=oneline
> 
> but also
> 
> git log --pretty=online
> git log --pretty=offline
> git log --pretty=omfg

Oops, that's unexpected.

> and finally (just to make it short *G*)
> 
> git log --pretty=osolomio
> 
> does trigger the oneline-feature. Perhaps this is not intended to work
> as it works now. I would recommend, that the switch should only accept
> the fully matched keyword and not just a lowercase "o" as the first
> letter of the keywords following after --pretty=, just to prevent people 
> getting bad habbits.

No.  The abbreviations are intentional.  It's anything but a bad habit.

--pretty=o
--pretty=on
--pretty=one
--pretty=onel
--pretty=oneli
--pretty=onelin
--pretty=oneline

are all valid abbreviations. I'm a lazy git :)

I also intend to resurrect gitopt in some form in the near future...

From: Eric Wong <normalperson@yhbt.net>
Date: Fri, 2 Feb 2007 05:10:25 -0800
Subject: [PATCH] Disallow invalid --pretty= abbreviations

--pretty=o is a valid abbreviation, --pretty=omfg is not

Noticed by: Nicolas Vilz
Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 commit.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/commit.c b/commit.c
index 9b2b842..3e8c872 100644
--- a/commit.c
+++ b/commit.c
@@ -47,7 +47,8 @@ enum cmit_fmt get_commit_format(const char *arg)
 	if (*arg == '=')
 		arg++;
 	for (i = 0; i < ARRAY_SIZE(cmt_fmts); i++) {
-		if (!strncmp(arg, cmt_fmts[i].n, cmt_fmts[i].cmp_len))
+		if (!strncmp(arg, cmt_fmts[i].n, cmt_fmts[i].cmp_len) &&
+		    !strncmp(arg, cmt_fmts[i].n, strlen(arg)))
 			return cmt_fmts[i].v;
 	}
 
-- 
Eric Wong
