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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F4AC1B0D8
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 20:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23666239D1
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 20:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387758AbgLIUDE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 15:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731863AbgLIUC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 15:02:59 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D716C0617A7
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 12:02:04 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id 3so2996029wmg.4
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 12:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r9hhnz5zwCEr+dhTPxdsHBLDZeJeUTfZCwkPbrwyGl8=;
        b=YhpxRvaUhJ+cBD/CID9tyr1oeV2Q0LmqaX2AJXUPrxXdrEax6soEOG0V9PESHKazDi
         3Phd0u1dpGSyl+eQW5wUv6FjHaLTUMcxJgsmMwR08T2MyL4hImizwQjpRKvA64Tuz790
         KH4hUfu/KDDE/gx56wRhR2Zp+QTrfwDL0l7PbC2PQFzxi2+AzZH9U2ydBttSlhnYwUni
         eQ0D+d1usMHcsBI9Db+ilXDM1spkPz+S6G9MQoiTre3Nu6ECt4jsEvr6CbbVC5zWUgLl
         lxfCU7O8n02W10xPXn7diuolFWzTjC5j3TP8Sr0PozwoyMVWqYeW+qQdNJdViYY9kKdh
         Bq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r9hhnz5zwCEr+dhTPxdsHBLDZeJeUTfZCwkPbrwyGl8=;
        b=ffjJGzQcd59/1GMMEp1EvbrluZAtE2c9XoK2Ih3VKQa8zKEKWBMZM6f2Yt1OCJ9be5
         mu0lfzUZd34TeG+yIEhSJsk13R4PlsQ9/IPI6b4EiiHqi4oH5Kg3jB51PmsarT0C8YAm
         +dfIQQLQEMqhprEcw2T2tLbbpExfChsx6R5AtWSArOJTnGaR4RreB+zMENUUxq3uvtnm
         3Ha1rKjsjKvkrTR5TOR7kLZs7GLqCAFP/ZpDsiVuUCdmUU8KkoJ701zWpO7GfrqZck4i
         qevcg6B5l2NrL5SoOY4GyAWh5JV2H6C7B96LL/3py5mnE5hgjwmCC24THnbC5uH6ZmKq
         +zlA==
X-Gm-Message-State: AOAM5321B+b0uzruGcP243EOB+IuQEHTsmn00hxPvsXl/c24c/ULehQp
        +1PvZrn+c8bbQlo7CTnpgl4POU+mB1rcsQ==
X-Google-Smtp-Source: ABdhPJxwAM1u8oMpfJuqu8/wQlBxENDTZS0jmnBf232e4tXc+ZOxX5Oq2vF7Q54gek63FpVGmwQ/jg==
X-Received: by 2002:a05:600c:274d:: with SMTP id 13mr4488454wmw.77.1607544123310;
        Wed, 09 Dec 2020 12:02:03 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 34sm5762128wrh.78.2020.12.09.12.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 12:02:02 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 05/10] mktag tests: remove needless SHA-1 hardcoding
Date:   Wed,  9 Dec 2020 21:01:35 +0100
Message-Id: <20201209200140.29425-6-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201126222257.5629-1-avarab@gmail.com>
References: <20201126222257.5629-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the tests amended in acb49d1cc8b (t3800: make hash-size
independent, 2019-08-18) even more to make them independent of either
SHA-1 or SHA-256.

Some of these tests were failing for the wrong reasons. The first one
being modified here would fail because the line starts with "xxxxxx"
instead of "object", the rest of the line doesn't matter.

Let's just put a valid hash on the rest of the line anyway to narrow
the test down for just the s/object/xxxxxx/ case.

The second one being modified here would fail under
GIT_TEST_DEFAULT_HASH=sha256 because <some sha-1 length garbage> is an
invalid SHA-256, but we should really be testing <some sha-256 length
garbage> when under SHA-256.

This doesn't really matter since we should be able to trust other
parts of the code to validate things in the 0-9a-f range, but let's
keep it for good measure.

There's a later test which tests an invalid SHA which looks like a
valid one, to stress the "We refuse to tag something we can't
verify[...]" logic in mktag.c.

But here we're testing for a SHA-length string which contains
characters outside of the /[0-9a-f]/i set.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3800-mktag.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 0e411e3c45f..a22a0954d5e 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -43,7 +43,7 @@ check_verify_failure 'Tag object length check' \
 #  2. object line label check
 
 cat >tag.sig <<EOF
-xxxxxx 139e9b33986b1c2670fff52c5067603117b3e895
+xxxxxx $head
 type tag
 tag mytag
 tagger . <> 0 +0000
@@ -53,10 +53,10 @@ EOF
 check_verify_failure '"object" line label check' '^error: char0: .*"object "$'
 
 ############################################################
-#  3. object line SHA1 check
+#  3. object line hash check
 
 cat >tag.sig <<EOF
-object zz9e9b33986b1c2670fff52c5067603117b3e895
+object $(echo $head | tr 0-9a-f z)
 type tag
 tag mytag
 tagger . <> 0 +0000
-- 
2.29.2.222.g5d2a92d10f8

