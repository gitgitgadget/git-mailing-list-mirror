Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B227C54FD0
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 05:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B8520777
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 05:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qCDnX/Im"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgCYFlb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 01:41:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37940 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgCYFl2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 01:41:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id s1so1352160wrv.5
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 22:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ahQq2NZanyTLE/D0ebhWiNuIpzx43XZ+EEpggX/gI1k=;
        b=qCDnX/ImLC+zOcRqFmzCdPM2eZxc0QZAekIcH+xazM9PV+H1/lagZe42k+6M61YXI0
         DH77tnSVn+qsVUgZ4YYhjw8T8oC53cTdbKbKRXJxQx0CFwg6tZtY8TZ5fxCBLYfFMC5P
         uJhu3SN3bbXzVBIsHVAUFNIOp5jIPXR/vNNT+o/+dYujLuR5xgE9O2LQNssfav1G0vRi
         PwYxVj2NfC/ahdNN7xANeUTKc2mMEQTmiV5ewa2vriZ8FbSbfve/ykwF51zxuroFsXJ6
         9E/n1sd9Kt1v1WC4I3exVugva0DGQoUubWdcAaNjkibAoh1JHbAgF5nTJgqBM9Yb3DZv
         /NTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ahQq2NZanyTLE/D0ebhWiNuIpzx43XZ+EEpggX/gI1k=;
        b=i2VoBtIOkuJg+ZRJ5JVc9nTvMIoA7hCNHHGVosSSIJo0nBrpzEYs9qhfSG1h64jEtF
         bDOzXmNgqKT59AW3eyLND/OMXdoy0xCVwn981e0BGjt0LejsPD1wdd2WPgPRL0GqqKDC
         /74db5io1xajflMC7ofkzxoXxZfmzt3lJdZSB4QULDAjLGGDmK5byiozdSMAmspLJTHs
         L1k7VWlnFiMxL2oy6/4dQKyegJkuI+KcNnPZu91TZy0/21VAUOBy5EhIB9d63OFwBtya
         z/Qk+s0hhfAHBEHEj1DvIpeorPHnWeZqG957gtV/ofOHTZ6aBIH+Rl7obG3WeEmnSZgh
         379Q==
X-Gm-Message-State: ANhLgQ0qFAGsl7PbXnjK2SAyQoHi1FP6pn+ULCrsulprgNOdYbkch1r4
        c6Bpuh8t27udvsamKB5xSsRhHLag
X-Google-Smtp-Source: ADFU+vvwrU+Ht9dsEEdzkXRvlPyWVP1GTYhUQoL36/8Dg8ejeR4UGR+e1hCJRXo7Gf6Q1Hy+FM4kXA==
X-Received: by 2002:adf:82a6:: with SMTP id 35mr1406161wrc.307.1585114886275;
        Tue, 24 Mar 2020 22:41:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h26sm7544883wmb.19.2020.03.24.22.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 22:41:25 -0700 (PDT)
Message-Id: <5e89b512513af0e2e16dc93c86ae3d1145061a82.1585114881.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.728.v2.git.git.1585114881.gitgitgadget@gmail.com>
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com>
        <pull.728.v2.git.git.1585114881.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Mar 2020 05:41:21 +0000
Subject: [PATCH v2 5/5] tests: increase the verbosity of the GPG-related
 prereqs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Especially when debugging a test failure that can only be reproduced in
the CI build (e.g. when the developer has no access to a macOS machine
other than running the tests on a macOS build agent), output should not
be suppressed.

In the instance of `hi/gpg-prefer-check-signature`, where one
GPG-related test failed for no apparent reason, the entire output of
`gpg` and `gpgsm` was suppressed, even in verbose mode, leaving
interested readers no clue what was going wrong.

Let's fix this by no longer redirecting the output not to `/dev/null`.
This is now possible because the affected prereqs were turned into lazy
ones (and are therefore evaluated via `test_eval_` which respects the
`--verbose` option).

Note that we _still_ redirect `stdout` to `/dev/null` for those commands
that sign their `stdin`, as the output would be binary (and useless
anyway, because the reader would not have anything against which to
compare the output).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/lib-gpg.sh | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 7a78c562e8d..9fc5241228e 100755
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -40,12 +40,12 @@ test_lazy_prereq GPG '
 		#		> lib-gpg/ownertrust
 		mkdir "$GNUPGHOME" &&
 		chmod 0700 "$GNUPGHOME" &&
-		(gpgconf --kill gpg-agent >/dev/null 2>&1 || : ) &&
-		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import \
+		(gpgconf --kill gpg-agent || : ) &&
+		gpg --homedir "${GNUPGHOME}" --import \
 			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
-		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import-ownertrust \
+		gpg --homedir "${GNUPGHOME}" --import-ownertrust \
 			"$TEST_DIRECTORY"/lib-gpg/ownertrust &&
-		gpg --homedir "${GNUPGHOME}" </dev/null >/dev/null 2>&1 \
+		gpg --homedir "${GNUPGHOME}" </dev/null >/dev/null \
 			--sign -u committer@example.com
 		;;
 	esac
@@ -68,23 +68,23 @@ test_lazy_prereq GPGSM '
 	#	gpgsm --homedir /tmp/gpghome/ \
 	#		-o t/lib-gpg/gpgsm_cert.p12 \
 	#		--export-secret-key-p12 "committer@example.com"
-       echo | gpgsm --homedir "${GNUPGHOME}" 2>/dev/null \
-	       --passphrase-fd 0 --pinentry-mode loopback \
-	       --import "$TEST_DIRECTORY"/lib-gpg/gpgsm_cert.p12 &&
+	echo | gpgsm --homedir "${GNUPGHOME}" \
+		--passphrase-fd 0 --pinentry-mode loopback \
+		--import "$TEST_DIRECTORY"/lib-gpg/gpgsm_cert.p12 &&
 
-       gpgsm --homedir "${GNUPGHOME}" 2>/dev/null -K |
-       grep fingerprint: |
-       cut -d" " -f4 |
+	gpgsm --homedir "${GNUPGHOME}" -K |
+	grep fingerprint: |
+	cut -d" " -f4 |
 	tr -d "\\n" >"${GNUPGHOME}/trustlist.txt" &&
 
-       echo " S relax" >>"${GNUPGHOME}/trustlist.txt" &&
-       echo hello | gpgsm --homedir "${GNUPGHOME}" >/dev/null \
-	       -u committer@example.com -o /dev/null --sign - 2>&1
+	echo " S relax" >>"${GNUPGHOME}/trustlist.txt" &&
+	echo hello | gpgsm --homedir "${GNUPGHOME}" >/dev/null \
+	       -u committer@example.com -o /dev/null --sign -
 '
 
 test_lazy_prereq RFC1991 '
 	test_have_prereq GPG &&
-	echo | gpg --homedir "${GNUPGHOME}" -b --rfc1991 >/dev/null 2>&1
+	echo | gpg --homedir "${GNUPGHOME}" -b --rfc1991 >/dev/null
 '
 
 sanitize_pgp() {
-- 
gitgitgadget
