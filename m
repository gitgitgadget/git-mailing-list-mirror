Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4710BC433DB
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 23:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1331361934
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 23:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbhC1X0g (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 19:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhC1X0H (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 19:26:07 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA16C061756
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 16:26:06 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so5744336wmi.3
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 16:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zLc7xaqmmmMfbq9SRjl/DB2cFjEkz6lAjtwlF7zwAvE=;
        b=eg4TnjhNdv2tSWEf8o34pimfAhQeJ7wmwmq68sOhV8YjRWvyNiENjqdx14WDBmB1E5
         sEV+yY/MUejd3kw5fPnBDFtOWhLQQn+PNRyIqzZpLf0OjW8hqfeEHvCORYYlGNTW7PmP
         xWeHSJXM77yZFuw20iK2fVSIFjBGcppbHQRsonFkc32McbEaefSSNXQtp0wU6Dv2HmWJ
         jzZcyhQKfqZFxTgtEQIlg+7b31AqUxCryzrNMoHV8ORNzE4I1rvPUQTxB+7OEuMEvyzj
         Y5yph0g9vgQXHVTf0t6nLIF9eYkabVEhOtwAMhNVa1msw8KDQIUNb8VCfHubFTMIw1Iy
         qyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zLc7xaqmmmMfbq9SRjl/DB2cFjEkz6lAjtwlF7zwAvE=;
        b=LyCLqvKUUEHw/7sNu1vARzo1l7O4eFu/qBg0imBhUQG0eEek/b8BOJtf9xwE7dDKxa
         32TInq17K1nSUxzMKkEhybUi2dISGYLsDbsap0G641W5NJlTh8V0XX/fOVh+Mm0flwSw
         mzbkYrj3i4w8u8bC+nwRxbYHHFqIVuMfazzQj0uKa7MsXPYwa2ibqUMHL8mAD6Pd1zaf
         QId6K1xo7D/OmRhJEYaxuwOVDxDP7YwbpoQc1f5k1Uf5789A3ptxyLlVVKMv6w446Hi6
         9lvCi2MA31VXPfyj1WB/T/fjmpFg90h47SfMZTZFLe7cEKexqudXMAZsB7BIlCdUza0J
         4MKg==
X-Gm-Message-State: AOAM533ZoPb34erNAb+3q+/PaMu6v5029v9tYrExqaB+OBuQPk4e7FPt
        Z1Nf5diFFPR9CEoTZjiDbTGBJ9IZbCA=
X-Google-Smtp-Source: ABdhPJzGjT08hlVDC6TiDsrdjcPlpCr+f3Qj/Vw8FcdzdLCNMqU/LBRaffOZW2ZM3cgrL0JutB2qKg==
X-Received: by 2002:a7b:cb05:: with SMTP id u5mr13686516wmj.21.1616973965042;
        Sun, 28 Mar 2021 16:26:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a14sm28530727wrg.84.2021.03.28.16.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 16:26:04 -0700 (PDT)
Message-Id: <pull.910.v6.git.1616973963862.gitgitgadget@gmail.com>
In-Reply-To: <pull.910.v5.git.1616817387441.gitgitgadget@gmail.com>
References: <pull.910.v5.git.1616817387441.gitgitgadget@gmail.com>
From:   "Georgios Kontaxis via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 28 Mar 2021 23:26:03 +0000
Subject: [PATCH v6] gitweb: redacted e-mail addresses feature.
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
    
    Changes since v5:
    
     * A simple <local@domain> filter is used instead of Mail::Address to
       identify addresses.
    
    Signed-off-by: Georgios Kontaxis geko1702+commits@99rst.org

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-910%2Fkontaxis%2Fkontaxis%2Femail_privacy-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-910/kontaxis/kontaxis/email_privacy-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/910

Range-diff vs v5:

 1:  1427231f9db5 ! 1:  245cfed8ad58 gitweb: redacted e-mail addresses feature.
     @@ Documentation/gitweb.conf.txt: default font sizes or lineheights are changed (e.
       	`$highlight_bin` program to be available (see the description of
      
       ## gitweb/gitweb.perl ##
     -@@
     - use File::Basename qw(basename);
     - use Time::HiRes qw(gettimeofday tv_interval);
     - use Digest::MD5 qw(md5_hex);
     -+use Git::LoadCPAN::Mail::Address;
     - 
     - binmode STDOUT, ':utf8';
     - 
      @@ gitweb/gitweb.perl: sub evaluate_uri {
       		'sub' => \&feature_extra_branch_refs,
       		'override' => 0,
     @@ gitweb/gitweb.perl: sub parse_date {
       	return %date;
       }
       
     -+sub is_mailaddr {
     -+	my @addrs = Mail::Address->parse(shift);
     -+	if (!@addrs || !$addrs[0]->host || !$addrs[0]->user) {
     -+		return 0;
     -+	}
     -+	return 1;
     -+}
     -+
      +sub hide_mailaddrs_if_private {
      +	my $line = shift;
      +	return $line unless gitweb_check_feature('email-privacy');
     -+	while ($line =~ m/(<[^>]+>)/g) {
     -+		my $match = $1;
     -+		if (!is_mailaddr($match)) {
     -+			next;
     -+		}
     -+		my $match_offset = pos($line) - length($match);
     -+		pos $line = $match_offset;
     -+
     -+		my $redaction = "<redacted>";
     -+		$line =~ s/\G(<[^>]+>)/$redaction/;
     -+
     -+		pos $line = $match_offset + length($redaction);
     -+	}
     ++	$line =~ s/<[^@>]+@[^>]+>/<redacted>/ig;
      +	return $line;
      +}
      +
     @@ gitweb/gitweb.perl: sub git_commitdiff {
       			$formats_nav .= " | " .
       				$cgi->a({-href => href(action=>"patch", -replay=>1)},
       					"patch");
     -
     - ## t/lib-gitweb.sh ##
     -@@ t/lib-gitweb.sh: gitweb_run () {
     - 	GITWEB_CONFIG=$(pwd)/gitweb_config.perl
     - 	export GITWEB_CONFIG
     - 
     -+	PERL5LIB="$GIT_BUILD_DIR/perl:$GIT_BUILD_DIR/perl/FromCPAN"
     -+	export PERL5LIB
     -+
     - 	# some of git commands write to STDERR on error, but this is not
     - 	# written to web server logs, so we are not interested in that:
     - 	# we are interested only in properly formatted errors/warnings


 Documentation/gitweb.conf.txt | 11 +++++++++++
 gitweb/gitweb.perl            | 34 +++++++++++++++++++++++++++-------
 2 files changed, 38 insertions(+), 7 deletions(-)

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
index 0959a782eccb..01c6faf88006 100755
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
+	# $feature{'email-privacy'}{'default'} = [1];
+	'email-privacy' => {
+		'sub' => sub { feature_bool('email-privacy', @_) },
+		'override' => 1,
+		'default' => [0]},
 );
 
 sub gitweb_get_feature {
@@ -3449,6 +3458,13 @@ sub parse_date {
 	return %date;
 }
 
+sub hide_mailaddrs_if_private {
+	my $line = shift;
+	return $line unless gitweb_check_feature('email-privacy');
+	$line =~ s/<[^@>]+@[^>]+>/<redacted>/ig;
+	return $line;
+}
+
 sub parse_tag {
 	my $tag_id = shift;
 	my %tag;
@@ -3465,7 +3481,7 @@ sub parse_tag {
 		} elsif ($line =~ m/^tag (.+)$/) {
 			$tag{'name'} = $1;
 		} elsif ($line =~ m/^tagger (.*) ([0-9]+) (.*)$/) {
-			$tag{'author'} = $1;
+			$tag{'author'} = hide_mailaddrs_if_private($1);
 			$tag{'author_epoch'} = $2;
 			$tag{'author_tz'} = $3;
 			if ($tag{'author'} =~ m/^([^<]+) <([^>]*)>/) {
@@ -3513,7 +3529,7 @@ sub parse_commit_text {
 		} elsif ((!defined $withparents) && ($line =~ m/^parent ($oid_regex)$/)) {
 			push @parents, $1;
 		} elsif ($line =~ m/^author (.*) ([0-9]+) (.*)$/) {
-			$co{'author'} = to_utf8($1);
+			$co{'author'} = hide_mailaddrs_if_private(to_utf8($1));
 			$co{'author_epoch'} = $2;
 			$co{'author_tz'} = $3;
 			if ($co{'author'} =~ m/^([^<]+) <([^>]*)>/) {
@@ -3523,7 +3539,7 @@ sub parse_commit_text {
 				$co{'author_name'} = $co{'author'};
 			}
 		} elsif ($line =~ m/^committer (.*) ([0-9]+) (.*)$/) {
-			$co{'committer'} = to_utf8($1);
+			$co{'committer'} = hide_mailaddrs_if_private(to_utf8($1));
 			$co{'committer_epoch'} = $2;
 			$co{'committer_tz'} = $3;
 			if ($co{'committer'} =~ m/^([^<]+) <([^>]*)>/) {
@@ -3568,9 +3584,10 @@ sub parse_commit_text {
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
 
@@ -7489,7 +7506,8 @@ sub git_log_generic {
 			         -accesskey => "n", -title => "Alt-n"}, "next");
 	}
 	my $patch_max = gitweb_get_feature('patches');
-	if ($patch_max && !defined $file_name) {
+	if ($patch_max && !defined $file_name &&
+		!gitweb_check_feature('email-privacy')) {
 		if ($patch_max < 0 || @commitlist <= $patch_max) {
 			$paging_nav .= " &sdot; " .
 				$cgi->a({-href => href(action=>"patches", -replay=>1)},
@@ -7550,7 +7568,8 @@ sub git_commit {
 			} @$parents ) .
 			')';
 	}
-	if (gitweb_check_feature('patches') && @$parents <= 1) {
+	if (gitweb_check_feature('patches') && @$parents <= 1 &&
+		!gitweb_check_feature('email-privacy')) {
 		$formats_nav .= " | " .
 			$cgi->a({-href => href(action=>"patch", -replay=>1)},
 				"patch");
@@ -7863,7 +7882,8 @@ sub git_commitdiff {
 		$formats_nav =
 			$cgi->a({-href => href(action=>"commitdiff_plain", -replay=>1)},
 			        "raw");
-		if ($patch_max && @{$co{'parents'}} <= 1) {
+		if ($patch_max && @{$co{'parents'}} <= 1 &&
+			!gitweb_check_feature('email-privacy')) {
 			$formats_nav .= " | " .
 				$cgi->a({-href => href(action=>"patch", -replay=>1)},
 					"patch");

base-commit: a5828ae6b52137b913b978e16cd2334482eb4c1f
-- 
gitgitgadget
