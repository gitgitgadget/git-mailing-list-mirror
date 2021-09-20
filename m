Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B44C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F5906112D
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239964AbhIUC7y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349435AbhIUC0g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 22:26:36 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFF4C1E327B
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 12:04:34 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id w17so24467407wrv.10
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 12:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EEujD/U9rZ84o26D9qaaLwC34RmOrNj/wMFAnOc3cq0=;
        b=m/RSmA/Fsn+SaDIlVIqbraaACNpgufb4L/HS44staz/khAHfk6O14NGaEMQ8krJ//n
         lKrDfQ9KFiP4XbAfZGZK5urSfWmgl/lQ6sPNueQWLW2avM35HEx8R5Q0tt03pHGWjE9j
         HaiO85T/Mgo+9bFIPHCAnK+pfPrwFceo5r6MBnuw0Xg+rkPN1W9BLEvSfkYKoeycxqq4
         BkuQ4ed+TgEjsKc6CLw4IvpYs/cwMOZFM8jQy2iv8yF6EIg/rObFgtXzHsrcxIXjV2Yo
         uqvtFn5z0s0X/wXigAyixRPSDowAT2ftZx2s6LbMP3rB/7G/d60JbO33OkVLr7y1p/aX
         EGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EEujD/U9rZ84o26D9qaaLwC34RmOrNj/wMFAnOc3cq0=;
        b=Kf+JCedvEEk6sw5qkizFBkyOF/0e08ijtZJSs1ApWKU9pCnsw1cmFaY399u4JnO+B4
         Tr+dCGxGg6ATC+DZ36DpfQqLMrHrnDcWP2qdrjfu0A00j1oo8hlvNwQZL90TbK8LH91f
         nmXF8bE6a9guRZ9uNZSq0+CnOazyIaURGa4i/t1dp6qXJ7l6+ITVShC/QNwRnwM7CueA
         VMOOyZO5C3dPUtUY8MjwubZmLPS9/MhxUOlUowYWlrD5XBbGmd4S7EXQrJVFFw8Dm9Q6
         ZEYWZeQjH1tKd8vvZsCVHjLfH4ZsRbXo1GVDhoZnwiurBT4Rl2LwQCfHcKTRiMgBlLuV
         I5Nw==
X-Gm-Message-State: AOAM532dtCB625eFsAviU5ibOK32DmXhtAdz78OXAkT6U+VLuPmX1cXv
        9Hmcd1KgfjZSlNRTfRryqg3F510HId77Sg==
X-Google-Smtp-Source: ABdhPJydE2Q/hxOZ71IDg/taa9xH6FUC+tXf8NN9v9llqvKDnBLtT95Z5RhQ1Cs2YAkhQ5736GTbuA==
X-Received: by 2002:a5d:544c:: with SMTP id w12mr17098152wrv.398.1632164672869;
        Mon, 20 Sep 2021 12:04:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o19sm8157772wrg.60.2021.09.20.12.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 12:04:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 08/17] cat-file tests: test for current --allow-unknown-type behavior
Date:   Mon, 20 Sep 2021 21:04:12 +0200
Message-Id: <patch-v7-08.17-cd1d52b8a07-20210920T190305Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.g29a6526ae47
In-Reply-To: <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com>
References: <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com> <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add more tests for the current --allow-unknown-type behavior. As noted
in [1] I don't think much of this makes sense, but let's test for it
as-is so we can see if the behavior changes in the future.

1. https://lore.kernel.org/git/87r1i4qf4h.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1006-cat-file.sh | 61 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 8bbc34efb0c..269ab7e4729 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -402,6 +402,67 @@ do
 	done
 done
 
+test_expect_success '-e is OK with a broken object without --allow-unknown-type' '
+	git cat-file -e $bogus_short_sha1
+'
+
+test_expect_success '-e can not be combined with --allow-unknown-type' '
+	test_expect_code 128 git cat-file -e --allow-unknown-type $bogus_short_sha1
+'
+
+test_expect_success '-p cannot print a broken object even with --allow-unknown-type' '
+	test_must_fail git cat-file -p $bogus_short_sha1 &&
+	test_expect_code 128 git cat-file -p --allow-unknown-type $bogus_short_sha1
+'
+
+test_expect_success '<type> <hash> does not work with objects of broken types' '
+	cat >err.expect <<-\EOF &&
+	fatal: invalid object type "bogus"
+	EOF
+	test_must_fail git cat-file $bogus_short_type $bogus_short_sha1 2>err.actual &&
+	test_cmp err.expect err.actual
+'
+
+test_expect_success 'broken types combined with --batch and --batch-check' '
+	echo $bogus_short_sha1 >bogus-oid &&
+
+	cat >err.expect <<-\EOF &&
+	fatal: invalid object type
+	EOF
+
+	test_must_fail git cat-file --batch <bogus-oid 2>err.actual &&
+	test_cmp err.expect err.actual &&
+
+	test_must_fail git cat-file --batch-check <bogus-oid 2>err.actual &&
+	test_cmp err.expect err.actual
+'
+
+test_expect_success 'the --batch and --batch-check options do not combine with --allow-unknown-type' '
+	test_expect_code 128 git cat-file --batch --allow-unknown-type <bogus-oid &&
+	test_expect_code 128 git cat-file --batch-check --allow-unknown-type <bogus-oid
+'
+
+test_expect_success 'the --allow-unknown-type option does not consider replacement refs' '
+	cat >expect <<-EOF &&
+	$bogus_short_type
+	EOF
+	git cat-file -t --allow-unknown-type $bogus_short_sha1 >actual &&
+	test_cmp expect actual &&
+
+	# Create it manually, as "git replace" will die on bogus
+	# types.
+	head=$(git rev-parse --verify HEAD) &&
+	test_when_finished "rm -rf .git/refs/replace" &&
+	mkdir -p .git/refs/replace &&
+	echo $head >.git/refs/replace/$bogus_short_sha1 &&
+
+	cat >expect <<-EOF &&
+	commit
+	EOF
+	git cat-file -t --allow-unknown-type $bogus_short_sha1 >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success "Type of broken object is correct" '
 	echo $bogus_short_type >expect &&
 	git cat-file -t --allow-unknown-type $bogus_short_sha1 >actual &&
-- 
2.33.0.1098.g29a6526ae47

