Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3588C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 00:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiCAAJF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 19:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiCAAJD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 19:09:03 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0C79A4CC
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 16:08:23 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id d5-20020a623605000000b004e01ccd08abso8570930pfa.10
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 16:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=psWNFvxVHzRNwn7LAZ1WWs1LyNdO3zDnyzLnegifRc4=;
        b=WvJve62/u1B9Z6AEP1p/PUuFb3VaEH4vU2bOLZxWAUN8imx3XRFLPS+aPL8aoPqO8j
         w7XCPN5oiJ+hnJdIe4dF9Au/xrSpBLCrqo3OpEt//HxaoJStPjpIU8nnY5AlpgENB+jZ
         nepMQxl1RsHvHU+Ht9VIjQBNQhVDIbORpHU+L5fhbW1ACGIwxK9jYz+7+SD3NENl72vy
         2RH8wfyvuR+40+ZQW6c3SFb4YuatKGZJi3ZzcarFGuLC6PgIIjtdQ+hwb2rB/warrrj9
         3XHi3BLld/fC5T5Ujq9UHTwDtOKY53E94sJsX8cuwWDo2a/NoWJ/RIVQ4c33HdrPgmgB
         Jt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=psWNFvxVHzRNwn7LAZ1WWs1LyNdO3zDnyzLnegifRc4=;
        b=e8ZZ1h5+bzHNMjH2fv8lF2n5x9CWPFPOYMiqfBfmV8ZVLFJePk+bIGW5LjxheTmian
         CuaI4wA+YVyh9+AR/2bm/b7akhw5tS/KcITRu0EYF+i8JcVo7Q8Ug07SG3buKV4UJy9F
         tj/9E1gxpt8XEO6CWGS7UfsIi47mucAUrpGrUryxokNTN8XgOrIha8b2x8Lun1vm4pZN
         KJRBP0GfVO2JxNbTooSL0V8CDBUnCiVUtXaYaSmHUB1UxeyYnOWj4zQZqaLd4KB0UWs+
         9Rc9wZCsiPt/OX69g5qkTPAzARYrBtNh8WpXlyA1W2R3Rzj4SflMgFBd8byuPlKfegbS
         DFTw==
X-Gm-Message-State: AOAM530IUiAg/vx/Mxrg/mdNnUtQ5N/5TGY12envYC+abuccCtHdazbQ
        V86IDz+P9IxhOv/YpmIGYC39bLSdCqFpkl2lRhNnJqpjJbxlGa92vJWhh4iJbJuM66JxY78OVAf
        bNUCy6vxqsLkLWo94vBTpdHxhUguDhIu7k0ZeStIpE+WTsmT44iCtOgCHDy2Isf8=
X-Google-Smtp-Source: ABdhPJxDiO21VJMEcCJplaA89gZCqnTaSzbUJ+VcOBPbBMREwqMykeMA+cZuB0I/PlZKL8OCDINE6TA7DDcG0Q==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a62:7697:0:b0:4df:34dc:d6c5 with SMTP id
 r145-20020a627697000000b004df34dcd6c5mr1732500pfc.9.1646093302956; Mon, 28
 Feb 2022 16:08:22 -0800 (PST)
Date:   Mon, 28 Feb 2022 16:08:04 -0800
In-Reply-To: <20220301000816.56177-1-chooglen@google.com>
Message-Id: <20220301000816.56177-2-chooglen@google.com>
Mime-Version: 1.0
References: <20220301000816.56177-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH 01/13] submodule tests: test for init and update failure output
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

