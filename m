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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB8BC433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 948CA6112D
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbhIUC7a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349407AbhIUC0b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 22:26:31 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5069CC1E3267
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 12:04:30 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id w29so32591983wra.8
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 12:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FtinolxSUiJS6loBlInPlbZmLZzLVWrH8sAer83veO4=;
        b=gjX61m3Mx07p/0utDW3MQsu9xANGSB8zFKM/e0TTZ2gW5VzH9DNn+6iezhtDwcXwPp
         Ncoiy5QqUUX2+0YYPEaLnoh9ym1Wmbowntzq/n0jlB5Cp3OU3jIvak3nPNpLYwV3VRS4
         EBWMQ3HFhICy//7k2GUdvqpKSiHdieBgQttHzDXmCEmjn7rlCnNKigI/+JEgtDCySNIk
         2SbV7uZ50UbJJeh6GNUAYaYGsFo5G+wZ8i/F3cBpFOrq4F8lIgceJ2Isdlewxcowkp1w
         mrZjLnq0rA9qEJunluVkSleG+k0QEf0IpqxEB7CPjkldubZt+it38Q/a4Rkt44Fi6fKE
         hmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FtinolxSUiJS6loBlInPlbZmLZzLVWrH8sAer83veO4=;
        b=yK6YyRkyeafun1CGZsuMi07tjefzUz3dZvCyuby6w2iNUxpDo4dV1evcsB690OTpjf
         wsHaVl8zOiwK6gifx1mJjrEyl8xYNjGiY+JQgKlS5ELP2PVgz3InZJKgI1NM978013kw
         mNe6hMlLv5h4EvPHXK0nq5jfng1BXL8SBYnEZsCC6p+ley2BMPKkwB6icaOCruRqMhwE
         aghQJGc3fTMv12MfoHqayY+H3SuUnjx8XyNEawdru2NP5LOfju80nT3NHSa8AWjxwVTo
         53VGvOjcx+H84zA0+zxVRR7iO9LP13v9Nh3/KN1480NbBJJMVpdnUuN25fNA5rcpwosE
         Y10w==
X-Gm-Message-State: AOAM530xZOlMHT2/ozX7bi5SWAYx/tukFZ9iRaNZDpZeLcQ/6kJBYad/
        PoLg0mB5sWjjZPSPcnK137h5HQa54k5jvg==
X-Google-Smtp-Source: ABdhPJzkEIJiJY1+SWD6PWlsK4NbLm093el3w2tk4LTHkm7/OnMydoTx3nQcdzytV+ziflANkyuHSw==
X-Received: by 2002:adf:f1c4:: with SMTP id z4mr30456413wro.418.1632164668642;
        Mon, 20 Sep 2021 12:04:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o19sm8157772wrg.60.2021.09.20.12.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 12:04:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 03/17] fsck tests: test current hash/type mismatch behavior
Date:   Mon, 20 Sep 2021 21:04:07 +0200
Message-Id: <patch-v7-03.17-1e40a4235e9-20210920T190305Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.g29a6526ae47
In-Reply-To: <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com>
References: <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com> <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If fsck we move an object around between .git/objects/?? directories
to simulate a hash mismatch "git fsck" will currently hard die() in
object-file.c. This behavior will be fixed in subsequent commits, but
let's test for it as-is for now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1450-fsck.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index f8edd15abf8..175ed304637 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -69,6 +69,30 @@ test_expect_success 'object with hash mismatch' '
 	)
 '
 
+test_expect_success 'object with hash and type mismatch' '
+	git init --bare hash-type-mismatch &&
+	(
+		cd hash-type-mismatch &&
+
+		oid=$(echo blob | git hash-object -w --stdin -t garbage --literally) &&
+		old=$(test_oid_to_path "$oid") &&
+		new=$(dirname $old)/$(test_oid ff_2) &&
+		oid="$(dirname $new)$(basename $new)" &&
+
+		mv objects/$old objects/$new &&
+		git update-index --add --cacheinfo 100644 $oid foo &&
+		tree=$(git write-tree) &&
+		cmt=$(echo bogus | git commit-tree $tree) &&
+		git update-ref refs/heads/bogus $cmt &&
+
+		cat >expect <<-\EOF &&
+		fatal: invalid object type
+		EOF
+		test_must_fail git fsck 2>actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'branch pointing to non-commit' '
 	git rev-parse HEAD^{tree} >.git/refs/heads/invalid &&
 	test_when_finished "git update-ref -d refs/heads/invalid" &&
-- 
2.33.0.1098.g29a6526ae47

