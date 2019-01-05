Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2050C1F6A9
	for <e@80x24.org>; Sat,  5 Jan 2019 01:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbfAEBJU (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Jan 2019 20:09:20 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43030 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfAEBJT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jan 2019 20:09:19 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so38007301wrs.10
        for <git@vger.kernel.org>; Fri, 04 Jan 2019 17:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=94oSWgv623B/vmFeXPtXCML7tcwqRLnG281XL1J9b1s=;
        b=ZJnExNgzaM+D5wgIa7o1vNiu1yTSX2l2O9zmvuaPBKiLBkr4piMIDG+lwcyKzvCCHN
         Py1snfOgUedHZPAFD9sWAkllW31vRkc5kF9H/ivWXvz2KjyntbrkIocK95iU31gKrVPf
         5wEQ51F/s8mi4mwIxHJwMZchXjptCZb521lbz5RpBy9c8qhKhtdYfYQIx9QHaZlj495b
         dWLWdvONzgiYS3Gp0fHJNA43D3TKMUorZCBt1I4wzzvmv8pyiZRzVaVl2dQeL03to/Dl
         q8qRC6h/kzNdV7TjdpuWJUiRugP7aXI4VLBe/sruhtLbWnRI30SQQWNjFWYWX6fAVBy+
         ZmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=94oSWgv623B/vmFeXPtXCML7tcwqRLnG281XL1J9b1s=;
        b=qd/dphsD4MevMXm65kciDTorbLDanaHnozWf8SH+RI0Aioo4xZYRflepqrycQ/Hr/c
         BIYy3cUtGXvKbjTzcmf/9Bp7imWidKknuQ/Cp5I0KvL4srYDZeXN1i23u7/Ub2aafv8K
         TXcuJUX3u78oUvF0H0Qjv3iwqwc7dBimq8I38aqzNdJRu+4M2InaIx4CtriCeJ0RakhR
         Cld9IgQrRwEeoovfH8QMyJCYurQ/jGpGrZ9M7AB6ZT8olalxxx4btfrvMk1XQQ1JBokc
         36RWsdKuoCoOK2S2bu1odD1+jYWhbs0T4uNdNs7sPUGdY3Fi6FS7SLBR8vW2xkjX3fX3
         ZrJQ==
X-Gm-Message-State: AJcUukcZn0OcuFEMgHbBUyJCh95fR6dKXnDVTr80FpTebKjKZIpPgJY1
        xl6rA49ycvTUZzdwS/sqSaY=
X-Google-Smtp-Source: ALg8bN6GJ6EUb+TJCk7oKkQT3abnWSOckBlSdCv/kQVOkc8UXDYZChhS/8TgROLJS7cXNG1bhDpyKQ==
X-Received: by 2002:adf:ae1a:: with SMTP id x26mr23318965wrc.0.1546650556822;
        Fri, 04 Jan 2019 17:09:16 -0800 (PST)
Received: from localhost.localdomain (94-21-23-250.pool.digikabel.hu. [94.21.23.250])
        by smtp.gmail.com with ESMTPSA id c15sm1851353wml.27.2019.01.04.17.09.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 Jan 2019 17:09:16 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v4 3/8] test-lib: parse options in a for loop to keep $@ intact
Date:   Sat,  5 Jan 2019 02:08:54 +0100
Message-Id: <20190105010859.11031-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.1.151.gec613c4b75
In-Reply-To: <20190105010859.11031-1-szeder.dev@gmail.com>
References: <20181230191629.3232-1-szeder.dev@gmail.com>
 <20190105010859.11031-1-szeder.dev@gmail.com>
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
 t/test-lib.sh | 78 +++++++++++++++++++++++++++------------------------
 1 file changed, 42 insertions(+), 36 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1f02e2e25b..3cf59a92f0 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -264,68 +264,74 @@ test "x$TERM" != "xdumb" && (
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
-		trace=t
-		shift ;;
+		trace=t ;;
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

