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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DCBC43460
	for <git@archiver.kernel.org>; Wed, 12 May 2021 13:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77EFF60FE6
	for <git@archiver.kernel.org>; Wed, 12 May 2021 13:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbhELNtu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 09:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbhELNto (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 09:49:44 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D25C06138A
        for <git@vger.kernel.org>; Wed, 12 May 2021 06:48:34 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t18so23711828wry.1
        for <git@vger.kernel.org>; Wed, 12 May 2021 06:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hwbnWD3Bl014IacyafllGwqxnOLBvjeMJ+tEHyBKC0M=;
        b=j/lFFEbBpzgAf9UvnvMKfFS6DusUQsu591HKl6Oy5nfQTbiuG6HoOinS01svW67Him
         UnyUS0CtjF4MyAYNpZ7tpn48/wj6HcVCe2xisaEFwvVYLdwVa7WkmX9kz44NT5LT0n0c
         MSBj1FtY3uHsd2TiA9/QHpntpnNsa11qCsO82sCf3XPWJV/iag+qhK7E6hBX6deeBMeM
         SkjveV/4Mj9m2QSgmSGw8/Luo738FPT9XgEIKMfsG+Zio2GO3QM0gfc1Z98dIpLbpqEo
         R2Y7/2KRQO4GdGdvqMeExSIxIiVfI2uOFN3g1+9uQR25LZZZEJMrNnhLsAL6mP6eNBWT
         d9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hwbnWD3Bl014IacyafllGwqxnOLBvjeMJ+tEHyBKC0M=;
        b=VbNkbLrlIfsMzoyRMo/NcaF8LvoCoUNg9xrDzkaTAfwvAz2GrHyKi5+2OHFvu0N2R+
         SJiR/+FskFgJiQypH+001OqgxK1BRzxPXTEy3oV595qxAMLaJ8z5tkSDv7sQVtultrLU
         Kyiz+FqTzm/RjEGnPzL2AkamYhUbXsNv0mGKkC0bIYw0tnxbxATDsIbJAyDcFxrP0/xc
         4OGAV0uX5H+m4KZkF0ZcdSnyZPDdQ7S0Fmml9Kd9+kbucErZDEh24ztvFMblrAEr2Adq
         XahEmzSZMvmvOYwjZstumohEeZmMfHbRjpyCtuZsvxMNMQP3ipwDidzHK60iF2CVruJs
         cwPQ==
X-Gm-Message-State: AOAM530D5GEcjvSj8F2sx4meBgKpa2frsZoi+lc9AWAK9xFkyz6mRH29
        Pu7TJaESCa9nvLW3SV1KGKDbhNAAiamU5g==
X-Google-Smtp-Source: ABdhPJzRuclffzsff1d9nG9TOzAKiI1RbbJ0AUfPafl/MYDc4pUT/09o6tgdG0pnGA0YD9PU+MIu5w==
X-Received: by 2002:a5d:64c6:: with SMTP id f6mr45947321wri.18.1620827313246;
        Wed, 12 May 2021 06:48:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n2sm31416612wmb.32.2021.05.12.06.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 06:48:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 7/9] send-email: lazily load modules for a big speedup
Date:   Wed, 12 May 2021 15:48:23 +0200
Message-Id: <patch-7.9-55a0b07062-20210512T132955Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.909.g789bb6d90e
In-Reply-To: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
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
 git-send-email.perl | 70 +++++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 31 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index f9c780ceed..907dc1425f 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -19,20 +19,10 @@
 use 5.008;
 use strict;
 use warnings;
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
@@ -309,9 +290,10 @@ sub do_edit {
 
 # Handle Uncouth Termination
 sub signal_handler {
+	require Term::ANSIColor;
 
 	# Make text normal
-	print color("reset"), "\n";
+	print Term::ANSIColor::color("reset"), "\n";
 
 	# SMTP password masked
 	system "stty echo";
@@ -574,11 +556,13 @@ sub read_config {
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
@@ -627,10 +611,11 @@ sub parse_sendmail_aliases {
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
@@ -702,7 +687,8 @@ sub is_format_patch_arg {
 		opendir my $dh, $f
 			or die sprintf(__("Failed to opendir %s: %s"), $f, $!);
 
-		push @files, grep { -f $_ } map { catfile($f, $_) }
+		require File::Spec;
+		push @files, grep { -f $_ } map { File::Spec->catfile($f, $_) }
 				sort readdir $dh;
 		closedir $dh;
 	} elsif ((-f $f or -p $f) and !is_format_patch_arg($f)) {
@@ -715,7 +701,8 @@ sub is_format_patch_arg {
 if (@rev_list_opts) {
 	die __("Cannot run git format-patch from outside a repository\n")
 		unless $repo;
-	push @files, $repo->command('format-patch', '-o', tempdir(CLEANUP => 1), @rev_list_opts);
+	require File::Temp;
+	push @files, $repo->command('format-patch', '-o', File::Temp::tempdir(CLEANUP => 1), @rev_list_opts);
 }
 
 @files = handle_backup_files(@files);
@@ -752,9 +739,10 @@ sub get_patch_subject {
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
 
@@ -861,6 +849,19 @@ sub get_patch_subject {
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
@@ -868,6 +869,7 @@ sub ask {
 	my $confirm_only = $arg{confirm_only};
 	my $resp;
 	my $i = 0;
+	my $term = term();
 	return defined $default ? $default : undef
 		unless defined $term->IN and defined fileno($term->IN) and
 		       defined $term->OUT and defined fileno($term->OUT);
@@ -1048,6 +1050,7 @@ sub extract_valid_address {
 	return $address if ($address =~ /^($local_part_regexp)$/);
 
 	$address =~ s/^\s*<(.*)>\s*$/$1/;
+	my $have_email_valid = eval { require Email::Valid; 1 };
 	if ($have_email_valid) {
 		return scalar Email::Valid->address($address);
 	}
@@ -1107,7 +1110,8 @@ sub validate_address_list {
 sub make_message_id {
 	my $uniq;
 	if (!defined $message_id_stamp) {
-		$message_id_stamp = strftime("%Y%m%d%H%M%S.$$", gmtime(time));
+		require POSIX;
+		$message_id_stamp = POSIX::strftime("%Y%m%d%H%M%S.$$", gmtime(time));
 		$message_id_serial = 0;
 	}
 	$message_id_serial++;
@@ -1277,6 +1281,7 @@ sub valid_fqdn {
 sub maildomain_net {
 	my $maildomain;
 
+	require Net::Domain;
 	my $domain = Net::Domain::domainname();
 	$maildomain = $domain if valid_fqdn($domain);
 
@@ -1287,6 +1292,7 @@ sub maildomain_mta {
 	my $maildomain;
 
 	for my $host (qw(mailhost localhost)) {
+		require Net::SMTP;
 		my $smtp = Net::SMTP->new($host);
 		if (defined $smtp) {
 			my $domain = $smtp->domain;
@@ -1965,13 +1971,15 @@ sub validate_patch {
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
2.31.1.909.g789bb6d90e

