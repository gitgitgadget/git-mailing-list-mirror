Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF84C04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 07:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C155F611AC
	for <git@archiver.kernel.org>; Mon, 24 May 2021 07:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhEXHy7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 03:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbhEXHyn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 03:54:43 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1477C061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 00:53:15 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id u4-20020a05600c00c4b02901774b80945cso10891564wmm.3
        for <git@vger.kernel.org>; Mon, 24 May 2021 00:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DrzvTwmqd1v1xQhmDV3+QP6hgONoi3kJ51ahQ6kpeX8=;
        b=BNq9urix4xIWNNC9PU135BKzDcDw+lkUPKahfykRwBYiWz8rDzcgdbvao8+l6AyA9l
         RWh5ToLJM0cjDdHft5RUBLItoGCLCzWpPV1HEQwPMqfVO8Na7Y7M11t2eSHzF6k6i+py
         2vWYAXNplseDjEg2x9x50uER5mwoWW9Rt/KVwG0roZ1dtMRG1cec3YoY+l2cFj7K1PJS
         q3B/WF3igHbGG0W/Z+C/it9JDpCSNlrMEMsQYjjOH5cxTHb1KpVZ5t2AzyTEFIt4j2Kg
         XkpiQsGGO1o/JhrSpafEj9+vc4iGdLb4FaVu8JXf92XumFzmx6jGhsdNDkYX+i6se3zg
         TRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DrzvTwmqd1v1xQhmDV3+QP6hgONoi3kJ51ahQ6kpeX8=;
        b=tBp21Npw56xowGdDs5sm/s+6YJJ5WV2m6ftreLDbSeX/g/mJkyFqmemzDk675ZeJw3
         MLZBDK+uedFIU6wBWTdQEh2QPnOz8bNI4BbBUL1+OxyLOw5yjeHPs/QQ2ZuOW3otHy5V
         Uq84B6Ey6xUQ9+YntRVBG30xwv6HRdsri7C4wxFGJoQDFZOvvmWegZiIE/tJvUl3L2/+
         8cZTSpDUQ5LA/W2fiQ5zzUi+yvU+CklO55SOR/c8l9/IF38OU9IP+BPRDmbIfbEg8Us+
         95yCQeujECtoOIAxEVgdr4KqKdFu08pH9I7RqzpinZ/RPNjDAQluddVz8S/3tpRI4mKl
         g30Q==
X-Gm-Message-State: AOAM532PhSMLAWODwqqus9ty3AIKhwaauetw0/+GzCF4W7TiUdzInWkz
        4e/q+g4HFgo+SKZq05TBAfyEnMFLrPRzIVsk
X-Google-Smtp-Source: ABdhPJwF5g+Zwie2o/zaYU7jiYE25AXrOcziCbsbw9ngjNYAs28RLNaVevg75mWOCevAGK1SUJXYxw==
X-Received: by 2002:a05:600c:3043:: with SMTP id n3mr17082986wmh.98.1621842793760;
        Mon, 24 May 2021 00:53:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u126sm8540459wmb.9.2021.05.24.00.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 00:53:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 10/13] send-email: lazily load modules for a big speedup
Date:   Mon, 24 May 2021 09:52:59 +0200
Message-Id: <patch-10.13-61e3e3c93c5-20210524T074932Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.385.g46e826f1e55
In-Reply-To: <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com>
References: <cover-00.13-0000000000-20210523T085231Z-avarab@gmail.com> <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Optimize the time git-send-email takes to do even the simplest of
things (such as serving up "-h") from around ~150ms to ~80ms-~90ms by
lazily loading the modules it requires.

Before this change Devel::TraceUse would report 99/97 used modules
under NO_GETTEXT=[|Y], respectively. Now it's 52/37. It now takes ~15s
to run t9001-send-email.sh, down from ~20s.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-send-email.perl | 71 +++++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 32 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index f1542cb3ea6..1e9273fd4f5 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -19,20 +19,10 @@
 use 5.008;
 use strict;
 use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
-use POSIX qw/strftime/;
-use Term::ReadLine;
 use Getopt::Long;
-use Text::ParseWords;
-use Term::ANSIColor;
-use File::Temp qw/ tempdir tempfile /;
-use File::Spec::Functions qw(catdir catfile);
 use Git::LoadCPAN::Error qw(:try);
-use Cwd qw(abs_path cwd);
 use Git;
 use Git::I18N;
-use Net::Domain ();
-use Net::SMTP ();
-use Git::LoadCPAN::Mail::Address;
 
 Getopt::Long::Configure qw/ pass_through /;
 
@@ -166,7 +156,6 @@ sub format_2822_time {
 		       );
 }
 
-my $have_email_valid = eval { require Email::Valid; 1 };
 my $smtp;
 my $auth;
 my $num_sent = 0;
@@ -192,14 +181,6 @@ sub format_2822_time {
 
 my $repo = eval { Git->repository() };
 my @repo = $repo ? ($repo) : ();
-my $term = eval {
-	$ENV{"GIT_SEND_EMAIL_NOTTY"}
-		? Term::ReadLine->new('git-send-email', \*STDIN, \*STDOUT)
-		: Term::ReadLine->new('git-send-email');
-};
-if ($@) {
-	$term = FakeTerm->new("$@: going non-interactive");
-}
 
 # Behavior modification variables
 my ($quiet, $dry_run) = (0, 0);
@@ -309,9 +290,9 @@ sub do_edit {
 
 # Handle Uncouth Termination
 sub signal_handler {
-
 	# Make text normal
-	print color("reset"), "\n";
+	require Term::ANSIColor;
+	print Term::ANSIColor::color("reset"), "\n";
 
 	# SMTP password masked
 	system "stty echo";
@@ -592,11 +573,13 @@ sub config_regexp {
 }
 
 sub parse_address_line {
+	require Git::LoadCPAN::Mail::Address;
 	return map { $_->format } Mail::Address->parse($_[0]);
 }
 
 sub split_addrs {
-	return quotewords('\s*,\s*', 1, @_);
+	require Text::ParseWords;
+	return Text::ParseWords::quotewords('\s*,\s*', 1, @_);
 }
 
 my %aliases;
@@ -645,10 +628,11 @@ sub parse_sendmail_aliases {
 			s/\\"/"/g foreach @addr;
 			$aliases{$alias} = \@addr
 		}}},
-	mailrc => sub { my $fh = shift; while (<$fh>) {
+	mailrc => sub {	my $fh = shift; while (<$fh>) {
 		if (/^alias\s+(\S+)\s+(.*?)\s*$/) {
+			require Text::ParseWords;
 			# spaces delimit multiple addresses
-			$aliases{$1} = [ quotewords('\s+', 0, $2) ];
+			$aliases{$1} = [ Text::ParseWords::quotewords('\s+', 0, $2) ];
 		}}},
 	pine => sub { my $fh = shift; my $f='\t[^\t]*';
 	        for (my $x = ''; defined($x); $x = $_) {
@@ -720,7 +704,8 @@ sub is_format_patch_arg {
 		opendir my $dh, $f
 			or die sprintf(__("Failed to opendir %s: %s"), $f, $!);
 
-		push @files, grep { -f $_ } map { catfile($f, $_) }
+		require File::Spec;
+		push @files, grep { -f $_ } map { File::Spec->catfile($f, $_) }
 				sort readdir $dh;
 		closedir $dh;
 	} elsif ((-f $f or -p $f) and !is_format_patch_arg($f)) {
@@ -733,7 +718,8 @@ sub is_format_patch_arg {
 if (@rev_list_opts) {
 	die __("Cannot run git format-patch from outside a repository\n")
 		unless $repo;
-	push @files, $repo->command('format-patch', '-o', tempdir(CLEANUP => 1), @rev_list_opts);
+	require File::Temp;
+	push @files, $repo->command('format-patch', '-o', File::Temp::tempdir(CLEANUP => 1), @rev_list_opts);
 }
 
 @files = handle_backup_files(@files);
@@ -770,9 +756,10 @@ sub get_patch_subject {
 if ($compose) {
 	# Note that this does not need to be secure, but we will make a small
 	# effort to have it be unique
+	require File::Temp;
 	$compose_filename = ($repo ?
-		tempfile(".gitsendemail.msg.XXXXXX", DIR => $repo->repo_path()) :
-		tempfile(".gitsendemail.msg.XXXXXX", DIR => "."))[1];
+		File::Temp::tempfile(".gitsendemail.msg.XXXXXX", DIR => $repo->repo_path()) :
+		File::Temp::tempfile(".gitsendemail.msg.XXXXXX", DIR => "."))[1];
 	open my $c, ">", $compose_filename
 		or die sprintf(__("Failed to open for writing %s: %s"), $compose_filename, $!);
 
@@ -879,6 +866,19 @@ sub get_patch_subject {
 	do_edit(@files);
 }
 
+sub term {
+	my $term = eval {
+		require Term::ReadLine;
+		$ENV{"GIT_SEND_EMAIL_NOTTY"}
+			? Term::ReadLine->new('git-send-email', \*STDIN, \*STDOUT)
+			: Term::ReadLine->new('git-send-email');
+	};
+	if ($@) {
+		$term = FakeTerm->new("$@: going non-interactive");
+	}
+	return $term;
+}
+
 sub ask {
 	my ($prompt, %arg) = @_;
 	my $valid_re = $arg{valid_re};
@@ -886,6 +886,7 @@ sub ask {
 	my $confirm_only = $arg{confirm_only};
 	my $resp;
 	my $i = 0;
+	my $term = term();
 	return defined $default ? $default : undef
 		unless defined $term->IN and defined fileno($term->IN) and
 		       defined $term->OUT and defined fileno($term->OUT);
@@ -1066,6 +1067,7 @@ sub extract_valid_address {
 	return $address if ($address =~ /^($local_part_regexp)$/);
 
 	$address =~ s/^\s*<(.*)>\s*$/$1/;
+	my $have_email_valid = eval { require Email::Valid; 1 };
 	if ($have_email_valid) {
 		return scalar Email::Valid->address($address);
 	}
@@ -1125,7 +1127,8 @@ sub validate_address_list {
 sub make_message_id {
 	my $uniq;
 	if (!defined $message_id_stamp) {
-		$message_id_stamp = strftime("%Y%m%d%H%M%S.$$", gmtime(time));
+		require POSIX;
+		$message_id_stamp = POSIX::strftime("%Y%m%d%H%M%S.$$", gmtime(time));
 		$message_id_serial = 0;
 	}
 	$message_id_serial++;
@@ -1295,6 +1298,7 @@ sub valid_fqdn {
 sub maildomain_net {
 	my $maildomain;
 
+	require Net::Domain;
 	my $domain = Net::Domain::domainname();
 	$maildomain = $domain if valid_fqdn($domain);
 
@@ -1305,6 +1309,7 @@ sub maildomain_mta {
 	my $maildomain;
 
 	for my $host (qw(mailhost localhost)) {
+		require Net::SMTP;
 		my $smtp = Net::SMTP->new($host);
 		if (defined $smtp) {
 			my $domain = $smtp->domain;
@@ -1983,13 +1988,15 @@ sub validate_patch {
 	my ($fn, $xfer_encoding) = @_;
 
 	if ($repo) {
-		my $validate_hook = catfile($repo->hooks_path(),
+		require File::Spec;
+		my $validate_hook = File::Spec->catfile($repo->hooks_path(),
 					    'sendemail-validate');
 		my $hook_error;
 		if (-x $validate_hook) {
-			my $target = abs_path($fn);
+			require Cwd;
+			my $target = Cwd::abs_path($fn);
 			# The hook needs a correct cwd and GIT_DIR.
-			my $cwd_save = cwd();
+			my $cwd_save = Cwd::cwd();
 			chdir($repo->wc_path() or $repo->repo_path())
 				or die("chdir: $!");
 			local $ENV{"GIT_DIR"} = $repo->repo_path();
-- 
2.32.0.rc1.385.g46e826f1e55

