Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354F1C4707A
	for <git@archiver.kernel.org>; Sun, 23 May 2021 08:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0980D61263
	for <git@archiver.kernel.org>; Sun, 23 May 2021 08:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhEWI6E (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 May 2021 04:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbhEWI6A (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 May 2021 04:58:00 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5FAC06138D
        for <git@vger.kernel.org>; Sun, 23 May 2021 01:56:32 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q5so25280623wrs.4
        for <git@vger.kernel.org>; Sun, 23 May 2021 01:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7snwvzrzmtFNZ1YA9658lbuYBwjP0VYrjN107S7yhsA=;
        b=dQ5SK8v9uR3HLwEvgrWFXQNXi323Lv2MXXkCvTU2JLSyI1YTlEfbrrMSqeJte6Df4Y
         JnoxAjvy8Vsn1f2Ui0HLnqkFLAaoOC+xMKV/shjxtUoydUbSgBlFjxjsNi0LtxklF1P1
         KtLwYRCtUDSOIEcp/7JZTQlCgCXF5rlvOAVrnFiTa2jjqO0ouDiSzzfdT/PIrMxNPEwZ
         YFe2Pcm5kX2AK6gegozVv728K5FkjviEv+PkMHpLpFeX0Igcnp0iMVWrwqWXXt58efTy
         +nNMxsjccN+7ofUZjBxX/wq0HAuEInt3Mnx/deCZo5g4SSagJRSCGecKZv8/q9owXzKK
         LRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7snwvzrzmtFNZ1YA9658lbuYBwjP0VYrjN107S7yhsA=;
        b=qhM4gZnY0kyKpBpJMaahtcK60f3bgiUphfsPgpgcvOnR4x5KmCENr7XtFkO5/Z0LRA
         El4Z7MdbMkj+40ksEt184Pb6yz+ypd6SFaWRKrg+PY2Guc0ULjMUDSy+Y2N+F1cLH16i
         JWgsSZORBfVPP6UJgt92E16QVhqtWbUBZKL1wwKqyQbQAJPFnOYUtcgBWjsHwMWx4Sj3
         GQEtPIN5cVWXG3oMiN4T7AohV1T2lJKd47o8uAq7tjWh73MhjuzySapz73Ylb+AjB9aT
         Wn2VmdhN/DsgADh8W2zg7QvgzEfQE9LnCGKm2B/Dq6xiGcS8A5f4KaAPAI6Wu2e9oKqa
         Wp2Q==
X-Gm-Message-State: AOAM530fV+W52cUOM2nwm0z7SqmcPvSEjYoLo+Di6xj7TzJbLg27gkOH
        ccETs5LGAMzZQwdAEKg7Qt3kHa8rGoUdJd+T
X-Google-Smtp-Source: ABdhPJwjdxYzecF+JP203EQJR1J91ZPvwvJRlfgVRwSd/N2sO8TNSdfZJ5VOu9a651US3ut8bmWWkA==
X-Received: by 2002:adf:9d8c:: with SMTP id p12mr17400266wre.310.1621760190553;
        Sun, 23 May 2021 01:56:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s15sm9577839wrt.54.2021.05.23.01.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 01:56:29 -0700 (PDT)
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
Subject: [PATCH v3 11/13] perl: lazily load some common Git.pm setup code
Date:   Sun, 23 May 2021 10:56:16 +0200
Message-Id: <patch-11.13-b3b342b173-20210523T085231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.406.g05cb3eebfc
In-Reply-To: <cover-00.13-0000000000-20210523T085231Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com> <cover-00.13-0000000000-20210523T085231Z-avarab@gmail.com>
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
index 73ebbf80cc..4d048f307b 100644
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
2.32.0.rc0.406.g05cb3eebfc

