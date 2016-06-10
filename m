From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 10/44] apply: make init_apply_state() return -1 instead of exit()ing
Date: Fri, 10 Jun 2016 22:10:44 +0200
Message-ID: <20160610201118.13813-11-chriscool@tuxfamily.org>
References: <20160610201118.13813-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:12:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSmd-00039B-CR
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbcFJUL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 16:11:56 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33287 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932102AbcFJULy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:11:54 -0400
Received: by mail-wm0-f65.google.com with SMTP id r5so1067655wmr.0
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nWbnKe6MK4BzA1scRs55/AJdrBZ/RQw5Zbfd4uSvYUY=;
        b=a3c5NyZUDvM5iJ9ECEMV/QDF+uK/as/MwevCKAL1A3QstQB9iaGbBeMikZNYp/RcX5
         x/AX+vQRBBc3dFeMwzogzjTn2mA6J25r+aDtwtqBI9j1+UW6a6elCHvSQuJPHd481BIb
         mpbsc5izgWlURwRC2drsf0HQ0VqQtYmPWGJy4gu+FuK5tvTM8ZCHy+mEFw/W3mzoMV6B
         qifjVQLYSYLx9kVVW393sdhaPnn4gwJRPVjFMe7PCBmL/joluxjpHuQm5iSZ0J5hbjoc
         77+Nf08h+gPzak4bV6cbzVEMiHuH/5hQJz8dALXVBCkyLniwBP05XLBqtBqryuHgrZ0a
         bdYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nWbnKe6MK4BzA1scRs55/AJdrBZ/RQw5Zbfd4uSvYUY=;
        b=k6QjfEbNKxs5NtBdEzMb5u8voyWnncUgx0JZJhxR/HJ3um1mUX09UAeGJEyiI80n6q
         PxxxCO+UfVweedCTGG8vuyKQKLGzWnZ+vw16o1CZhjN1Q2xO65IuGQuuJEt4+m//T5FM
         qr4XddJl04KAkINX88tZD6McFZmhBLSmIos4UpnNvUwZXe6VjpaQsONnHrPxZmudIzi2
         lwC2cOaRLc3e3OuLBeOu12DjTHKpWPVmsN8XDA8zzlYAbFlPzs86OSMQvHwctWFo9uIv
         kut9WMrdRDpk7CVaFao+oxiLLTxMVU45seYt8y8Esg9IlBy6cq7bG/Uto+Wt1y1tCueN
         0+cw==
X-Gm-Message-State: ALyK8tLGUjRtlU88D+xtwCaozJBgnH5rUeo0p4ukTqlSyziJerbr4qUvWaw32KyhXVwwNA==
X-Received: by 10.195.12.229 with SMTP id et5mr4162780wjd.22.1465589513547;
        Fri, 10 Jun 2016 13:11:53 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o129sm689125wmb.17.2016.06.10.13.11.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 13:11:52 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.362.g3cd93d0
In-Reply-To: <20160610201118.13813-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297028>

To libify `git apply` functionality we have to signal errors to the
caller instead of exit()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", init_apply_state() should return -1 instead of
calling exit().

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c         | 11 ++++++-----
 apply.h         |  6 +++---
 builtin/apply.c |  3 ++-
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/apply.c b/apply.c
index 1f31bb4..c5a9ee2 100644
--- a/apply.c
+++ b/apply.c
@@ -55,9 +55,9 @@ int parse_ignorewhitespace_option(struct apply_state *state,
 	return error(_("unrecognized whitespace ignore option '%s'"), option);
 }
 
-void init_apply_state(struct apply_state *state,
-		      const char *prefix,
-		      struct lock_file *lock_file)
+int init_apply_state(struct apply_state *state,
+		     const char *prefix,
+		     struct lock_file *lock_file)
 {
 	memset(state, 0, sizeof(*state));
 	state->prefix = prefix;
@@ -76,9 +76,10 @@ void init_apply_state(struct apply_state *state,
 
 	git_apply_config();
 	if (apply_default_whitespace && parse_whitespace_option(state, apply_default_whitespace))
-		exit(1);
+		return -1;
 	if (apply_default_ignorewhitespace && parse_ignorewhitespace_option(state, apply_default_ignorewhitespace))
-		exit(1);
+		return -1;
+	return 0;
 }
 
 void clear_apply_state(struct apply_state *state)
diff --git a/apply.h b/apply.h
index 77502be..7d3a03b 100644
--- a/apply.h
+++ b/apply.h
@@ -102,9 +102,9 @@ extern int parse_whitespace_option(struct apply_state *state,
 extern int parse_ignorewhitespace_option(struct apply_state *state,
 					 const char *option);
 
-extern void init_apply_state(struct apply_state *state,
-			     const char *prefix,
-			     struct lock_file *lock_file);
+extern int init_apply_state(struct apply_state *state,
+			    const char *prefix,
+			    struct lock_file *lock_file);
 extern void clear_apply_state(struct apply_state *state);
 
 #endif
diff --git a/builtin/apply.c b/builtin/apply.c
index bc15545..2ae1243 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4728,7 +4728,8 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	init_apply_state(&state, prefix, &lock_file);
+	if (init_apply_state(&state, prefix, &lock_file))
+		exit(1);
 
 	argc = parse_options(argc, argv, state.prefix, builtin_apply_options,
 			apply_usage, 0);
-- 
2.9.0.rc2.362.g3cd93d0
