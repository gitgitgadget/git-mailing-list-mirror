From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/6] reflog: remove i18n legos in pruning message
Date: Thu, 31 May 2012 15:31:02 -0500
Message-ID: <20120531203102.GA27332@burratino>
References: <1338463242-10618-1-git-send-email-worldhello.net@gmail.com>
 <1338469482-30936-1-git-send-email-pclouds@gmail.com>
 <1338469482-30936-3-git-send-email-pclouds@gmail.com>
 <20120531134538.GA10523@burratino>
 <7vlik86xqd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 31 22:31:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaC2C-0007Py-En
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 22:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758470Ab2EaUbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 16:31:39 -0400
Received: from mail-gh0-f180.google.com ([209.85.160.180]:44063 "EHLO
	mail-gh0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758453Ab2EaUbR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 16:31:17 -0400
Received: by mail-gh0-f180.google.com with SMTP id z12so1385326ghb.11
        for <git@vger.kernel.org>; Thu, 31 May 2012 13:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=UHJZW7x3M8KzMB5KTo0rLw/fiJjjq14elS4pn6clLFY=;
        b=dril52RC5X73nDJ+FJfiR1hV3yvxcJomRbfCF9p+MmbWsF7b2dUja1e2+h9U1GI1LZ
         vKe+DZFGVFkR97skALViPcXvwRUL9yVVTf0D2Nbhz1QrFBaq4gPNwWJ8CQIBXYnd4djd
         uXgMWVR1VAJ0MB9AUB5pC7xZD8nIc4lyTRKTC7zqFGF/ga8WaNcERYMo3JKMK8fj0HlC
         XhgsNT+HXCNASk8gXgmCCrKa02M2+pqd0OKukZ87AZUpszwpylOY4V2TnqM368PmGfat
         0Rhinud282Xmjqnq88kwxOL8xQhRqS9P/AkflwcVZd6iNbAwogmEkhZkpphhNO4WiNnf
         ZGQg==
Received: by 10.50.42.196 with SMTP id q4mr15392950igl.28.1338496276671;
        Thu, 31 May 2012 13:31:16 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id yg9sm2287554igb.15.2012.05.31.13.31.14
        (version=SSLv3 cipher=OTHER);
        Thu, 31 May 2012 13:31:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vlik86xqd.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198945>

Junio C Hamano wrote:

> These are for human consumption; they used to go to standard error
> stream back when it was written at 4264dc1 (git reflog expire,
> 2006-12-19).

Good.  Thanks for clarifying and for looking that up.

Why was this changed to write to standard output in 1389d9dd (reflog
expire --fix-stale, 2007-01-06)?  Would changing it back some time
to follow the usual "progress and diagnostics go to stderr" pattern
be worthwhile?
---
 builtin/reflog.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git i/builtin/reflog.c w/builtin/reflog.c
index 062d7dad..90e820a0 100644
--- i/builtin/reflog.c
+++ w/builtin/reflog.c
@@ -327,11 +327,11 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 		hashcpy(cb->last_kept_sha1, nsha1);
 	}
 	if (cb->cmd->verbose)
-		printf("keep %s", message);
+		fprintf(stderr, "keep %s", message);
 	return 0;
  prune:
 	if (!cb->newlog || cb->cmd->verbose)
-		printf("%sprune %s", cb->newlog ? "" : "would ", message);
+		fprintf(stderr, "%sprune %s", cb->newlog ? "" : "would ", message);
 	return 0;
 }
 
@@ -646,10 +646,10 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	if (cb.stalefix) {
 		init_revisions(&cb.revs, prefix);
 		if (cb.verbose)
-			printf("Marking reachable objects...");
+			fprintf(stderr, "Marking reachable objects...");
 		mark_reachable_objects(&cb.revs, 0, NULL);
 		if (cb.verbose)
-			putchar('\n');
+			fputc('\n', stderr);
 	}
 
 	if (do_all) {
-- 
