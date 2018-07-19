Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 269181F597
	for <e@80x24.org>; Thu, 19 Jul 2018 22:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731190AbeGSXMB (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 19:12:01 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41915 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730469AbeGSXMA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 19:12:00 -0400
Received: by mail-ed1-f67.google.com with SMTP id s24-v6so8234851edr.8
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 15:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xvkvEhI7b2lOcciU/fj4jMOobKj9DUFHhGXPkMBrjWo=;
        b=hh+EKdjhx+brGy4cAM9EHb1rKPwG2LsuXmOT0XaFRKIwqbg2r5Feb1QtKaW0IxAW3/
         nueBo7VLIODhce1N4OcCcRA5T0+rklNM3vOa4bTpuhNlXqbWNQfMoNuRMHXuJF9FCqfE
         dsAgWhrbNyGlv+UP4n8sRhgb84ePhVX/bKRgejh7Qn6+Oo89NfsOFf02iCZjFGVZel5N
         JcguHV3EH1UYshueZQmVYNoojbybSnV+ZantyWTybxC4i8qiEXZ7ueXe1CcXLClgY3AR
         SpYcugONZTTj50trd03a7y+gXxavxWJeqXUoyilm9DZjYoen14zOLGVDtHpKHDTSmFLa
         2i8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xvkvEhI7b2lOcciU/fj4jMOobKj9DUFHhGXPkMBrjWo=;
        b=c3hGEccqSWveN/kk4xWLDhVzPzJWYytQhamb+YrAqkYI3dOXlS2WOb7nVJlOFQUIUz
         /kD/413Ofbntd96ZNl754g7fG14JV9/OBgRZ2obj3MTk9xy753zoLrIpIVoJm7it5oUv
         dal8qY4hmpjh9jBEG5VvYtzqMn1yVLk7MeoCnQ/Dbvx81zEGkujsuBZdXg9NMSPhfGI+
         0F7XoTprhnKbIrHVSzJmZxrE+U9sGA6fcu90kFVjJZKNSadtLjM66JNxVN545+a1d6ut
         J3qjLDjGJbE4l5D4uSMVU5T+htINmpyT9hLfzbaoaytl2i8CVuMaKiJhlsN4AMDvSjVl
         /+Vg==
X-Gm-Message-State: AOUpUlEcT+p+8ilyk4RH4/jH066TZej03eT9i6lcrYd9zmY5PcQdLCUc
        zJhBhCPDg/E+JM1dSR3cHZs=
X-Google-Smtp-Source: AAOMgpedNGzLtDjpdNnMD7eAdKgw16yyrkSkLfrSODhPHZiv3fCTfIYUQMgYyZnMxP1dssrBEq3X2w==
X-Received: by 2002:a50:ed09:: with SMTP id j9-v6mr12449667eds.28.1532039211198;
        Thu, 19 Jul 2018 15:26:51 -0700 (PDT)
Received: from localhost.localdomain (x4db1dbec.dyn.telefonica.de. [77.177.219.236])
        by smtp.gmail.com with ESMTPSA id u3-v6sm294679edo.44.2018.07.19.15.26.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jul 2018 15:26:50 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Rannaud <e@nanocritical.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] t9300: wait for background fast-import process to die after killing it
Date:   Fri, 20 Jul 2018 00:26:41 +0200
Message-Id: <20180719222641.12152-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.408.g42635c01bc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The five new tests added to 't9300-fast-import.sh' in 30e215a65c
(fast-import: checkpoint: dump branches/tags/marks even if
object_count==0, 2017-09-28), all with the prefix "V:" in their test
description, run 'git fast-import' in the background and then 'kill'
it as part of a 'test_when_finished' cleanup command.  When this test
script is executed with Bash, some or even all of these tests tend to
pollute the test script's stderr, and messages about terminated
processes end up on the terminal:

  $ bash ./t9300-fast-import.sh
  <... snip ...>
  ok 179 - V: checkpoint helper does not get stuck with extra output
  /<...>/test-lib-functions.sh: line 388: 28383 Terminated              git fast-import $options 0<&8 1>&9
  ok 180 - V: checkpoint updates refs after reset
  ./t9300-fast-import.sh: line 3210: 28401 Terminated              git fast-import $options 0<&8 1>&9
  ok 181 - V: checkpoint updates refs and marks after commit
  ok 182 - V: checkpoint updates refs and marks after commit (no new objects)
  ./test-lib.sh: line 634: line 3250: 28485 Terminated              git fast-import $options 0<&8 1>&9
  ok 183 - V: checkpoint updates tags after tag
  ./t9300-fast-import.sh: line 3264: 28510 Terminated              git fast-import $options 0<&8 1>&9

After a background child process terminates, its parent Bash process
always outputs a message like those above to stderr, even when in
non-interactive mode.

But how do some of these messages end up on the test script's stderr,
why don't we get them from all five tests, and why do they come from
different file/line locations?  Well, after sending the TERM signal to
the background child process, it takes a little while until that
process receives the signal and terminates, and then it takes another
while until the parent process notices it.  During this time the
parent Bash process is continuing execution, and by the time it
notices that its child terminated it might have already left
'test_eval_inner_' and its stderr is not redirected to /dev/null
anymore.  That's why such a message can appear on the test script's
stderr, while other times, when the child terminates fast and/or the
parent shell is slow enough, the message ends up in /dev/null, just
like any other output of the test does.  Bash always adds the file
name and line number of the code location it was about to execute when
it notices the termination of its child process as a prefix to that
message, hence the varying and sometimes totally unrelated location
prefixes in those messages (e.g. line 388 in 'test-lib-functions.sh'
is 'test_verify_prereq', and I saw such a message pointing to
'say_color' as well).

Prevent these messages from appearing on the test script's stderr by
'wait'-ing on the pid of the background 'git fast-import' process
after sending it the TERM signal.  This ensures that the executing
shell's stderr is still redirected when the shell notices the
termination of its child process in the background, and that these
messages get a consistent file/line location prefix.

Note that this is not an issue when the test script is run with Bash
and '-v', because then these messages are supposed to go to the test
script's stderr anyway, and indeed all of them do; though the
sometimes seemingly random file/line prefixes could be confusing
still.  Similarly, it's not an issue with Bash and '--verbose-log'
either, because then all messages go to the log file as they should.
Finally, it's not an issue with some other shells (I tried dash, ksh,
ksh93 and mksh) even without any of the verbose options, because they
don't print messages like these in non-interactive mode in the first
place.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t9300-fast-import.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 9e7f96223d..fac33e524c 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3147,7 +3147,10 @@ background_import_then_checkpoint () {
 	echo $! >V.pid
 	# We don't mind if fast-import has already died by the time the test
 	# ends.
-	test_when_finished "exec 8>&-; exec 9>&-; kill $(cat V.pid) || true"
+	test_when_finished "
+		exec 8>&-; exec 9>&-;
+		kill $(cat V.pid) && wait $(cat V.pid)
+		true"
 
 	# Start in the background to ensure we adhere strictly to (blocking)
 	# pipes writing sequence. We want to assume that the write below could
-- 
2.18.0.408.g42635c01bc

