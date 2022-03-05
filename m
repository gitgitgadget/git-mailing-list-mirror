Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000BEC433EF
	for <git@archiver.kernel.org>; Sat,  5 Mar 2022 00:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiCEAPp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 19:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiCEAPn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 19:15:43 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B237724317C
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 16:14:54 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id z10-20020a170902708a00b0014fc3888923so5386774plk.22
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 16:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=psWNFvxVHzRNwn7LAZ1WWs1LyNdO3zDnyzLnegifRc4=;
        b=OhhjEzjQR2Kqu2do+0He7X9JLlLuzriIiHGA4qhCSEYa7uS//go7EBV1sVeygWTxW/
         tGcH0TfAwfDeWUyoZ7lkZBA2VNg96kWj9Ppv0grj9LPaQCxJCZhKUCOKDc8wx4tj15uN
         W9Cc7mipO74R5zE4utKPLzXYBQ9nEHa2pOy+fOMwhxOOFv+asKxVSengc013efdMzbSo
         Qz1sZ/BzPZe+/eajfRXqS1Sb46pqJJC6ktAMa0ABB0t7bxE/7v1rH4GgyuQNztCISqzC
         tGY34ym/zRkspUWe4OPF5/V/1peD9iHeUx3472hZYt73ewsATMvy6X/hwHt3UGsdB39F
         QCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=psWNFvxVHzRNwn7LAZ1WWs1LyNdO3zDnyzLnegifRc4=;
        b=37y+SXeb51ZFu9CbUbYWy9zZWT0c7B9w95A3GS/qBCaV4rnSyZX4N+Q6a+TOzErt4r
         AtFctI8v8Ev+FJsIEvJyFBqSXlUzsDsbKPYr2ziPgMagUUyg9zCDluTT4dJsY7jdMvCt
         sgAGb3Kw6mJNBm/SxpTRXbFtGpt6jdoJTqKjIb7U5KniYNIc16V//nUtIOy8brJzrYMy
         FVj1B9zCi3YX376potNuw1dqtju1+lHayYQEMlzNTG6ugsHseEmjZFnE5vjvUn/ZvpDY
         n6RHcCQG5wDI6ThmM5/u3sQv0MMuFWz0KUHURXk2Vkeq72OhoiuGZoyvpyjnqXpYFxiC
         +SNQ==
X-Gm-Message-State: AOAM532OD35N4rkZ5Nk7IzV1RMVLFq6/zfZpkgDjU/u63K4esm+HInoD
        LF0rb2h4hd+eqUZ2YLu13WZ6kjkCdCX9EtdX3xnMhIBO+0oI/hO9rK+mqASMUTZ0AZxr0ukK1Dy
        ibMrUzx6slVSioGD7xF9sgrDw/e0noCx1yU5FL6ZQjrHnN1akHbOZtMc3wX5z5p4=
X-Google-Smtp-Source: ABdhPJwxTiN2YxFNOasJ28Oe1EKm+XR+r1zRFJ8uK0PJny8tB9iBBMkRAzyXz1PrzqHH1q0U90EL6rfoW957rw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:e805:b0:14f:d33b:b769 with SMTP
 id u5-20020a170902e80500b0014fd33bb769mr997979plg.24.1646439294081; Fri, 04
 Mar 2022 16:14:54 -0800 (PST)
Date:   Fri,  4 Mar 2022 16:13:49 -0800
In-Reply-To: <20220305001401.20888-1-chooglen@google.com>
Message-Id: <20220305001401.20888-2-chooglen@google.com>
Mime-Version: 1.0
References: <20220303005727.69270-1-chooglen@google.com> <20220305001401.20888-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v4 01/13] submodule tests: test for init and update failure output
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Josh Steadmon <steadmon@google.com>
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
Signed-off-by: Glen Choo <chooglen@google.com>
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

