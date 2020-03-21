Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A64C4332B
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 03:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D71B620709
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 03:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="fKYfuYft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgCUDHZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 23:07:25 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]:40953 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgCUDHZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 23:07:25 -0400
Received: by mail-qk1-f173.google.com with SMTP id l25so4494721qki.7
        for <git@vger.kernel.org>; Fri, 20 Mar 2020 20:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H3bNIVsE7MbgDcihWqo7i12B208h6l/wbN0uz21w/Yw=;
        b=fKYfuYfteb1ywNkr+Mq79GF/H622LSp1tfHXSvroQ+Gagdefk0VPjhQGxEdaO5Ta+Q
         pFVVMAiQx+JBkP1Vaimlt9F/0nDkFa7Vl/6k9L/uajdpz5hO51Wxda90EOXF2HcL8w6E
         BzMsEy9oWtk+HDhfDezu8WvucpA75pKaspD4nvIEIZTf9raDjkEgkTAlldt7Qohz5ird
         G7tbt5Zij0Oc/6AkR6HE8m3B5nrXWVOhduOyRU9/7zgiSpg52atyFspNYAtxMLEodeLe
         /NgPikxgKUmtPucnqgMrN03vOP6fAQDu4oLS0KRXtU0XWq9MQ35eQeHgCfUKE6/mlFhR
         BdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H3bNIVsE7MbgDcihWqo7i12B208h6l/wbN0uz21w/Yw=;
        b=BehmyEBwF3xdWMCKCwRwCyjzcr1nE4zMPBKn/oCEM1Ed307SQZqdkG32LkqjI2Ucmd
         er+ge8lwrrrLx3PR1E/qyidjd6/FaIvsJ+NeUWRoW2TziVoNKuIAVGMoWKBWIx0PWeZH
         qw/13FzRposIGM033IjZi7RNiysqigWwGff7wYM7vhQDBrdikN+jBfY/bqAHr6SqOxeS
         Tyk5mUiivAGAIuJ0HiNm5jhh23pAhyvN7z3m/+TyrT52TMBuRGv5qPrGZfYZncCLK2EN
         pg8d3Z0YbymEAP8IIulctlbc6mBVoQLGK2H0sNG5muDpw6nqxpbVZ+TIey9l3JmoE1IW
         hEqw==
X-Gm-Message-State: ANhLgQ3LZgmIRe/B7e8mMzXpuwhkY92ZwwViVFowkBD55cqNZkZlODBL
        7EL6FlDRWb2hDuSTQhcV6YQdQ6A0NiE=
X-Google-Smtp-Source: ADFU+vs0Kb6juDTU5gDz8E6BNu+ElCNOixsFZoFgvQz2nq/TLekZRVqQj0VqtKVJu/KKdNwh/foTIw==
X-Received: by 2002:a37:a89:: with SMTP id 131mr256185qkk.137.1584760041422;
        Fri, 20 Mar 2020 20:07:21 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::3])
        by smtp.gmail.com with ESMTPSA id f13sm6200772qti.47.2020.03.20.20.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 20:07:20 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] test-lib: allow short options to be stacked
Date:   Sat, 21 Mar 2020 00:07:05 -0300
Message-Id: <48c28683412e3e0803d4c7189a6d66daddcdc580.1584759277.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When debugging a test (or a set of tests), it's common to execute it
with some combination of short options, such as:

	$ ./txxx-testname.sh -d -x -i

In cases like this, CLIs usually allow the short options to be stacked
in a single argument, for convenience and agility. Let's add this
feature to test-lib, allowing the above command to be run as:

	$ ./txxx-testname.sh -dxi
	(or any other permutation, e.g. '-ixd')

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 t/README      |  3 ++-
 t/test-lib.sh | 46 ++++++++++++++++++++++++++++++++--------------
 2 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/t/README b/t/README
index 9afd61e3ca..c3cf8f617b 100644
--- a/t/README
+++ b/t/README
@@ -69,7 +69,8 @@ You can also run each test individually from command line, like this:
 
 You can pass --verbose (or -v), --debug (or -d), and --immediate
 (or -i) command line argument to the test, or by setting GIT_TEST_OPTS
-appropriately before running "make".
+appropriately before running "make". Short options can be stacked, i.e.
+'-d -v' is the same as '-dv'.
 
 -v::
 --verbose::
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0ea1e5a05e..14363010d2 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -72,119 +72,137 @@ then
 	if test -n "$GIT_TEST_INSTALLED"
 	then
 		echo >&2 "error: there is no working Git at '$GIT_TEST_INSTALLED'"
 	else
 		echo >&2 'error: you do not seem to have built git yet.'
 	fi
 	exit 1
 fi
 
-# Parse options while taking care to leave $@ intact, so we will still
-# have all the original command line options when executing the test
-# script again for '--tee' and '--verbose-log' below.
-store_arg_to=
-prev_opt=
-for opt
-do
-	if test -n "$store_arg_to"
-	then
-		eval $store_arg_to=\$opt
-		store_arg_to=
-		prev_opt=
-		continue
-	fi
+parse_option () {
+	local opt="$@"
 
 	case "$opt" in
 	-d|--d|--de|--deb|--debu|--debug)
 		debug=t ;;
 	-i|--i|--im|--imm|--imme|--immed|--immedi|--immedia|--immediat|--immediate)
 		immediate=t ;;
 	-l|--l|--lo|--lon|--long|--long-|--long-t|--long-te|--long-tes|--long-test|--long-tests)
 		GIT_TEST_LONG=t; export GIT_TEST_LONG ;;
 	-r)
 		store_arg_to=run_list
 		;;
 	--run=*)
 		run_list=${opt#--*=} ;;
 	-h|--h|--he|--hel|--help)
 		help=t ;;
 	-v|--v|--ve|--ver|--verb|--verbo|--verbos|--verbose)
 		verbose=t ;;
 	--verbose-only=*)
 		verbose_only=${opt#--*=}
 		;;
 	-q|--q|--qu|--qui|--quie|--quiet)
 		# Ignore --quiet under a TAP::Harness. Saying how many tests
 		# passed without the ok/not ok details is always an error.
 		test -z "$HARNESS_ACTIVE" && quiet=t ;;
 	--with-dashes)
 		with_dashes=t ;;
 	--no-bin-wrappers)
 		no_bin_wrappers=t ;;
 	--no-color)
 		color= ;;
 	--va|--val|--valg|--valgr|--valgri|--valgrin|--valgrind)
 		valgrind=memcheck
 		tee=t
 		;;
 	--valgrind=*)
 		valgrind=${opt#--*=}
 		tee=t
 		;;
 	--valgrind-only=*)
 		valgrind_only=${opt#--*=}
 		tee=t
 		;;
 	--tee)
 		tee=t ;;
 	--root=*)
 		root=${opt#--*=} ;;
 	--chain-lint)
 		GIT_TEST_CHAIN_LINT=1 ;;
 	--no-chain-lint)
 		GIT_TEST_CHAIN_LINT=0 ;;
 	-x)
 		trace=t ;;
 	-V|--verbose-log)
 		verbose_log=t
 		tee=t
 		;;
 	--write-junit-xml)
 		write_junit_xml=t
 		;;
 	--stress)
 		stress=t ;;
 	--stress=*)
 		echo "error: --stress does not accept an argument: '$opt'" >&2
 		echo "did you mean --stress-jobs=${opt#*=} or --stress-limit=${opt#*=}?" >&2
 		exit 1
 		;;
 	--stress-jobs=*)
 		stress=t;
 		stress=${opt#--*=}
 		case "$stress" in
 		*[!0-9]*|0*|"")
 			echo "error: --stress-jobs=<N> requires the number of jobs to run" >&2
 			exit 1
 			;;
 		*)	# Good.
 			;;
 		esac
 		;;
 	--stress-limit=*)
 		stress=t;
 		stress_limit=${opt#--*=}
 		case "$stress_limit" in
 		*[!0-9]*|0*|"")
 			echo "error: --stress-limit=<N> requires the number of repetitions" >&2
 			exit 1
 			;;
 		*)	# Good.
 			;;
 		esac
 		;;
 	*)
 		echo "error: unknown test option '$opt'" >&2; exit 1 ;;
 	esac
+}
+
+# Parse options while taking care to leave $@ intact, so we will still
+# have all the original command line options when executing the test
+# script again for '--tee' and '--verbose-log' below.
+store_arg_to=
+prev_opt=
+for opt
+do
+	if test -n "$store_arg_to"
+	then
+		eval $store_arg_to=\$opt
+		store_arg_to=
+		prev_opt=
+		continue
+	fi
+
+	case "$opt" in
+	--*)
+		parse_option "$opt" ;;
+	-?*)
+		# stacked short options must be fed separately to parse_option
+		for c in $(echo "${opt#-}" | sed 's/./& /g')
+		do
+			parse_option "-$c"
+		done
+		;;
+	*)
+		echo "error: unknown test option '$opt'" >&2; exit 1 ;;
+	esac
 
 	prev_opt=$opt
 done
-- 
2.25.1

