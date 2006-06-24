From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH 5/7] DIFF_FORMAT_RAW is not default anymore
Date: Sat, 24 Jun 2006 20:25:08 +0300
Message-ID: <20060624202508.b997e4e5.tihirvon@gmail.com>
References: <20060624201843.a5b4f7b9.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 19:30:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuBxp-0001XZ-Ef
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 19:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbWFXRa2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 13:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbWFXRa2
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 13:30:28 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:17675 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750959AbWFXRa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 13:30:27 -0400
Received: by nf-out-0910.google.com with SMTP id m19so402614nfc
        for <git@vger.kernel.org>; Sat, 24 Jun 2006 10:30:27 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=pVxrK5j4jSYrAZahiG+0NsBfsrMm/WX2uh528foYRvxJ4K5r6aVnfsmUz99npUkq5pPkXzpxnm50KoamcWbV41JyW2fR+DWaB9wWN96+31aQfg80S2q12NaOA7PIMA+kKudpQiOPhm8meZBs5lSVFPNktmk8ShV2Lb5Io4ct4O0=
Received: by 10.48.231.6 with SMTP id d6mr3525219nfh;
        Sat, 24 Jun 2006 10:30:27 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id g1sm4223621nfe.2006.06.24.10.30.26;
        Sat, 24 Jun 2006 10:30:26 -0700 (PDT)
To: junkio@cox.net
In-Reply-To: <20060624201843.a5b4f7b9.tihirvon@gmail.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22532>

diff_setup() used to initialize output_format to DIFF_FORMAT_RAW.  Now
the default is 0 (no output) so don't compare against DIFF_FORMAT_RAW to
see if any diff format command line flags were given.

Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>
---
 builtin-log.c |    5 +----
 revision.c    |    3 +--
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 65f9527..f173070 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -24,11 +24,8 @@ static int cmd_log_wc(int argc, const ch
 	rev->verbose_header = 1;
 	argc = setup_revisions(argc, argv, rev, "HEAD");
 	if (rev->always_show_header) {
-		if (rev->diffopt.pickaxe || rev->diffopt.filter) {
+		if (rev->diffopt.pickaxe || rev->diffopt.filter)
 			rev->always_show_header = 0;
-			if (rev->diffopt.output_format == DIFF_FORMAT_RAW)
-				rev->diffopt.output_format = DIFF_FORMAT_NO_OUTPUT;
-		}
 	}
 
 	if (argc > 1)
diff --git a/revision.c b/revision.c
index b963f2a..ae4ca82 100644
--- a/revision.c
+++ b/revision.c
@@ -851,8 +851,7 @@ int setup_revisions(int argc, const char
 	}
 	if (revs->combine_merges) {
 		revs->ignore_merges = 0;
-		if (revs->dense_combined_merges &&
-		    (revs->diffopt.output_format != DIFF_FORMAT_DIFFSTAT))
+		if (revs->dense_combined_merges && !revs->diffopt.output_format)
 			revs->diffopt.output_format = DIFF_FORMAT_PATCH;
 	}
 	revs->diffopt.abbrev = revs->abbrev;
-- 
1.4.1.rc1.g8637
