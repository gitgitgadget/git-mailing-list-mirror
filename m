Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A68C4708D
	for <git@archiver.kernel.org>; Fri, 28 May 2021 09:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6339613DD
	for <git@archiver.kernel.org>; Fri, 28 May 2021 09:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236334AbhE1JZ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 05:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbhE1JZl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 05:25:41 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D66C06138C
        for <git@vger.kernel.org>; Fri, 28 May 2021 02:24:05 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id m18so1759642wmq.0
        for <git@vger.kernel.org>; Fri, 28 May 2021 02:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=br7SwP5fnqqAfXSBPF5xLRPT9/56hBZmmDmZOLqcfOI=;
        b=tekOrJtoWSoaT5IwuyFH/SjspK482x9QFSWl9rEuq9mrC2QWfQovWs54Ca6mVq4YfC
         aPHlS2aTBQPxp5Vu2df1Qh+vXc49KVrbCmMtD+/qeHLxX8yuD4RYRR2dbCcfHorfOYKS
         imEVAabXhQC9WtkBPTx3eG12rEBsEF+wZ6AYMgA3tXB/YvytOyo7PVeZT0PxEXPyOSZu
         v9Fq5JTgZqvl+sdkQw3LeAEoNI0anPoOxhi8q4uNdm0pC7v7miIS4+ykgkqy3c9FRnfU
         GUlCkKSD9g8aDdfan33MJvCI2wgVV3jVE3BjSVDKwn/+Ecfm0PRpWPInMobR8KcLQYHK
         bt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=br7SwP5fnqqAfXSBPF5xLRPT9/56hBZmmDmZOLqcfOI=;
        b=K18b8IAbLdI9P+iVRQtY0V4nzaRIp70DZKUq876npe3cPdF40e61nXwXCwHbQQTyum
         5O05Mfn+MfjkTWi66vibSy18sWqqjz50HuBxmN+s2gcriWlbz45ex8IMgL9q8p+dV7+b
         e4FPEEbySf495l+6Y6jUDFRaUjl+7rKSZz1liwwQVuOsrJLIzXKZV6P/uCKF6cDUR7A6
         3AR53hAXnsrNUox3Eo9/F8AmrFmqXs2YBSKhaVF0ntCXQr1rGjESzbH2uIuXqKnQx214
         LDWDqKnjISYieNrP/EO8VP7XSNVOvmM17a0b/jsHxIOR98jtWokSscye1gfgC8+VuU6D
         U1yA==
X-Gm-Message-State: AOAM533A4BaSXjs9ZM1WCtVtOsaMTSHhjMU2Ys5k+0ZvS1Qu+pGx8qIs
        P/cftdCbA/0Bm7Mql7tAFf3ixIQZCwB6Lg==
X-Google-Smtp-Source: ABdhPJyuNXPAdF6YCgXhDSAJlNoyiH8rHQA/R4DeIFXFsAMqzFMrJvhIu2G99CmG4nJOf33XCN+JJA==
X-Received: by 2002:a05:600c:4f15:: with SMTP id l21mr7490814wmq.37.1622193843304;
        Fri, 28 May 2021 02:24:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18sm5842009wmj.15.2021.05.28.02.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:24:02 -0700 (PDT)
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
Subject: [PATCH v5 10/13] send-email: lazily load modules for a big speedup
Date:   Fri, 28 May 2021 11:23:49 +0200
Message-Id: <patch-10.13-9f21bc6e6f2-20210528T092228Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.458.gd885d4f985c
In-Reply-To: <cover-00.13-00000000000-20210528T092228Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com> <cover-00.13-00000000000-20210528T092228Z-avarab@gmail.com>
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

Changing File::Spec::Functions::{catdir,catfile} to invoking class
methods on File::Spec itself is idiomatic. See [1] for a more
elaborate explanation, the resulting code behaves the same way, just
without the now-pointless function wrapper.

1. http://lore.kernel.org/git/8735u8mmj9.fsf@evledraar.gmail.com

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-send-email.perl | 71 +++++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 32 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index cc1027d8774..a8949c9d313 100755
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
@@ -319,9 +300,9 @@ sub do_edit {
 
 # Handle Uncouth Termination
 sub signal_handler {
-
 	# Make text normal
-	print color("reset"), "\n";
+	require Term::ANSIColor;
+	print Term::ANSIColor::color("reset"), "\n";
 
 	# SMTP password masked
 	system "stty echo";
@@ -602,11 +583,13 @@ sub config_regexp {
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
@@ -655,10 +638,11 @@ sub parse_sendmail_aliases {
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
@@ -730,7 +714,8 @@ sub is_format_patch_arg {
 		opendir my $dh, $f
 			or die sprintf(__("Failed to opendir %s: %s"), $f, $!);
 
-		push @files, grep { -f $_ } map { catfile($f, $_) }
+		require File::Spec;
+		push @files, grep { -f $_ } map { File::Spec->catfile($f, $_) }
 				sort readdir $dh;
 		closedir $dh;
 	} elsif ((-f $f or -p $f) and !is_format_patch_arg($f)) {
@@ -743,7 +728,8 @@ sub is_format_patch_arg {
 if (@rev_list_opts) {
 	die __("Cannot run git format-patch from outside a repository\n")
 		unless $repo;
-	push @files, $repo->command('format-patch', '-o', tempdir(CLEANUP => 1), @rev_list_opts);
+	require File::Temp;
+	push @files, $repo->command('format-patch', '-o', File::Temp::tempdir(CLEANUP => 1), @rev_list_opts);
 }
 
 @files = handle_backup_files(@files);
@@ -780,9 +766,10 @@ sub get_patch_subject {
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
 
@@ -889,6 +876,19 @@ sub get_patch_subject {
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
@@ -896,6 +896,7 @@ sub ask {
 	my $confirm_only = $arg{confirm_only};
 	my $resp;
 	my $i = 0;
+	my $term = term();
 	return defined $default ? $default : undef
 		unless defined $term->IN and defined fileno($term->IN) and
 		       defined $term->OUT and defined fileno($term->OUT);
@@ -1076,6 +1077,7 @@ sub extract_valid_address {
 	return $address if ($address =~ /^($local_part_regexp)$/);
 
 	$address =~ s/^\s*<(.*)>\s*$/$1/;
+	my $have_email_valid = eval { require Email::Valid; 1 };
 	if ($have_email_valid) {
 		return scalar Email::Valid->address($address);
 	}
@@ -1135,7 +1137,8 @@ sub validate_address_list {
 sub make_message_id {
 	my $uniq;
 	if (!defined $message_id_stamp) {
-		$message_id_stamp = strftime("%Y%m%d%H%M%S.$$", gmtime(time));
+		require POSIX;
+		$message_id_stamp = POSIX::strftime("%Y%m%d%H%M%S.$$", gmtime(time));
 		$message_id_serial = 0;
 	}
 	$message_id_serial++;
@@ -1305,6 +1308,7 @@ sub valid_fqdn {
 sub maildomain_net {
 	my $maildomain;
 
+	require Net::Domain;
 	my $domain = Net::Domain::domainname();
 	$maildomain = $domain if valid_fqdn($domain);
 
@@ -1315,6 +1319,7 @@ sub maildomain_mta {
 	my $maildomain;
 
 	for my $host (qw(mailhost localhost)) {
+		require Net::SMTP;
 		my $smtp = Net::SMTP->new($host);
 		if (defined $smtp) {
 			my $domain = $smtp->domain;
@@ -1994,13 +1999,15 @@ sub validate_patch {
 
 	if ($repo) {
 		my $hooks_path = $repo->command_oneline('rev-parse', '--git-path', 'hooks');
-		my $validate_hook = catfile($hooks_path,
+		require File::Spec;
+		my $validate_hook = File::Spec->catfile($hooks_path,
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
2.32.0.rc1.458.gd885d4f985c

