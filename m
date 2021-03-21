Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,RDNS_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (unknown [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8ABC433E1
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 03:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E4B660249
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 03:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhCUDcw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 23:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhCUDcr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 23:32:47 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865E2C061574
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 20:32:46 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j18so13077115wra.2
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 20:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RtcG77d5OJtx3HZM4AEIcV1D7DH/KyqaDMUgBM0BdMQ=;
        b=NA+aC/infb2aTT9jvujfQBNcsrqRfjgoJyC+6Zpr26+MaNEVkbOJG8Qbmcpv4RLyoc
         iLOTSRyktNG8a1uSPEjp/uwcZnF7T0fLq2VlQ7E7zOw7p6ovbx65s22AuNxHcuvbrOox
         wu1Esbgzr6qEYsqSTgUgsPMpaDiz1Z2MmN8ixbvoEk6sRCdYD1CM17Yf1js4drkq4uAT
         lvl76PzQ9y/+b5EhGN/XFHUq3fqYyWCJvXizZShRUMn9UCNGADGyh9S7ZZSyKzZ6oXSv
         l8IlGOuncHXjuvaP7BL8ep3REXHih/j5k2Sf4K/Wg2OmGUyj6+lajF2OA/oTkJUnLvEt
         Vd9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RtcG77d5OJtx3HZM4AEIcV1D7DH/KyqaDMUgBM0BdMQ=;
        b=FCtfGREAK5PAOiomWHoyKaaISxFWq2pf39CYUkFgOyTmRAwUtgYExroIIDYjGZahSV
         kwQ2Kq7LorJ5fd7Rnuwz0VdG/68Q/K3w+RT5vxa55SXY9UObL7CrMNDK62Z3KAAHJnoZ
         /06H2SM871q7cIMm3KwJJZXN48a+nWeAYPwkA3Ts2n0LvDRT2zQ0QSo3jcY+TzyujtR+
         vdJjZxDcPTM9PkHs21I/r0oE6m9MBl7SAOpT7dAsmXoIsHvQubNR1VDY56SeCbPwgO2B
         HKD/SBnE0SsshAli7IFsth9PdLA0njdj6YzufDnNlZqa7N0X1TcqHgeOOwwC9dlZZ2el
         2pAg==
X-Gm-Message-State: AOAM5301DMGBsycwOOj2Vgia5vYXR1R4Mg7d91i6jzTQhK8J0S+T65a5
        jfzwOTpjVO3gowpxkKNAmqmke0LtFVk=
X-Google-Smtp-Source: ABdhPJy96mESy/s3xRsqIn8c8cmDhwGn/WU9x1qMBb4rwxFARUGQ91/JB5gsnBY+EjjTUiXd8WEw1g==
X-Received: by 2002:adf:d1c5:: with SMTP id b5mr11640485wrd.126.1616297565278;
        Sat, 20 Mar 2021 20:32:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a14sm16106023wrg.84.2021.03.20.20.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 20:32:44 -0700 (PDT)
Message-Id: <pull.910.v2.git.1616297564158.gitgitgadget@gmail.com>
In-Reply-To: <pull.910.git.1616283780358.gitgitgadget@gmail.com>
References: <pull.910.git.1616283780358.gitgitgadget@gmail.com>
From:   "Georgios Kontaxis via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 21 Mar 2021 03:32:43 +0000
Subject: [PATCH v2] gitweb: redacted e-mail addresses feature.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-910%2Fkontaxis%2Fkontaxis%2Femail_privacy-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-910/kontaxis/kontaxis/email_privacy-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/910

Range-diff vs v1:

 1:  6fe6ebdb8e59 ! 1:  74af11ca8bf2 gitweb: redacted e-mail addresses feature.
     @@ Commit message
      
          Gitweb extracts content from the Git log and makes it accessible
          over HTTP. As a result, e-mail addresses found in commits are
     -    exposed to web crawlers. This may result in unsolicited messages.
     -    This is a feature for redacting e-mail addresses from the generated
     -    HTML content.
     +    exposed to web crawlers and they may not respect robots.txt.
     +    This may result in unsolicited messages.
     +    This is a feature for redacting e-mail addresses
     +    from the generated HTML, etc. content.
      
          This feature does not prevent someone from downloading the
     -    unredacted commit log and extracting information from it.
     +    unredacted commit log, e.g., by cloning the repository, and
     +    extracting information from it.
          It aims to hinder the low-effort bulk collection of e-mail
          addresses by web crawlers.
      
     +    Changes since v1:
     +    - Turned off the feature by default.
     +    - Removed duplicate code.
     +    - Added note about Gitweb consumers receiving redacted logs.
     +
          Signed-off-by: Georgios Kontaxis <geko1702+commits@99rst.org>
      
       ## Documentation/gitweb.conf.txt ##
     @@ Documentation/gitweb.conf.txt: same as of the snippet above:
      +email_privacy::
      +    Redact e-mail addresses from the generated HTML, etc. content.
      +    This hides e-mail addresses found in the commit log from web crawlers.
     -+    Enabled by default.
     ++    Disabled by default.
      ++
     -+It is highly recommended to keep this feature enabled unless web crawlers
     -+are hindered in some other way. You can disable this feature as shown below:
     ++It is highly recommended to enable this feature unless web crawlers are
     ++hindered in some other way. Note that crawlers intent on harvesting e-mail
     ++addresses may disregard robots.txt. You can enable this feature like so:
      ++
      +---------------------------------------------------------------------------
     -+$feature{'email_privacy'}{'default'} = [0];
     ++$feature{'email_privacy'}{'default'} = [1];
      +---------------------------------------------------------------------------
     +++
     ++Note that if Gitweb is not the final step in a workflow then subsequent
     ++steps may misbehave because of the redacted information they receive.
      +
       
       EXAMPLES
     @@ gitweb/gitweb.perl: sub evaluate_uri {
       		'override' => 0,
       		'default' => []},
      +
     -+    # Redact e-mail addresses.
     ++	# Redact e-mail addresses.
      +
     -+    # To disable system wide have in $GITWEB_CONFIG
     -+    # $feature{'email_privacy'}{'default'} = [0];
     ++	# To enable system wide have in $GITWEB_CONFIG
     ++	# $feature{'email_privacy'}{'default'} = [1];
      +	'email_privacy' => {
      +		'sub' => sub { feature_bool('email_privacy', @_) },
      +		'override' => 0,
     -+		'default' => [1]},
     ++		'default' => [0]},
       );
       
       sub gitweb_get_feature {
     +@@ gitweb/gitweb.perl: sub parse_date {
     + 	return %date;
     + }
     + 
     ++sub hide_mailaddr_if_private {
     ++	my $line = shift;
     ++	return $line unless (gitweb_check_feature('email_privacy') &&
     ++						$line =~ m/^([^<]+) <([^>]*)>/);
     ++	return hide_mailaddr($line)
     ++}
     ++
     ++sub hide_mailaddr {
     ++	my $mailaddr = shift;
     ++	$mailaddr =~ s/<([^>]*)>/<private>/;
     ++	return $mailaddr;
     ++}
     ++
     + sub parse_tag {
     + 	my $tag_id = shift;
     + 	my %tag;
      @@ gitweb/gitweb.perl: sub parse_tag {
       			if ($tag{'author'} =~ m/^([^<]+) <([^>]*)>/) {
       				$tag{'author_name'}  = $1;
       				$tag{'author_email'} = $2;
      +				if (gitweb_check_feature('email_privacy')) {
      +					$tag{'author_email'} = "private";
     -+					$tag{'author'} =~ s/<([^>]+)>/<private>/;
     ++					$tag{'author'} = hide_mailaddr($tag{'author'});
      +				}
       			} else {
       				$tag{'author_name'} = $tag{'author'};
     @@ gitweb/gitweb.perl: sub parse_commit_text {
       				$co{'author_email'} = $2;
      +				if (gitweb_check_feature('email_privacy')) {
      +					$co{'author_email'} = "private";
     -+					$co{'author'} =~ s/<([^>]+)>/<private>/;
     ++					$co{'author'} = hide_mailaddr($co{'author'});
      +				}
       			} else {
       				$co{'author_name'} = $co{'author'};
     @@ gitweb/gitweb.perl: sub parse_commit_text {
       				$co{'committer_email'} = $2;
      +				if (gitweb_check_feature('email_privacy')) {
      +					$co{'committer_email'} = "private";
     -+					$co{'committer'} =~ s/<([^>]+)>/<private>/;
     ++					$co{'committer'} = hide_mailaddr($co{'committer'});
      +				}
       			} else {
       				$co{'committer_name'} = $co{'committer'};
     @@ gitweb/gitweb.perl: sub parse_commit_text {
      +	# remove added spaces, redact e-mail addresses if applicable.
       	foreach my $line (@commit_lines) {
       		$line =~ s/^    //;
     -+		if (gitweb_check_feature('email_privacy') &&
     -+			$line =~ m/^([^<]+) <([^>]*)>/) {
     -+			$line =~ s/<([^>]+)>/<private>/;
     -+		}
     ++		$line = hide_mailaddr_if_private($line);
       	}
       	$co{'comment'} = \@commit_lines;
       
     @@ gitweb/gitweb.perl: sub git_commitdiff {
      -		local $/ = undef;
      -		print <$fd>;
      +		while (my $line = <$fd>) {
     -+			if (gitweb_check_feature('email_privacy') &&
     -+				$line =~ m/^([^<]+) <([^>]*)>/) {
     -+				$line =~ s/<([^>]+)>/<private>/;
     -+			}
     -+			print $line;
     ++			print hide_mailaddr_if_private($line);
      +		}
       		close $fd
       			or print "Reading git-format-patch failed\n";


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
index 0959a782eccb..210228f32efd 100755
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
+		'override' => 0,
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
