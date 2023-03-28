Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4818FC76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 17:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjC1Rju (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 13:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjC1Rji (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 13:39:38 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90D8D520
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 10:39:36 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id ca2-20020a056830610200b006a11ab58c3fso6108876otb.4
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 10:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680025176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Asn3uzUI7K34zyY0EobVtH/3PMaw9aapstIAZFkCEcs=;
        b=OI8Cp5mBjDMlA6NrVoULfuJF8qDGee9rhAsQQNRRNuUv8lW4vHQJP6ONu4P0D04ghY
         h0/F7cFwRBP2Kv0SobcGYeh9ctDD/vPC/v3a3wawoGX8c3T2U7xmvDApm5jjw1ah5mbl
         D+Ei6WH+kiQPuE24Z5KAus7IKIz27s4GfHdWvnx5ApoGTjW6oOhXqIgWyFXLC21jCwM2
         1mAwes2/SXqOpLsxaUp++/2C/MGmjqsYRQDp16M6G/PjrDRKoNrvhK1QYVtaJe5/jsFS
         pAortc8pkUrVAF7ufMQSrqQmc1dd4YVfdmBpYqyb+zpxp34uLoK9QG2oKeIQhxHubMON
         mghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680025176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Asn3uzUI7K34zyY0EobVtH/3PMaw9aapstIAZFkCEcs=;
        b=O0hznMStsvoGjvyIu2Fnr/IA+KZoy/yvd3AMpfrJsTEq+w5uA8rleUrfRa9rSYj3S2
         EuTd3iJdTWLPdNx7S25HshXnULGhPOVx5o7joFpFi4V5gZT6NugabO4nVsq/9GD/hpc1
         HeYNbkvOdSiUScwnJAxQG0qLHaE0QFOucn81j9hjXDoGg+EwN5A8J0Wq09tO2zK9gNCA
         /6X0cbFPBw9IlpsL3uvTerhMyMzGVKKHkDZmTTr9EfdJHvLChwAZIRA7vtFmw6PQedNa
         UgsPJr5KzdYkUARoo/sIx+c49GzBNK0Vqyu/p5tUmzngwF404IGnv/0B9XB3/2ZJZfOt
         viBw==
X-Gm-Message-State: AAQBX9f+PRdnALe8+7qqd92k8STgDX0NskyZ2ooMOzxU+1f2/HYNcylR
        KrHVbF7SM68lvDdNMiLvZE5lzRYzFTs=
X-Google-Smtp-Source: AKy350YgIi+Yjid0AqNn/ZFDUxSG8rYbq36LVYX194c2egANRfYcHmfxpxyB66+0YJ2VndIRPxC++g==
X-Received: by 2002:a05:6830:114c:b0:6a1:3cc7:170d with SMTP id x12-20020a056830114c00b006a13cc7170dmr3856694otq.10.1680025175823;
        Tue, 28 Mar 2023 10:39:35 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id x10-20020a9d6d8a000000b006a1561e336dsm1032434otp.49.2023.03.28.10.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 10:39:35 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/6] test: fix build for zsh
Date:   Tue, 28 Mar 2023 11:39:27 -0600
Message-Id: <20230328173932.3614601-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.39.2.13.g1fb56cf030
In-Reply-To: <20230328173932.3614601-1-felipe.contreras@gmail.com>
References: <20230328173932.3614601-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/lib-bash.sh |  2 +-
 t/test-lib.sh | 20 ++++++++++++++------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/t/lib-bash.sh b/t/lib-bash.sh
index b0b6060929..798b6d0265 100644
--- a/t/lib-bash.sh
+++ b/t/lib-bash.sh
@@ -10,7 +10,7 @@ elif type bash >/dev/null 2>&1
 then
 	# execute in full-on bash mode
 	unset POSIXLY_CORRECT
-	exec bash "$0" "$@"
+	exec bash "${ZSH_ARGZERO-$0}" "$@"
 else
 	echo '1..0 #SKIP skipping bash completion tests; bash not available'
 	exit 0
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 62136caee5..cc705df981 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -15,6 +15,14 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see http://www.gnu.org/licenses/ .
 
+if test -n "${ZSH_VERSION-}"
+then
+	emulate sh
+	ARGZERO="$ZSH_ARGZERO"
+else
+	ARGZERO="$0"
+fi
+
 # Test the binaries we have just built.  The tests are kept in
 # t/ subdirectory and are run in 'trash directory' subdirectory.
 if test -z "$TEST_DIRECTORY"
@@ -310,7 +318,7 @@ then
 fi
 
 TEST_STRESS_JOB_SFX="${GIT_TEST_STRESS_JOB_NR:+.stress-$GIT_TEST_STRESS_JOB_NR}"
-TEST_NAME="$(basename "$0" .sh)"
+TEST_NAME="$(basename "$ARGZERO" .sh)"
 TEST_NUMBER="${TEST_NAME%%-*}"
 TEST_NUMBER="${TEST_NUMBER#t}"
 TEST_RESULTS_DIR="$TEST_OUTPUT_DIRECTORY/test-results"
@@ -388,7 +396,7 @@ then
 			      { test -z "$stress_limit" ||
 				test $cnt -le $stress_limit ; }
 			do
-				$TEST_SHELL_PATH "$0" "$@" >"$TEST_RESULTS_BASE.stress-$job_nr.out" 2>&1 &
+				$TEST_SHELL_PATH "$ARGZERO" "$@" >"$TEST_RESULTS_BASE.stress-$job_nr.out" 2>&1 &
 				test_pid=$!
 
 				if wait $test_pid
@@ -442,7 +450,7 @@ then
 	# from any previous runs.
 	>"$GIT_TEST_TEE_OUTPUT_FILE"
 
-	(GIT_TEST_TEE_STARTED=done ${TEST_SHELL_PATH} "$0" "$@" 2>&1;
+	(GIT_TEST_TEE_STARTED=done ${TEST_SHELL_PATH} "$ARGZERO" "$@" 2>&1;
 	 echo $? >"$TEST_RESULTS_BASE.exit") | tee -a "$GIT_TEST_TEE_OUTPUT_FILE"
 	test "$(cat "$TEST_RESULTS_BASE.exit")" = 0
 	exit
@@ -467,7 +475,7 @@ then
 	then
 		: Executed by a Bash version supporting BASH_XTRACEFD.  Good.
 	else
-		echo >&2 "warning: ignoring -x; '$0' is untraceable without BASH_XTRACEFD"
+		echo >&2 "warning: ignoring -x; '$ARGZERO' is untraceable without BASH_XTRACEFD"
 		trace=
 	fi
 fi
@@ -1595,7 +1603,7 @@ fi
 
 if test "${GIT_TEST_CHAIN_LINT:-1}" != 0
 then
-	"$PERL_PATH" "$TEST_DIRECTORY/chainlint.pl" "$0" ||
+	"$PERL_PATH" "$TEST_DIRECTORY/chainlint.pl" "$ARGZERO" ||
 		BUG "lint error (see '?!...!? annotations above)"
 fi
 
@@ -1637,7 +1645,7 @@ fi
 # in subprocesses like git equals our $PWD (for pathname comparisons).
 cd -P "$TRASH_DIRECTORY" || BAIL_OUT "cannot cd -P to \"$TRASH_DIRECTORY\""
 
-start_test_output "$0"
+start_test_output "$ARGZERO"
 
 # Convenience
 # A regexp to match 5 and 35 hexdigits
-- 
2.39.2.13.g1fb56cf030

