Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,URIBL_SBL,URIBL_SBL_A shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BE512047F
	for <e@80x24.org>; Tue, 26 Sep 2017 09:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754418AbdIZJxY (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 05:53:24 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:50331 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753933AbdIZJxW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 05:53:22 -0400
Received: by mail-pg0-f41.google.com with SMTP id p5so5637191pgn.7
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 02:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nanocritical.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N+4AsmLO/6/zdlvoHa3VGDR4yubb4F4pRXnJ2dmyHlM=;
        b=eDGqQBx/qCGaB3Og8yifyhtcobZUdudvwkF/31wU4n7VUKNZoVHMyl6ekuGWrUs8MZ
         eShITalOj74QNQvP5oIMdFsBrkNQLUXf7nF8cfbdGymjqXZwMWRhBGYRStjWKZ9rIEIe
         4khBPA0zIo4WE9hO3CLRcSKGLH4NuT6R9nKOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N+4AsmLO/6/zdlvoHa3VGDR4yubb4F4pRXnJ2dmyHlM=;
        b=CC9jQWWkidXXyvtW3GXlO8qk8Her48ZR2FlkJPXINIENyragegO9Vyl9Oe/QentlX7
         wMTmZV445iPqYnlpM4jhGrCLFoM960lzOfqoUoImawtHOk9YsT5w+/ik/YSBNZsdyOfF
         QCk67uXD7ZR/TID47X+O1FxXj+w6oZNqwQuWztSXbp6u2zYohjJDHxDxvqe5RQBeqcZY
         knqv0Z0pKjTsaKRoDhMC54srSz2p5oNEwRmiLQqoOFlVeIGouxLxRk4YIOZd4NBUKNg5
         6XNU2Jvp7fAMao9Cybt/dluw38VTcoB8l/ix630YhKT/oJHJtvOG87vB7Hxm60xuWg8d
         /b1Q==
X-Gm-Message-State: AHPjjUhKxF3Eq5ABe+UU8f/oN7SN8gqRFaPkahnplOguYD7D5QI45uj/
        o7yRYdhqqLkdaU64EmAxhUZmCgvQrhs=
X-Google-Smtp-Source: AOwi7QB01TqE5zQJp+m8ic5TStbCTs48E3uJDwiMAoTbTMfBMC7Z+rTyLRBY3WQbC78k0QSGaM6Dig==
X-Received: by 10.84.254.70 with SMTP id a6mr10101113pln.71.1506419602135;
        Tue, 26 Sep 2017 02:53:22 -0700 (PDT)
Received: from localhost (node-1w7jr9qppj83lps4xk3hyfn0o.ipv6.telus.net. [2001:569:78d7:e800:bae8:56ff:fe42:9848])
        by smtp.gmail.com with ESMTPSA id h186sm14717786pge.72.2017.09.26.02.53.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Sep 2017 02:53:21 -0700 (PDT)
Received: by localhost (sSMTP sendmail emulation); Tue, 26 Sep 2017 02:53:19 -0700
From:   "Eric Rannaud" <e@nanocritical.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, jeremy.serror@gmail.com,
        "Shawn O . Pearce" <spearce@spearce.org>,
        Eric Rannaud <e@nanocritical.com>
Subject: [PATCH 1/1] fast-import: checkpoint: dump branches/tags/marks even if object_count==0
Date:   Tue, 26 Sep 2017 02:53:04 -0700
Message-Id: <eedb545ccb43a14820802bab10f59ab8ab9557a0.1506419307.git.e@nanocritical.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <xmqqr2uuaxy1.fsf@gitster.mtv.corp.google.com>
References: <xmqqr2uuaxy1.fsf@gitster.mtv.corp.google.com>
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
 t/t9300-fast-import.sh | 117 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 120 insertions(+), 3 deletions(-)


Any comments on the testing strategy with a background fast-import?

To summarize:
- fast-import is started in the background with a command stream that
  ends with "checkpoint\nprogress checkpoint\n". fast-import keeps
  running after reaching the last command (we don't want fast-import to
  terminate).
- In the meantime, the test is waiting to read "progress checkpoint" in
  the output of fast-import, then it checks the testing conditions.
- Finally, the test ensures that fast-import is still running in the
  background (and thus that it has just observed the effect of
  checkpoint, and not the side effects of fast-import terminating).
- After 10 sec, no matter what, the background fast-import is sent
  "done" and terminates.

I tried to make sure that the test runs quickly and does not (typically) sleep.
Upon failure, the test may take up to 10 sec to fully terminate.

However, the test could break under (very heavy) load if fast-import is unable
to make progress in a reasonable amount of time (either "progress checkpoint"
is not read within 5 sec, or fast-import receives "done" before the testing
conditions are checked). Let me know if this is not acceptable.

Should these test cases be at least separated to a new t9304 to
circumscribe any such nuisance? Alternatively, a FIFO-based approach
could be considered.

(Note: added cases 2 and 4 pass without this patch, but 1 and 3 do not.)


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
index 67b8c50a5ab4..b410bf3a3a7a 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3120,4 +3120,121 @@ test_expect_success 'U: validate root delete result' '
 	compare_diff_raw expect actual
 '
 
+###
+### series V (checkpoint)
+###
+
+# To make sure you're observing the side effects of checkpoint *before*
+# fast-import terminates (and thus writes out its state), check that the
+# fast-import process is still running using background_import_still_running
+# *after* evaluating the test conditions.
+background_import_until_checkpoint () {
+	options=$1
+	input_file=$2
+	( cat $input_file; sleep 10; echo done ) | git fast-import $options >V.output &
+	echo $! >V.pid
+
+	# The loop will poll for approximately 5 seconds before giving up.
+	n=0
+	while ! test "$(cat V.output)" = "progress checkpoint"; do
+		if test $n -gt 55
+		then
+			echo >&2 "no progress checkpoint received"
+			exit 1
+		fi
+
+		# Try to avoid sleeping in the first iterations and poll
+		# aggressively.
+		if test $n -ge 50
+		then
+			sleep 1
+		fi
+
+		n=$(($n + 1))
+	done
+}
+
+background_import_still_running () {
+	if ! ps --pid "$(cat V.pid)"
+	then
+		echo >&2 "background fast-import terminated too early"
+		exit 1
+	fi
+	kill $(cat V.pid)
+}
+
+test_expect_success 'V: checkpoint updates refs after reset' '
+	cat >input <<-INPUT_END &&
+	reset refs/heads/V
+	from refs/heads/U
+
+	checkpoint
+	progress checkpoint
+	INPUT_END
+
+	background_import_until_checkpoint "" input &&
+	test "$(git rev-parse --verify V)" = "$(git rev-parse --verify U)" &&
+	background_import_still_running
+'
+
+test_expect_success 'V: checkpoint updates refs and marks after commit' '
+	cat >input <<-INPUT_END &&
+	commit refs/heads/V
+	mark :1
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 0
+	from refs/heads/U
+
+	checkpoint
+	progress checkpoint
+	INPUT_END
+
+	background_import_until_checkpoint "--export-marks=marks.actual" input &&
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
+test_expect_success 'V: checkpoint updates refs and marks after commit (no new objects)' '
+	cat >input <<-INPUT_END &&
+	commit refs/heads/V2
+	mark :2
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 0
+	from refs/heads/U
+
+	checkpoint
+	progress checkpoint
+	INPUT_END
+
+	background_import_until_checkpoint "--export-marks=marks.actual" input &&
+
+	echo ":2 $(git rev-parse --verify V2)" >marks.expected &&
+
+	test "$(git rev-parse --verify V2)" = "$(git rev-parse --verify V)" &&
+	test_cmp marks.expected marks.actual &&
+	background_import_still_running
+'
+
+test_expect_success 'V: checkpoint updates tags after tag' '
+	cat >input <<-INPUT_END &&
+	tag Vtag
+	from refs/heads/V
+	tagger $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 0
+
+	checkpoint
+	progress checkpoint
+	INPUT_END
+
+	background_import_until_checkpoint "" input &&
+	git show-ref -d Vtag &&
+	background_import_still_running
+'
+
 test_done
-- 
2.14.1

