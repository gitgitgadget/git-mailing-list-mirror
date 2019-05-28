Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 742441F462
	for <e@80x24.org>; Tue, 28 May 2019 10:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfE1KPw (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 06:15:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42886 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfE1KPw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 06:15:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id l2so19563798wrb.9
        for <git@vger.kernel.org>; Tue, 28 May 2019 03:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XrGlZRu5rNEz6iD4xUGB565TD6qEqWCcnxyrJUW6sG4=;
        b=iJQrwlAt6sylSfv2hJDJJmrVa53g1obA+m4t/iI3Blzjdir9TGrHTMYm7HOZWYsckN
         gqDwIIL1VKXczDfrMdNxMfWTbLwMG3V7HuxJsIf2/UiibhM72Y5i6kJ1Eww6zWTVbtiG
         rq41TA4AvNXFW7jU9/CvzPbjZcCzorRkSHhqlrjJQ3J6cCJ3ggcOlpaof25MTJf/Loqt
         CAudXMwm+C49aRm3URn43JVQvA+X6KRTpiuuNzjGwFmLuMbtOHi3wTz9qnvReLPNUZ3J
         17U9RXUqAm7Rnp3LtLjyuSdtkSIWI0nGNsEOI9dEzhF4IdCLjm5Vd9AxXdKe0eJXTEz9
         E+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=XrGlZRu5rNEz6iD4xUGB565TD6qEqWCcnxyrJUW6sG4=;
        b=bKRo7LhYPlRiURKmsIr1R3lj7rmBN4/lwBEdVJ4ZBKyEDEhKtRilVWnf6kXpHiUTnt
         HqIKSvgVOi5t0R6Azh4Q3QaGHQb+vMjcvlqtb//sLewN0NNmJYwLqvDpeuUj7K7d4fNS
         L72eRJRjMsFgLRFl0q2ptKLSNhH3AX/z41aIjnz/DaSa9Cn/vBOi9EZ6D/h3bSYZZJoM
         0asBPGzwTUItJ4FFYnI/NnFQKBSSRfEylFzdN9Kop07Zvoc6wudYFxrY2dGAn3dKyoCn
         uSMrUJV5Qb+zpjHY3gJP8bhe6koMjIjg2tWl2HwkWJOUWk0wb3wmnsNf//4mzv/H3AnS
         ef2Q==
X-Gm-Message-State: APjAAAXdnhpSylxDX0iRnrUgKEOqJyAGM4vhujkQFouoSr7HVXiSnZvH
        T1+3U+POQjqDAyDNeHfLExxvETV5
X-Google-Smtp-Source: APXvYqwToaafVKQi1mG4/BOi5tfg2UM/DmyQ8ym2qWbdsYmI3Fj3FS2g9gNb+jL78eyjTNsXKWa28Q==
X-Received: by 2002:a5d:5283:: with SMTP id c3mr38539899wrv.268.1559038549440;
        Tue, 28 May 2019 03:15:49 -0700 (PDT)
Received: from donizetti.lan ([2001:b07:6468:f312:c43e:46a8:e962:cee8])
        by smtp.gmail.com with ESMTPSA id d9sm12339721wro.26.2019.05.28.03.15.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 03:15:48 -0700 (PDT)
From:   Paolo Bonzini <bonzini@gnu.org>
To:     git@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 2/2] request-pull: warn if the remote object is not the same as the local one
Date:   Tue, 28 May 2019 12:15:43 +0200
Message-Id: <20190528101543.16094-3-bonzini@gnu.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190528101543.16094-1-bonzini@gnu.org>
References: <20190528101543.16094-1-bonzini@gnu.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

In some cases, git request-pull might be invoked with remote and
local objects that differ even though they point to the same commit.
For example, the remote object might be a lightweight tag
vs. an annotated tag on the local side; or the user might have
reworded the tag locally and forgotten to push it.

When this happens git-request-pull will not warn, because it only
checks that "git ls-remote" returns an SHA1 that matches the local
commit (known as $headrev in the script).  This patch makes
git-request-pull retrieve the tag object SHA1 while processing
the "git ls-remote" output, so that it can be matched against the
local object.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 git-request-pull.sh     | 43 +++++++++++++++++++++++++++--------------
 t/t5150-request-pull.sh | 35 +++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 15 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index 0d128be7fd..2d0e44656c 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -65,6 +65,8 @@ test -z "$head" && die "fatal: Not a valid revision: $local"
 headrev=$(git rev-parse --verify --quiet "$head"^0)
 test -z "$headrev" && die "fatal: Ambiguous revision: $local"
 
+local_sha1=$(git rev-parse --verify --quiet "$head")
+
 # Was it a branch with a description?
 branch_name=${head#refs/heads/}
 if test "z$branch_name" = "z$headref" ||
@@ -77,42 +79,53 @@ merge_base=$(git merge-base $baserev $headrev) ||
 die "fatal: No commits in common between $base and $head"
 
 # $head is the refname from the command line.
-# If a ref with the same name as $head exists at the remote
-# and their values match, use that.
-#
-# Otherwise find a random ref that matches $headrev.
+# Find a ref with the same name as $head that exists at the remote
+# and points to the same commit as the local object.
 find_matching_ref='
 	my ($head,$headrev) = (@ARGV);
 	my $pattern = qr{/\Q$head\E$};
-	my ($found);
+	my ($remote_sha1, $found);
 
 	while (<STDIN>) {
 		chomp;
 		my ($sha1, $ref, $deref) = /^(\S+)\s+([^^]+)(\S*)$/;
-		next unless ($sha1 eq $headrev);
 
-		if ($ref eq $head) {
-			$found = $ref;
-		}
-		if ($ref =~ $pattern) {
-			$found = $ref;
-		}
 		if ($sha1 eq $head) {
-			$found = $sha1;
+			$found = $remote_sha1 = $sha1;
+			break;
+		}
+
+		if ($ref eq $head || $ref =~ $pattern) {
+			if ($deref eq "") {
+				# Remember the matching object on the remote side
+				$remote_sha1 = $sha1;
+			}
+			if ($sha1 eq $headrev) {
+				$found = $ref;
+				break;
+			}
 		}
 	}
 	if ($found) {
-		print "$found\n";
+		$remote_sha1 = $headrev if ! defined $remote_sha1;
+		print "$remote_sha1 $found\n";
 	}
 '
 
-ref=$(git ls-remote "$url" | @@PERL@@ -e "$find_matching_ref" "${remote:-HEAD}" "$headrev")
+set fnord $(git ls-remote "$url" | @@PERL@@ -e "$find_matching_ref" "${remote:-HEAD}" "$headrev")
+remote_sha1=$2
+ref=$3
 
 if test -z "$ref"
 then
 	echo "warn: No match for commit $headrev found at $url" >&2
 	echo "warn: Are you sure you pushed '${remote:-HEAD}' there?" >&2
 	status=1
+elif test "$local_sha1" != "$remote_sha1"
+then
+	echo "warn: $head found at $url but points to a different object" >&2
+	echo "warn: Are you sure you pushed '${remote:-HEAD}' there?" >&2
+	status=1
 fi
 
 # Special case: turn "for_linus" to "tags/for_linus" when it is correct
diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index c1a821a549..852dcd913f 100755
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -264,4 +264,39 @@ test_expect_success 'request-pull quotes regex metacharacters properly' '
 
 '
 
+test_expect_success 'pull request with mismatched object' '
+
+	rm -fr downstream.git &&
+	git init --bare downstream.git &&
+	(
+		cd local &&
+		git checkout initial &&
+		git merge --ff-only master &&
+		git push origin HEAD:refs/tags/full &&
+		test_must_fail git request-pull initial "$downstream_url" tags/full \
+			2>../err
+	) &&
+	grep "points to a different object" err &&
+	grep "Are you sure you pushed" err
+
+'
+
+test_expect_success 'pull request with stale object' '
+
+	rm -fr downstream.git &&
+	git init --bare downstream.git &&
+	(
+		cd local &&
+		git checkout initial &&
+		git merge --ff-only master &&
+		git push origin refs/tags/full &&
+		git tag -f -m"Thirty-one days" full &&
+		test_must_fail git request-pull initial "$downstream_url" tags/full \
+			2>../err
+	) &&
+	grep "points to a different object" err &&
+	grep "Are you sure you pushed" err
+
+'
+
 test_done
-- 
2.21.0

