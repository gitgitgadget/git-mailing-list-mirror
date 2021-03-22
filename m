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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFC4C433DB
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 06:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AFE0601FE
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 06:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhCVG6O (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 02:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhCVG5u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 02:57:50 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72DFC061574
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 23:57:49 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso8628206wmi.0
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 23:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HVbzQuRgfUMYM+SqWL+pjXHTLF38ejNDEzZj2uM1ahI=;
        b=fwmD4xmQuporf7rI/5gxOIegf8SCBwfHoznAXGcuIFX6Vu3E3RBHZ8TpwbbrG6rlRS
         pVaLC9Cvb3AqzV8743sLT4vMgr5sb+f+/PwSvIow/nYek2XoKeaCHe87uqQzRTboWzlj
         QdUBownjpWZqtrktoHPM0UGybhinzuM1qJRmPRRIsnbJt+DwawN/yK1ux3IephakE5ah
         7ul0DFN8sSPV8hr68ipSSkT5LLa/eplKYRKH08D7gkuRdcguqkMmarHxk7cFAxEr2XmG
         XGJkWkBCXwYpCWlHyisNNxsNfgEkXfI1drpTdVBElF2B8mmWwUGlL+Ay8ONnIKI7W6kD
         KGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HVbzQuRgfUMYM+SqWL+pjXHTLF38ejNDEzZj2uM1ahI=;
        b=if7xxRIZ1QB//RdJcNqXDy3+n+Rjgq2nvRA4Q1pily3XfIKIUYSqVJUJ2ZTbF2Giz9
         6+aSXrl0PtRACEjtqb7bJ8iNQUbfJWptebjtAPL/yd3EVuLc11oMV+gi6QxnPpjf6mCF
         7Ogo2190i9fvfcYARFKjtx7aWUrsT9lHC3WGD7CcDI292UiQhIdBY7UWtf4DRjlUNLR/
         tiRb36erJiSjE58GlX0+TNzHRsQGSwWW5P0Fu1j4QEl0nySyDS0MU0/e3nJ+D7nlKjlR
         sMEHglU82i4V+Zx3BjJepZ38uIPD6KaReNpGQqUq9uHeFOvIWYQuzDBbUjNAFmErfZtO
         flIw==
X-Gm-Message-State: AOAM531r9ZXl3NJ5t3dbMUWpuJuXgnS7TREVhWaE5MFMSKVnD9WPqZwK
        exhxWeJpdJf1Xfy/Ouerx9OJRbeuFjg=
X-Google-Smtp-Source: ABdhPJwzCOtNIt7WbH8+cWxhRO0lbNbItuTXg/k9j4G2H3jJ5a+PGM9EVflgc/9zNDS1TLJGHUCqLg==
X-Received: by 2002:a1c:e084:: with SMTP id x126mr14450749wmg.37.1616396268359;
        Sun, 21 Mar 2021 23:57:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u8sm18433275wrr.42.2021.03.21.23.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 23:57:47 -0700 (PDT)
Message-Id: <pull.910.v4.git.1616396267010.gitgitgadget@gmail.com>
In-Reply-To: <pull.910.v3.git.1616347731514.gitgitgadget@gmail.com>
References: <pull.910.v3.git.1616347731514.gitgitgadget@gmail.com>
From:   "Georgios Kontaxis via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Mar 2021 06:57:46 +0000
Subject: [PATCH v4] gitweb: redacted e-mail addresses feature.
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

Signed-off-by: Georgios Kontaxis <geko1702+commits@99rst.org>
---
    gitweb: redacted e-mail addresses feature.
    
    Gitweb extracts content from the Git log and makes it accessible over
    HTTP. As a result, e-mail addresses found in commits are exposed to web
    crawlers and they may not respect robots.txt. This may result in
    unsolicited messages. This is a feature for redacting e-mail addresses
    from the generated HTML, etc. content.
    
    This feature does not prevent someone from downloading the unredacted
    commit log, e.g., by cloning the repository, and extracting information
    from it. It aims to hinder the low-effort bulk collection of e-mail
    addresses by web crawlers.
    
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
    
    Signed-off-by: Georgios Kontaxis geko1702+commits@99rst.org

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-910%2Fkontaxis%2Fkontaxis%2Femail_privacy-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-910/kontaxis/kontaxis/email_privacy-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/910

Range-diff vs v3:

 1:  930cdefe7ee0 ! 1:  03a3f41c37ef gitweb: redacted e-mail addresses feature.
     @@ Commit message
          It aims to hinder the low-effort bulk collection of e-mail
          addresses by web crawlers.
      
     -    Changes since v1:
     -    - Turned off the feature by default.
     -    - Removed duplicate code.
     -    - Added note about Gitweb consumers receiving redacted logs.
     -
     -    Changes since v2:
     -    - The feature can be set on a per-project basis. ('override' => 1)
     -
          Signed-off-by: Georgios Kontaxis <geko1702+commits@99rst.org>
      
       ## Documentation/gitweb.conf.txt ##
     -@@ Documentation/gitweb.conf.txt: same as of the snippet above:
     - It is an error to specify a ref that does not pass "git check-ref-format"
     - scrutiny. Duplicated values are filtered.
     +@@ Documentation/gitweb.conf.txt: default font sizes or lineheights are changed (e.g. via adding extra
     + CSS stylesheet in `@stylesheets`), it may be appropriate to change
     + these values.
       
     -+email_privacy::
     -+    Redact e-mail addresses from the generated HTML, etc. content.
     -+    This hides e-mail addresses found in the commit log from web crawlers.
     -+    Disabled by default.
     -++
     -+It is highly recommended to enable this feature unless web crawlers are
     -+hindered in some other way. Note that crawlers intent on harvesting e-mail
     -+addresses may disregard robots.txt. You can enable this feature like so:
     -++
     -+---------------------------------------------------------------------------
     -+$feature{'email_privacy'}{'default'} = [1];
     -+---------------------------------------------------------------------------
     -++
     -+Note that if Gitweb is not the final step in a workflow then subsequent
     -+steps may misbehave because of the redacted information they receive.
     ++email-privacy::
     ++	Redact e-mail addresses from the generated HTML, etc. content.
     ++	This hides e-mail addresses found in the commit log from HTTP clients.
     ++	It is meant to hinder web crawlers that harvest and abuse addresses.
     ++	Such crawlers may not respect robots.txt.
     ++	Note that users and user tools also see the addresses redacted.
     ++	If Gitweb is not the final step in a workflow then subsequent steps
     ++	may misbehave because of the redacted information they receive.
     ++	Disabled by default.
      +
     - 
     - EXAMPLES
     - --------
     + highlight::
     + 	Server-side syntax highlight support in "blob" view.  It requires
     + 	`$highlight_bin` program to be available (see the description of
      
       ## gitweb/gitweb.perl ##
     +@@
     + use File::Basename qw(basename);
     + use Time::HiRes qw(gettimeofday tv_interval);
     + use Digest::MD5 qw(md5_hex);
     ++use Git::LoadCPAN::Mail::Address;
     + 
     + binmode STDOUT, ':utf8';
     + 
      @@ gitweb/gitweb.perl: sub evaluate_uri {
       		'sub' => \&feature_extra_branch_refs,
       		'override' => 0,
     @@ gitweb/gitweb.perl: sub evaluate_uri {
      +	# Redact e-mail addresses.
      +
      +	# To enable system wide have in $GITWEB_CONFIG
     -+	# $feature{'email_privacy'}{'default'} = [1];
     -+	'email_privacy' => {
     -+		'sub' => sub { feature_bool('email_privacy', @_) },
     ++	# $feature{'email-privacy'}{'default'} = [1];
     ++	'email-privacy' => {
     ++		'sub' => sub { feature_bool('email-privacy', @_) },
      +		'override' => 1,
      +		'default' => [0]},
       );
     @@ gitweb/gitweb.perl: sub parse_date {
       	return %date;
       }
       
     -+sub hide_mailaddr_if_private {
     -+	my $line = shift;
     -+	return $line unless (gitweb_check_feature('email_privacy') &&
     -+						$line =~ m/^([^<]+) <([^>]*)>/);
     -+	return hide_mailaddr($line)
     ++sub is_mailaddr {
     ++	my @addrs = Mail::Address->parse(shift);
     ++	if (!@addrs || !$addrs[0]->host || !$addrs[0]->user) {
     ++		return 0;
     ++	}
     ++	return 1;
      +}
      +
     -+sub hide_mailaddr {
     -+	my $mailaddr = shift;
     -+	$mailaddr =~ s/<([^>]*)>/<private>/;
     -+	return $mailaddr;
     ++sub hide_mailaddrs_if_private {
     ++	my $line = shift;
     ++	return $line unless gitweb_check_feature('email-privacy');
     ++	while ($line =~ m/(<[^>]+>)/g) {
     ++		my $match = $1;
     ++		if (!is_mailaddr($match)) {
     ++			next;
     ++		}
     ++		my $offset = pos $line;
     ++		my $head = substr $line, 0, $offset - length($match);
     ++		my $redaction = "<redacted>";
     ++		my $tail = substr $line, $offset;
     ++		$line = $head . $redaction . $tail;
     ++		pos $line = length($head) + length($redaction);
     ++	}
     ++	return $line;
      +}
      +
       sub parse_tag {
       	my $tag_id = shift;
       	my %tag;
      @@ gitweb/gitweb.perl: sub parse_tag {
     + 		} elsif ($line =~ m/^tag (.+)$/) {
     + 			$tag{'name'} = $1;
     + 		} elsif ($line =~ m/^tagger (.*) ([0-9]+) (.*)$/) {
     +-			$tag{'author'} = $1;
     ++			$tag{'author'} = hide_mailaddrs_if_private($1);
     + 			$tag{'author_epoch'} = $2;
     + 			$tag{'author_tz'} = $3;
       			if ($tag{'author'} =~ m/^([^<]+) <([^>]*)>/) {
     - 				$tag{'author_name'}  = $1;
     - 				$tag{'author_email'} = $2;
     -+				if (gitweb_check_feature('email_privacy')) {
     -+					$tag{'author_email'} = "private";
     -+					$tag{'author'} = hide_mailaddr($tag{'author'});
     -+				}
     - 			} else {
     - 				$tag{'author_name'} = $tag{'author'};
     - 			}
      @@ gitweb/gitweb.perl: sub parse_commit_text {
     + 		} elsif ((!defined $withparents) && ($line =~ m/^parent ($oid_regex)$/)) {
     + 			push @parents, $1;
     + 		} elsif ($line =~ m/^author (.*) ([0-9]+) (.*)$/) {
     +-			$co{'author'} = to_utf8($1);
     ++			$co{'author'} = hide_mailaddrs_if_private(to_utf8($1));
     + 			$co{'author_epoch'} = $2;
     + 			$co{'author_tz'} = $3;
       			if ($co{'author'} =~ m/^([^<]+) <([^>]*)>/) {
     - 				$co{'author_name'}  = $1;
     - 				$co{'author_email'} = $2;
     -+				if (gitweb_check_feature('email_privacy')) {
     -+					$co{'author_email'} = "private";
     -+					$co{'author'} = hide_mailaddr($co{'author'});
     -+				}
     - 			} else {
     +@@ gitweb/gitweb.perl: sub parse_commit_text {
       				$co{'author_name'} = $co{'author'};
       			}
     -@@ gitweb/gitweb.perl: sub parse_commit_text {
     + 		} elsif ($line =~ m/^committer (.*) ([0-9]+) (.*)$/) {
     +-			$co{'committer'} = to_utf8($1);
     ++			$co{'committer'} = hide_mailaddrs_if_private(to_utf8($1));
     + 			$co{'committer_epoch'} = $2;
     + 			$co{'committer_tz'} = $3;
       			if ($co{'committer'} =~ m/^([^<]+) <([^>]*)>/) {
     - 				$co{'committer_name'}  = $1;
     - 				$co{'committer_email'} = $2;
     -+				if (gitweb_check_feature('email_privacy')) {
     -+					$co{'committer_email'} = "private";
     -+					$co{'committer'} = hide_mailaddr($co{'committer'});
     -+				}
     - 			} else {
     - 				$co{'committer_name'} = $co{'committer'};
     - 			}
      @@ gitweb/gitweb.perl: sub parse_commit_text {
       	if (! defined $co{'title'} || $co{'title'} eq "") {
       		$co{'title'} = $co{'title_short'} = '(no commit message)';
     @@ gitweb/gitweb.perl: sub parse_commit_text {
      +	# remove added spaces, redact e-mail addresses if applicable.
       	foreach my $line (@commit_lines) {
       		$line =~ s/^    //;
     -+		$line = hide_mailaddr_if_private($line);
     ++		$line = hide_mailaddrs_if_private($line);
       	}
       	$co{'comment'} = \@commit_lines;
       
     -@@ gitweb/gitweb.perl: sub git_commitdiff {
     - 		close $fd
     - 			or print "Reading git-diff-tree failed\n";
     - 	} elsif ($format eq 'patch') {
     --		local $/ = undef;
     --		print <$fd>;
     -+		while (my $line = <$fd>) {
     -+			print hide_mailaddr_if_private($line);
     -+		}
     - 		close $fd
     - 			or print "Reading git-format-patch failed\n";
     +@@ gitweb/gitweb.perl: sub git_log_generic {
     + 			         -accesskey => "n", -title => "Alt-n"}, "next");
     + 	}
     + 	my $patch_max = gitweb_get_feature('patches');
     +-	if ($patch_max && !defined $file_name) {
     ++	if ($patch_max && !defined $file_name &&
     ++		!gitweb_check_feature('email-privacy')) {
     + 		if ($patch_max < 0 || @commitlist <= $patch_max) {
     + 			$paging_nav .= " &sdot; " .
     + 				$cgi->a({-href => href(action=>"patches", -replay=>1)},
     +@@ gitweb/gitweb.perl: sub git_commit {
     + 			} @$parents ) .
     + 			')';
       	}
     +-	if (gitweb_check_feature('patches') && @$parents <= 1) {
     ++	if (gitweb_check_feature('patches') && @$parents <= 1 &&
     ++		!gitweb_check_feature('email-privacy')) {
     + 		$formats_nav .= " | " .
     + 			$cgi->a({-href => href(action=>"patch", -replay=>1)},
     + 				"patch");
     +@@ gitweb/gitweb.perl: sub git_commitdiff {
     + 		$formats_nav =
     + 			$cgi->a({-href => href(action=>"commitdiff_plain", -replay=>1)},
     + 			        "raw");
     +-		if ($patch_max && @{$co{'parents'}} <= 1) {
     ++		if ($patch_max && @{$co{'parents'}} <= 1 &&
     ++			!gitweb_check_feature('email-privacy')) {
     + 			$formats_nav .= " | " .
     + 				$cgi->a({-href => href(action=>"patch", -replay=>1)},
     + 					"patch");
     +
     + ## t/lib-gitweb.sh ##
     +@@ t/lib-gitweb.sh: gitweb_run () {
     + 	GITWEB_CONFIG=$(pwd)/gitweb_config.perl
     + 	export GITWEB_CONFIG
     + 
     ++	PERL5LIB="$GIT_BUILD_DIR/perl:$GIT_BUILD_DIR/perl/FromCPAN"
     ++	export PERL5LIB
     ++
     + 	# some of git commands write to STDERR on error, but this is not
     + 	# written to web server logs, so we are not interested in that:
     + 	# we are interested only in properly formatted errors/warnings


 Documentation/gitweb.conf.txt | 10 +++++++
 gitweb/gitweb.perl            | 54 ++++++++++++++++++++++++++++++-----
 t/lib-gitweb.sh               |  3 ++
 3 files changed, 60 insertions(+), 7 deletions(-)

diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
index 7963a79ba98b..47d85717ccaa 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -751,6 +751,16 @@ default font sizes or lineheights are changed (e.g. via adding extra
 CSS stylesheet in `@stylesheets`), it may be appropriate to change
 these values.
 
+email-privacy::
+	Redact e-mail addresses from the generated HTML, etc. content.
+	This hides e-mail addresses found in the commit log from HTTP clients.
+	It is meant to hinder web crawlers that harvest and abuse addresses.
+	Such crawlers may not respect robots.txt.
+	Note that users and user tools also see the addresses redacted.
+	If Gitweb is not the final step in a workflow then subsequent steps
+	may misbehave because of the redacted information they receive.
+	Disabled by default.
+
 highlight::
 	Server-side syntax highlight support in "blob" view.  It requires
 	`$highlight_bin` program to be available (see the description of
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0959a782eccb..6630c76d92fd 100755
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
@@ -3449,6 +3459,32 @@ sub parse_date {
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
+		my $offset = pos $line;
+		my $head = substr $line, 0, $offset - length($match);
+		my $redaction = "<redacted>";
+		my $tail = substr $line, $offset;
+		$line = $head . $redaction . $tail;
+		pos $line = length($head) + length($redaction);
+	}
+	return $line;
+}
+
 sub parse_tag {
 	my $tag_id = shift;
 	my %tag;
@@ -3465,7 +3501,7 @@ sub parse_tag {
 		} elsif ($line =~ m/^tag (.+)$/) {
 			$tag{'name'} = $1;
 		} elsif ($line =~ m/^tagger (.*) ([0-9]+) (.*)$/) {
-			$tag{'author'} = $1;
+			$tag{'author'} = hide_mailaddrs_if_private($1);
 			$tag{'author_epoch'} = $2;
 			$tag{'author_tz'} = $3;
 			if ($tag{'author'} =~ m/^([^<]+) <([^>]*)>/) {
@@ -3513,7 +3549,7 @@ sub parse_commit_text {
 		} elsif ((!defined $withparents) && ($line =~ m/^parent ($oid_regex)$/)) {
 			push @parents, $1;
 		} elsif ($line =~ m/^author (.*) ([0-9]+) (.*)$/) {
-			$co{'author'} = to_utf8($1);
+			$co{'author'} = hide_mailaddrs_if_private(to_utf8($1));
 			$co{'author_epoch'} = $2;
 			$co{'author_tz'} = $3;
 			if ($co{'author'} =~ m/^([^<]+) <([^>]*)>/) {
@@ -3523,7 +3559,7 @@ sub parse_commit_text {
 				$co{'author_name'} = $co{'author'};
 			}
 		} elsif ($line =~ m/^committer (.*) ([0-9]+) (.*)$/) {
-			$co{'committer'} = to_utf8($1);
+			$co{'committer'} = hide_mailaddrs_if_private(to_utf8($1));
 			$co{'committer_epoch'} = $2;
 			$co{'committer_tz'} = $3;
 			if ($co{'committer'} =~ m/^([^<]+) <([^>]*)>/) {
@@ -3568,9 +3604,10 @@ sub parse_commit_text {
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
 
@@ -7489,7 +7526,8 @@ sub git_log_generic {
 			         -accesskey => "n", -title => "Alt-n"}, "next");
 	}
 	my $patch_max = gitweb_get_feature('patches');
-	if ($patch_max && !defined $file_name) {
+	if ($patch_max && !defined $file_name &&
+		!gitweb_check_feature('email-privacy')) {
 		if ($patch_max < 0 || @commitlist <= $patch_max) {
 			$paging_nav .= " &sdot; " .
 				$cgi->a({-href => href(action=>"patches", -replay=>1)},
@@ -7550,7 +7588,8 @@ sub git_commit {
 			} @$parents ) .
 			')';
 	}
-	if (gitweb_check_feature('patches') && @$parents <= 1) {
+	if (gitweb_check_feature('patches') && @$parents <= 1 &&
+		!gitweb_check_feature('email-privacy')) {
 		$formats_nav .= " | " .
 			$cgi->a({-href => href(action=>"patch", -replay=>1)},
 				"patch");
@@ -7863,7 +7902,8 @@ sub git_commitdiff {
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
