Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6CDC54FCF
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 15:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D6920724
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 15:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="u4TkSDkd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgCVP7Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 11:59:16 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]:43841 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbgCVP7P (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 11:59:15 -0400
Received: by mail-qk1-f181.google.com with SMTP id o10so6900428qki.10
        for <git@vger.kernel.org>; Sun, 22 Mar 2020 08:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xtlOzxVDpF03T3OBcU/HpiAl5ZkCRP0qTt/F3IQdUwU=;
        b=u4TkSDkdCcGDeK9cOvKirqnvJMQ8c7Di2uiBk0DsEvhaAcC8PL14QbJXZVZXNRhBsK
         brqKYyHRNDPcyi6c9B0XyLZddn5ovvC5ohSErG7zBscnsz8sz3mRChh3OW56sCuaxyBJ
         jF8mp5qbT7Zwh1+lQTN31sS0GYflw5xjJk0WaFfvtfPqxmE1+veTUsRPaCm2ghbjigH9
         2qOtc3jkigUhTXb+2k+Kthpmt7T7xD89Djw7xHRB16SGnzz86g783Q/ucM40hbX9ZEn7
         /hAS3eC1LEfItiTx/fWVVcBvPxMB6u7dKOUBRFbhujJ9K4M9+gxXO2P9T7wWihw3jA6k
         ytiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xtlOzxVDpF03T3OBcU/HpiAl5ZkCRP0qTt/F3IQdUwU=;
        b=f8w+vkxMweCFq/cjJSsdnd2rqR4bWxm/d44BgAfS+h17roRf0CbAgz2qaU7zX3pV40
         TGj0lz8GjBwbfIlA3Lrpm6XAq7Si6rE8XptYkLyGyxqUC9/aeVoVl+Fbum3dbkCKBKci
         2VDP6QccqLBEE8w3EZU/S/chL62H1koEeZvndKBC9sw8VxmDlT1NFIGuBo4f41xC1NHo
         WElfUXfd9XvbVLTiBWCdXBtHRFjMIx6Agcw2vRl7i+JecwMS8wr3bsVMtMeC5Aqzeojf
         Kkegd/TR9l7HIjtpfB/Kdt/jBC8aPyKATvXa8sq53MZmvmEBPV7ZZ14Db1JSHae6opms
         SvcQ==
X-Gm-Message-State: ANhLgQ3s6MyclT2rPIDKM3ifxzmm9dwYLFX9p5MxOP2S0Y9GfspgHSbx
        UqDHM/r6KbAOMSibsmaEdKPW6g==
X-Google-Smtp-Source: ADFU+vvAKJSmg17TTlnLKgprOAwI7Go3mZahtOyOgp52z87sBqDNhZGepoxZOCYibNnf3UUpB0wJjw==
X-Received: by 2002:a37:a95:: with SMTP id 143mr2021723qkk.264.1584892753212;
        Sun, 22 Mar 2020 08:59:13 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::3])
        by smtp.gmail.com with ESMTPSA id n21sm9627655qtn.17.2020.03.22.08.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 08:59:12 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, j6t@kdbg.org,
        peff@peff.net, szeder.dev@gmail.com
Subject: [PATCH v3] test-lib: allow short options to be bundled
Date:   Sun, 22 Mar 2020 12:58:57 -0300
Message-Id: <cec4bbcc4270914a729a2c65d9c0efc4a45742ce.1584854619.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <7a6a8197dcd58e8690892d03cb904dd1eec5d7c1.1584818457.git.matheus.bernardino@usp.br>
References: <7a6a8197dcd58e8690892d03cb904dd1eec5d7c1.1584818457.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When debugging a test (or a set of tests), it's common to execute it
with some combination of short options, such as:

	$ ./txxx-testname.sh -d -x -i

In cases like this, CLIs usually allow the short options to be bundled
in a single argument, for convenience and agility. Let's add this
feature to test-lib, allowing the above command to be run as:

	$ ./txxx-testname.sh -dxi
	(or any other permutation, e.g. '-ixd')

Note: Short options that require an argument can also be used in a
bundle, in any position. So, for example, '-r 5 -x', '-xr 5' and '-rx 5'
are all valid and equivalent. A special case would be having a bundle
with more than one of such options. To keep things simple, this case is
not allowed for now. This shouldn't be a major limitation, though, as
the only short option that requires an argument today is '-r'. And
concatenating '-r's as in '-rr 5 6' would probably not be very
practical: its unbundled format would be '-r 5 -r 6', for which test-lib
currently considers only the last argument. Therefore, if '-rr 5 6' were
to be allowed, it would have the same effect as just typing '-r 6'.

Note: the test-lib currently doesn't support '-r5', as an alternative
for '-r 5', so the former is not supported in bundles as well.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---

Changes since v2:
- Fixed style in mark_option_requires_arg(), moving "{" to the same line
- In the main options parser loop, joined long options and unbundled
  short options in the same case arm, as suggested by J6t. This provides
  a clearer codeflow.
- Summarized, in the commit message, the approach chosen on bundling
  options that require args. Since this was an important point in the
  last rounds, I thought it would be good to include our decisions (and
  justification) in the commit body.

 t/README      |  3 ++-
 t/test-lib.sh | 61 +++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 49 insertions(+), 15 deletions(-)

diff --git a/t/README b/t/README
index 9afd61e3ca..080bc59fc4 100644
--- a/t/README
+++ b/t/README
@@ -69,7 +69,8 @@ You can also run each test individually from command line, like this:
 
 You can pass --verbose (or -v), --debug (or -d), and --immediate
 (or -i) command line argument to the test, or by setting GIT_TEST_OPTS
-appropriately before running "make".
+appropriately before running "make". Short options can be bundled, i.e.
+'-d -v' is the same as '-dv'.
 
 -v::
 --verbose::
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0ea1e5a05e..a6178e9fac 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -78,20 +78,23 @@ then
 	exit 1
 fi
 
-# Parse options while taking care to leave $@ intact, so we will still
-# have all the original command line options when executing the test
-# script again for '--tee' and '--verbose-log' below.
 store_arg_to=
-prev_opt=
-for opt
-do
-	if test -n "$store_arg_to"
+opt_required_arg=
+# $1: option string
+# $2: name of the var where the arg will be stored
+mark_option_requires_arg () {
+	if test -n "$opt_required_arg"
 	then
-		eval $store_arg_to=\$opt
-		store_arg_to=
-		prev_opt=
-		continue
+		echo "error: options that require args cannot be bundled" \
+			"together: '$opt_required_arg' and '$1'" >&2
+		exit 1
 	fi
+	opt_required_arg=$1
+	store_arg_to=$2
+}
+
+parse_option () {
+	local opt="$1"
 
 	case "$opt" in
 	-d|--d|--de|--deb|--debu|--debug)
@@ -101,7 +104,7 @@ do
 	-l|--l|--lo|--lon|--long|--long-|--long-t|--long-te|--long-tes|--long-test|--long-tests)
 		GIT_TEST_LONG=t; export GIT_TEST_LONG ;;
 	-r)
-		store_arg_to=run_list
+		mark_option_requires_arg "$opt" run_list
 		;;
 	--run=*)
 		run_list=${opt#--*=} ;;
@@ -185,12 +188,42 @@ do
 	*)
 		echo "error: unknown test option '$opt'" >&2; exit 1 ;;
 	esac
+}
+
+# Parse options while taking care to leave $@ intact, so we will still
+# have all the original command line options when executing the test
+# script again for '--tee' and '--verbose-log' later.
+for opt
+do
+	if test -n "$store_arg_to"
+	then
+		eval $store_arg_to=\$opt
+		store_arg_to=
+		opt_required_arg=
+		continue
+	fi
 
-	prev_opt=$opt
+	case "$opt" in
+	--*|-?)
+		parse_option "$opt" ;;
+	-?*)
+		# bundled short options must be fed separately to parse_option
+		opt=${opt#-}
+		while test -n "$opt"
+		do
+			extra=${opt#?}
+			this=${opt%$extra}
+			opt=$extra
+			parse_option "-$this"
+		done
+		;;
+	*)
+		echo "error: unknown test option '$opt'" >&2; exit 1 ;;
+	esac
 done
 if test -n "$store_arg_to"
 then
-	echo "error: $prev_opt requires an argument" >&2
+	echo "error: $opt_required_arg requires an argument" >&2
 	exit 1
 fi
 
-- 
2.25.1

