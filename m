Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3DFC433F5
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 13:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3985611C7
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 13:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351402AbhI3NjS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 09:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351538AbhI3NjN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 09:39:13 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7851C06176E
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 06:37:30 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id t16-20020a1c7710000000b003049690d882so8436690wmi.5
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 06:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qm9f25krk0upFswiwr84ZshPl1GjzPVuBelyJiasPpI=;
        b=j8t5SeUWpdTh+++cklHuaTS3kT74KKpUMTf+3KYT4sJwH5mvCsMSWCH0FU0wI5/Hr7
         7QqhfTiykRyzgeRDlDkYxL6cn+Fea60Sf0Fjt/8dkxrQ6jPatrfk1SMY4WxTNCtqI88X
         gCaRt0k/G+qPZfn4Pv/oShrUj8NhyfRN5Zs7SExZ+S92aL4tERcUP1BEL6SFxoeZHos4
         84wPuJvwT6BmT4w1rbgROMKUX/iWXlwI/t6cVi7nTiX5N6H41gY+5VbSFnKjKR9JMInh
         FfWcF6fHmUkmd2DPPbDd32Jd2+pWOSa/OgqTH20cbphdzAu6P0v7CkitV3TjO2r2ucKW
         GVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qm9f25krk0upFswiwr84ZshPl1GjzPVuBelyJiasPpI=;
        b=oIYhwNLnIw6Ijzi3LqhMniKQ4MSEKGFNBJet8urPmiRkPo3ic1kZ/51Yt/o+Myhk/8
         zuyBVJ9+kZ4e9lR/lQ1bWhIBEAMST9m6Kzoq7RNQe04qF/VjOTd63dgPeC/QWW9ZH90f
         qehAoQCevZb7h8stSb8yLBj+oZwdYSEQXBVq4KZKsS7Fm43CKOefhJgO975qdiLeAsKB
         B97HBaSdT0TxwIPxUfElyNAA1NhpLobOZugcPqXfAvbuSex8X2910qcg88dArUSnL8dd
         UTzIhybhjw7JyHdXlrsnKSryXwM2hKcDYMOiMuaSNZsC5ZuMNAQFMNqqriTmxE+Gnwjw
         A2Ww==
X-Gm-Message-State: AOAM533PByd0Ur45iDp9VISTBZ9KtqSAExcegGunewHWqLAMJdGnKO7D
        +SdPzoA/arPjtyruxcX/CQaxD752su+ronpl
X-Google-Smtp-Source: ABdhPJwt7QRvAXFYHm9D9BgoTOJxCIYljvOTIME5gRtM/rVCpysM6NHGf8aiAHJ+aB91bDRzw5rQNw==
X-Received: by 2002:a05:600c:410b:: with SMTP id j11mr15876353wmi.142.1633009048781;
        Thu, 30 Sep 2021 06:37:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o11sm4654713wmh.11.2021.09.30.06.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 06:37:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 03/17] fsck tests: test current hash/type mismatch behavior
Date:   Thu, 30 Sep 2021 15:37:08 +0200
Message-Id: <patch-v9-03.17-102bc4f0176-20210930T133300Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1374.g05459a61530
In-Reply-To: <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com>
References: <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com> <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com>
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
2.33.0.1374.g05459a61530

