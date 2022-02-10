Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A93C433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 09:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238582AbiBJJ3I (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 04:29:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238539AbiBJJ3E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 04:29:04 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE46D95
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:29:05 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id q16-20020a170902edd000b0014d6be8d4b7so1147405plk.18
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=PcDPigmq9mq3SJk3g82pK/HsmEj4Qxy6w2HHVzWfTMo=;
        b=tCD2rhtnU1sWsQ85nQhQgx5Npnxzzxp5ycw2c5D+6F6rI+Z1hreUYLXSA390/HNbs2
         lTN8qnU/6CHsAAgNO0sAjYk3jBZ/hP/uXMeI4E5wRycsGoGrnaR0YQoOmVh04AFDO41E
         g4vu+lWvJOT1ZFsA/Avf0AKiR20GKf12qv37G06TWUFKWqzEfgWKsgKSyRzQ9cM8flqC
         o34/kEsAwGL4o2vPYhoDbq+K0OXT/LW9SSM1LOVmrtPx+X6FUFf308obYvx3nTQInPT6
         Es9MB9MJou4bFzXWtPtf+5SqeDvUzi350Lc0dVQ2L/sFNjVK3lPS438beaDICQSK8cph
         B90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=PcDPigmq9mq3SJk3g82pK/HsmEj4Qxy6w2HHVzWfTMo=;
        b=s5oRpHX1x4yQwUlnAt6gzpNV3b/V7AGzYq5Vs30R8M3yDJDTcD7xbIAntC2h+1CDOi
         fa+sahM+bGSHIKTW5ULYimMOiaWZVMoaZ+o7K82ieGRcu39W7QuEq5r0zzabYHBkOhuR
         Sy1Ycn/A1/ujp8OOT7npKIp3uXwDETuNNpnkOLdsqHBcEoza9eZ5iKdUhE1gMfQ2yN1v
         z+xDsiktYAbISRyJBiGzeD560qBlW+Qf5tCVRGJPD4FQrCnXy5oy5WPiLLpPWtIfwGFK
         oMqrmIQbmHHYv067UI9W9QgFxAVQqYF14LdOUavQrsHEOuM/9oXf84oMqnqKrmvJUkF2
         m20A==
X-Gm-Message-State: AOAM530r2Ueo2TP2F2tki8Md2+VX38kSBgZmWdvOwYe5MXsKJgiSQibE
        B3MHZ3RBfD9gBafav+p3a7WWRI60aQdiE5MamzismyZJrL2VhUTP9jKKIHULque8C5Ev8pmCqHQ
        mLZd4MMDJpr1eJD4yLEyBsraWt9+R05oJlzc0jZcF81LBANP9L9/KqSRirKgFXgU=
X-Google-Smtp-Source: ABdhPJynbpgKJkJRu+7TpJ99CaB/ts5LTAOcOjUX4/dOAfguvkMEpEn+M2jBEf2b9bpM0xmKWGUU+OcmsIFS1A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:4a52:: with SMTP id
 lb18mr659947pjb.92.1644485345023; Thu, 10 Feb 2022 01:29:05 -0800 (PST)
Date:   Thu, 10 Feb 2022 17:28:21 +0800
In-Reply-To: <20220210092833.55360-1-chooglen@google.com>
Message-Id: <20220210092833.55360-9-chooglen@google.com>
Mime-Version: 1.0
References: <20220208083952.35036-1-chooglen@google.com> <20220210092833.55360-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v7 08/20] submodule tests: test for init and update failure output
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

Amend some submodule tests to test for the failure output of "git
submodule [update|init]". The lack of such tests hid a regression in
an earlier version of a subsequent commit.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7406-submodule-update.sh    | 14 ++++++++++++--
 t/t7408-submodule-reference.sh | 14 +++++++++++++-
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 11cccbb333..7764c1c3cb 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -205,8 +205,18 @@ test_expect_success 'submodule update should fail due =
to local changes' '
 	 (cd submodule &&
 	  compare_head
 	 ) &&
-	 test_must_fail git submodule update submodule
-	)
+	 test_must_fail git submodule update submodule 2>../actual.raw
+	) &&
+	sed "s/^> //" >expect <<-\EOF &&
+	> error: Your local changes to the following files would be overwritten b=
y checkout:
+	> 	file
+	> Please commit your changes or stash them before you switch branches.
+	> Aborting
+	> fatal: Unable to checkout OID in submodule path '\''submodule'\''
+	EOF
+	sed -e "s/checkout $SQ[^$SQ]*$SQ/checkout OID/" <actual.raw >actual &&
+	test_cmp expect actual
+
 '
 test_expect_success 'submodule update should throw away changes with --for=
ce ' '
 	(cd super &&
diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.s=
h
index a3892f494b..c3a4545510 100755
--- a/t/t7408-submodule-reference.sh
+++ b/t/t7408-submodule-reference.sh
@@ -193,7 +193,19 @@ test_expect_success 'missing nested submodule alternat=
e fails clone and submodul
 		cd supersuper-clone &&
 		check_that_two_of_three_alternates_are_used &&
 		# update of the submodule fails
-		test_must_fail git submodule update --init --recursive
+		cat >expect <<-\EOF &&
+		fatal: submodule '\''sub'\'' cannot add alternate: path ... does not exi=
st
+		Failed to clone '\''sub'\''. Retry scheduled
+		fatal: submodule '\''sub-dissociate'\'' cannot add alternate: path ... d=
oes not exist
+		Failed to clone '\''sub-dissociate'\''. Retry scheduled
+		fatal: submodule '\''sub'\'' cannot add alternate: path ... does not exi=
st
+		Failed to clone '\''sub'\'' a second time, aborting
+		fatal: Failed to recurse into submodule path ...
+		EOF
+		test_must_fail git submodule update --init --recursive 2>err &&
+		grep -e fatal: -e ^Failed err >actual.raw &&
+		sed -e "s/path $SQ[^$SQ]*$SQ/path .../" <actual.raw >actual &&
+		test_cmp expect actual
 	)
 '
=20
--=20
2.33.GIT

