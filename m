Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,URIBL_SBL,URIBL_SBL_A shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA39F20A10
	for <e@80x24.org>; Fri, 29 Sep 2017 03:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751219AbdI2DJo (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 23:09:44 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:44761 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750891AbdI2DJn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 23:09:43 -0400
Received: by mail-pg0-f52.google.com with SMTP id j16so62023pga.1
        for <git@vger.kernel.org>; Thu, 28 Sep 2017 20:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nanocritical.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xm8SBAcu60S1ZkAJAwXm9VK9ViMhpNnS68kiHEKlEwQ=;
        b=THBpF4ekZ0FG8H5ztHfT9h2Aad+FV6YnLEKwaBeyxZPRfnZTRRgnNBwaggJR9wL2J6
         t+1XxSMepdY7q5h/CF3soVzWLFRxkj+BNPQ4KgEGVywJ6qr48hiJK7rtEOTELFL/lMOH
         NIPC3f31r5RCa4fz94b32BrdWqFpPN6g2Q29M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xm8SBAcu60S1ZkAJAwXm9VK9ViMhpNnS68kiHEKlEwQ=;
        b=nV3grES7YZbDb7y7RhzKOX6+N21Fi/CW9hX6gHiJDjxm3z9oUyRhwaR5pkmtF8xzft
         nifYfq/2zpLzXHAnZjO93UAdNJVHvjLfy4Fy1jgEM3wkv6hs2U69BHAgXghiIGiPDeIv
         tiJmU3gPm2CKgXusH+xHT42LipfuCq/cvRGQgMHrikRBo/TPnfvmW9nbNd1NVbgqQ52p
         TDONc6HPuv/fw7un2oUP/Zszy++QV23N0q4a2ARR3yL5OFM1ww10r7mvTl3EknM1h6gO
         oQHG8CDwQDO1KZkT3sxAJ0Fb0wrOhGwVzeIKKePn56te+51xf8I7bpczfL4vcCUCCSJL
         e8nQ==
X-Gm-Message-State: AHPjjUgtQOkHm/XkFlZcAPQdtfcrigwhCsIK2WjmB3XXx7BNztBEU+gZ
        G5ZMeNBhv/ci0GoQyPu/8EQQew==
X-Google-Smtp-Source: AOwi7QANSGCzX6KrF0NtaQo5/Kq2SbASds504Zznv4N6hCuxAxbeezE/UJUIACvMeKlPONpXG/ogtQ==
X-Received: by 10.84.225.134 with SMTP id u6mr5430345plj.177.1506654583077;
        Thu, 28 Sep 2017 20:09:43 -0700 (PDT)
Received: from localhost (node-1w7jr9qprg76wahmznhtpeq14.ipv6.telus.net. [2001:569:78e4:8500:bae8:56ff:fe42:9848])
        by smtp.gmail.com with ESMTPSA id 77sm5047889pfi.103.2017.09.28.20.09.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Sep 2017 20:09:42 -0700 (PDT)
Received: by localhost (sSMTP sendmail emulation); Thu, 28 Sep 2017 20:09:40 -0700
From:   "Eric Rannaud" <e@nanocritical.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Adam Dinwoodie <adam@dinwoodie.org>, git@vger.kernel.org,
        jeremy.serror@gmail.com, "Shawn O . Pearce" <spearce@spearce.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Rannaud <e@nanocritical.com>
Subject: [PATCH] fast-import: checkpoint: dump branches/tags/marks even if object_count==0
Date:   Thu, 28 Sep 2017 20:09:36 -0700
Message-Id: <0cb786584bd2669763c303f80072baa3693efc33.1506654123.git.e@nanocritical.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <xmqq3776z0jg.fsf@gitster.mtv.corp.google.com>
References: <xmqq3776z0jg.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The checkpoint command cycles packfiles if object_count != 0, a sensible
test or there would be no pack files to write. Since 820b931012, the
command also dumps branches, tags and marks, but still conditionally.
However, it is possible for a command stream to modify refs or create
marks without creating any new objects.

For example, reset a branch (and keep fast-import running):

	$ git fast-import
	reset refs/heads/master
	from refs/heads/master^

	checkpoint

but refs/heads/master remains unchanged.

Other example: a commit command that re-creates an object that already
exists in the object database.

The man page also states that checkpoint "updates the refs" and that
"placing a progress command immediately after a checkpoint will inform
the reader when the checkpoint has been completed and it can safely
access the refs that fast-import updated". This wasn't always true
without this patch.

This fix unconditionally calls dump_{branches,tags,marks}() for all
checkpoint commands. dump_branches() and dump_tags() are cheap to call
in the case of a no-op.

Add tests to t9300 that observe the (non-packfiles) effects of
checkpoint.

Signed-off-by: Eric Rannaud <e@nanocritical.com>
---
 fast-import.c          |   6 +--
 t/t9300-fast-import.sh | 130 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 133 insertions(+), 3 deletions(-)


Junio, this last version addresses your last remark regarding the
potential for the cat $input_file sequence to block when the FIFOs are
unbuffered.

The concern is mainly theoretical (*if* the shell function is used
correctly): fast-import will not start writing to its own output until
it has fully consumed its input (as the only command generating output
should be the last one). Nevertheless, in this version the write is done
in the background.

Thanks!


diff --git a/fast-import.c b/fast-import.c
index 35bf671f12c4..d5e4cf0bad41 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3189,10 +3189,10 @@ static void checkpoint(void)
 	checkpoint_requested = 0;
 	if (object_count) {
 		cycle_packfile();
-		dump_branches();
-		dump_tags();
-		dump_marks();
 	}
+	dump_branches();
+	dump_tags();
+	dump_marks();
 }
 
 static void parse_checkpoint(void)
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 67b8c50a5ab4..8f583e8a22c1 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3120,4 +3120,134 @@ test_expect_success 'U: validate root delete result' '
 	compare_diff_raw expect actual
 '
 
+###
+### series V (checkpoint)
+###
+
+# The commands in input_file should not produce any output on the file
+# descriptor set with --cat-blob-fd (or stdout if unspecified).
+#
+# To make sure you're observing the side effects of checkpoint *before*
+# fast-import terminates (and thus writes out its state), check that the
+# fast-import process is still running using background_import_still_running
+# *after* evaluating the test conditions.
+background_import_then_checkpoint () {
+	options=$1
+	input_file=$2
+
+	mkfifo V.input
+	exec 8<>V.input
+	rm V.input
+
+	mkfifo V.output
+	exec 9<>V.output
+	rm V.output
+
+	git fast-import $options <&8 >&9 &
+	echo $! >V.pid
+	# We don't mind if fast-import has already died by the time the test
+	# ends.
+	test_when_finished "exec 8>&-; exec 9>&-; kill $(cat V.pid) || true"
+
+	# Start in the background to ensure we adhere strictly to (blocking)
+	# pipes writing sequence. We want to assume that the write below could
+	# block, e.g. if fast-import blocks writing its own output to &9
+	# because there is no reader on &9 yet.
+	( cat "$input_file"
+	echo "checkpoint"
+	echo "progress checkpoint" ) >&8 &
+
+	error=0
+	if read output <&9
+	then
+		if ! test "$output" = "progress checkpoint"
+		then
+			echo >&2 "no progress checkpoint received: $output"
+			error=1
+		fi
+	else
+		echo >&2 "failed to read fast-import output"
+		error=1
+	fi
+
+	if test $error -eq 1
+	then
+		false
+	fi
+}
+
+background_import_still_running () {
+	if ! kill -0 "$(cat V.pid)"
+	then
+		echo >&2 "background fast-import terminated too early"
+		false
+	fi
+}
+
+test_expect_success PIPE 'V: checkpoint updates refs after reset' '
+	cat >input <<-\INPUT_END &&
+	reset refs/heads/V
+	from refs/heads/U
+
+	INPUT_END
+
+	background_import_then_checkpoint "" input &&
+	test "$(git rev-parse --verify V)" = "$(git rev-parse --verify U)" &&
+	background_import_still_running
+'
+
+test_expect_success PIPE 'V: checkpoint updates refs and marks after commit' '
+	cat >input <<-INPUT_END &&
+	commit refs/heads/V
+	mark :1
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 0
+	from refs/heads/U
+
+	INPUT_END
+
+	background_import_then_checkpoint "--export-marks=marks.actual" input &&
+
+	echo ":1 $(git rev-parse --verify V)" >marks.expected &&
+
+	test "$(git rev-parse --verify V^)" = "$(git rev-parse --verify U)" &&
+	test_cmp marks.expected marks.actual &&
+	background_import_still_running
+'
+
+# Re-create the exact same commit, but on a different branch: no new object is
+# created in the database, but the refs and marks still need to be updated.
+test_expect_success PIPE 'V: checkpoint updates refs and marks after commit (no new objects)' '
+	cat >input <<-INPUT_END &&
+	commit refs/heads/V2
+	mark :2
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 0
+	from refs/heads/U
+
+	INPUT_END
+
+	background_import_then_checkpoint "--export-marks=marks.actual" input &&
+
+	echo ":2 $(git rev-parse --verify V2)" >marks.expected &&
+
+	test "$(git rev-parse --verify V2)" = "$(git rev-parse --verify V)" &&
+	test_cmp marks.expected marks.actual &&
+	background_import_still_running
+'
+
+test_expect_success PIPE 'V: checkpoint updates tags after tag' '
+	cat >input <<-INPUT_END &&
+	tag Vtag
+	from refs/heads/V
+	tagger $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 0
+
+	INPUT_END
+
+	background_import_then_checkpoint "" input &&
+	git show-ref -d Vtag &&
+	background_import_still_running
+'
+
 test_done
-- 
2.14.1

