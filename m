Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A6ACCA481
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 14:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358369AbiFVO3h (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 10:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358259AbiFVO2S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 10:28:18 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799441E3F1
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 07:28:17 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id n1so23434929wrg.12
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 07:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vNbdYyLvsPGnbc44NFGJLiVkWfg8HWxJb4yhAWMq2Jo=;
        b=AOM9C0sqwf/SQchcGyBtk9qrfq6KFHO1YWDpovTnUIdmvkN/F9shRRxEt4Wtp2sS7x
         2RQj8cz64io8U54KuACq2J7E7NmMO0J9FUvd37rHsgqGoj6uA1QKYmCDeSDxjZhRURlD
         smp0yx7qWCGJn71uCy8XAox7WhQW3+zeIVK5GeQZwte6UnF0JhMfX/3uF7DCMs6cZodk
         Kx6K9VruJ0EvlOW0Faclr/2XQqGvhRXX4PYSBl8kt4YpEHvHHeEJyOis/zJf+i/5LfNO
         vkEWdUcdt8IucJtbuFRHEfqBsDhxc+uqdRSsLqBg/S2tG48YL2j3CNnK9RihP9DumEKE
         hUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vNbdYyLvsPGnbc44NFGJLiVkWfg8HWxJb4yhAWMq2Jo=;
        b=QP+V33mB1/lFt7Blv/yOSBBgBJQU9r45/NMTzL4QTela3mxAjeMbfs0ylarTRd3Rpg
         n9iHhjzcFqe5aHcV0iIenAv6YPsU261cm8Q6EvBGvIYtFLAKxxJ9P+QPOuXam+jgxzOp
         5b6xGwqRF+awq8zZWLkB86vNqeeztI1G2tc3ZGKCPBTpCB80NOoOwDfPWQ2kpoJBdBW4
         hzn5N9NzDW0e7deyLWORWUQb15YIOSk1m/Z9UoF3NNPiYZgBA4hmwZgcJhPEa5tX0JCH
         YpbCbV96TOkwMXo4chXPAzTB+t7W14sDI9vHQo/Nhl9ZAT+jUHvJSw1WkhUqCviKYE8B
         GRYw==
X-Gm-Message-State: AJIora9XQlQqomZ2q8+QdiHUSGQ8RNB6tBa+8zcihWq/yn54IfqH9jzt
        XDXLo4uLGTlpEQZgeNkdOXmiWAMPqPI1GA==
X-Google-Smtp-Source: AGRyM1vCSJYbcbZNKd0lHVWhwDkquHBtayvC3Y+SlTNXHMrIx8xftV/BSz9W9GYEAomjWhKGi9RqsA==
X-Received: by 2002:adf:dc91:0:b0:21b:89bc:9d5c with SMTP id r17-20020adfdc91000000b0021b89bc9d5cmr3637509wrj.159.1655908096703;
        Wed, 22 Jun 2022 07:28:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j11-20020a05600c190b00b0039c5328ad92sm30468304wmq.41.2022.06.22.07.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 07:28:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 06/12] submodule update: remove "-v" option
Date:   Wed, 22 Jun 2022 16:28:01 +0200
Message-Id: <patch-v3-06.12-b82faad77bb-20220622T142012Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com>
References: <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com> <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In e84c3cf3dc3 (git-submodule.sh: accept verbose flag in cmd_update to
be non-quiet, 2018-08-14) the "git submodule update" sub-command was
made to understand "-v", but the option was never documented.

The only in-tree user has been this test added in
3ad0401e9e6 (submodule update: silence underlying merge/rebase with
"--quiet", 2020-09-30), it wasn't per-se testing --quiet, but fixing a
bug in e84c3cf3dc3: It used to set "GIT_QUIET=0" instead of unsetting
it on "-v", and thus we'd end up passing "--quiet" to "git
submodule--helper" on "-v", since the "--quiet" option was passed
using the ${parameter:+word} construct.

Furthermore, even if someone had used the "-v" option they'd only be
getting the default output. Our default in both git-submodule.sh and
"git submodule--helper" has been to be "verbose", so the only way this
option could have matter is if it were used as e.g.:

    git submodule --quiet update -v [...]

I.e. to undo the effect of a previous "--quiet" on the command-line.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-submodule.sh            | 3 ---
 t/t7406-submodule-update.sh | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 5b9683bf766..0df6b0fc974 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -241,9 +241,6 @@ cmd_update()
 		-q|--quiet)
 			GIT_QUIET=1
 			;;
-		-v)
-			unset GIT_QUIET
-			;;
 		--progress)
 			progress=1
 			;;
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 43f779d751c..06d804e2131 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -1074,7 +1074,7 @@ test_expect_success 'submodule update --quiet passes quietness to merge/rebase'
 	 git submodule update --rebase --quiet >out 2>err &&
 	 test_must_be_empty out &&
 	 test_must_be_empty err &&
-	 git submodule update --rebase -v >out 2>err &&
+	 git submodule update --rebase >out 2>err &&
 	 test_file_not_empty out &&
 	 test_must_be_empty err
 	)
-- 
2.36.1.1239.gfba91521d90

