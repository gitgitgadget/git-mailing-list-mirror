Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C67C433EF
	for <git@archiver.kernel.org>; Sun, 12 Dec 2021 20:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhLLUPC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Dec 2021 15:15:02 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:41729 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbhLLUOq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 15:14:46 -0500
Received: by mail-wr1-f45.google.com with SMTP id a9so23824790wrr.8
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 12:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ThIlTancmNRkDkEkINWcSb8Jb50jcasG1TIrQz4X8Y=;
        b=bH0nGpJFoaQbvTgRKaUJWwtsueW0/LhFyEw3huLcUJAtt0lvEeLPXNMqX0J9Z5qRGb
         KNqaUqVeJu0kS+GXcaCnViil4aAyKZYDvftUYuP/4kyU9V8rDZzHBOz2qPFCZY/tYcJ5
         K4G2bm9PR/jFUZmalm63v9zrnyAFOaL1YHE9hyLxdUkvFO83HuJqHkikORV3GVHWnP2i
         wsxk7kSQCZIPhK41D2tMK6qLR8DFw5F2QBzVMihJl98Vf20Rc9QuUO/PknowS18/7DNM
         bkJSMf4w+5KyCRmLOoo+4oi76l/sOuEpzodbGluBiDdwno8jWGANDn610XQAexi5dmhR
         MWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ThIlTancmNRkDkEkINWcSb8Jb50jcasG1TIrQz4X8Y=;
        b=hL8DoxgxsWChbi8uyx7sILb4tOHTNIfx0EipbahKp+4jjyVF9W07P56vaQ+Xg4QK9G
         Vbe9yULuHhl2e19BLjM4CrAsp7yf5iQZbWqeOONRrMGfq4owwLaa76yk14hbUXRo7v2K
         sOhmDCNAiosyRG/2GC4PFIzS+JUpU33cml+/jb9mR934+nG/R5EizQU2p5bg5LXcdjRu
         OOP250gBu5p9wqlFbWZU6atJy28Ej1DTgunXDu+w5bhnSY3Yu70bZXwgOFvQEIq+sFOi
         I33SlaJvG8LJcytpnumgWQOzBbCzuNcyX3GSMGNaQ+eYqeE6f+EDW1XNsixfES5ApfNl
         /m1g==
X-Gm-Message-State: AOAM530efrxGe7/8yZw69n24Oa4DfpjZ6RigKX5GKFStBIZDCIElxI54
        oZRy8Fw9NbosWWB86C19Ns133TqWe87WTg==
X-Google-Smtp-Source: ABdhPJwGdoMBryrFf8U1eEhbgRY6P/mnoYhXcSesLtifSOh26dXSC9Gx+00so7QpYxW0hc4NDaCEtA==
X-Received: by 2002:adf:8b47:: with SMTP id v7mr12564082wra.715.1639340024890;
        Sun, 12 Dec 2021 12:13:44 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay21sm4824336wmb.7.2021.12.12.12.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 12:13:44 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 12/13] tests: migrate miscellaneous "write_script" to "write_hooks"
Date:   Sun, 12 Dec 2021 21:13:22 +0100
Message-Id: <patch-12.13-2acbaa77f8d-20211212T201308Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1020.gb1392dd1877
In-Reply-To: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3430-rebase-merges.sh    | 5 +++--
 t/t5540-http-push-webdav.sh | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 43c82d9a33b..8003e41427c 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -292,9 +292,10 @@ test_expect_success 'post-rewrite hook and fixups work for merges' '
 	git commit --fixup HEAD same2.t &&
 	fixup="$(git rev-parse HEAD)" &&
 
-	mkdir -p .git/hooks &&
 	test_when_finished "rm .git/hooks/post-rewrite" &&
-	echo "cat >actual" | write_script .git/hooks/post-rewrite &&
+	write_hook post-rewrite <<-\EOF &&
+	cat >actual
+	EOF
 
 	test_tick &&
 	git rebase -i --autosquash -r HEAD^^^ &&
diff --git a/t/t5540-http-push-webdav.sh b/t/t5540-http-push-webdav.sh
index 8b1f76fb3b8..31d13547b26 100755
--- a/t/t5540-http-push-webdav.sh
+++ b/t/t5540-http-push-webdav.sh
@@ -36,7 +36,7 @@ test_expect_success 'setup remote repository' '
 	git clone --bare test_repo test_repo.git &&
 	cd test_repo.git &&
 	git --bare update-server-info &&
-	write_script "hooks/post-update" <<-\EOF &&
+	write_hook post-update <<-\EOF &&
 	exec git update-server-info
 	EOF
 	ORIG_HEAD=$(git rev-parse --verify HEAD) &&
-- 
2.34.1.1020.gb1392dd1877

