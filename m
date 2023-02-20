Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38F5C636CC
	for <git@archiver.kernel.org>; Mon, 20 Feb 2023 14:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjBTOZF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Feb 2023 09:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjBTOZD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2023 09:25:03 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1531EE079
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 06:25:02 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id q5so1548409plh.9
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 06:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3l9tq+DBMa2p8MZLdW6F6CaIqGm4/odo6ihzcIF69M=;
        b=GnUNcjl65h97L/KBFOYw31jsYfbca3c1D65SZ+iSFfiAGeyKIpjS/kKtTv9OENMFYZ
         /AeUC2Z7dqNtQHzl5H2129FxJLVj2pG/SzCFXL0WAUcw0eBsWa+yebZaUX3z+VJHu3rJ
         gqJ1coo03pFY7bCY2HCwSP563/aGLBhEym9sqgNt1zrrnyvjTSKz1rs0PqA2v7Tc3NAb
         QinGayUzofXeLLOwHCMIt/EL4jyJNKjCqc4jIU2tWb3TNWKyGj3jCjvn6gFLRUue98uA
         Tpw0oqJuoUErI9lFD8tAv9wRheuyMg4fTaYaI+lB/mSxO1GLf2DRMwwu4m1S/1lQwBzc
         4ijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3l9tq+DBMa2p8MZLdW6F6CaIqGm4/odo6ihzcIF69M=;
        b=Zdq/MS4+iWWc0sCX9G2KymhTK0feOQVN9Dcyt8Rs/9UEVBXv6dNGJCAaBb2N+g5KaP
         WihZCL4rTR+DwGwAZNR/G0p05O77O9gFgfuqwEsYOR17gl2sWc1GoEO0cc114+cMiwI1
         NJaz1UtN8X4r0NWKzhR3KN3nJAPkWs1nSDpatkf5p4Ix8L7sm+W2j7Dtn6JfzB/++NXd
         zFD9b3UI84DSYDNuEsGfeFggYVRSFzOq0Wsy0m1cUYcwu0EG8r6flayfBG/3LYXvgEOk
         2wrbJosRwRgJrJidkjsP1TPVSNxs6lanKZHEbSAnARp2DYZWZIIt4gEJzfAj8lHWIc7m
         /rIA==
X-Gm-Message-State: AO0yUKWEqWK/6U90MHP4ham2lg6LP3WEW3uv7jahJEmnuEkvy9N/uiKe
        TFE3bqDUn7bOZZMsdliG6mkeOjY1PqKHXvWD
X-Google-Smtp-Source: AK7set/D5RyO/vGkHlRdoLMOEbayZ+pbT93H8QePipWTUW+2iQSFI6Hi7dz6GPxUmELWzbi7jDgnIA==
X-Received: by 2002:a17:902:d2cd:b0:19a:98fd:9c54 with SMTP id n13-20020a170902d2cd00b0019a98fd9c54mr3078072plc.35.1676903101242;
        Mon, 20 Feb 2023 06:25:01 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.53])
        by smtp.gmail.com with ESMTPSA id l1-20020a170902ec0100b0019ac7319ed1sm8031595pld.126.2023.02.20.06.24.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Feb 2023 06:24:59 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, --cc=tenglong.tl@alibaba-inc.com,
        Teng Long <dyroneteng@gmail.com>
Subject: [PATCH 1/1] range-diff: let '--abbrev' option takes effect
Date:   Mon, 20 Feb 2023 22:24:44 +0800
Message-Id: <20230220142444.18739-2-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.39.2.459.g1d9d282d
In-Reply-To: <20230220142444.18739-1-tenglong.tl@alibaba-inc.com>
References: <20230220142444.18739-1-tenglong.tl@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

As mentioned in 'git-range-diff.txt': "`git range-diff` also accepts the
regular diff options (see linkgit:git-diff[1])...", but '--abbrev' is not
in the "regular" scope.

In Git, the "abbrev" of an object may not be a fixed value in different
repositories, depending on the needs of the them(Linus mentioned in
e6c587c7 in 2016: "the Linux kernel project needs 11 to 12 hexdigits"
at that time ), that's why a user may want to display abbrev according
to a specified length.

Although a similar effect can be achieved through configuration (like:
git -c core.abbrev=<abbrev>), but based on ease of use (many users may not
know that the -c option can be specified) and the description in existing
document, supporting users to directly use '--abbrev', could be a good way.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 range-diff.c          | 11 +++++++----
 t/t3206-range-diff.sh | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index 8255ab43..086365df 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -383,11 +383,14 @@ static void output_pair_header(struct diff_options *diffopt,
 	const char *color_new = diff_get_color_opt(diffopt, DIFF_FILE_NEW);
 	const char *color_commit = diff_get_color_opt(diffopt, DIFF_COMMIT);
 	const char *color;
+	char abbrev = diffopt->abbrev;
+
+	if (abbrev < 0)
+		abbrev = DEFAULT_ABBREV;
 
 	if (!dashes->len)
 		strbuf_addchars(dashes, '-',
-				strlen(find_unique_abbrev(oid,
-							  DEFAULT_ABBREV)));
+				strlen(find_unique_abbrev(oid, abbrev)));
 
 	if (!b_util) {
 		color = color_old;
@@ -409,7 +412,7 @@ static void output_pair_header(struct diff_options *diffopt,
 		strbuf_addf(buf, "%*s:  %s ", patch_no_width, "-", dashes->buf);
 	else
 		strbuf_addf(buf, "%*d:  %s ", patch_no_width, a_util->i + 1,
-			    find_unique_abbrev(&a_util->oid, DEFAULT_ABBREV));
+			    find_unique_abbrev(&a_util->oid, abbrev));
 
 	if (status == '!')
 		strbuf_addf(buf, "%s%s", color_reset, color);
@@ -421,7 +424,7 @@ static void output_pair_header(struct diff_options *diffopt,
 		strbuf_addf(buf, " %*s:  %s", patch_no_width, "-", dashes->buf);
 	else
 		strbuf_addf(buf, " %*d:  %s", patch_no_width, b_util->i + 1,
-			    find_unique_abbrev(&b_util->oid, DEFAULT_ABBREV));
+			    find_unique_abbrev(&b_util->oid, abbrev));
 
 	commit = lookup_commit_reference(the_repository, oid);
 	if (commit) {
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 84dd0cd2..b5f4d6a6 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -33,6 +33,26 @@ test_expect_success 'setup' '
 	u3 sha256:736c4bc
 	u4 sha256:673e77d
 
+	# topic (abbrev=10)
+	t1_abbrev sha1:4de457d2c0
+	t2_abbrev sha1:fccce22f8c
+	t3_abbrev sha1:147e64ef53
+	t4_abbrev sha1:a63e992599
+	t1_abbrev sha256:b89f8b9092
+	t2_abbrev sha256:5f12aadf34
+	t3_abbrev sha256:ea8b273a6c
+	t4_abbrev sha256:14b73361fc
+
+	# unmodified (abbrev=10)
+	u1_abbrev sha1:35b9b25f76
+	u2_abbrev sha1:de345ab3de
+	u3_abbrev sha1:9af6654000
+	u4_abbrev sha1:2901f773f3
+	u1_abbrev sha256:e3731be242
+	u2_abbrev sha256:14fadf8cee
+	u3_abbrev sha256:736c4bcb44
+	u4_abbrev sha256:673e77d589
+
 	# reordered
 	r1 sha1:aca177a
 	r2 sha1:14ad629
@@ -153,6 +173,18 @@ test_expect_success 'simple A B C (unmodified)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'simple A..B A..C (unmodified) with --abbrev' '
+	git range-diff --no-color --abbrev=10 main..topic main..unmodified \
+		>actual &&
+	cat >expect <<-EOF &&
+	1:  $(test_oid t1_abbrev) = 1:  $(test_oid u1_abbrev) s/5/A/
+	2:  $(test_oid t2_abbrev) = 2:  $(test_oid u2_abbrev) s/4/A/
+	3:  $(test_oid t3_abbrev) = 3:  $(test_oid u3_abbrev) s/11/B/
+	4:  $(test_oid t4_abbrev) = 4:  $(test_oid u4_abbrev) s/12/B/
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'A^! and A^-<n> (unmodified)' '
 	git range-diff --no-color topic^! unmodified^-1 >actual &&
 	cat >expect <<-EOF &&
-- 
2.39.2.459.g1d9d282d

