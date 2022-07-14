Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7ECC43334
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 11:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239085AbiGNLtg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 07:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238870AbiGNLtb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 07:49:31 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E513B491FA
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 04:49:28 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-10c0e6dd55eso2072043fac.7
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 04:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sCOniJepg/VfD+yb/OJCveOwJK8mITiw+cjjvAezGdY=;
        b=Vvv9uJhjRKnVO0FrTdzYo3d4iXO/fiE/Zg2xFHaewHDkab+V2XeOkahaqzqe0CbcpL
         RxiXpQjLrHIZDyLBRj379hmhAh3GxFWOcNvtFq09/HwuuVugZ/euGOx50SjstVmBUNfe
         PnaW+bV7mj8+aI5lOZq4kJWskwxhl6d0LlaotynOsHAdPCYuNqtbKPnAPQLchsdr9Kzw
         LOe+Y5BMdkDhOeGkIQXL6z7gV2XlsyJ/ZdrG+1dr0jL0wp42Oyfeao/HG5mBGQ2lg+JK
         upsK18ZVY/XFT8u+VFarcIjxY9RCdnC1kt1sAu71PpKNC+E9OXh+YcTgcDjCawY+8a6N
         TESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sCOniJepg/VfD+yb/OJCveOwJK8mITiw+cjjvAezGdY=;
        b=JZz3eauh5BhGOMWACYF+f4u9kDOz0aeIsiD08gFygJlwTjvWF3Q6iNb5nvoq5VS9yd
         Sj1uGPPJU/gbGArId9H+CtT5wiriMdlf/5uwjmEKcbb0r5YpFUG0h13EvfIi0kpYF3py
         De8EB+tH7MSqLZ2pZveTnwOHBP3nmkg5hQG5FXjLk9m4ZIDz/CIG/TIf3qIhSubjE2nf
         kVK1r6FJ+S8ATbYxn9M/Lq4MAB7bOwuZ5uBl5kVesdkUTk2ETT2Ws88FBoJWj3c3QMmr
         Xq7af0U4ewd9ygl9T8bx92/+JTaTh4bEHptcJkvrZhj1CB825vnyhTx9A/IK6KhW2nW4
         enDw==
X-Gm-Message-State: AJIora8Y6X/3Ux2tbJdunxoCF2Pui4d5yo5RTrdvNvLI4oT79g+DcxEk
        mW3d9ZtrJxfIk5bUATr4ZQQnKw==
X-Google-Smtp-Source: AGRyM1t0YQJo+uqHEXQEQKsLIgUFmq3p/LAEouagbcESDHZtsN41Fy6iJbPfSeTJKcgHCFUNe5XQEA==
X-Received: by 2002:a05:6870:95a9:b0:101:fa11:2e51 with SMTP id k41-20020a05687095a900b00101fa112e51mr4357852oao.56.1657799368131;
        Thu, 14 Jul 2022 04:49:28 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.109.17])
        by smtp.gmail.com with ESMTPSA id o23-20020a9d4117000000b00616c5ce1d83sm548035ote.68.2022.07.14.04.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 04:49:27 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: [PATCH v2 2/3] checkout: show bug about failed entries being included in final report
Date:   Thu, 14 Jul 2022 08:49:11 -0300
Message-Id: <4541e90224f5e79b16717b94f37edd10a4fdbbb1.1657799213.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1657799213.git.matheus.bernardino@usp.br>
References: <cover.1657799213.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After checkout, git usually reports how many entries were updated at
that operation. However, because we count the entries too soon during
the checkout process, we may actually include entries that do not get
properly checked out in the end. This can lead to an inaccurate final
report if the user expects it to show only the *successful* updates.
This will be fixed in the next commit, but for now let's document it
with a test that cover all checkout modes.

Note that `test_checkout_workers` have to be slightly adjusted in order
to use the construct `test_checkout_workers ...  test_must_fail git
checkout`. The function runs the command given to it with an assignment
prefix to set the GIT_TRACE2 variable. However, this this assignment has
an undefined behavior when the command is a shell function (like
`test_must_fail`). As POSIX specifies:

  If the command name is a function that is not a standard utility
  implemented as a function, variable assignments shall affect the
  current execution environment during the execution of the function. It
  is unspecified:

    - Whether or not the variable assignments persist after the
      completion of the function

    - Whether or not the variables gain the export attribute during the
      execution of the function

Thus, in order to make sure the GIT_TRACE2 value gets visible to the git
command executed by `test_must_fail`, export the variable and run git in
a subshell.

[1]: https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html
     (Vol. 3: Shell and Utilities, Section 2.9.1: Simple Commands)

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 t/lib-parallel-checkout.sh          |  6 +++-
 t/t2080-parallel-checkout-basics.sh | 48 +++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/t/lib-parallel-checkout.sh b/t/lib-parallel-checkout.sh
index 83b279a846..acaee9cbb6 100644
--- a/t/lib-parallel-checkout.sh
+++ b/t/lib-parallel-checkout.sh
@@ -25,7 +25,11 @@ test_checkout_workers () {
 
 	local trace_file=trace-test-checkout-workers &&
 	rm -f "$trace_file" &&
-	GIT_TRACE2="$(pwd)/$trace_file" "$@" 2>&8 &&
+	(
+		GIT_TRACE2="$(pwd)/$trace_file" &&
+		export GIT_TRACE2 &&
+		"$@" 2>&8
+	) &&
 
 	local workers="$(grep "child_start\[..*\] git checkout--worker" "$trace_file" | wc -l)" &&
 	test $workers -eq $expected_workers &&
diff --git a/t/t2080-parallel-checkout-basics.sh b/t/t2080-parallel-checkout-basics.sh
index 3e0f8c675f..7d6d26e1a4 100755
--- a/t/t2080-parallel-checkout-basics.sh
+++ b/t/t2080-parallel-checkout-basics.sh
@@ -226,4 +226,52 @@ test_expect_success SYMLINKS 'parallel checkout checks for symlinks in leading d
 	)
 '
 
+# This test is here (and not in e.g. t2022-checkout-paths.sh), because we
+# check the final report including sequential, parallel, and delayed entries
+# all at the same time. So we must have finer control of the parallel checkout
+# variables.
+test_expect_failure PERL '"git checkout ." report should not include failed entries' '
+	write_script rot13-filter.pl "$PERL_PATH" \
+		<"$TEST_DIRECTORY"/t0021/rot13-filter.pl &&
+
+	test_config_global filter.delay.process \
+		"\"$(pwd)/rot13-filter.pl\" --always-delay delayed.log clean smudge delay" &&
+	test_config_global filter.delay.required true &&
+	test_config_global filter.cat.clean cat  &&
+	test_config_global filter.cat.smudge cat  &&
+	test_config_global filter.cat.required true  &&
+
+	set_checkout_config 2 0 &&
+	git init failed_entries &&
+	(
+		cd failed_entries &&
+		cat >.gitattributes <<-EOF &&
+		*delay*              filter=delay
+		parallel-ineligible* filter=cat
+		EOF
+		echo a >missing-delay.a &&
+		echo a >parallel-ineligible.a &&
+		echo a >parallel-eligible.a &&
+		echo b >success-delay.b &&
+		echo b >parallel-ineligible.b &&
+		echo b >parallel-eligible.b &&
+		git add -A &&
+		git commit -m files &&
+
+		a_blob="$(git rev-parse :parallel-ineligible.a)" &&
+		rm .git/objects/$(test_oid_to_path $a_blob) &&
+		rm *.a *.b &&
+
+		test_checkout_workers 2 test_must_fail git checkout . 2>err &&
+
+		# All *.b entries should succeed and all *.a entries should fail:
+		#  - missing-delay.a: the delay filter will drop this path
+		#  - parallel-*.a: the blob will be missing
+		#
+		grep "Updated 3 paths from the index" err &&
+		test_stdout_line_count = 3 ls *.b &&
+		! ls *.a
+	)
+'
+
 test_done
-- 
2.37.0

