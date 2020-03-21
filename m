Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF2DC4332B
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 19:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DBFF2072C
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 19:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="RGIVhB9y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgCUT5q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 15:57:46 -0400
Received: from mail-qv1-f42.google.com ([209.85.219.42]:45760 "EHLO
        mail-qv1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbgCUT5q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 15:57:46 -0400
Received: by mail-qv1-f42.google.com with SMTP id h20so5029236qvr.12
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 12:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V7IkjM76madigAkXuxIINRH6TnxGYQjDNHBzGnmnYKc=;
        b=RGIVhB9ylqM4y8UBtRglpffBv9krHH3ae5jTXfmw9VUW/Emc5/qCFR7jO5sIoTNSRo
         BA89MIKHGG1mYCgBoDPOO77ai6uHTUQMJSHE8nvIKqgAdOU4GEK5WVtCvPyRdz1n+Jiw
         MbkzHOUFZu+Zq6iWjNndVLI4AW33YO/kyrE6IXv105JHkUH5UzLsPNqkixS1K5vnBwdV
         lT6znhfaIQLC2g4Jk+9+lALUNu/W5LQrH7ZIEn3439Fq9agsDV1tfwB1AZftG+63uv7p
         O8ZdyELWzLfCU3KfvZQxcrtf642MdkKpUnJjtrDxhKaapQixbLh6yRe/5MLa+m6JpZoA
         5UZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V7IkjM76madigAkXuxIINRH6TnxGYQjDNHBzGnmnYKc=;
        b=GvGUeM5Zstiv25PmulPd6wiUtdVraVrShIBtGS1yRRa53Y4CffvnV2/zvfPwEJF3Kp
         Bks/wIOLiCQdlEBYA9egLWxJCwU06MeuGM2Fh5ZzzlymkFUr/iAm2jFs7R7loXNWHlx+
         CQOOlr99wqaFKoCet/NOeKxDGbjDqLAlnve+Ta1IZwXPgqACsj4FZ/barm/CNQyyVR4c
         GcNYiOHL3k4M/PKYu2Is3Dr5d01GNSL/ieDCZJe+FWtTnMBZse+xp5sIhVpyg7kVjVDR
         NlnfLM4A4MwvJIivK3CarT+JUcpW5xtjJsvi+mu9LXQF92eHSv8dqkDkE6PHuwtQjvY9
         3bPw==
X-Gm-Message-State: ANhLgQ0fICyp6UDHBXf7YAHdUMg+0mToAMaxMTtfc/f0lRz1Iy/qAlVT
        /b9IYdTOIblGt9kb04MTI8ybc8k8UYA=
X-Google-Smtp-Source: ADFU+vt5vUuqw64CFm4QVa7rPkYpfUKilGdDQpGtV2C3/gX3a3G+KBXhs7B4YLmQX7Sj0VNFVO/nxQ==
X-Received: by 2002:a0c:9b95:: with SMTP id o21mr14492288qve.175.1584820663669;
        Sat, 21 Mar 2020 12:57:43 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::3])
        by smtp.gmail.com with ESMTPSA id f68sm7863391qtb.19.2020.03.21.12.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 12:57:42 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, szeder.dev@gmail.com,
        Johannes.Schindelin@gmx.de, j6t@kdbg.org, peff@peff.net
Subject: [PATCH v2] test-lib: allow short options to be bundled
Date:   Sat, 21 Mar 2020 16:57:31 -0300
Message-Id: <7a6a8197dcd58e8690892d03cb904dd1eec5d7c1.1584818457.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <48c28683412e3e0803d4c7189a6d66daddcdc580.1584759277.git.matheus.bernardino@usp.br>
References: <48c28683412e3e0803d4c7189a6d66daddcdc580.1584759277.git.matheus.bernardino@usp.br>
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

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---

Changes since v1:
- Added a check for bundles containing more than one "option that
  requires args" (e.g. '-rr'), in which case we error-out. We could
  interpret '-rr 1 2' as 'run tests 1 _and_ 2', but the unbundled
  format, '-r 1 -r 2', is not currently interpreted like that (the last
  just overrides the previous). So, for simplicity, let's only forbid
  such bundles for now.
- Used "$1" instead of "$@" to get the argument in parse_option()
- Replaced occurrences of "stacked options" to "bundled options"
- Eliminated spawning of extra processes in the bundled options parser
- s/below/later/ in the parser loop comment, to make it clearer

 t/README      |  3 ++-
 t/test-lib.sh | 62 +++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 50 insertions(+), 15 deletions(-)

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
index 0ea1e5a05e..dda770ec94 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -78,20 +78,24 @@ then
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
+mark_option_requires_arg ()
+{
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
@@ -101,7 +105,7 @@ do
 	-l|--l|--lo|--lon|--long|--long-|--long-t|--long-te|--long-tes|--long-test|--long-tests)
 		GIT_TEST_LONG=t; export GIT_TEST_LONG ;;
 	-r)
-		store_arg_to=run_list
+		mark_option_requires_arg "$opt" run_list
 		;;
 	--run=*)
 		run_list=${opt#--*=} ;;
@@ -185,12 +189,42 @@ do
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
+	--*)
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

