Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1D1C43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 15:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 871BF2082D
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 15:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThC2eQqW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbgCZPfj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:35:39 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46562 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbgCZPfi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 11:35:38 -0400
Received: by mail-ed1-f66.google.com with SMTP id cf14so7268833edb.13
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 08:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ahQq2NZanyTLE/D0ebhWiNuIpzx43XZ+EEpggX/gI1k=;
        b=ThC2eQqWsDf1qtcJzS6HGk/B6AIEUYJ5Z8Ca4uEaIr50B9L/oo8AuwN0d7YRrZs/G0
         G0r2JO9C7FH2TCW4/0MMENp0q3PpRN470YDeSElwn0tHZMdiXwdNYlrGDrh+wlsdynjr
         wrcU0DgLZj3ignCxI6hKiSr5OfHPIfpjA1HW9vO+Yx2WTerIYssl/ct24suD7xTQjmhg
         Go73x5ex2cR9ICraeyQ4gfjgxhwLvZ1XpLR7KapGBPPOPYOhxThnXuByvekjzq6lc3l9
         tlRD8Zj2DiWEGNTLLZDQJAgDRyslX9E0AxkIhgLdN5FJZ8+SGQb8u3MKCiiawgQASKNy
         cv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ahQq2NZanyTLE/D0ebhWiNuIpzx43XZ+EEpggX/gI1k=;
        b=IZ73z7ZkucWfA8ToSe4WYddQCXzYSBykZxUxt9fz/9JuYRXUm8/8GETL4oTQcvBQ1L
         NqZzr5kEmKkh75JUbvd0qtaaupf5ya7tNhiLm4SOnrxlkQrrA0+dHUSlbEhZzSmKwZmF
         toS7MAqfxdXz9+KwquLwYfx+NgIhR1xP7R5sCjKUUadtKXXTFr5qcUedoRvKopBLUauR
         9GJJnthzHydUFPBCRZabdnUhqPsS1epGW/khy4jPLkYm82TqR6oK7CUiAoPXaRj85xZc
         eUbPd2Qh2V2uHr3RuaWCTLb9nSw1TIvJsrMZLrc+VAcA4IVDAiQwnAaANSogGssLcFRf
         sH7w==
X-Gm-Message-State: ANhLgQ0iksFTLbj4bc+VU51/771DspnvOCT1PP88YvLJTK3IQQp5diyN
        o0kJTv3cYgFp7WI9NrqaXCde3iXc
X-Google-Smtp-Source: ADFU+vtK75D7Tx7ZMZWePlkeD4kGSc8yN182nU+FiIFk4A0Sgf1Whlc9vW6cehJ3/pGjK5tLLMuFSQ==
X-Received: by 2002:a17:906:8554:: with SMTP id h20mr8330026ejy.332.1585236934363;
        Thu, 26 Mar 2020 08:35:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a17sm374136edj.53.2020.03.26.08.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 08:35:33 -0700 (PDT)
Message-Id: <064f4e541b8968d05bbd471ec347b9ed91181d72.1585236929.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.728.v3.git.git.1585236929.gitgitgadget@gmail.com>
References: <pull.728.v2.git.git.1585114881.gitgitgadget@gmail.com>
        <pull.728.v3.git.git.1585236929.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 Mar 2020 15:35:28 +0000
Subject: [PATCH v3 5/5] tests: increase the verbosity of the GPG-related
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
