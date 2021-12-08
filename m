Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31D9C433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 23:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241192AbhLHXqw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 18:46:52 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61152 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241171AbhLHXqt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 18:46:49 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A7D31ECD70;
        Wed,  8 Dec 2021 18:43:16 -0500 (EST)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=qnTwghWVxQCrTAvd9KW4gEXFJ
        MDcvzDiLrtdrmlsit0=; b=QZWJY4DzgiWXcfuQu271YEiQK8zuocTX9DnxxiWvU
        Dk7LE2u0Ijrn748i6nu6HmhoHpFjSuMS2PcNpGXTgfjOwlHjVvLsW6V2mgiib6n1
        kW4Q1wsI7RFm+LI0qy+eNiGiXvP0Ib+vaHX2ttohBCCUlCEoOCpdyS2DjmUGBbx7
        3Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A0693ECD6F;
        Wed,  8 Dec 2021 18:43:16 -0500 (EST)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 05CE7ECD6E;
        Wed,  8 Dec 2021 18:43:15 -0500 (EST)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v5.1 1/8] t/fmt-merge-msg: make gpg/ssh tests more specific
Date:   Wed,  8 Dec 2021 15:43:06 -0800
Message-Id: <20211208234313.3052303-2-gitster@pobox.com>
X-Mailer: git-send-email 2.34.1-365-gae484d3562
In-Reply-To: <20211208234313.3052303-1-gitster@pobox.com>
References: <20211208234313.3052303-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 9D56E03C-5880-11EC-A97C-C48D900A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Fabian Stelzer <fs@gigacodes.de>

All the GPG and GPGSSH tests are redirecing stdout as well as stderr
to `actual` and grep for success/failure over the resulting file.
However, no output is printed on stderr and we do not need to
include it in the grep.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t6200-fmt-merge-msg.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 06c5fb5615..b18ba58745 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -104,7 +104,7 @@ test_expect_success 'message for merging local branch=
' '
 test_expect_success GPG 'message for merging local tag signed by good ke=
y' '
 	git checkout main &&
 	git fetch . signed-good-tag &&
-	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
 	grep "^Merge tag ${apos}signed-good-tag${apos}" actual &&
 	grep "^# gpg: Signature made" actual &&
 	grep "^# gpg: Good signature from" actual
@@ -113,7 +113,7 @@ test_expect_success GPG 'message for merging local ta=
g signed by good key' '
 test_expect_success GPG 'message for merging local tag signed by unknown=
 key' '
 	git checkout main &&
 	git fetch . signed-good-tag &&
-	GNUPGHOME=3D. git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
+	GNUPGHOME=3D. git fmt-merge-msg <.git/FETCH_HEAD >actual &&
 	grep "^Merge tag ${apos}signed-good-tag${apos}" actual &&
 	grep "^# gpg: Signature made" actual &&
 	grep -E "^# gpg: Can${apos}t check signature: (public key not found|No =
public key)" actual
@@ -123,7 +123,7 @@ test_expect_success GPGSSH 'message for merging local=
 tag signed by good ssh key
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	git checkout main &&
 	git fetch . signed-good-ssh-tag &&
-	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
 	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
 	! grep "${GPGSSH_BAD_SIGNATURE}" actual
 '
@@ -132,7 +132,8 @@ test_expect_success GPGSSH 'message for merging local=
 tag signed by unknown ssh
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	git checkout main &&
 	git fetch . signed-untrusted-ssh-tag &&
-	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
+	grep "^Merge tag ${apos}signed-untrusted-ssh-tag${apos}" actual &&
 	grep "${GPGSSH_GOOD_SIGNATURE_UNTRUSTED}" actual &&
 	! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
 	grep "${GPGSSH_KEY_NOT_TRUSTED}" actual
--=20
2.34.1-365-gae484d3562

