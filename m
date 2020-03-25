Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E33DC54FD5
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 05:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B43120788
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 05:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEyAAZm4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgCYFl2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 01:41:28 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:38411 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbgCYFl1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 01:41:27 -0400
Received: by mail-wr1-f51.google.com with SMTP id s1so1352063wrv.5
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 22:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=F1HPCbd+tjWaXBpHt9iAsPgbOLN7Y2JqRia8XS7vCbk=;
        b=QEyAAZm4KMj7qnl4Pc/ZIWxVW5nXPa91uqC9ZgF7c8M+pXBNODz8ac1IrDUR2UBdjP
         63UlXKcaOzbkWRMbwVjEYScPTYGriyj7xRM0qMQMQb3m3DO/gWR7y9149egVpN9Gg9Vh
         VLxCtLs+7werFF2yMIL6fg4GJvT3VEuezU/hha4ac8THIac3noxDzdNLGm3yH7g1pWiV
         5ta7Mwknj/j3WONg4m1WiKvwQqOkps+ZsNL1OT97A3xwNbpMZMRmlvOAxkkBjVSpB6dL
         9QEMG8t/9houSSXeJuInuJCM0CjLFeZfTTCs3VUzMSeqOTUVAXq/gSeebB9bE4E7Ec/a
         aCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=F1HPCbd+tjWaXBpHt9iAsPgbOLN7Y2JqRia8XS7vCbk=;
        b=nUPi4YZobut7nwxD0umwOYHaud8K0LwlLcgTdplNO5ov33NgEcG7qH4qjKyMhn2sXd
         wZJSH/Uv+cKUbRKRtHUe2wRPoUFwR2gKnGkkYEAElQkcKwXm1v7+7P0poCESbHf63S5H
         QjrkjO+j2x1f2vmoO4cq9X8T3Si8LEF/W+CyZLtNtuUpoJWlFxVIUSCRvkaar652YXjS
         9JxvSuJ0d+fa7WYCeVzMHVBoDPBcPWuOwSs2NjMDgqK5I4dSO+06cCZlCxwN+1n6TD7e
         GTj4xro834LJEbyRn5ZFJoY9j1JflCuzjmFVmUeVEaQQSxs4xYxlatT0l8YkL2TSTNve
         I3ag==
X-Gm-Message-State: ANhLgQ3PweTfZCXG3xW7ZXipUmS7Td31TWC2Rf0roTquQmPkeXz6IKN3
        n11fOnPm51qnl2oDTpFCMSBRCpsC
X-Google-Smtp-Source: ADFU+vvaEP4IYtLoeEp0wmyg/w0hI2kPEN/ecLq87bWnYwjDSD8XY9MPWbAnCFbYXBIG1coT40rS0Q==
X-Received: by 2002:adf:9d88:: with SMTP id p8mr746937wre.257.1585114882758;
        Tue, 24 Mar 2020 22:41:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u16sm32586578wro.23.2020.03.24.22.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 22:41:22 -0700 (PDT)
Message-Id: <pull.728.v2.git.git.1585114881.gitgitgadget@gmail.com>
In-Reply-To: <pull.728.git.git.1584968990.gitgitgadget@gmail.com>
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Mar 2020 05:41:16 +0000
Subject: [PATCH v2 0/5] Enable GPG in the Windows part of the CI/PR builds
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While debugging the breakages introduced by hi/gpg-prefer-check-signature, I
noticed that the GPG prereq was not available on Windows, even if Git for
Windows' SDK comes with a fully functional GPG2.

The fix was easy, but finding out what was going on was not, so for good
measure, the fix is accompanied by a patch that will hopefully make future
investigations into GPG-related problems much, much easier.

Changes since v1:

 * The prereqs are now lazy ones.
   
   
 * A new patch was introduced to make tracing via -x work even with those
   inter-dependent prereqs.
   
   
 * The test-signing's stdout is redirected to /dev/null because it is
   unreadable and unhelpful binary gibberish, anyway. (This imitates Peff's
   patch.)

Johannes Schindelin (5):
  tests(gpg): allow the gpg-agent to start on Windows
  t/lib-gpg.sh: stop pretending to be a stand-alone script
  tests: turn GPG, GPGSM and RFC1991 into lazy prereqs
  tests: do not let lazy prereqs inside `test_expect_*` turn off tracing
  tests: increase the verbosity of the GPG-related prereqs

 t/lib-gpg.sh     | 110 ++++++++++++++++++++++++++---------------------
 t/t0000-basic.sh |  13 ++++++
 t/test-lib.sh    |   6 ++-
 3 files changed, 77 insertions(+), 52 deletions(-)


base-commit: 30e9940356dc67959877f4b2417da33ebdefbb79
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-728%2Fdscho%2Fci-windows-gpg-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-728/dscho/ci-windows-gpg-v2
Pull-Request: https://github.com/git/git/pull/728

Range-diff vs v1:

 1:  287a21f1033 = 1:  287a21f1033 tests(gpg): allow the gpg-agent to start on Windows
 -:  ----------- > 2:  c1811d54190 t/lib-gpg.sh: stop pretending to be a stand-alone script
 2:  dd26cb05a37 ! 3:  85457a7b618 tests(gpg): increase verbosity to allow debugging
     @@ -1,21 +1,36 @@
      Author: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     -    tests(gpg): increase verbosity to allow debugging
     +    tests: turn GPG, GPGSM and RFC1991 into lazy prereqs
      
     -    Especially when debugging a test failure that can only be reproduced in
     -    the CI build (e.g. when the developer has no access to a macOS machine
     -    other than running the tests on a macOS build agent), output should not
     -    be suppressed.
     +    The code to set those prereqs is executed completely outside of any
     +    `test_eval_` block. As a consequence, its output had to be suppressed so
     +    that it does not clutter the output of a regular test script run.
      
     -    In the instance of `hi/gpg-prefer-check-signature`, where one
     -    GPG-related test failed for no apparent reason, the entire output of
     -    `gpg` and `gpgsm` was suppressed, even in verbose mode, leaving
     -    interested readers no clue what was going wrong.
     +    Unfortunately, the output *stays* suppressed even when the `--verbose`
     +    option is in effect.
      
     -    Let's fix this by redirecting the output not to `/dev/null`, but to the
     -    file descriptors that may, or may not, be redirected via
     -    `--verbose-log`. For good measure, also turn on tracing if the user
     -    asked for it, and prefix it with a helpful info message.
     +    This hid important output when debugging why the GPG prereq was not
     +    enabled in the Windows part of our CI builds.
     +
     +    In preparation for fixing that, let's move all of this code into lazy
     +    prereqs.
     +
     +    The only slightly tricky part is the global environment variable
     +    `GNUPGHOME`. Originally, it was configured only when we verified that
     +    there is a `gpg` in the `PATH` that we can use. This is now no longer
     +    possible, as lazy prereqs are evaluated in a subshell that changes the
     +    working directory to a temporary one. Therefore, we simply _always_ set
     +    that environment variable: it does not hurt anything because it does not
     +    indicate the presence of a working GPG.
     +
     +    Side note: it was quite tempting to use a hack that is possible because
     +    we do not validate what is passed to `test_lazy_prereq` (and it is
     +    therefore possible to "break out" of the lazy_prereq subshell:
     +
     +            test_lazy_prereq GPG '...) && GNUPGHOME=... && (...'
     +
     +    However, this is rather tricksy hobbitses code, and the current patch is
     +    _much_ easier to understand.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     @@ -23,67 +38,128 @@
       --- a/t/lib-gpg.sh
       +++ b/t/lib-gpg.sh
      @@
     +-gpg_version=$(gpg --version 2>&1)
     +-if test $? != 127
     +-then
     ++# We always set GNUPGHOME, even if no usable GPG was found, as
     ++#
     ++# - It does not hurt, and
     ++#
     ++# - we cannot set global environment variables in lazy prereqs because they are
     ++#   executed in an eval'ed subshell that changes the working directory to a
     ++#   temporary one.
     ++
     ++GNUPGHOME="$PWD/gpghome"
     ++export GNUPGHOME
     ++
     ++test_lazy_prereq GPG '
     ++	gpg_version=$(gpg --version 2>&1)
     ++	test $? != 127 || exit 1
     ++
     + 	# As said here: http://www.gnupg.org/documentation/faqs.html#q6.19
     +-	# the gpg version 1.0.6 didn't parse trust packets correctly, so for
     ++	# the gpg version 1.0.6 did not parse trust packets correctly, so for
     + 	# that version, creation of signed tags using the generated key fails.
     + 	case "$gpg_version" in
     +-	'gpg (GnuPG) 1.0.6'*)
     ++	"gpg (GnuPG) 1.0.6"*)
       		say "Your version of gpg (1.0.6) is too buggy for testing"
     ++		exit 1
       		;;
       	*)
     -+		say_color info >&4 "Trying to set up GPG"
     -+		want_trace && set -x
       		# Available key info:
     - 		# * Type DSA and Elgamal, size 2048 bits, no expiration date,
     - 		#   name and email: C O Mitter <committer@example.com>
      @@
     - 		chmod 0700 ./gpghome &&
     - 		GNUPGHOME="$PWD/gpghome" &&
     - 		export GNUPGHOME &&
     --		(gpgconf --kill gpg-agent >/dev/null 2>&1 || : ) &&
     --		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import \
     --			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
     --		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import-ownertrust \
     --			"$TEST_DIRECTORY"/lib-gpg/ownertrust &&
     --		gpg --homedir "${GNUPGHOME}" </dev/null >/dev/null 2>&1 \
     + 		# To export ownertrust:
     + 		#	gpg --homedir /tmp/gpghome --export-ownertrust \
     + 		#		> lib-gpg/ownertrust
     +-		mkdir ./gpghome &&
     +-		chmod 0700 ./gpghome &&
     +-		GNUPGHOME="$PWD/gpghome" &&
     +-		export GNUPGHOME &&
     ++		mkdir "$GNUPGHOME" &&
     ++		chmod 0700 "$GNUPGHOME" &&
     + 		(gpgconf --kill gpg-agent >/dev/null 2>&1 || : ) &&
     + 		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import \
     + 			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
     + 		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import-ownertrust \
     + 			"$TEST_DIRECTORY"/lib-gpg/ownertrust &&
     + 		gpg --homedir "${GNUPGHOME}" </dev/null >/dev/null 2>&1 \
      -			--sign -u committer@example.com &&
     -+		(gpgconf --kill gpg-agent >&3 2>&4 || : ) &&
     -+		gpg --homedir "${GNUPGHOME}" --import \
     -+			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg >&3 2>&4 &&
     -+		gpg --homedir "${GNUPGHOME}" --import-ownertrust \
     -+			"$TEST_DIRECTORY"/lib-gpg/ownertrust >&3 2>&4 &&
     -+		gpg --homedir "${GNUPGHOME}" </dev/null \
     -+			--sign -u committer@example.com >&3 2>&4 &&
     - 		test_set_prereq GPG &&
     - 		# Available key info:
     - 		# * see t/lib-gpg/gpgsm-gen-key.in
     -@@
     - 		#	gpgsm --homedir /tmp/gpghome/ \
     - 		#		-o t/lib-gpg/gpgsm_cert.p12 \
     - 		#		--export-secret-key-p12 "committer@example.com"
     +-		test_set_prereq GPG &&
     +-		# Available key info:
     +-		# * see t/lib-gpg/gpgsm-gen-key.in
     +-		# To generate new certificate:
     +-		#  * no passphrase
     +-		#	gpgsm --homedir /tmp/gpghome/ \
     +-		#		-o /tmp/gpgsm.crt.user \
     +-		#		--generate-key \
     +-		#		--batch t/lib-gpg/gpgsm-gen-key.in
     +-		# To import certificate:
     +-		#	gpgsm --homedir /tmp/gpghome/ \
     +-		#		--import /tmp/gpgsm.crt.user
     +-		# To export into a .p12 we can later import:
     +-		#	gpgsm --homedir /tmp/gpghome/ \
     +-		#		-o t/lib-gpg/gpgsm_cert.p12 \
     +-		#		--export-secret-key-p12 "committer@example.com"
      -		echo | gpgsm --homedir "${GNUPGHOME}" 2>/dev/null \
     -+		echo | gpgsm --homedir "${GNUPGHOME}" >&3 2>&4 \
     - 			--passphrase-fd 0 --pinentry-mode loopback \
     - 			--import "$TEST_DIRECTORY"/lib-gpg/gpgsm_cert.p12 &&
     - 
     +-			--passphrase-fd 0 --pinentry-mode loopback \
     +-			--import "$TEST_DIRECTORY"/lib-gpg/gpgsm_cert.p12 &&
     +-
      -		gpgsm --homedir "${GNUPGHOME}" 2>/dev/null -K |
     -+		gpgsm --homedir "${GNUPGHOME}" -K 2>&4 |
     - 		grep fingerprint: |
     - 		cut -d" " -f4 |
     - 		tr -d '\n' >"${GNUPGHOME}/trustlist.txt" &&
     - 
     - 		echo " S relax" >>"${GNUPGHOME}/trustlist.txt" &&
     +-		grep fingerprint: |
     +-		cut -d" " -f4 |
     +-		tr -d '\n' >"${GNUPGHOME}/trustlist.txt" &&
     +-
     +-		echo " S relax" >>"${GNUPGHOME}/trustlist.txt" &&
      -		echo hello | gpgsm --homedir "${GNUPGHOME}" >/dev/null \
      -			-u committer@example.com -o /dev/null --sign - 2>&1 &&
     -+		echo hello | gpgsm --homedir "${GNUPGHOME}" >&3 2>&4 \
     -+			-u committer@example.com -o /dev/null --sign - &&
     - 		test_set_prereq GPGSM
     +-		test_set_prereq GPGSM
     ++			--sign -u committer@example.com
       		;;
       	esac
     - fi
     +-fi
     ++'
     ++
     ++test_lazy_prereq GPGSM '
     ++	test_have_prereq GPG &&
     ++	# Available key info:
     ++	# * see t/lib-gpg/gpgsm-gen-key.in
     ++	# To generate new certificate:
     ++	#  * no passphrase
     ++	#	gpgsm --homedir /tmp/gpghome/ \
     ++	#		-o /tmp/gpgsm.crt.user \
     ++	#		--generate-key \
     ++	#		--batch t/lib-gpg/gpgsm-gen-key.in
     ++	# To import certificate:
     ++	#	gpgsm --homedir /tmp/gpghome/ \
     ++	#		--import /tmp/gpgsm.crt.user
     ++	# To export into a .p12 we can later import:
     ++	#	gpgsm --homedir /tmp/gpghome/ \
     ++	#		-o t/lib-gpg/gpgsm_cert.p12 \
     ++	#		--export-secret-key-p12 "committer@example.com"
     ++       echo | gpgsm --homedir "${GNUPGHOME}" 2>/dev/null \
     ++	       --passphrase-fd 0 --pinentry-mode loopback \
     ++	       --import "$TEST_DIRECTORY"/lib-gpg/gpgsm_cert.p12 &&
     ++
     ++       gpgsm --homedir "${GNUPGHOME}" 2>/dev/null -K |
     ++       grep fingerprint: |
     ++       cut -d" " -f4 |
     ++	tr -d "\\n" >"${GNUPGHOME}/trustlist.txt" &&
     ++
     ++       echo " S relax" >>"${GNUPGHOME}/trustlist.txt" &&
     ++       echo hello | gpgsm --homedir "${GNUPGHOME}" >/dev/null \
     ++	       -u committer@example.com -o /dev/null --sign - 2>&1
     ++'
       
     - if test_have_prereq GPG &&
     +-if test_have_prereq GPG &&
      -    echo | gpg --homedir "${GNUPGHOME}" -b --rfc1991 >/dev/null 2>&1
     -+    echo | gpg --homedir "${GNUPGHOME}" -b --rfc1991 >&3 2>&4
     - then
     - 	test_set_prereq RFC1991
     - fi
     -+want_trace && set +x
     +-then
     +-	test_set_prereq RFC1991
     +-fi
     ++test_lazy_prereq RFC1991 '
     ++	test_have_prereq GPG &&
     ++	echo | gpg --homedir "${GNUPGHOME}" -b --rfc1991 >/dev/null 2>&1
     ++'
       
       sanitize_pgp() {
       	perl -ne '
 -:  ----------- > 4:  0767c8b77c8 tests: do not let lazy prereqs inside `test_expect_*` turn off tracing
 -:  ----------- > 5:  5e89b512513 tests: increase the verbosity of the GPG-related prereqs

-- 
gitgitgadget
