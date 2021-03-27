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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E255C433C1
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 03:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 660A661A18
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 03:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhC0D4m (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 23:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhC0D4b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 23:56:31 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8F0C0613AA
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 20:56:30 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso3975084wmi.0
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 20:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+hJnX/uCEvVahpyK9RNm4lW8kHb5XB9qnCbFbi1wqo0=;
        b=BEkzPS130nIN1KkM9rLCJIRWAC6sDwcW95ARZkAwqv78Poohrm8tr6t61DtPVDpGyA
         uutcdmYS1E25PNK30tC7mfD3FNiCJGSpX8GbkqClecvyTTMuwYufWwhDqMwGNPxoysBQ
         i9N7N++LY3fvrwlK6TdRFfti0lm/m7LQLG5zrcjZqdTo72mBZYpbFvQQhBh770ggsp2m
         UfNJNv+9nDmBVnxGE9eqB63CjARQPJ3drFiJ1jTM5Wa9uWWlspCaC0FPXcTId04t/WwZ
         KM0iplvEbicOI8fbwm2oJAptw1X55kCWaF0jTvTtClrynCx4lUALlRmYCAKV5V/Q3/Bn
         IuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+hJnX/uCEvVahpyK9RNm4lW8kHb5XB9qnCbFbi1wqo0=;
        b=ZUuZWEOtTOs+40NUYck+61+NwOxz1yd1ezUPbR+VeW++7VTQzCJkArjL+4HZRov3tw
         WnbJaEgdHRDNokGZEnWIjUe2iJdNs9BHcas5jrvx87tBR7hAOZURyzSHqG8JoYBxc8aV
         nUr9bZIvz682N/oVrS6AJSeuH1ggdx5NzBLcc7h8ihKO2Y4mU0yaURBtSMQX7Cq2VLL7
         MkWUyo/wb8MGIuYipOkwzftTIKs7Uty7cpDiRrxYDp3hPIIeYXdLnVZg0e3y9AY7F5vo
         zLjij7FY2twD/kOfkXXOGNAUx6UmxTPKI2Y2Fpr1qgtREDdLNtjTWmJZ37Sc104k3uu5
         5Chw==
X-Gm-Message-State: AOAM530Y2ZT1az7yz8N9BNuXfCUfWoGpqfynUDeG+z2OosCKhJH2O+Ym
        s5GPcuruXbtQRVnZXJCaIIJbWSep3qM=
X-Google-Smtp-Source: ABdhPJxhEvPae+u5o2h/+2kNQ/c0yaBYLppXotGKu2pk0VwPGdjgmfocEPjTmlTKxEYe8U1Dn/ThvA==
X-Received: by 2002:a7b:c047:: with SMTP id u7mr15687341wmc.98.1616817388860;
        Fri, 26 Mar 2021 20:56:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c2sm14513982wmr.22.2021.03.26.20.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 20:56:28 -0700 (PDT)
Message-Id: <pull.910.v5.git.1616817387441.gitgitgadget@gmail.com>
In-Reply-To: <pull.910.v4.git.1616396267010.gitgitgadget@gmail.com>
References: <pull.910.v4.git.1616396267010.gitgitgadget@gmail.com>
From:   "Georgios Kontaxis via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 27 Mar 2021 03:56:26 +0000
Subject: [PATCH v5] gitweb: redacted e-mail addresses feature.
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
This can result in unsolicited messages.

Introduce an 'email-privacy' feature which redacts e-mail addresses
from the generated HTML content. Specifically, obscure addresses
retrieved from the the author/committer and comment sections of the
Git log. The feature is off by default.

This feature does not prevent someone from downloading the
unredacted commit log, e.g., by cloning the repository, and
extracting information from it. It aims to hinder the low-
effort, bulk collection of e-mail addresses by web crawlers.

Signed-off-by: Georgios Kontaxis <geko1702+commits@99rst.org>
---
    gitweb: redacted e-mail addresses feature.
    
    Changes since v1:
    
     * Turned off the feature by default.
     * Removed duplicate code.
     * Added note about Gitweb consumers receiving redacted logs.
    
    Changes since v2:
    
     * The feature can be set on a per-project basis. ('override' => 1)
    
    Changes since v3:
    
     * Renamed feature to "email-privacy" and improved documentation.
     * Removed UI elements for git-format-patch since it won't be redacted.
     * Simplified calls to the address redaction logic.
     * Mail::Address is now used to reduce false-positive redactions.
    
    Changes since v4:
    
     * Rephrased the commit comment.
     * hide_mailaddrs_if_private is slighly more compact.
    
    Signed-off-by: Georgios Kontaxis geko1702+commits@99rst.org

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-910%2Fkontaxis%2Fkontaxis%2Femail_privacy-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-910/kontaxis/kontaxis/email_privacy-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/910

Range-diff vs v4:

 1:  03a3f41c37ef ! 1:  1427231f9db5 gitweb: redacted e-mail addresses feature.
     @@ Commit message
          Gitweb extracts content from the Git log and makes it accessible
          over HTTP. As a result, e-mail addresses found in commits are
          exposed to web crawlers and they may not respect robots.txt.
     -    This may result in unsolicited messages.
     -    This is a feature for redacting e-mail addresses
     -    from the generated HTML, etc. content.
     +    This can result in unsolicited messages.
     +
     +    Introduce an 'email-privacy' feature which redacts e-mail addresses
     +    from the generated HTML content. Specifically, obscure addresses
     +    retrieved from the the author/committer and comment sections of the
     +    Git log. The feature is off by default.
      
          This feature does not prevent someone from downloading the
          unredacted commit log, e.g., by cloning the repository, and
     -    extracting information from it.
     -    It aims to hinder the low-effort bulk collection of e-mail
     -    addresses by web crawlers.
     +    extracting information from it. It aims to hinder the low-
     +    effort, bulk collection of e-mail addresses by web crawlers.
      
          Signed-off-by: Georgios Kontaxis <geko1702+commits@99rst.org>
      
     @@ Documentation/gitweb.conf.txt: default font sizes or lineheights are changed (e.
       
      +email-privacy::
      +	Redact e-mail addresses from the generated HTML, etc. content.
     -+	This hides e-mail addresses found in the commit log from HTTP clients.
     ++	This obscures e-mail addresses retrieved from the author/committer
     ++	and comment sections of the Git log.
      +	It is meant to hinder web crawlers that harvest and abuse addresses.
      +	Such crawlers may not respect robots.txt.
     -+	Note that users and user tools also see the addresses redacted.
     ++	Note that users and user tools also see the addresses as redacted.
      +	If Gitweb is not the final step in a workflow then subsequent steps
      +	may misbehave because of the redacted information they receive.
      +	Disabled by default.
     @@ gitweb/gitweb.perl: sub parse_date {
      +		if (!is_mailaddr($match)) {
      +			next;
      +		}
     -+		my $offset = pos $line;
     -+		my $head = substr $line, 0, $offset - length($match);
     ++		my $match_offset = pos($line) - length($match);
     ++		pos $line = $match_offset;
     ++
      +		my $redaction = "<redacted>";
     -+		my $tail = substr $line, $offset;
     -+		$line = $head . $redaction . $tail;
     -+		pos $line = length($head) + length($redaction);
     ++		$line =~ s/\G(<[^>]+>)/$redaction/;
     ++
     ++		pos $line = $match_offset + length($redaction);
      +	}
      +	return $line;
      +}


 Documentation/gitweb.conf.txt | 11 +++++++
 gitweb/gitweb.perl            | 55 ++++++++++++++++++++++++++++++-----
 t/lib-gitweb.sh               |  3 ++
 3 files changed, 62 insertions(+), 7 deletions(-)

diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
index 7963a79ba98b..34b1d6e22435 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -751,6 +751,17 @@ default font sizes or lineheights are changed (e.g. via adding extra
 CSS stylesheet in `@stylesheets`), it may be appropriate to change
 these values.
 
+email-privacy::
+	Redact e-mail addresses from the generated HTML, etc. content.
+	This obscures e-mail addresses retrieved from the author/committer
+	and comment sections of the Git log.
+	It is meant to hinder web crawlers that harvest and abuse addresses.
+	Such crawlers may not respect robots.txt.
+	Note that users and user tools also see the addresses as redacted.
+	If Gitweb is not the final step in a workflow then subsequent steps
+	may misbehave because of the redacted information they receive.
+	Disabled by default.
+
 highlight::
 	Server-side syntax highlight support in "blob" view.  It requires
 	`$highlight_bin` program to be available (see the description of
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0959a782eccb..fe1dbc266ea7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -21,6 +21,7 @@
 use File::Basename qw(basename);
 use Time::HiRes qw(gettimeofday tv_interval);
 use Digest::MD5 qw(md5_hex);
+use Git::LoadCPAN::Mail::Address;
 
 binmode STDOUT, ':utf8';
 
@@ -569,6 +570,15 @@ sub evaluate_uri {
 		'sub' => \&feature_extra_branch_refs,
 		'override' => 0,
 		'default' => []},
+
+	# Redact e-mail addresses.
+
+	# To enable system wide have in $GITWEB_CONFIG
+	# $feature{'email-privacy'}{'default'} = [1];
+	'email-privacy' => {
+		'sub' => sub { feature_bool('email-privacy', @_) },
+		'override' => 1,
+		'default' => [0]},
 );
 
 sub gitweb_get_feature {
@@ -3449,6 +3459,33 @@ sub parse_date {
 	return %date;
 }
 
+sub is_mailaddr {
+	my @addrs = Mail::Address->parse(shift);
+	if (!@addrs || !$addrs[0]->host || !$addrs[0]->user) {
+		return 0;
+	}
+	return 1;
+}
+
+sub hide_mailaddrs_if_private {
+	my $line = shift;
+	return $line unless gitweb_check_feature('email-privacy');
+	while ($line =~ m/(<[^>]+>)/g) {
+		my $match = $1;
+		if (!is_mailaddr($match)) {
+			next;
+		}
+		my $match_offset = pos($line) - length($match);
+		pos $line = $match_offset;
+
+		my $redaction = "<redacted>";
+		$line =~ s/\G(<[^>]+>)/$redaction/;
+
+		pos $line = $match_offset + length($redaction);
+	}
+	return $line;
+}
+
 sub parse_tag {
 	my $tag_id = shift;
 	my %tag;
@@ -3465,7 +3502,7 @@ sub parse_tag {
 		} elsif ($line =~ m/^tag (.+)$/) {
 			$tag{'name'} = $1;
 		} elsif ($line =~ m/^tagger (.*) ([0-9]+) (.*)$/) {
-			$tag{'author'} = $1;
+			$tag{'author'} = hide_mailaddrs_if_private($1);
 			$tag{'author_epoch'} = $2;
 			$tag{'author_tz'} = $3;
 			if ($tag{'author'} =~ m/^([^<]+) <([^>]*)>/) {
@@ -3513,7 +3550,7 @@ sub parse_commit_text {
 		} elsif ((!defined $withparents) && ($line =~ m/^parent ($oid_regex)$/)) {
 			push @parents, $1;
 		} elsif ($line =~ m/^author (.*) ([0-9]+) (.*)$/) {
-			$co{'author'} = to_utf8($1);
+			$co{'author'} = hide_mailaddrs_if_private(to_utf8($1));
 			$co{'author_epoch'} = $2;
 			$co{'author_tz'} = $3;
 			if ($co{'author'} =~ m/^([^<]+) <([^>]*)>/) {
@@ -3523,7 +3560,7 @@ sub parse_commit_text {
 				$co{'author_name'} = $co{'author'};
 			}
 		} elsif ($line =~ m/^committer (.*) ([0-9]+) (.*)$/) {
-			$co{'committer'} = to_utf8($1);
+			$co{'committer'} = hide_mailaddrs_if_private(to_utf8($1));
 			$co{'committer_epoch'} = $2;
 			$co{'committer_tz'} = $3;
 			if ($co{'committer'} =~ m/^([^<]+) <([^>]*)>/) {
@@ -3568,9 +3605,10 @@ sub parse_commit_text {
 	if (! defined $co{'title'} || $co{'title'} eq "") {
 		$co{'title'} = $co{'title_short'} = '(no commit message)';
 	}
-	# remove added spaces
+	# remove added spaces, redact e-mail addresses if applicable.
 	foreach my $line (@commit_lines) {
 		$line =~ s/^    //;
+		$line = hide_mailaddrs_if_private($line);
 	}
 	$co{'comment'} = \@commit_lines;
 
@@ -7489,7 +7527,8 @@ sub git_log_generic {
 			         -accesskey => "n", -title => "Alt-n"}, "next");
 	}
 	my $patch_max = gitweb_get_feature('patches');
-	if ($patch_max && !defined $file_name) {
+	if ($patch_max && !defined $file_name &&
+		!gitweb_check_feature('email-privacy')) {
 		if ($patch_max < 0 || @commitlist <= $patch_max) {
 			$paging_nav .= " &sdot; " .
 				$cgi->a({-href => href(action=>"patches", -replay=>1)},
@@ -7550,7 +7589,8 @@ sub git_commit {
 			} @$parents ) .
 			')';
 	}
-	if (gitweb_check_feature('patches') && @$parents <= 1) {
+	if (gitweb_check_feature('patches') && @$parents <= 1 &&
+		!gitweb_check_feature('email-privacy')) {
 		$formats_nav .= " | " .
 			$cgi->a({-href => href(action=>"patch", -replay=>1)},
 				"patch");
@@ -7863,7 +7903,8 @@ sub git_commitdiff {
 		$formats_nav =
 			$cgi->a({-href => href(action=>"commitdiff_plain", -replay=>1)},
 			        "raw");
-		if ($patch_max && @{$co{'parents'}} <= 1) {
+		if ($patch_max && @{$co{'parents'}} <= 1 &&
+			!gitweb_check_feature('email-privacy')) {
 			$formats_nav .= " | " .
 				$cgi->a({-href => href(action=>"patch", -replay=>1)},
 					"patch");
diff --git a/t/lib-gitweb.sh b/t/lib-gitweb.sh
index 1f32ca66ea51..77fc1298d4c6 100644
--- a/t/lib-gitweb.sh
+++ b/t/lib-gitweb.sh
@@ -67,6 +67,9 @@ gitweb_run () {
 	GITWEB_CONFIG=$(pwd)/gitweb_config.perl
 	export GITWEB_CONFIG
 
+	PERL5LIB="$GIT_BUILD_DIR/perl:$GIT_BUILD_DIR/perl/FromCPAN"
+	export PERL5LIB
+
 	# some of git commands write to STDERR on error, but this is not
 	# written to web server logs, so we are not interested in that:
 	# we are interested only in properly formatted errors/warnings

base-commit: a5828ae6b52137b913b978e16cd2334482eb4c1f
-- 
gitgitgadget
