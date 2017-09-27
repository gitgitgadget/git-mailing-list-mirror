Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,URIBL_SBL,URIBL_SBL_A shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44FF62047F
	for <e@80x24.org>; Wed, 27 Sep 2017 19:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751261AbdI0Tqh (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 15:46:37 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:53706 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750917AbdI0Tqg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 15:46:36 -0400
Received: by mail-pf0-f172.google.com with SMTP id x78so7755721pff.10
        for <git@vger.kernel.org>; Wed, 27 Sep 2017 12:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nanocritical.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kEXlzzVOSckcoIqjX7RVABm0IaIjXfxW4JM74sN6pLM=;
        b=DhMVXgJ86IknkMeiekuEKODaQ2JbyFiWcoJL8LEQFiFUasRVoRY2A+pDFJh4gV0Zrm
         EkN3TiGXlh7hoAXCEemUJE1Uq6ILTcO3g0fQ2dZGq1UBZOTwHcCm9xDUa6C8MofW5EWn
         uEfn+X0ZopfvHk1CDvIxQtNnW2epIE2F15BX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kEXlzzVOSckcoIqjX7RVABm0IaIjXfxW4JM74sN6pLM=;
        b=Bfa7tkB/1XogmWMAGQb3NYhCI/XvsqwGkC7LpuoUfWR2dhueL80CStvH8BUEOcvh0s
         sOZzBNnj0I6pm5D/5THbtEFcG443WbX+SvlIbFDLQrjEzNfEQtdgTgtYGVif8gVYL2Dn
         R+2+nMWs7oBxeCEIkFqgGTd3RUfSBDpA/QbfepOs0v/QrV0Vt5J/8KJmYWRL+BiyoJGW
         BJpbnY2nd7dXgruKbpCDFKwOP90NJwjoo8o95q0FI71vkMDVJJ2L4aiowMY8caLNmUBi
         evTw+oqDKtQ647i+5iTLdjfWTPUPnX9DZ6XLMvKzhQ2nbqlo2EZtNQgmaflfk9Tl+02c
         z+Tg==
X-Gm-Message-State: AHPjjUiovQg1tKdrNPjShCUK4KpcWyflieGBir92qSgxcwGI0iRslsKA
        BmPfCi2pZ5Oev18MGmHLGtrf5w==
X-Google-Smtp-Source: AOwi7QAHBI5LXhsHgu217WjdVyZ+q0XC/4e4QYxALgsGzIWBytLxc7/7VqoqxcGde8/FyfDCWZ+kng==
X-Received: by 10.99.189.66 with SMTP id d2mr2172064pgp.94.1506541595246;
        Wed, 27 Sep 2017 12:46:35 -0700 (PDT)
Received: from localhost (node-1w7jr9qprg76wahmznhtpeq14.ipv6.telus.net. [2001:569:78e4:8500:bae8:56ff:fe42:9848])
        by smtp.gmail.com with ESMTPSA id s17sm21397131pgq.25.2017.09.27.12.46.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Sep 2017 12:46:34 -0700 (PDT)
Received: by localhost (sSMTP sendmail emulation); Wed, 27 Sep 2017 12:46:32 -0700
From:   "Eric Rannaud" <e@nanocritical.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, jeremy.serror@gmail.com,
        "Shawn O . Pearce" <spearce@spearce.org>,
        Eric Rannaud <e@nanocritical.com>
Subject: [PATCH] fast-import: checkpoint: dump branches/tags/marks even if object_count==0
Date:   Wed, 27 Sep 2017 12:46:26 -0700
Message-Id: <cccb06b75df3cad9f013d5a9ab0371f0a2d9c2ce.1506541322.git.e@nanocritical.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <xmqqefqs7qx8.fsf@gitster.mtv.corp.google.com>
References: <xmqqefqs7qx8.fsf@gitster.mtv.corp.google.com>
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
 t/t9300-fast-import.sh | 129 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 132 insertions(+), 3 deletions(-)


Use named pipes instead of the polling approach. Also incorporate your other
comments.


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
index 67b8c50a5ab4..9aa3470d895b 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3120,4 +3120,133 @@ test_expect_success 'U: validate root delete result' '
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
+
+	mkfifo V.input
+	exec 8<>V.input
+	rm V.input
+
+	mkfifo V.output
+	exec 9<>V.output
+	rm V.output
+
+	cat $input_file >&8
+	git fast-import $options <&8 >&9 &
+	echo $! >V.pid
+	test_when_finished "kill $(cat V.pid) || true"
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
+	exec 8>&-
+	exec 9>&-
+
+	if test $error -eq 1
+	then
+		exit 1
+	fi
+}
+
+background_import_still_running () {
+	if ! kill -0 "$(cat V.pid)"
+	then
+		echo >&2 "background fast-import terminated too early"
+		exit 1
+	fi
+}
+
+test_expect_success 'V: checkpoint updates refs after reset' '
+	cat >input <<-\INPUT_END &&
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

