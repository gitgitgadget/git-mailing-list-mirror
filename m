From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH v2 18/31] rebase: extract merge code to new source file
Date: Thu, 24 Feb 2011 22:32:06 -0500 (EST)
Message-ID: <alpine.DEB.2.00.1102242229230.11894@debian>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com> <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com> <1297017841-20678-19-git-send-email-martin.von.zweigbergk@gmail.com> <4D58E17C.9090001@viscovery.net>
 <alpine.DEB.2.00.1102232216180.11038@debian> <20110224080734.GB25595@sigill.intra.peff.net> <20110224080904.GC25595@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 25 04:32:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsoPo-0005x0-1k
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 04:32:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755896Ab1BYDcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 22:32:17 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:61021 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755596Ab1BYDcO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 22:32:14 -0500
Received: by qyg14 with SMTP id 14so1156763qyg.19
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 19:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=8n34n3ZqIwDh0oYRf2ycXoxQvNU9r49XxGRjtxskk2w=;
        b=tYac6TZC63T8BOne+RxzZXeYTBjibVN6gsLQ760usQCGVp7RoAGH1hAouAgVBFlbq/
         +8nhuxaqrcbTiGJRnqIUK1tYbiTjOyUuMpP6Bn272jX5ucV0oBkoOh8K5WIQ8hovXWw4
         UAagIwolCZYhsNg6EbiIPvsCfPBdxFeaF3140=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=xR9ZHsDwLVonG7O4zLaN6zKVNcsRY5IEOqnftdpzRagKL4zgJPjZJ50ZOgQRUStQmJ
         azzm5iofVTitc+XVsFILjJrofNYMlXJYVg79eJU+pOpdClSPcXaHeg20dLj1jG6m7j1i
         XN8jUrIenc/e31eWyCaZo9S8cKwxGpKerk1wY=
Received: by 10.229.188.21 with SMTP id cy21mr1495063qcb.16.1298604733113;
        Thu, 24 Feb 2011 19:32:13 -0800 (PST)
Received: from [192.168.1.101] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id e29sm174542qck.27.2011.02.24.19.32.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 Feb 2011 19:32:11 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <20110224080904.GC25595@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167874>

On Thu, 24 Feb 2011, Jeff King wrote:

> On Thu, Feb 24, 2011 at 03:07:34AM -0500, Jeff King wrote:
> 
> > On Wed, Feb 23, 2011 at 10:27:23PM -0500, Martin von Zweigbergk wrote:
> > 
> > > > > +++ b/git-rebase--merge.sh
> > > > 
> > > > This should be mode 100755. (Ditto for git-rebase--am.sh in 19/31)
> > > 
> > > I was just about to fix now and I noticed that quite a few other
> > > script files are mode 100644. Should all be changed to mode 100755 or
> > > is there some kind of rule as to which mode they should be? Both
> > > git-sh-setup.sh and git-parse-remote.sh are also mode 100644 and I
> > > (think I) know that both are always sourced. If the rule is that
> > > sourced scripts should be mode 100644 (but I'm just guessing here),
> > > then I should actually have changed the mode of
> > > git-rebase--interactive.sh to that mode instead. Please advice.
> > 
> > Yes, sourced scripts should not have an executable bit. See 46bac90 for
> > rationale.
> 
> And I should have mentioned: they should go in SCRIPT_LIB in the
> Makefile, not SCRIPT_SH.

Thanks. The below should hopefully fix my mistakes.

-- 8< --
Subject: [PATCH] Makefile: do not install sourced rebase scripts

When git-rebase.sh recently started sourcing
git-rebase--interactive.sh instead of executing it, executable bit of
the latter file should have been turned off and it should have been
moved from SCRIPT_SH to SCRIPT_LIB in the Makefile. Its two new
siblings, git-rebase--am.sh and git-rebase--merge.sh (whose executable
bits are already off) should also be moved to SCRIPT_LIB in the
Makefile.

Reported-by: Johannes Sixt <j6t@kdbg.org>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
Applies on top of mz/rebase.

 Makefile                   |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)
 mode change 100755 => 100644 git-rebase--interactive.sh

diff --git a/Makefile b/Makefile
index b2501cc..e722b95 100644
--- a/Makefile
+++ b/Makefile
@@ -369,9 +369,6 @@ SCRIPT_SH += git-merge-resolve.sh
 SCRIPT_SH += git-mergetool.sh
 SCRIPT_SH += git-pull.sh
 SCRIPT_SH += git-quiltimport.sh
-SCRIPT_SH += git-rebase--am.sh
-SCRIPT_SH += git-rebase--interactive.sh
-SCRIPT_SH += git-rebase--merge.sh
 SCRIPT_SH += git-rebase.sh
 SCRIPT_SH += git-repack.sh
 SCRIPT_SH += git-request-pull.sh
@@ -382,6 +379,9 @@ SCRIPT_SH += git-web--browse.sh
 SCRIPT_LIB += git-mergetool--lib
 SCRIPT_LIB += git-parse-remote
 SCRIPT_LIB += git-sh-setup
+SCRIPT_LIB += git-rebase--am.sh
+SCRIPT_LIB += git-rebase--interactive.sh
+SCRIPT_LIB += git-rebase--merge.sh
 
 SCRIPT_PERL += git-add--interactive.perl
 SCRIPT_PERL += git-difftool.perl
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
old mode 100755
new mode 100644
-- 
1.7.4.1.79.gba571.dirty
