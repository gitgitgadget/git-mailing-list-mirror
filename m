Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB92C433E0
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 346EF601FE
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhCTXnI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 19:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhCTXnD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 19:43:03 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42E8C061574
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 16:43:02 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id d8-20020a1c1d080000b029010f15546281so6946432wmd.4
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 16:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=0mGVMBLTYfYIbkGXfC0/qIEWH0B5Yfn5bveY9+Mxe7o=;
        b=btvBT3OqDHVg729wGyBic5Bz2EGzlgKsdLo4N+w2RxYU2y5JjFDHedh12Iy7LzGzwg
         VC4t/toFRNQx50vDOpyuuGoBjZvUtSpHBPxGOpgSkVc+nprmBfsdCoxNF0/C7dsUslXG
         hLsQkjD8hnPGrYyiODjza36V2iiZOD0TSsdIwsS8s6o/w3g+w1DPYb06AoEttUcOuWw1
         p35a6VgxvLNxN1M7zAguEuGMIKjDjpZdkv7JfSTeKFwz4LTkN9TMo/rn8kPvyAwsQwxH
         hXiKsyfIuURuEWRiqIHwOaRjM6IZWnlAnG9cr0E6rD6uzPXlNSL/CypIc814PYLUuX+m
         6Jug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0mGVMBLTYfYIbkGXfC0/qIEWH0B5Yfn5bveY9+Mxe7o=;
        b=muXbuEumMjqSPN0DsBxWIgyPyeYqYLUNFHTUxJA6d312HRwosRc862tqYnWfwF3cjB
         AEETn86ze9jGh1f7pJgxkHiIUt2jvaZ4kMScWPPUJi8sXPkPvAHecGa0iB2vMXVhAbrR
         GSg2EKeAlFB8DSmJ2Lltqf4547hiz/WDCVLxYggfDvDFj39ybBWqIE7TyJM9CPGpAcFA
         yUVJCenBl09GaUsHbF0resZkYw4ikwDcwjlL8mhxVoWW6OoOYDVs1opSMEt/nx3K+4/g
         4vuMW//Elx6z0ppTaSQLepD1CrwDrzDHHXQjMadg7+PEtjx0Ibsk3ONBXsN11/QXvgyI
         zX0A==
X-Gm-Message-State: AOAM532PySLCYlxCg7qJGMAxDCLASD81DsZJZVaoDnIvVkpYFA+p+TgK
        ek62H06e9RgEgNATmtA4+L5xVvuBCh0=
X-Google-Smtp-Source: ABdhPJyyBJ+2aKf7L7qCpD4nBV87O+SyfBPVHNQWRqD+LpV1mjIHnuHbLuARv1sQiTmfBMcdKfoWmA==
X-Received: by 2002:a1c:750d:: with SMTP id o13mr9530812wmc.76.1616283781251;
        Sat, 20 Mar 2021 16:43:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e8sm12168075wme.14.2021.03.20.16.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 16:43:00 -0700 (PDT)
Message-Id: <pull.910.git.1616283780358.gitgitgadget@gmail.com>
From:   "Georgios Kontaxis via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 20 Mar 2021 23:42:59 +0000
Subject: [PATCH] gitweb: redacted e-mail addresses feature.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Georgios Kontaxis <geko1702+commits@99rst.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Georgios Kontaxis <geko1702+commits@99rst.org>

Gitweb extracts content from the Git log and makes it accessible
over HTTP. As a result, e-mail addresses found in commits are
exposed to web crawlers. This may result in unsolicited messages.
This is a feature for redacting e-mail addresses from the generated
HTML content.

This feature does not prevent someone from downloading the
unredacted commit log and extracting information from it.
It aims to hinder the low-effort bulk collection of e-mail
addresses by web crawlers.

Signed-off-by: Georgios Kontaxis <geko1702+commits@99rst.org>
---
    gitweb: Redacted e-mail addresses feature.
    
    Gitweb extracts content from the Git log and makes it accessible over
    HTTP. As a result, e-mail addresses found in commits are exposed to web
    crawlers. This may result in unsolicited messages. This is a feature for
    redacting e-mail addresses from the generated HTML content.
    
    This feature does not prevent someone from downloading the unredacted
    commit log and extracting information from it. It aims to hinder the
    low-effort bulk collection of e-mail addresses by web crawlers.
    
    Signed-off-by: Georgios Kontaxis geko1702+commits@99rst.org

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-910%2Fkontaxis%2Fkontaxis%2Femail_privacy-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-910/kontaxis/kontaxis/email_privacy-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/910

 Documentation/gitweb.conf.txt | 12 ++++++++++++
 gitweb/gitweb.perl            | 36 ++++++++++++++++++++++++++++++++---
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
index 7963a79ba98b..10653d8670a8 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -896,6 +896,18 @@ same as of the snippet above:
 It is an error to specify a ref that does not pass "git check-ref-format"
 scrutiny. Duplicated values are filtered.
 
+email_privacy::
+    Redact e-mail addresses from the generated HTML, etc. content.
+    This hides e-mail addresses found in the commit log from web crawlers.
+    Enabled by default.
++
+It is highly recommended to keep this feature enabled unless web crawlers
+are hindered in some other way. You can disable this feature as shown below:
++
+---------------------------------------------------------------------------
+$feature{'email_privacy'}{'default'} = [0];
+---------------------------------------------------------------------------
+
 
 EXAMPLES
 --------
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0959a782eccb..9d21c2583e18 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -569,6 +569,15 @@ sub evaluate_uri {
 		'sub' => \&feature_extra_branch_refs,
 		'override' => 0,
 		'default' => []},
+
+    # Redact e-mail addresses.
+
+    # To disable system wide have in $GITWEB_CONFIG
+    # $feature{'email_privacy'}{'default'} = [0];
+	'email_privacy' => {
+		'sub' => sub { feature_bool('email_privacy', @_) },
+		'override' => 0,
+		'default' => [1]},
 );
 
 sub gitweb_get_feature {
@@ -3471,6 +3480,10 @@ sub parse_tag {
 			if ($tag{'author'} =~ m/^([^<]+) <([^>]*)>/) {
 				$tag{'author_name'}  = $1;
 				$tag{'author_email'} = $2;
+				if (gitweb_check_feature('email_privacy')) {
+					$tag{'author_email'} = "private";
+					$tag{'author'} =~ s/<([^>]+)>/<private>/;
+				}
 			} else {
 				$tag{'author_name'} = $tag{'author'};
 			}
@@ -3519,6 +3532,10 @@ sub parse_commit_text {
 			if ($co{'author'} =~ m/^([^<]+) <([^>]*)>/) {
 				$co{'author_name'}  = $1;
 				$co{'author_email'} = $2;
+				if (gitweb_check_feature('email_privacy')) {
+					$co{'author_email'} = "private";
+					$co{'author'} =~ s/<([^>]+)>/<private>/;
+				}
 			} else {
 				$co{'author_name'} = $co{'author'};
 			}
@@ -3529,6 +3546,10 @@ sub parse_commit_text {
 			if ($co{'committer'} =~ m/^([^<]+) <([^>]*)>/) {
 				$co{'committer_name'}  = $1;
 				$co{'committer_email'} = $2;
+				if (gitweb_check_feature('email_privacy')) {
+					$co{'committer_email'} = "private";
+					$co{'committer'} =~ s/<([^>]+)>/<private>/;
+				}
 			} else {
 				$co{'committer_name'} = $co{'committer'};
 			}
@@ -3568,9 +3589,13 @@ sub parse_commit_text {
 	if (! defined $co{'title'} || $co{'title'} eq "") {
 		$co{'title'} = $co{'title_short'} = '(no commit message)';
 	}
-	# remove added spaces
+	# remove added spaces, redact e-mail addresses if applicable.
 	foreach my $line (@commit_lines) {
 		$line =~ s/^    //;
+		if (gitweb_check_feature('email_privacy') &&
+			$line =~ m/^([^<]+) <([^>]*)>/) {
+			$line =~ s/<([^>]+)>/<private>/;
+		}
 	}
 	$co{'comment'} = \@commit_lines;
 
@@ -8060,8 +8085,13 @@ sub git_commitdiff {
 		close $fd
 			or print "Reading git-diff-tree failed\n";
 	} elsif ($format eq 'patch') {
-		local $/ = undef;
-		print <$fd>;
+		while (my $line = <$fd>) {
+			if (gitweb_check_feature('email_privacy') &&
+				$line =~ m/^([^<]+) <([^>]*)>/) {
+				$line =~ s/<([^>]+)>/<private>/;
+			}
+			print $line;
+		}
 		close $fd
 			or print "Reading git-format-patch failed\n";
 	}

base-commit: a5828ae6b52137b913b978e16cd2334482eb4c1f
-- 
gitgitgadget
