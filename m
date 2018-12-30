Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACB9D1F770
	for <e@80x24.org>; Sun, 30 Dec 2018 19:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbeL3TQ4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Dec 2018 14:16:56 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37887 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbeL3TQ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Dec 2018 14:16:56 -0500
Received: by mail-wr1-f68.google.com with SMTP id s12so25102020wrt.4
        for <git@vger.kernel.org>; Sun, 30 Dec 2018 11:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fw3JiTxr8pl7NFZa0U6iDv+WqrEjcmmnIKRvHqU7b84=;
        b=s4VfVHrtJ/aNTFqWceNoce1nUa2MzW8GyimT5OQXLeqj9Lk1zqGqvnfM96trPlDEMt
         vG06c7LuajX/rQyvgwZwaDFbOGVmOnHlaPtAhAb7U+kxc+VjkYVRv/60RNJxV5BGIi0I
         FQ4Tp0h+0fsZ3r6QxYQkmTGWL0Ge57Ul59tW9O37Pg91+a6ftPskT9XsHSuc6oiihBSi
         WkyK251kbq3W+gLSLSWuNOa28vGkF/xWBW+2pVQX9tLY5XJMIsZq1WXS/nQ0sEKVXcor
         nswZYsWMdEJYKISoF8VQ+Etw06sInhQp8no4G8G9BdN5a1/PYZ7J7+cCRgfGi8DwGb2q
         qUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fw3JiTxr8pl7NFZa0U6iDv+WqrEjcmmnIKRvHqU7b84=;
        b=BvO2E3CiXRdLMKfqAmKpOtDT+2+Lh1jiCuWhoRo5onZsAnO1r1ClRcb9eigrsHJM1C
         WlAJ8OZs/IHW4d5kyY5ipKXpSypuTc+ciFHI9ondIRjs5/9MaUIVrpYTGvnEbMxaKDol
         PulINoXIkxvSDgkpm+JtPjj8EC6UmIEmSA3ZaLl7N6GgYJ97eYJbe1XWvOOcSfuQM5km
         xrYLMAygePLLaEsOB0CMFStFOhK7uB1B0x2ugytipUbG4QBS7FgSlwSaJkJRecqs0YMf
         EWstRFtiBPHTxzp9+7HJB6kmxHr5X4zEYdehnr/1/Y0S3M8czu9uEE83cECgNVbTjG8r
         RAvQ==
X-Gm-Message-State: AJcUukfc7YRP3sKRh/wEGEo5O+P0DX1fmgO2PosjPhMrOPp5u4+lSmHy
        9OD8ynkKm7WTLS5hvVnzXSo=
X-Google-Smtp-Source: ALg8bN6ax2QY16J8jC0Y6Meux/82cAYmIllOqECEDXLb4uqn5iW2IpkMmPofqgQ0Z6hNoONjvxwMPw==
X-Received: by 2002:adf:c612:: with SMTP id n18mr30204516wrg.174.1546197413610;
        Sun, 30 Dec 2018 11:16:53 -0800 (PST)
Received: from localhost.localdomain (84-236-109-65.pool.digikabel.hu. [84.236.109.65])
        by smtp.gmail.com with ESMTPSA id h62sm28954226wmf.11.2018.12.30.11.16.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 30 Dec 2018 11:16:53 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 2/8] test-lib: parse options in a for loop to keep $@ intact
Date:   Sun, 30 Dec 2018 20:16:23 +0100
Message-Id: <20181230191629.3232-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.1.151.gec613c4b75
In-Reply-To: <20181230191629.3232-1-szeder.dev@gmail.com>
References: <20181209225628.22216-1-szeder.dev@gmail.com>
 <20181230191629.3232-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'test-lib.sh' looks for the presence of certain options like '--tee'
and '--verbose-log', so it can execute the test script again to save
its standard output and error, and to do so it needs the original
command line options the test was invoked with.

The next patch is about to move the option parsing loop earlier in
'test-lib.sh', but it is implemented using 'shift' in a while loop,
effecively destroying "$@" by the end of the option parsing.  Not
good.

As a preparatory step, turn that option parsing loop into a 'for opt
in "$@"' loop to preserve "$@" intact while iterating over the
options, and taking extra care to handle the '-r' option's required
argument (or the lack thereof).

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/test-lib.sh | 77 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 35 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 9a3f7930a3..ed7267962f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -264,58 +264,59 @@ test "x$TERM" != "xdumb" && (
 	) &&
 	color=t
 
-while test "$#" -ne 0
+store_arg_to=
+prev_opt=
+for opt
 do
-	case "$1" in
+	if test -n "$store_arg_to"
+	then
+		eval $store_arg_to=\$opt
+		store_arg_to=
+		prev_opt=
+		continue
+	fi
+
+	case "$opt" in
 	-d|--d|--de|--deb|--debu|--debug)
-		debug=t; shift ;;
+		debug=t ;;
 	-i|--i|--im|--imm|--imme|--immed|--immedi|--immedia|--immediat|--immediate)
-		immediate=t; shift ;;
+		immediate=t ;;
 	-l|--l|--lo|--lon|--long|--long-|--long-t|--long-te|--long-tes|--long-test|--long-tests)
-		GIT_TEST_LONG=t; export GIT_TEST_LONG; shift ;;
+		GIT_TEST_LONG=t; export GIT_TEST_LONG ;;
 	-r)
-		shift; test "$#" -ne 0 || {
-			echo 'error: -r requires an argument' >&2;
-			exit 1;
-		}
-		run_list=$1; shift ;;
+		store_arg_to=run_list
+		;;
 	--run=*)
-		run_list=${1#--*=}; shift ;;
+		run_list=${opt#--*=} ;;
 	-h|--h|--he|--hel|--help)
-		help=t; shift ;;
+		help=t ;;
 	-v|--v|--ve|--ver|--verb|--verbo|--verbos|--verbose)
-		verbose=t; shift ;;
+		verbose=t ;;
 	--verbose-only=*)
-		verbose_only=${1#--*=}
-		shift ;;
+		verbose_only=${opt#--*=}
+		;;
 	-q|--q|--qu|--qui|--quie|--quiet)
 		# Ignore --quiet under a TAP::Harness. Saying how many tests
 		# passed without the ok/not ok details is always an error.
-		test -z "$HARNESS_ACTIVE" && quiet=t; shift ;;
+		test -z "$HARNESS_ACTIVE" && quiet=t ;;
 	--with-dashes)
-		with_dashes=t; shift ;;
+		with_dashes=t ;;
 	--no-color)
-		color=; shift ;;
+		color= ;;
 	--va|--val|--valg|--valgr|--valgri|--valgrin|--valgrind)
-		valgrind=memcheck
-		shift ;;
+		valgrind=memcheck ;;
 	--valgrind=*)
-		valgrind=${1#--*=}
-		shift ;;
+		valgrind=${opt#--*=} ;;
 	--valgrind-only=*)
-		valgrind_only=${1#--*=}
-		shift ;;
+		valgrind_only=${opt#--*=} ;;
 	--tee)
-		shift ;; # was handled already
+		;; # was handled already
 	--root=*)
-		root=${1#--*=}
-		shift ;;
+		root=${opt#--*=} ;;
 	--chain-lint)
-		GIT_TEST_CHAIN_LINT=1
-		shift ;;
+		GIT_TEST_CHAIN_LINT=1 ;;
 	--no-chain-lint)
-		GIT_TEST_CHAIN_LINT=0
-		shift ;;
+		GIT_TEST_CHAIN_LINT=0 ;;
 	-x)
 		# Some test scripts can't be reliably traced  with '-x',
 		# unless the test is run with a Bash version supporting
@@ -335,14 +336,20 @@ do
 		else
 			echo >&2 "warning: ignoring -x; '$0' is untraceable without BASH_XTRACEFD"
 		fi
-		shift ;;
+		;;
 	-V|--verbose-log)
-		verbose_log=t
-		shift ;;
+		verbose_log=t ;;
 	*)
-		echo "error: unknown test option '$1'" >&2; exit 1 ;;
+		echo "error: unknown test option '$opt'" >&2; exit 1 ;;
 	esac
+
+	prev_opt=$opt
 done
+if test -n "$store_arg_to"
+then
+	echo "error: $prev_opt requires an argument" >&2
+	exit 1
+fi
 
 if test -n "$valgrind_only"
 then
-- 
2.20.1.151.gec613c4b75

