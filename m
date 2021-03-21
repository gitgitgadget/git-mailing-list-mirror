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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D90FC433DB
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 17:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D43F561931
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 17:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhCUR24 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 13:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhCUR2y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 13:28:54 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70B0C061574
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 10:28:53 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id a132-20020a1c668a0000b029010f141fe7c2so7859859wmc.0
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 10:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QETDm2LiVi5cX7snpJApqbSwfAPm1WMYJMnQ+qocE0Q=;
        b=etKIrqm098lZFHj1SxVsqmVbDTd+1D8th8MH5FZZA6WfHA/fx7vcClZR4SQ4KVmsaU
         n6bLTSRPigJfpGo/D1uxBPLgnorIA4okvcmwFbwIOMoiIqOQcgutdKWzb07z4N+gkgU2
         MNngBa/l6oVpQyz079zBR0RSiN5IGEC788vyw4qUpc8POCCXEJcwSMV0uJdi8rtyj7bj
         eKYJORrZ7Sp0rglYetwKqjyn4mtC3npKok+HUdlItaWWobOnzKNasq8m0NZmAGp3yd9I
         eIFvVlCJnsM6p5yTxgCICVsdjggH0tCRpWx/8f8W9BB6XgQZCcn6cig7DSqWuNVfxhUk
         hKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QETDm2LiVi5cX7snpJApqbSwfAPm1WMYJMnQ+qocE0Q=;
        b=jzQNkZHPFNXrCbniL0884owiAGyEvGkwlStvDNEANFVEymNvSApUUDbULLJdCPmyfd
         UDRyLVP7rgstGuAQ6UATgTeCAU8Z1ecRfiQ5x+98GYROMAKOsHm/hvnSCssCT1BLo5pE
         buW3J5Gg6S93QtYYDsqOcC/DsOMY8uYpBh+bHfpYvqqgVkkGn1RILCmRrot2S1+mJvuH
         GgWW8iV+o1D1rULFJR543VlkmRyhCDkq5S8YSV/g0QmeMAZ1QwzdUV5AqpNhryghHCH/
         j/WAI3HcYIwwz34wRGCUM0q7YJG5q4zkKveCxb8rWkFVJbYEWiUqH6Q9+OfvE7fw1T1+
         UQ6Q==
X-Gm-Message-State: AOAM530NnKb5aUZ2AoXPB4Cicro7lc7r3J9NiIzPIXd8ByCRjBT98boI
        Ap7dnQsyAjQ8G1xesE8j9V1zrJpN4mU=
X-Google-Smtp-Source: ABdhPJyuWGrRp7vU2poV0q0KnQixBmsa//9ClJtgHTn1nMQ7Bf7Md2tEs+kYgoripTYY00me47GDZw==
X-Received: by 2002:a05:600c:1405:: with SMTP id g5mr12291632wmi.140.1616347732381;
        Sun, 21 Mar 2021 10:28:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j20sm13495524wmp.30.2021.03.21.10.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 10:28:52 -0700 (PDT)
Message-Id: <pull.910.v3.git.1616347731514.gitgitgadget@gmail.com>
In-Reply-To: <pull.910.v2.git.1616297564158.gitgitgadget@gmail.com>
References: <pull.910.v2.git.1616297564158.gitgitgadget@gmail.com>
From:   "Georgios Kontaxis via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 21 Mar 2021 17:28:50 +0000
Subject: [PATCH v3] gitweb: redacted e-mail addresses feature.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Georgios Kontaxis <geko1702+commits@99rst.org>,
        Georgios Kontaxis <geko1702+commits@99rst.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Georgios Kontaxis <geko1702+commits@99rst.org>

Gitweb extracts content from the Git log and makes it accessible
over HTTP. As a result, e-mail addresses found in commits are
exposed to web crawlers and they may not respect robots.txt.
This may result in unsolicited messages.
This is a feature for redacting e-mail addresses
from the generated HTML, etc. content.

This feature does not prevent someone from downloading the
unredacted commit log, e.g., by cloning the repository, and
extracting information from it.
It aims to hinder the low-effort bulk collection of e-mail
addresses by web crawlers.

Changes since v1:
- Turned off the feature by default.
- Removed duplicate code.
- Added note about Gitweb consumers receiving redacted logs.

Changes since v2:
- The feature can be set on a per-project basis. ('override' => 1)

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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-910%2Fkontaxis%2Fkontaxis%2Femail_privacy-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-910/kontaxis/kontaxis/email_privacy-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/910

Range-diff vs v2:

 1:  74af11ca8bf2 ! 1:  930cdefe7ee0 gitweb: redacted e-mail addresses feature.
     @@ Commit message
          - Removed duplicate code.
          - Added note about Gitweb consumers receiving redacted logs.
      
     +    Changes since v2:
     +    - The feature can be set on a per-project basis. ('override' => 1)
     +
          Signed-off-by: Georgios Kontaxis <geko1702+commits@99rst.org>
      
       ## Documentation/gitweb.conf.txt ##
     @@ gitweb/gitweb.perl: sub evaluate_uri {
      +	# $feature{'email_privacy'}{'default'} = [1];
      +	'email_privacy' => {
      +		'sub' => sub { feature_bool('email_privacy', @_) },
     -+		'override' => 0,
     ++		'override' => 1,
      +		'default' => [0]},
       );
       


 Documentation/gitweb.conf.txt | 16 +++++++++++++
 gitweb/gitweb.perl            | 42 ++++++++++++++++++++++++++++++++---
 2 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
index 7963a79ba98b..b7af3240177d 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -896,6 +896,22 @@ same as of the snippet above:
 It is an error to specify a ref that does not pass "git check-ref-format"
 scrutiny. Duplicated values are filtered.
 
+email_privacy::
+    Redact e-mail addresses from the generated HTML, etc. content.
+    This hides e-mail addresses found in the commit log from web crawlers.
+    Disabled by default.
++
+It is highly recommended to enable this feature unless web crawlers are
+hindered in some other way. Note that crawlers intent on harvesting e-mail
+addresses may disregard robots.txt. You can enable this feature like so:
++
+---------------------------------------------------------------------------
+$feature{'email_privacy'}{'default'} = [1];
+---------------------------------------------------------------------------
++
+Note that if Gitweb is not the final step in a workflow then subsequent
+steps may misbehave because of the redacted information they receive.
+
 
 EXAMPLES
 --------
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0959a782eccb..174cc566d97d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -569,6 +569,15 @@ sub evaluate_uri {
 		'sub' => \&feature_extra_branch_refs,
 		'override' => 0,
 		'default' => []},
+
+	# Redact e-mail addresses.
+
+	# To enable system wide have in $GITWEB_CONFIG
+	# $feature{'email_privacy'}{'default'} = [1];
+	'email_privacy' => {
+		'sub' => sub { feature_bool('email_privacy', @_) },
+		'override' => 1,
+		'default' => [0]},
 );
 
 sub gitweb_get_feature {
@@ -3449,6 +3458,19 @@ sub parse_date {
 	return %date;
 }
 
+sub hide_mailaddr_if_private {
+	my $line = shift;
+	return $line unless (gitweb_check_feature('email_privacy') &&
+						$line =~ m/^([^<]+) <([^>]*)>/);
+	return hide_mailaddr($line)
+}
+
+sub hide_mailaddr {
+	my $mailaddr = shift;
+	$mailaddr =~ s/<([^>]*)>/<private>/;
+	return $mailaddr;
+}
+
 sub parse_tag {
 	my $tag_id = shift;
 	my %tag;
@@ -3471,6 +3493,10 @@ sub parse_tag {
 			if ($tag{'author'} =~ m/^([^<]+) <([^>]*)>/) {
 				$tag{'author_name'}  = $1;
 				$tag{'author_email'} = $2;
+				if (gitweb_check_feature('email_privacy')) {
+					$tag{'author_email'} = "private";
+					$tag{'author'} = hide_mailaddr($tag{'author'});
+				}
 			} else {
 				$tag{'author_name'} = $tag{'author'};
 			}
@@ -3519,6 +3545,10 @@ sub parse_commit_text {
 			if ($co{'author'} =~ m/^([^<]+) <([^>]*)>/) {
 				$co{'author_name'}  = $1;
 				$co{'author_email'} = $2;
+				if (gitweb_check_feature('email_privacy')) {
+					$co{'author_email'} = "private";
+					$co{'author'} = hide_mailaddr($co{'author'});
+				}
 			} else {
 				$co{'author_name'} = $co{'author'};
 			}
@@ -3529,6 +3559,10 @@ sub parse_commit_text {
 			if ($co{'committer'} =~ m/^([^<]+) <([^>]*)>/) {
 				$co{'committer_name'}  = $1;
 				$co{'committer_email'} = $2;
+				if (gitweb_check_feature('email_privacy')) {
+					$co{'committer_email'} = "private";
+					$co{'committer'} = hide_mailaddr($co{'committer'});
+				}
 			} else {
 				$co{'committer_name'} = $co{'committer'};
 			}
@@ -3568,9 +3602,10 @@ sub parse_commit_text {
 	if (! defined $co{'title'} || $co{'title'} eq "") {
 		$co{'title'} = $co{'title_short'} = '(no commit message)';
 	}
-	# remove added spaces
+	# remove added spaces, redact e-mail addresses if applicable.
 	foreach my $line (@commit_lines) {
 		$line =~ s/^    //;
+		$line = hide_mailaddr_if_private($line);
 	}
 	$co{'comment'} = \@commit_lines;
 
@@ -8060,8 +8095,9 @@ sub git_commitdiff {
 		close $fd
 			or print "Reading git-diff-tree failed\n";
 	} elsif ($format eq 'patch') {
-		local $/ = undef;
-		print <$fd>;
+		while (my $line = <$fd>) {
+			print hide_mailaddr_if_private($line);
+		}
 		close $fd
 			or print "Reading git-format-patch failed\n";
 	}

base-commit: a5828ae6b52137b913b978e16cd2334482eb4c1f
-- 
gitgitgadget
