Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23077C433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 11:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239220AbiCGLjN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 06:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237681AbiCGLjM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 06:39:12 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D6119C20
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 03:38:17 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id q7-20020a7bce87000000b00382255f4ca9so10635468wmj.2
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 03:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dhsvMNl9axmBh1H+b52dPC0lDttysWUMszzhuDRy5fU=;
        b=YOAJ2uj+EQblmBPtogsDgS9JqyElFNO/4kkHI7NNzC4PC5/VZjjkYMgar+pUOvGV7u
         uMZRlIJfnuW4ZXC1IOV53YmZGqYDuBQamNqX/7QiNLBA6wVVsQpn6K59tq9STNtJZZkD
         Vqn37hQoFJGs7XaQbx+FUy9CzInBqYirglNAEWw62kPVkXOkWJkymhqK0lYIHBniJjwj
         2QGRUWesg8qbUr1DNMnmvAjSdg0Cd51Kws0KPFe6zdZmMtKPehW5CRwdQsumcN0GO790
         NZc90DjHAkEGVTdGWXkXY0lPBGPPIBzv7yvadWJqaiGqJLv4xqXVJSyVKVOn2q+A0XVS
         67Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dhsvMNl9axmBh1H+b52dPC0lDttysWUMszzhuDRy5fU=;
        b=ZkHLwODMBYQDfbt/pLpbSNRvJc3hHI+fxTLGUJylvrW93rymdpfjRFUq8a0JRyFdvb
         G2E7DGF2tQ+nsoZkIkYxFwg/I6Jm6HseeOiPHoVtZde4MsxLD4LeWFq/VCwuI/jyI748
         1lPNSj1ey2SwDXldj+XTtsF9+ZQtqok23xUneaXmC9V4SeTw0P13MrdNPu2YiAb/SqDR
         IiA9eK/OPzeBGUi3WyoH1VekI3BbQ1vUSNaD4uj6+1kUvDUTPW0+ITWqsdtbmJ1qRO+Q
         Jwv5YCbGtNJmZc9qC9nek0t8B2Pf5hue1Xk3vDq8oefdXFIsEl3fIRiH2EV/ZDu65Mbk
         jxYg==
X-Gm-Message-State: AOAM532zKoD2DA77g4V06/f2Vl7nh1aY9vICQ68+edTLGAGLKWW7vqoY
        ROQJssQ6h9QPFqV+HgrB00RJiGBJmgPJ4A==
X-Google-Smtp-Source: ABdhPJyL+g7x0KH5WFSByaxRusRreFa/41LcZfg0E8DnsXOB/fRweGg0mTEsUVjQ+DO4ukC7Ljik/A==
X-Received: by 2002:a1c:7302:0:b0:381:1f9a:a22b with SMTP id d2-20020a1c7302000000b003811f9aa22bmr8875929wmb.78.1646653095987;
        Mon, 07 Mar 2022 03:38:15 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a14-20020a05600c348e00b00389ab74c033sm1809074wmq.4.2022.03.07.03.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 03:38:15 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] gettext API users: correct use of casts for Q_()
Date:   Mon,  7 Mar 2022 12:38:00 +0100
Message-Id: <patch-1.2-83659fbc459-20220307T113707Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1241.gd8d69a17521
In-Reply-To: <cover-0.2-00000000000-20220307T113707Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20220307T113707Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change users of the inline gettext.h Q_() function to cast its
argument to "unsigned long" instead of "int" or "unsigned int".

The ngettext() function (which Q_() resolves to) takes an "unsigned
long int", and so does our Q_() wrapper for it, see 0c9ea33b90f (i18n:
add stub Q_() wrapper for ngettext, 2011-03-09).

In a subsequent commit we'll be making more use of this pattern of:

    func(Q_(..%"PRIuMAX..., (unsigned long)x), (uintmax_t)x);

By making this change we ensure that this case isn't the odd one out
in that post-image.

This:

 * Corrects code added in 7171a0b0cf5 (index-pack: correct "len" type
   in unpack_data(), 2016-07-13) to cast the "off_t len" to an
   "unsigned long int" rather than an "unsigned int".

 * Does the same for code in add-interactive.c added in several
   commits starting with a8c45be939d (built-in add -i: implement the
   `update` command, 2019-11-29).

 * Likewise for a case in 9254bdfb4f9 (built-in add -p: implement the
   'g' ("goto") command, 2019-12-13) where only the err() argument had
   a cast, but not the same argument to Q_().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 add-interactive.c    | 15 +++++++++------
 add-patch.c          |  8 ++++----
 builtin/index-pack.c |  2 +-
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index e1ab39cce30..6da781004ad 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -707,8 +707,9 @@ static int run_update(struct add_i_state *s, const struct pathspec *ps,
 		res = error(_("could not write index"));
 
 	if (!res)
-		printf(Q_("updated %d path\n",
-			  "updated %d paths\n", count), (int)count);
+		printf(Q_("updated %"PRIuMAX" path\n",
+			  "updated %"PRIuMAX" paths\n", (unsigned long)count),
+		       (uintmax_t)count);
 
 	putchar('\n');
 	return res;
@@ -814,8 +815,9 @@ static int run_revert(struct add_i_state *s, const struct pathspec *ps,
 						   NULL, NULL, NULL);
 
 	if (!res)
-		printf(Q_("reverted %d path\n",
-			  "reverted %d paths\n", count), (int)count);
+		printf(Q_("reverted %"PRIuMAX" path\n",
+			  "reverted %"PRIuMAX" paths\n", (unsigned long)count),
+		       (uintmax_t)count);
 
 finish_revert:
 	putchar('\n');
@@ -896,8 +898,9 @@ static int run_add_untracked(struct add_i_state *s, const struct pathspec *ps,
 		res = error(_("could not write index"));
 
 	if (!res)
-		printf(Q_("added %d path\n",
-			  "added %d paths\n", count), (int)count);
+		printf(Q_("added %"PRIuMAX" path\n",
+			  "added %"PRIuMAX" paths\n", (unsigned long)count),
+		       (uintmax_t)count);
 
 finish_add_untracked:
 	putchar('\n');
diff --git a/add-patch.c b/add-patch.c
index 55d719f7845..dfef00e5680 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1569,10 +1569,10 @@ static int patch_update_file(struct add_p_state *s,
 			else if (0 < response && response <= file_diff->hunk_nr)
 				hunk_index = response - 1;
 			else
-				err(s, Q_("Sorry, only %d hunk available.",
-					  "Sorry, only %d hunks available.",
-					  file_diff->hunk_nr),
-				    (int)file_diff->hunk_nr);
+				err(s, Q_("Sorry, only %"PRIuMAX" hunk available.",
+					  "Sorry, only %"PRIuMAX" hunks available.",
+					  (unsigned long)file_diff->hunk_nr),
+				    (uintmax_t)file_diff->hunk_nr);
 		} else if (s->answer.buf[0] == '/') {
 			regex_t regex;
 			int ret;
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 3c2e6aee3cc..f15b59e22b0 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -579,7 +579,7 @@ static void *unpack_data(struct object_entry *obj,
 		if (!n)
 			die(Q_("premature end of pack file, %"PRIuMAX" byte missing",
 			       "premature end of pack file, %"PRIuMAX" bytes missing",
-			       (unsigned int)len),
+			       (unsigned long)len),
 			    (uintmax_t)len);
 		from += n;
 		len -= n;
-- 
2.35.1.1241.gd8d69a17521

