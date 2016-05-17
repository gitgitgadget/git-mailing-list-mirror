From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/5] modernize t1500
Date: Tue, 17 May 2016 15:36:25 -0400
Message-ID: <20160517193630.10379-1-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 21:37:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2koC-00008r-1F
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 21:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbcEQThQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 15:37:16 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:33022 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120AbcEQThO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 15:37:14 -0400
Received: by mail-io0-f194.google.com with SMTP id x35so5522822ioi.0
        for <git@vger.kernel.org>; Tue, 17 May 2016 12:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=EPJUK34YODvQHgNqyD4WYps61Y8C45AIJbmqfHloS5o=;
        b=FlngTK1XYqkix1etE9+P3r18FP4baIC9Hk7ftV/SVdSHiZu2X1t1GFa74tpT2Wju9u
         KIDGMLVWBTXa4x7Pz47IDWImCpWj7DZby70YRksGXA8/JAdhYLh3FSZ6xSXyBIcrFO5c
         CxWpeQOo+gqOnNlxw9tiY3homGvJy1QFo/sq2N0jnUqvh9cB3lD6yyntpvFYixQaorZl
         82R5poKjMPvb+XOqj5k8aCTT7J6Cn/QzrOiG+9leERqaye6aPu+f2+6wYMidG+zaF9jO
         KzlANUUsVZPqvwefU3qTnMea3HTsqxcEGDHm6j13ONWTJClZYL2npk+kSe4BXAGh6sQ8
         MS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=EPJUK34YODvQHgNqyD4WYps61Y8C45AIJbmqfHloS5o=;
        b=iTewmJ+5/K6NGHcWKc2x43+Di58PEfJ8lU/UF2cOEvteIvalDXDWadxHr4KDvAOBOD
         cFA5aa0trNjwEeZ/dieY8KqBFW5q+gbTivPHf1HPZdUH8Rveijl1SpY6zJvSSiDceFa1
         9flXjagMaTSEDhXYlDRxou2RmFm01k2HhvVF9pA17dIRpP1V90vM3C/c7YopdNq8SSOi
         dJUtVT4H5GTUfEtE9qt58/Tr2Azx0GvTdQ9lEKK0zBKAyy978WDGGgX+i8Agwsmp7921
         li9KEe6RgDuSMq/Lhrb1stPvSXidao2iR1Ozze0E7lLeFNdimhMpSoO1aTbIqY15or+Q
         RSSw==
X-Gm-Message-State: AOPr4FUDNjMueY0kVOeVbF3LhwdzAFCWrK9FN8U8II/ZFzwSE6vM24l1mtcgpsHbH5XaiQ==
X-Received: by 10.107.128.74 with SMTP id b71mr2281912iod.87.1463513832840;
        Tue, 17 May 2016 12:37:12 -0700 (PDT)
Received: from localhost.localdomain (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id b67sm1506218iob.33.2016.05.17.12.37.11
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 17 May 2016 12:37:11 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.703.g78b384c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294902>

This is a re-roll of [1] which modernizes t1500 by updating tests to set
up their own needed state rather than relying upon manipulation of
global state.

Changes since v1[1]:

In v1 patch 1/6, which makes test_rev_parse() for-loop driven, the loop
control has been moved to the top of the loop for improved robustness.

v1 patch 2/6, which tweaked the value of GIT_CONFIG in preparation for
removal of global cd's has been squashed into patch 3/6 which actually
removes the cd's since the below diff makes perfect sense in the context
of the latter patch, thus doesn't require its own preparatory patch.

    -cd work || exit 1
    -GIT_CONFIG="$(pwd)"/../.git/config
    +GIT_CONFIG="$(pwd)/work/../.git/config"

v1 patch 3/6, which teaches test_rev_parse() the -C option, has been
revised to ensure that the argument to -C is always quoted upon use to
avoid problems with whitespace in directory names (though current tests
don't have any such directories).

v1 patches 4/6 and 5/6, which teach test_rev_parse() the -b and -g
options, no longer assigns shell code to a variable for later
execution/evaluation; instead they just execute the code directly.

v1 patch 5/6 ensures that the argument to -g is properly quoted when
assigned to GIT_DIR to avoid problems with whitespace in directory
names.

v1 patch 6/6, which changes "mv .git repo.git" to "cp -R .git repo.git",
has been squashed with Junio's 7/6[2], which moves the "cp -R" earlier
in the script, and now sits at the front of the series. Other
setup-related actions have likewise been moved into a common "setup"
test[3].

Most commit messages have seen minor tweaks.

A v1 to v2 interdiff is included below.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/294088
[2]: http://thread.gmane.org/gmane.comp.version-control.git/294088/focus=294168
[3]: http://thread.gmane.org/gmane.comp.version-control.git/294088/focus=294170

Eric Sunshine (5):
  t1500: be considerate to future potential tests
  t1500: test_rev_parse: facilitate future test enhancements
  t1500: avoid changing working directory outside of tests
  t1500: avoid setting configuration options outside of tests
  t1500: avoid setting environment variables outside of tests

 t/t1500-rev-parse.sh | 123 ++++++++++++++++++++++++++-------------------------
 1 file changed, 63 insertions(+), 60 deletions(-)

--- >8 ---
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index af223ed..39af565 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -7,26 +7,21 @@ test_description='test git rev-parse'
 test_rev_parse () {
 	dir=
 	bare=
-	env=
+	gitdir=
 	while :
 	do
 		case "$1" in
-		-C) dir="-C $2"; shift; shift ;;
-		-b) bare="$2"; shift; shift ;;
-		-g) env="GIT_DIR=$2; export GIT_DIR"; shift; shift ;;
+		-C) dir="$2"; shift; shift ;;
+		-b) case "$2" in
+		    [tfu]*) bare="$2"; shift; shift ;;
+		    *) error "test_rev_parse: bogus core.bare value '$2'" ;;
+		    esac ;;
+		-g) gitdir="$2"; shift; shift ;;
 		-*) error "test_rev_parse: unrecognized option '$1'" ;;
 		*) break ;;
 		esac
 	done
 
-	case "$bare" in
-	'') ;;
-	t*) bare="test_config $dir core.bare true" ;;
-	f*) bare="test_config $dir core.bare false" ;;
-	u*) bare="test_unconfig $dir core.bare" ;;
-	*) error "test_rev_parse: unrecognized core.bare value '$bare'"
-	esac
-
 	name=$1
 	shift
 
@@ -36,35 +31,48 @@ test_rev_parse () {
 		 show-prefix \
 		 git-dir
 	do
+		test $# -eq 0 && break
 		expect="$1"
 		test_expect_success "$name: $o" '
-			test_when_finished "sane_unset GIT_DIR" &&
-			eval $env &&
-			$bare &&
+			if test -n "$gitdir"
+			then
+				test_when_finished "unset GIT_DIR" &&
+				GIT_DIR="$gitdir" &&
+				export GIT_DIR
+			fi &&
+
+			case "$bare" in
+			t*) test_config ${dir:+-C "$dir"} core.bare true ;;
+			f*) test_config ${dir:+-C "$dir"} core.bare false ;;
+			u*) test_unconfig ${dir:+-C "$dir"} core.bare ;;
+			esac &&
+
 			echo "$expect" >expect &&
-			git $dir rev-parse --$o >actual &&
+			git ${dir:+-C "$dir"} rev-parse --$o >actual &&
 			test_cmp expect actual
 		'
 		shift
-		test $# -eq 0 && break
 	done
 }
 
 ROOT=$(pwd)
 
+test_expect_success 'setup' '
+	mkdir -p sub/dir work &&
+	cp -R .git repo.git
+'
+
 test_rev_parse toplevel false false true '' .git
 
 test_rev_parse -C .git .git/ false true false '' .
 test_rev_parse -C .git/objects .git/objects/ false true false '' "$ROOT/.git"
 
-test_expect_success 'setup untracked sub/dir' 'mkdir -p sub/dir'
 test_rev_parse -C sub/dir subdirectory false false true sub/dir/ "$ROOT/.git"
 
 test_rev_parse -b t 'core.bare = true' true false false
 
 test_rev_parse -b u 'core.bare undefined' false false true
 
-test_expect_success 'setup non-local database ../.git' 'mkdir work'
 
 test_rev_parse -C work -g ../.git -b f 'GIT_DIR=../.git, core.bare = false' false false true ''
 
@@ -72,7 +80,6 @@ test_rev_parse -C work -g ../.git -b t 'GIT_DIR=../.git, core.bare = true' true
 
 test_rev_parse -C work -g ../.git -b u 'GIT_DIR=../.git, core.bare undefined' false false true ''
 
-test_expect_success 'setup non-local database ../repo.git' 'cp -R .git repo.git'
 
 test_rev_parse -C work -g ../repo.git -b f 'GIT_DIR=../repo.git, core.bare = false' false false true ''
 
--- >8 ---


-- 
2.8.2.703.g78b384c
