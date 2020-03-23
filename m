Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAF3C54FCE
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 13:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306802072D
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 13:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAdPeDWi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgCWNJ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 09:09:56 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37643 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbgCWNJz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 09:09:55 -0400
Received: by mail-ed1-f67.google.com with SMTP id b23so16127021edx.4
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 06:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bH40N9bh2GlGKo+JoKJ53SDoMaOqCQezpdTv8F+37dM=;
        b=bAdPeDWiHGZXxA8c0b8+Ae7v8YVsTZmvxMGEKIuEbOopbUTfE2idXCMdpwNzVtKFCK
         wgBaUAT/vgfpPYYbrf5mSgS8luqCuBu8fZVtTk/Jm3ZQaDoKItCwKzGSPIA9iIlN3S0A
         /sc56BwxZhkVPUZGWs8D9X3/DLY9UlOgd7HPB0FXbl3ei6npdlL4gLJdIMTEY93feOCf
         Ej8F4eeCabyvxYOMeoLZZKPx74cdOZW9/EyMRTRotCpeUWUzMRlsmdi4qAUfwPPW+Eaf
         ohWJL0Qfl+rkpfWP+HxXUVEe+T7Frd4QHOmN0PfK5sOngOLseLmn6xfqGr7bmvp9DopL
         v/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bH40N9bh2GlGKo+JoKJ53SDoMaOqCQezpdTv8F+37dM=;
        b=p74DisyYcXfBGBoL8CIfeDzKg1mQkUt1S95mVtg3GRypKfNlLhjIxZxpPVolMXZ+31
         liUP0S4iEywwSP1d+s3umWmQTVZdmv8yQ3QBa5jCq6gG3BmfmptrB8f0pL3Fwhc7YC2K
         KpfNwP4BVLbhTPf4Bo5fqi5hU80eMiUikGkeYSWb6vkKl6llNuCoSXHiUG/liir0oJNn
         qEHsLiav1ImSrLq1P8z6OSjmDK8RzRBqhxWTGcWR8AVmrkHuGwDYA4j3eVyzvS2mQ/DS
         Zmk3J1goOqVYvCuDwa+tYGnbXAeF0yhfn7rBDMhy4bvoPwjb5Xm/7spHOJu6Je2nLgYX
         ZvbQ==
X-Gm-Message-State: ANhLgQ29AKgCoO+RuSIWOeoKKV5xDlRxVpamwRQk0HRBU5LpZ0T6xBtL
        TDOdDZUl9IgR7k12dn0RbjG1PA/2
X-Google-Smtp-Source: ADFU+vus+JTA7H7FQH8kcWDASBiHRs7guvAdYafL/EApm6XyiuE4mvDwBApAcr36Z8jlcLhNFYGuBw==
X-Received: by 2002:a17:906:ad92:: with SMTP id la18mr20090242ejb.326.1584968993286;
        Mon, 23 Mar 2020 06:09:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 91sm1018917edq.78.2020.03.23.06.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 06:09:52 -0700 (PDT)
Message-Id: <dd26cb05a37a54d9d245823772d33fe0daab8ffa.1584968990.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.728.git.git.1584968990.gitgitgadget@gmail.com>
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Mar 2020 13:09:50 +0000
Subject: [PATCH 2/2] tests(gpg): increase verbosity to allow debugging
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
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

Let's fix this by redirecting the output not to `/dev/null`, but to the
file descriptors that may, or may not, be redirected via
`--verbose-log`. For good measure, also turn on tracing if the user
asked for it, and prefix it with a helpful info message.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/lib-gpg.sh | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 11b83b8c24a..a7d0708f5df 100755
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -11,6 +11,8 @@ then
 		say "Your version of gpg (1.0.6) is too buggy for testing"
 		;;
 	*)
+		say_color info >&4 "Trying to set up GPG"
+		want_trace && set -x
 		# Available key info:
 		# * Type DSA and Elgamal, size 2048 bits, no expiration date,
 		#   name and email: C O Mitter <committer@example.com>
@@ -31,13 +33,13 @@ then
 		chmod 0700 ./gpghome &&
 		GNUPGHOME="$PWD/gpghome" &&
 		export GNUPGHOME &&
-		(gpgconf --kill gpg-agent >/dev/null 2>&1 || : ) &&
-		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import \
-			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
-		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import-ownertrust \
-			"$TEST_DIRECTORY"/lib-gpg/ownertrust &&
-		gpg --homedir "${GNUPGHOME}" </dev/null >/dev/null 2>&1 \
-			--sign -u committer@example.com &&
+		(gpgconf --kill gpg-agent >&3 2>&4 || : ) &&
+		gpg --homedir "${GNUPGHOME}" --import \
+			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg >&3 2>&4 &&
+		gpg --homedir "${GNUPGHOME}" --import-ownertrust \
+			"$TEST_DIRECTORY"/lib-gpg/ownertrust >&3 2>&4 &&
+		gpg --homedir "${GNUPGHOME}" </dev/null \
+			--sign -u committer@example.com >&3 2>&4 &&
 		test_set_prereq GPG &&
 		# Available key info:
 		# * see t/lib-gpg/gpgsm-gen-key.in
@@ -54,28 +56,29 @@ then
 		#	gpgsm --homedir /tmp/gpghome/ \
 		#		-o t/lib-gpg/gpgsm_cert.p12 \
 		#		--export-secret-key-p12 "committer@example.com"
-		echo | gpgsm --homedir "${GNUPGHOME}" 2>/dev/null \
+		echo | gpgsm --homedir "${GNUPGHOME}" >&3 2>&4 \
 			--passphrase-fd 0 --pinentry-mode loopback \
 			--import "$TEST_DIRECTORY"/lib-gpg/gpgsm_cert.p12 &&
 
-		gpgsm --homedir "${GNUPGHOME}" 2>/dev/null -K |
+		gpgsm --homedir "${GNUPGHOME}" -K 2>&4 |
 		grep fingerprint: |
 		cut -d" " -f4 |
 		tr -d '\n' >"${GNUPGHOME}/trustlist.txt" &&
 
 		echo " S relax" >>"${GNUPGHOME}/trustlist.txt" &&
-		echo hello | gpgsm --homedir "${GNUPGHOME}" >/dev/null \
-			-u committer@example.com -o /dev/null --sign - 2>&1 &&
+		echo hello | gpgsm --homedir "${GNUPGHOME}" >&3 2>&4 \
+			-u committer@example.com -o /dev/null --sign - &&
 		test_set_prereq GPGSM
 		;;
 	esac
 fi
 
 if test_have_prereq GPG &&
-    echo | gpg --homedir "${GNUPGHOME}" -b --rfc1991 >/dev/null 2>&1
+    echo | gpg --homedir "${GNUPGHOME}" -b --rfc1991 >&3 2>&4
 then
 	test_set_prereq RFC1991
 fi
+want_trace && set +x
 
 sanitize_pgp() {
 	perl -ne '
-- 
gitgitgadget
