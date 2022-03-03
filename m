Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE76C433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 00:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiCCA6d (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 19:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbiCCA62 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 19:58:28 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1DA151680
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 16:57:43 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id h3-20020a628303000000b004e12f44a262so2159282pfe.21
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 16:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=psWNFvxVHzRNwn7LAZ1WWs1LyNdO3zDnyzLnegifRc4=;
        b=O9xWLOTn9CTsP++a9NgPZoaXBmiyv4hGW8tdhOOAP0nPLYMjaweKWOu/ZSZID8jKnf
         Kb5LE0qYt0j1ynlijorlrmtIhA8yK71hBRGyDxhFlSAy3f4gv2+tima0CWIuLHtQMRDD
         /y46Yy8NFsweZ9H8a05dcRtLHOWyi9eW5DSbCi6ZHMtlaa9Lq5liYYW+sA2vjydEOlde
         nmITY0YG2vfXd0ZB29LBkPmdysJXeeHYXBcpyRAIIwpsdtbHipDG+wwmbJNHdbGrJNga
         se52Lf1N+U5onunA58vEPUa0ZE0E7qc3g/ajmM66VMpo7EF9zfjOZE8881/06EUTHSIW
         bp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=psWNFvxVHzRNwn7LAZ1WWs1LyNdO3zDnyzLnegifRc4=;
        b=YtFN1sbKoVykrCkGEGFaWMLyeLKSSV/G6W9isxvSssL99BiBmIaXYG+rrGVCXb0AUy
         XuhL1JwlA/OtEcPUN58n5KncEZlZL6hRsEukNu0D/g1Zr25yr8hdLTIZrQFtqWbUdOrV
         1bUE4PCfphsoSPucnBhNl8GHJn2BnxjUhoem0opRu4au4ZUSvYs1E/e32UQKw3vnxwG5
         G266jyRU3Srsve+wr2bEdzhaWRbnJgfH0SXK04ZO0W45Viz7L16nvDIih2h+pLMHPNV2
         GwP7jVqcofPFejzGYyCA7JVA0MnBe4M9ayEESb0HjMq2mcyd/ofeOhEW+pulc4JXfbS9
         Kj5w==
X-Gm-Message-State: AOAM5310YbEhsRtarz00JKlf927YBd1b9MZq0Tz4mVO5TwbxxSyBeOVW
        RsNvlFx3UdUjbewv68jg6lyuHExuPgHtYCXoiz7Hz1aacwVQ/R+WAIrqZn0emvmfEM9VMB/vmPx
        yoVW8ZItrZF7ry9Ah7vCIefsnFh0l0j07uaitLfIzTsCu2mxG3ELH4R3TgbAItFo=
X-Google-Smtp-Source: ABdhPJyE1K3El9B7KgpUjvublZP9hFovL4G/LvFFsd29SXCjly0al0urI2NSth7WGFUZnyz5J4IOi2jbSUUL7g==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:bf04:b0:149:c5a5:5323 with SMTP
 id bi4-20020a170902bf0400b00149c5a55323mr33384162plb.97.1646269063228; Wed,
 02 Mar 2022 16:57:43 -0800 (PST)
Date:   Wed,  2 Mar 2022 16:57:15 -0800
In-Reply-To: <20220303005727.69270-1-chooglen@google.com>
Message-Id: <20220303005727.69270-2-chooglen@google.com>
Mime-Version: 1.0
References: <20220301044132.39474-1-chooglen@google.com> <20220303005727.69270-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v3 01/13] submodule tests: test for init and update failure output
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

