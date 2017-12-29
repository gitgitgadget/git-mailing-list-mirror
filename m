Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 567641F404
	for <e@80x24.org>; Fri, 29 Dec 2017 22:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751059AbdL2Wvc (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Dec 2017 17:51:32 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39468 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750810AbdL2Wvb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Dec 2017 17:51:31 -0500
Received: by mail-wm0-f65.google.com with SMTP id i11so49832019wmf.4
        for <git@vger.kernel.org>; Fri, 29 Dec 2017 14:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Ma7R8eQMqaA6F8GNYacEjFS4deGGOyAdyykXw4TZDU=;
        b=HotiAUNGgFMpeHi2ARQtkyIMqvct+kOIwjCW6grrl/0o0HC+FwGyEr3tVAEONx87yv
         8plGuQi1Q99W1Nd2u5fHFvtJuvYPe15zSNd+gJFR0UMnOe/8WMdEhfvj8adANIO1okjk
         0FTx6z8bJeJGYBQN3txiUtX5r4LX8nWiUrYBROYFaIvl79zfg5Xq+RvtDZ+4Jfq3VnvK
         b9ZVM4lyYFHez2D6LBSUVoMtO0myMvG/zDd1Mr9VWe7oGMpf3R+ioRl3HzKamOTM/IuY
         4Lj//E9V1t8O01iJEAFv+5jT8IIgn5Oq43+Jn3nkIyIejmC6/dDEM5uxsXlcBwyRAjfG
         Dn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Ma7R8eQMqaA6F8GNYacEjFS4deGGOyAdyykXw4TZDU=;
        b=P36dSy7zIctn4t0kMku7BhjJ1yc2QUDWZmPB/touNQY+brzqDXH861JW6SoFxU5+C1
         XpbVh+3nChRXdSbO0W516S63CHVZ9l1gERDD1ETTk2k0Dxeh1T7txWDU8s1gzdqIJK+6
         61myfwbB60WV8WbsxEAKtJ0O70RnxduSKLnokwfyFplkYeAphHIEd8xEL+Ple67WvbLi
         GzjkOa7GMbgqhYr+Khwyc9Vd4OWBl/dHCaooAGDpaauAeclEIEnAkofX9Memru0UiPIT
         fQVVjiXgumC/h8ut8T8e9ZDOK8lWEB7ImXNdiEp1mVaMjAjfw5J5FW3iwCBbyFKWmrtt
         vg7A==
X-Gm-Message-State: AKGB3mJpiCEMn78zcTlGkpZrg3kM/m7D/gVS6nleiqDh0G9CstmH6XtA
        QinJIsbVnZ57MwGgCFxyjq++HsCf
X-Google-Smtp-Source: ACJfBovfPgA97jqnJykLzh5GDlz9oWC1TLY45fu6V3KpkTCA1C728J487NZ68eNa5YG2ihhg9h/ooA==
X-Received: by 10.28.110.24 with SMTP id j24mr27602897wmc.100.1514587889703;
        Fri, 29 Dec 2017 14:51:29 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 2sm20413079wmk.28.2017.12.29.14.51.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Dec 2017 14:51:28 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Zefram <zefram@fysh.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] diff-tree: obey the color.ui configuration
Date:   Fri, 29 Dec 2017 22:51:21 +0000
Message-Id: <20171229225121.13805-1-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <87zi616vgf.fsf@evledraar.gmail.com>
References: <87zi616vgf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before git-bisect exits it calls `diff-tree --pretty --stat $commit`
on the bad commit. This would always print the "commit" line with
coloring despite color.ui being set to "never".

Teach diff-tree to look at the git_color_config() configuration. I
initially tried to add this to git_diff_basic_config itself, but it
makes other unrelated things fail, and this is a more isolated change
that solves the issue.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

No idea how to test this, in particular trying to pipe the output of
color.ui=never v.s. color.ui=auto to a file as "auto" will disable
coloring when it detects a pipe, but this fixes the issue.

 builtin/diff-tree.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index b775a75647..0311c01a87 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -97,6 +97,15 @@ static void diff_tree_tweak_rev(struct rev_info *rev, struct setup_revision_opt
 	}
 }
 
+
+static int diff_tree_config(const char *var, const char *value, void *cb)
+{
+	if (git_color_config(var, value, cb) < 0)
+		return -1;
+
+	return git_diff_basic_config(var, value, cb);
+}
+
 int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 {
 	char line[1000];
@@ -108,7 +117,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(diff_tree_usage);
 
-	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
+	git_config(diff_tree_config, NULL); /* no "diff" UI options */
 	init_revisions(opt, prefix);
 	if (read_cache() < 0)
 		die(_("index file corrupt"));
-- 
2.15.1.424.g9478a66081

