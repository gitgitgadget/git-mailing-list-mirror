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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B9DC433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 13:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A16B961040
	for <git@archiver.kernel.org>; Wed, 12 May 2021 13:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhELNtw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 09:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbhELNto (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 09:49:44 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDFCC061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 06:48:36 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id b19-20020a05600c06d3b029014258a636e8so3081606wmn.2
        for <git@vger.kernel.org>; Wed, 12 May 2021 06:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hMBc0k8GsPu5lUaY9RoSIKmGYK8M1KP5ub7m7/1DxYE=;
        b=Gg5U6lNNXnIkZgPPnVZCtCXuP8viW+jl1OTGRX4fvsbLiPNQNL3pSVUMDbMoMDEqjL
         Rn3UW9yJbXepVb/0EDG9h5YFniCz41UWmAw1cvmJn4ljG5r4CXx6o9r7kUbjzmtMsg4w
         g7hwTyWIbsf47Z3TA/FSXPXhWXdPzYd+QL3mjqVPYsDVZj5dmIGxmNR1mIkziPxUcjPL
         EaiKl25jdvnSygFUd18uBf1zsESLDq/gKXChNOMCqaB1ZPFRvgSDu/sY505dS6AUQB0F
         6sDEorxi7EZv44/YmC/45Z3Q2m0MKqyCXNL5O8WfD3/wtw1Z06QQ3gQW/u1vAhvjddX3
         aVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hMBc0k8GsPu5lUaY9RoSIKmGYK8M1KP5ub7m7/1DxYE=;
        b=FtLS4XN789IeyGhKis+mstZslpID6/N1oUWqiVltJ8ovcwtnfLlov7YqXb3xbn+YYM
         ZUA3quig45RCej1R/BJfJvLYDs1BV+oNX+KyCljcG7mkSGJiw6ztIA5EeaIeaOx47MQC
         4IE8x26peMlpXtY9RqijypwfP3lxJJByG5WRKbhfP/GsknVfnHHC3BTJXI4W+ojAhnxl
         ey0sz2rCpYQQBRUL4gPM7rOMMflicGHyDcp5nnN6EXUUU0zK36OiIIAoL/rSZYYq9sJD
         OCi1p3wASk4JG9aOqU7c0omyj1s4ynmisf4LPw0xA4IO0y/kNp1b+sPyXFeMSLUJJGZ0
         SV2g==
X-Gm-Message-State: AOAM532ZRrd1C9H66GXLBDPZui0HGWK9nfai49zHfCeuDKCwA7DnKfKp
        QIe3FE474pjgMUxI6S/VM/QRIAfFmfoMfA==
X-Google-Smtp-Source: ABdhPJzltUaLnnxOnqnXOjP1GZml06su52NQot+WqHRFJ57AWiX5WaKE0bqMD1M/idMOszRk6dzOvQ==
X-Received: by 2002:a1c:1b43:: with SMTP id b64mr11616319wmb.178.1620827314169;
        Wed, 12 May 2021 06:48:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n2sm31416612wmb.32.2021.05.12.06.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 06:48:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 8/9] perl: lazily load some common Git.pm setup code
Date:   Wed, 12 May 2021 15:48:24 +0200
Message-Id: <patch-8.9-2312346f71-20210512T132955Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.909.g789bb6d90e
In-Reply-To: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of unconditionally requiring modules such as File::Spec, let's
only load them when needed. This speeds up code that only needs a
subset of the features Git.pm provides.

This brings a plain invocation of "git send-email" down from 52/37
loaded modules under NO_GETTEXT=[|Y] to 39/18, and it now takes
~60-~70ms instead of ~80-~90ms. The runtime of t9001-send-email.sh
test is down to ~13s from ~15s.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 perl/Git.pm | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 06a10b175a..f18852fb09 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -11,9 +11,6 @@ package Git;
 use strict;
 use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
 
-use File::Temp ();
-use File::Spec ();
-
 BEGIN {
 
 our ($VERSION, @ISA, @EXPORT, @EXPORT_OK);
@@ -103,12 +100,9 @@ =head1 DESCRIPTION
 =cut
 
 
-use Carp qw(carp croak); # but croak is bad - throw instead
+sub carp { require Carp; goto &Carp::carp }
+sub croak { require Carp; goto &Carp::croak }
 use Git::LoadCPAN::Error qw(:try);
-use Cwd qw(abs_path cwd);
-use IPC::Open2 qw(open2);
-use Fcntl qw(SEEK_SET SEEK_CUR);
-use Time::Local qw(timegm);
 }
 
 
@@ -191,13 +185,15 @@ sub repository {
 			$dir = undef;
 		};
 
+		require Cwd;
 		if ($dir) {
+			require File::Spec;
 			File::Spec->file_name_is_absolute($dir) or $dir = $opts{Directory} . '/' . $dir;
-			$opts{Repository} = abs_path($dir);
+			$opts{Repository} = Cwd::abs_path($dir);
 
 			# If --git-dir went ok, this shouldn't die either.
 			my $prefix = $search->command_oneline('rev-parse', '--show-prefix');
-			$dir = abs_path($opts{Directory}) . '/';
+			$dir = Cwd::abs_path($opts{Directory}) . '/';
 			if ($prefix) {
 				if (substr($dir, -length($prefix)) ne $prefix) {
 					throw Error::Simple("rev-parse confused me - $dir does not have trailing $prefix");
@@ -223,7 +219,7 @@ sub repository {
 				throw Error::Simple("fatal: Not a git repository: $dir");
 			}
 
-			$opts{Repository} = abs_path($dir);
+			$opts{Repository} = Cwd::abs_path($dir);
 		}
 
 		delete $opts{Directory};
@@ -408,10 +404,12 @@ sub command_bidi_pipe {
 	my $cwd_save = undef;
 	if ($self) {
 		shift;
-		$cwd_save = cwd();
+		require Cwd;
+		$cwd_save = Cwd::cwd();
 		_setup_git_cmd_env($self);
 	}
-	$pid = open2($in, $out, 'git', @_);
+	require IPC::Open2;
+	$pid = IPC::Open2::open2($in, $out, 'git', @_);
 	chdir($cwd_save) if $cwd_save;
 	return ($pid, $in, $out, join(' ', @_));
 }
@@ -538,7 +536,8 @@ sub get_tz_offset {
 	my $t = shift || time;
 	my @t = localtime($t);
 	$t[5] += 1900;
-	my $gm = timegm(@t);
+	require Time::Local;
+	my $gm = Time::Local::timegm(@t);
 	my $sign = qw( + + - )[ $gm <=> $t ];
 	return sprintf("%s%02d%02d", $sign, (gmtime(abs($t - $gm)))[2,1]);
 }
@@ -629,7 +628,8 @@ sub hooks_path {
 	my ($self) = @_;
 
 	my $dir = $self->command_oneline('rev-parse', '--git-path', 'hooks');
-	my $abs = abs_path($dir);
+	require Cwd;
+	my $abs = Cwd::abs_path($dir);
 	return $abs;
 }
 
@@ -1353,6 +1353,7 @@ sub _temp_cache {
 		my $n = $name;
 		$n =~ s/\W/_/g; # no strange chars
 
+		require File::Temp;
 		($$temp_fd, $fname) = File::Temp::tempfile(
 			"Git_${n}_XXXXXX", UNLINK => 1, DIR => $tmpdir,
 			) or throw Error::Simple("couldn't open new temp file");
@@ -1375,9 +1376,9 @@ sub temp_reset {
 
 	truncate $temp_fd, 0
 		or throw Error::Simple("couldn't truncate file");
-	sysseek($temp_fd, 0, SEEK_SET) and seek($temp_fd, 0, SEEK_SET)
+	sysseek($temp_fd, 0, Fcntl::SEEK_SET()) and seek($temp_fd, 0, Fcntl::SEEK_SET())
 		or throw Error::Simple("couldn't seek to beginning of file");
-	sysseek($temp_fd, 0, SEEK_CUR) == 0 and tell($temp_fd) == 0
+	sysseek($temp_fd, 0, Fcntl::SEEK_CUR()) == 0 and tell($temp_fd) == 0
 		or throw Error::Simple("expected file position to be reset");
 }
 
-- 
2.31.1.909.g789bb6d90e

