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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51638C4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 09:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28978613B6
	for <git@archiver.kernel.org>; Fri, 28 May 2021 09:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236381AbhE1J0H (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 05:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235299AbhE1JZt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 05:25:49 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E88C06138D
        for <git@vger.kernel.org>; Fri, 28 May 2021 02:24:05 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j14so2584761wrq.5
        for <git@vger.kernel.org>; Fri, 28 May 2021 02:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5I+xcKLkUGBqWiPXXs25+b2vmihNkiQ1B8sYGc+SI7I=;
        b=IeDo2WjBYgUDy19cciLhpsmpuK0HjsDy/lDvROWFvM+y9s1lLAaoClEfWzji0VlPBH
         E/HA8Ps1OIa+oe1JHAHr+AmLugLf2LkizZLbATNxCH/WSoW0TncFdcyx8QUlv73w8bK/
         0eu6ZBXnvD2pD7NIfGOfXET+JB939CYp43Kuuhzg3PK2bZ8zHNPiXxbuSg7ybGv3VkWk
         c88435+7mQXUTprChJlScU2cNRmOlqRE2BTnzDe/rW9EWDwDyOvz6mN9rx+WFe8yI7rZ
         vu0K91Lojk9zE5t64U46ZT3LNrUZRRY5ukkOaAUY4MKiwmCknLSAnlXBVJfpChKko4OF
         I5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5I+xcKLkUGBqWiPXXs25+b2vmihNkiQ1B8sYGc+SI7I=;
        b=N9SYKvOVGuaweCY5PRFnExcadnB1cNOKV3q1Lo8oLOsnRyjemjfAUKp4LOxR4ajY2B
         m7K6X7KV1cj2A5BG9yyXn7Z/gyVs0mRriv9cBj8X5gD/O/NzoQPCkxNUWX/lKZGT9obL
         Z1FBdZLxd8vpprr7+vtwpjlu0itlxeEWNAauQ5R5uKG5TiCjoSeL2PAvHMuRwHujZkfL
         PAupoZAP5WZVkyuz606FuRDU+LphKbuzUoE9XmvOa+ClNqRMapTQ1t6LM3RfIGg8X+98
         v0VKMG82J0zG/knHm3PNe/M9CGbDbmWP5ffwF1ZyFak8n9JSClYq1PapESnUwjfOKB7T
         yn+w==
X-Gm-Message-State: AOAM532YDW6SJXC3N95QO77rgmq034f/k5jOBKndVnwmJ2N7hFNlXu0d
        IOKDT+IgRcGGgYmaVrg56yKZa46mARk2DQ==
X-Google-Smtp-Source: ABdhPJwXkZp93tOGBnmJpVCw06yQ5oELDfryURPpnNSxmJWzpHzEOekbpvhHmOu/NgHPjvxqEYETxQ==
X-Received: by 2002:adf:f54a:: with SMTP id j10mr1642422wrp.383.1622193843947;
        Fri, 28 May 2021 02:24:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18sm5842009wmj.15.2021.05.28.02.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:24:03 -0700 (PDT)
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
Subject: [PATCH v5 11/13] perl: lazily load some common Git.pm setup code
Date:   Fri, 28 May 2021 11:23:50 +0200
Message-Id: <patch-11.13-66f68e38c16-20210528T092228Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.458.gd885d4f985c
In-Reply-To: <cover-00.13-00000000000-20210528T092228Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com> <cover-00.13-00000000000-20210528T092228Z-avarab@gmail.com>
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
 perl/Git.pm | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 02eacef0c2a..5562c0cede2 100644
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
@@ -1340,6 +1339,7 @@ sub _temp_cache {
 		my $n = $name;
 		$n =~ s/\W/_/g; # no strange chars
 
+		require File::Temp;
 		($$temp_fd, $fname) = File::Temp::tempfile(
 			"Git_${n}_XXXXXX", UNLINK => 1, DIR => $tmpdir,
 			) or throw Error::Simple("couldn't open new temp file");
@@ -1362,9 +1362,9 @@ sub temp_reset {
 
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
2.32.0.rc1.458.gd885d4f985c

