Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70EC920D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 23:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751122AbdFAXvV (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 19:51:21 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33909 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbdFAXvU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 19:51:20 -0400
Received: by mail-pf0-f179.google.com with SMTP id 9so40426795pfj.1
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 16:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cbeiJEJKXO3RP+q39+lxFCzzzdjM6VlfMm472FJwHaI=;
        b=Zwlp5U+w4IS+oT8F47iO8BhFeqOO9Ub6wH9MpaDnYOzlSfLmT2iIiNRjYpHYeeT0+i
         olN7ExJnOqGeqYp4/C8eo9q/pAa03NnItJnyWDPe+7mxTWv/F2H2zKAC3ijNR80z6yUj
         oTwT97Xd7Du55rIBNXvCFcRVn4bdwUr0J9TGHnRpyEywitn85YlFtEXfnLDSnvdzLVUc
         doH/w1QrH4f3aleQcl+rr0btyMOw96axIh0g34v5xnx/2VwSOYopnRQQNANORj5LL59P
         3WzbnQmnziU/qoBRQ24JFKKA0nKgJmOr/dqe39UgNjvuR722oP8ARsFKd3rwAj8tZi3d
         0y8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cbeiJEJKXO3RP+q39+lxFCzzzdjM6VlfMm472FJwHaI=;
        b=NGrl6QA6yM7VNVJ/M9C/DtEpyf/hwBvn/c4ZQHYS8q2goHtZrU23irvmbI3qSMoTk4
         ZO9DpslVoU4oqBaeMDk9a/urwUyMSZ1fKxj79I+bll0yj9WYL3uA+Ifqrlz3cGn/bTpe
         O0KlT251V/S9DTFYqok74xjgL6Insa457Deq+jMKeNEnPc0dgy+u5xmXwY6exJE/8ANk
         a82XdD8Bu0yze8igak8kT2bf4RRYP5BmxZFmWNn9ibVAgIEysbOyDsw22CpRc5S8Inlq
         cbABRuFs+5js1iVLILW7E5gNpurMyW9Y7wvLwYwjq4nMOqsNClZzdbdX1K+bOIXUImzf
         F3OA==
X-Gm-Message-State: AODbwcD6cqJGrXnUnlp18rzyWF/srg6C+aA+yFr7jOlP+X6suEegetN5
        bM36c7XzO9J1kCACXxSogQ==
X-Received: by 10.101.76.201 with SMTP id n9mr3858784pgt.40.1496361079783;
        Thu, 01 Jun 2017 16:51:19 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id z7sm21074096pgr.3.2017.06.01.16.51.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 16:51:18 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, bmwill@google.com,
        gitster@pobox.com, jacob.keller@gmail.com
Subject: [PATCH] send-email: check for repo before invoking hook
Date:   Thu,  1 Jun 2017 16:50:55 -0700
Message-Id: <20170601235055.22621-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.0.506.g27d5fe0cd-goog
In-Reply-To: <CA+P7+xr39qk9qHE0=uU3HZE2wOhU9X7rmENoDfP=bp09j9N9Mg@mail.gmail.com>
References: <CA+P7+xr39qk9qHE0=uU3HZE2wOhU9X7rmENoDfP=bp09j9N9Mg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unless --no-validate is passed, send-email will invoke
$repo->repo_path() in its search for a validate hook regardless of
whether a Git repo is actually present.  Teach send-email to first check
for repo existence.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Thanks for the notification. Here's a patch to fix that.
---
 git-send-email.perl   | 32 +++++++++++++++++---------------
 t/t9001-send-email.sh |  8 ++++++++
 2 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index f0417f64e..94c54dc5a 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1755,21 +1755,23 @@ sub unique_email_list {
 sub validate_patch {
 	my $fn = shift;
 
-	my $validate_hook = catfile(catdir($repo->repo_path(), 'hooks'),
-				    'sendemail-validate');
-	my $hook_error;
-	if (-x $validate_hook) {
-		my $target = abs_path($fn);
-		# The hook needs a correct cwd and GIT_DIR.
-		my $cwd_save = cwd();
-		chdir($repo->wc_path() or $repo->repo_path())
-			or die("chdir: $!");
-		local $ENV{"GIT_DIR"} = $repo->repo_path();
-		$hook_error = "rejected by sendemail-validate hook"
-			if system($validate_hook, $target);
-		chdir($cwd_save) or die("chdir: $!");
-	}
-	return $hook_error if $hook_error;
+	if ($repo) {
+		my $validate_hook = catfile(catdir($repo->repo_path(), 'hooks'),
+					    'sendemail-validate');
+		my $hook_error;
+		if (-x $validate_hook) {
+			my $target = abs_path($fn);
+			# The hook needs a correct cwd and GIT_DIR.
+			my $cwd_save = cwd();
+			chdir($repo->wc_path() or $repo->repo_path())
+				or die("chdir: $!");
+			local $ENV{"GIT_DIR"} = $repo->repo_path();
+			$hook_error = "rejected by sendemail-validate hook"
+				if system($validate_hook, $target);
+			chdir($cwd_save) or die("chdir: $!");
+		}
+		return $hook_error if $hook_error;
+	}
 
 	open(my $fh, '<', $fn)
 		or die sprintf(__("unable to open %s: %s\n"), $fn, $!);
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 15128c755..d1e4e8ad1 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1953,4 +1953,12 @@ test_expect_success $PREREQ 'invoke hook' '
 	)
 '
 
+test_expect_success $PREREQ 'test that send-email works outside a repo' '
+	nongit git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		"$(pwd)/0001-add-master.patch"
+'
+
 test_done
-- 
2.13.0.506.g27d5fe0cd-goog

