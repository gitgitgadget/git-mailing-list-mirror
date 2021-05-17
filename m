Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187C1C433B4
	for <git@archiver.kernel.org>; Mon, 17 May 2021 15:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F33AF610FA
	for <git@archiver.kernel.org>; Mon, 17 May 2021 15:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243952AbhEQPQL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 11:16:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57652 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243384AbhEQPNn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 11:13:43 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B612BCC28;
        Mon, 17 May 2021 11:12:25 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=BYo3W6xtE1jUoncb8cerrTQ0r
        JrJFoC+tdGJv5+SeIA=; b=EiJp8m1k8shWRnVxm6LqGRhplyKRIbNBnDBqXfjTO
        p8sOZPlK8l0UevPvW3MLzVqfJw+gAaIOsc6CoJ1TRjOZn0PpxD4A2zSxEJgBLzyk
        pVxSZ2VCzlsDfrfHx99rBZTTD37tmvebWjhGp5F4/mHajHR+XUfjOrz4BIjlzyUx
        2w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 831E5BCC27;
        Mon, 17 May 2021 11:12:25 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BC879BCC26;
        Mon, 17 May 2021 11:12:24 -0400 (EDT)
        (envelope-from tmz@pobox.com)
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] t7500: remove non-existant C_LOCALE_OUTPUT prereq
Date:   Mon, 17 May 2021 11:12:22 -0400
Message-Id: <20210517151222.2865093-1-tmz@pobox.com>
X-Mailer: git-send-email 2.32.0.rc0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Pobox-Relay-ID: 4938871C-B722-11EB-941E-D152C8D8090B-09356542!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The C_LOCALE_OUTPUT prerequisite was removed in b1e079807b (tests:
remove last uses of C_LOCALE_OUTPUT, 2021-02-11), where =C3=86var noted:

    I'm not leaving the prerequisite itself in place for in-flight change=
s
    as there currently are none that introduce new tests that rely on it,
    and because C_LOCALE_OUTPUT is currently a noop on the master branch
    we likely won't have any new submissions that use it.

One more use of C_LOCALE_OUTPUT did creep in with 3d1bda6b5b (t7500: add
tests for --fixup=3D[amend|reword] options, 2021-03-15).  This causes a
number of the tests to be skipped by default:

    ok 35 # SKIP --fixup=3Dreword: incompatible with --all (missing C_LOC=
ALE_OUTPUT)
    ok 36 # SKIP --fixup=3Dreword: incompatible with --include (missing C=
_LOCALE_OUTPUT)
    ok 37 # SKIP --fixup=3Dreword: incompatible with --only (missing C_LO=
CALE_OUTPUT)
    ok 38 # SKIP --fixup=3Dreword: incompatible with --interactive (missi=
ng C_LOCALE_OUTPUT)
    ok 39 # SKIP --fixup=3Dreword: incompatible with --patch (missing C_L=
OCALE_OUTPUT)

Remove the C_LOCALE_OUTPUT prerequisite from these tests so they are
not skipped.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
I noticed this while testing 2.32.0-rc0.  I grep for skipped tests to hel=
p me
catch missing requirements in the Fedora packages.

 t/t7500-commit-template-squash-signoff.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-t=
emplate-squash-signoff.sh
index 9092db5fdc..7d02f79c0d 100755
--- a/t/t7500-commit-template-squash-signoff.sh
+++ b/t/t7500-commit-template-squash-signoff.sh
@@ -413,7 +413,7 @@ test_expect_success 'amend! commit allows empty commi=
t msg body with --allow-emp
 '
=20
 test_fixup_reword_opt () {
-	test_expect_success C_LOCALE_OUTPUT "--fixup=3Dreword: incompatible wit=
h $1" "
+	test_expect_success "--fixup=3Dreword: incompatible with $1" "
 		echo 'fatal: reword option of --fixup is mutually exclusive with'\
 			'--patch/--interactive/--all/--include/--only' >expect &&
 		test_must_fail git commit --fixup=3Dreword:HEAD~ $1 2>actual &&
