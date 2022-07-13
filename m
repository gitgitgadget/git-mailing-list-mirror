Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D944C43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 04:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbiGMEUZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 00:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiGMEUX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 00:20:23 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D7ED9E19
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 21:20:22 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-10c8e8d973eso10937935fac.5
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 21:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Z9fgn/uWcbF29UZLT99g9d6JDnsfUzSqkMlEG4c6UKE=;
        b=iCzFci8ZsydQ2OSqxcybxNCtHCzYJANEl3fppWz83okpwCTL4FVIIvBY1lmFxE06Ox
         5JAIjuZlo8iwHwOQ+Q7ilV3gn9ixp4JWR02U0Wl3zYskW8+YHqn+TkBi2KeZbGRJFcGA
         QXt2wNG1VFTI2KW0XamQt+++MAhwYZVaBS3AjSXRSHLGnyo2ngk87dkKX+Qq39UtNYBJ
         YTvGcugYIGuZnUsOCrrFMSukwgRYZoSk9QYv+g4mtkE12O2tOlZF/JRqxReri/J7B2sT
         yUQBqrOVF7oq0iyRI7yQBTxCUzyIefDmvtlJ1pG+5S/NUELEdFWeOwdFgbWTd3xb5y8p
         efdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z9fgn/uWcbF29UZLT99g9d6JDnsfUzSqkMlEG4c6UKE=;
        b=CVl6pubYx7m52buuTIOdKQe9DsneWIHvbW7gaEkHSHGNM/tezraOK4pANbqObzEx/K
         fN28QyMa2n9C7sjF1kh85X3H5tu84yKISl+k+DTyDfGUSxYnhhD4IKaQQmHIK/vXb+eE
         t44wR0axHR/CchLMAfDThhTVZx4dbS/9D5qauGlIG6tpwLaLbP8aZrKRYrLbks9ylwtQ
         Bbkkjk34hYtpknzauXx9jZozDcADOcrTRza6ig/nAztz+twkjQLYf/hXnQ+vxC99n5jR
         OR84i3+7zsU74VpTlo2doky+ygfDqhNPezkKgklza49rNGiSGNr7AnxmuErPLOt7mxqu
         Yqkw==
X-Gm-Message-State: AJIora/WOlBvwhByTxySGZt4AGBT+zEUpb5Xw1+efdulla80m5VOfpKJ
        SlmNnZyD2iTuDNal18Rwp+tYYi+0GYKnfw==
X-Google-Smtp-Source: AGRyM1vrArzKQ/XHlxzb+SZ6kSTjS6VY7KecJ04BBeq3oZjY33lWAfoWfwRMZ0Ja/hv6j6ry6ybCCg==
X-Received: by 2002:a05:6870:4284:b0:101:202e:a78d with SMTP id y4-20020a056870428400b00101202ea78dmr3606944oah.37.1657686021213;
        Tue, 12 Jul 2022 21:20:21 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.109.17])
        by smtp.gmail.com with ESMTPSA id eh40-20020a056870f5a800b000f342d078fasm5649062oab.52.2022.07.12.21.20.19
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 21:20:20 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Subject: [PATCH 2/3] checkout: show bug about failed entries being included in final report
Date:   Wed, 13 Jul 2022 01:19:56 -0300
Message-Id: <8da18a0a8c34a1c10d55bcdda725817db586f763.1657685948.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1657685948.git.matheus.bernardino@usp.br>
References: <cover.1657685948.git.matheus.bernardino@usp.br>
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
     (Section 2.9.1: Simple Commands)

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 t/lib-parallel-checkout.sh          |  6 +++-
 t/t2080-parallel-checkout-basics.sh | 50 +++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 1 deletion(-)

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
index 3e0f8c675f..6fd7e4c4b2 100755
--- a/t/t2080-parallel-checkout-basics.sh
+++ b/t/t2080-parallel-checkout-basics.sh
@@ -226,4 +226,54 @@ test_expect_success SYMLINKS 'parallel checkout checks for symlinks in leading d
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
+		dir="$(echo "$a_blob" | cut -c 1-2)" &&
+		file="$(echo "$a_blob" | cut -c 3-)" &&
+		rm ".git/objects/$dir/$file" &&
+		rm *.a *.b &&
+
+		test_checkout_workers 2 test_must_fail git checkout . 2>err &&
+
+		# All *.b entries should succeed and all *.a entries should fail:
+		#  - missing-delay.a: the delay filter will drop this path
+		#  - parallel-*.a: the blob will be missing
+		#
+		grep "Updated 3 paths from the index" err &&
+		test "$(ls *.b | wc -l)" -eq 3 &&
+		test "$(ls *.a | wc -l)" -eq 0
+	)
+'
+
 test_done
-- 
2.37.0

