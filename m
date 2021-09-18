Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B45C433F5
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 13:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 726A761350
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 13:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235477AbhIRNQA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 09:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhIRNP7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 09:15:59 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D67C061574
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 06:14:35 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d6so19743397wrc.11
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 06:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=gYJuGw4HM08xeRhi8FGun5b1r8mpPZXbCPCDHW7FUUI=;
        b=bh/hrNUMPzbyquoP3Fl0aN8aIz1NdCEN5y9Hbnr42QSlXALg7bGYormVIrE79ijyV6
         rty+kal2pNfNAh24gI298dpRY8FMMrQlYa8rSFP0Ejtzm5N4sgwRqMCSDBCj0OR1hTVg
         qwlMa/U5b6AFZfVbPRM2RKLGNLGGFH9WWfvX+So/D6W7N7FV2IlljbMpkvm0phgISsHb
         sxafMwQya1oTwGAmow7Y4Qbo6h7LUeZaeOCtg7ZapOaFHLO3iSeIJ7/gEH7HltryQ6uC
         jjbOL+4I2VlCF/WSBgku7wbSJGHZPGR6S26YXDs3KOMRPRk7ZJPiAEPM+FbSNHrqZNhw
         +w7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gYJuGw4HM08xeRhi8FGun5b1r8mpPZXbCPCDHW7FUUI=;
        b=rz87EbzbHTOgCgassWrkm+QFCzejm+GWu6HcidiVyw7DBZ7bfcSAjaGIdMugwDEzGe
         D8kej8bhQ6su0+Rv4EvkITm4x+m/l+/nqNClWcTnMd7wC0aQApNy8nQDj0d3l1UnAwvp
         rx0e7yWwXUpHFw+HJqwbag8JkG//h878r6HZ7UnUgnsvo1SpzOqxAJ3fxNRLg800vexQ
         PBrkwmbxhKFxAgBB/hktQmpHzzQQsjk5KjkHGzk1NuHrvYL93z3byKLmwRfVDiDzfTaa
         p8SN4gzqiTshuUgpXtQ4SffDiF9tKH5M2+OHEO9T3IidqApZZUawe4PFhA0DhdX2Ikp3
         WABg==
X-Gm-Message-State: AOAM533XO0oLvx3pm4eynxBKa4bLmYkAZVTyYTOCjvU1BotNhv0ROqHC
        x942SDtuc+Tf7ZW4f4PRcg4U8alUd9s=
X-Google-Smtp-Source: ABdhPJzaekbHe8d7tHfOVM/bIEIDdpikP65M56Wr8tEPZUwWVnICjPgmLNTkP5Zdr1tGKbestru3SA==
X-Received: by 2002:a5d:6392:: with SMTP id p18mr17584378wru.372.1631970873554;
        Sat, 18 Sep 2021 06:14:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h18sm9943556wmq.23.2021.09.18.06.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 06:14:33 -0700 (PDT)
Message-Id: <pull.1091.git.git.1631970872884.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 18 Sep 2021 13:14:32 +0000
Subject: [PATCH] connect: also update offset for features without values
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <andrzej@ahunt.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <andrzej@ahunt.org>

parse_feature_value() does not update offset if the feature being
searched for does not specify a value. A loop that uses
parse_feature_value() to find a feature which was specified without a
value therefore might never exit (such loops will typically use
next_server_feature_value() as opposed to parse_feature_value() itself).
This usually isn't an issue: there's no point in using
next_server_feature_value() to search for repeated instances of the same
capability unless that capability typically specifies a value - but a
broken server could send a response that omits the value for a feature
even when we are expecting a value.

Therefore we add an offset update calculation for the no-value case,
which helps ensure that loops using next_server_feature_value() will
always terminate.

next_server_feature_value(), and the offset calculation, were first
added in 2.28 in:
  2c6a403d96 (connect: add function to parse multiple v1 capability values, 2020-05-25)

Thanks to Peff for authoring the test.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Andrzej Hunt <andrzej@ahunt.org>
---
    connect: also update offset for features without values
    
    This is a small patch to avoid an infinite loop which can occur when a
    broken server forgets to include a value when specifying symref in the
    capabilities list.
    
    Thanks to Peff for writing the test.
    
    Note: I modified the test by adding and object-format=... to the
    injected server response, because the oid that we're using is the
    default hash (which will be e.g. sha256 for some CI jobs), but our
    protocol handler assumes sha1 unless a different hash has been
    explicitly specified. I'm open to alternative suggestions.
    
    ATB,
    
    Andrzej

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1091%2Fahunt%2Fconnectloop-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1091/ahunt/connectloop-v1
Pull-Request: https://github.com/git/git/pull/1091

 connect.c                      |  2 ++
 t/t5704-protocol-violations.sh | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/connect.c b/connect.c
index aff13a270e6..eaf7d6d2618 100644
--- a/connect.c
+++ b/connect.c
@@ -557,6 +557,8 @@ const char *parse_feature_value(const char *feature_list, const char *feature, i
 			if (!*value || isspace(*value)) {
 				if (lenp)
 					*lenp = 0;
+				if (offset)
+					*offset = found + len - feature_list;
 				return value;
 			}
 			/* feature with a value (e.g., "agent=git/1.2.3") */
diff --git a/t/t5704-protocol-violations.sh b/t/t5704-protocol-violations.sh
index 5c941949b98..34538cebf01 100755
--- a/t/t5704-protocol-violations.sh
+++ b/t/t5704-protocol-violations.sh
@@ -32,4 +32,17 @@ test_expect_success 'extra delim packet in v2 fetch args' '
 	test_i18ngrep "expected flush after fetch arguments" err
 '
 
+test_expect_success 'bogus symref in v0 capabilities' '
+	test_commit foo &&
+	oid=$(git rev-parse HEAD) &&
+	{
+		printf "%s HEAD\0symref object-format=%s\n" "$oid" "$GIT_DEFAULT_HASH" |
+			test-tool pkt-line pack-raw-stdin &&
+		printf "0000"
+	} >input &&
+	git ls-remote --upload-pack="cat input ;:" . >actual &&
+	printf "%s\tHEAD\n" "$oid" >expect &&
+	test_cmp expect actual
+'
+
 test_done

base-commit: 186eaaae567db501179c0af0bf89b34cbea02c26
-- 
gitgitgadget
