Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B1921F858
	for <e@80x24.org>; Wed,  3 Aug 2016 16:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758114AbcHCQnf (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 12:43:35 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33065 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757786AbcHCQnE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 12:43:04 -0400
Received: by mail-wm0-f66.google.com with SMTP id o80so37174735wme.0
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 09:42:40 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fm3lcrWVDZK8pfhwKjwy6B9BRuqUge9fFdPgJZWxyEA=;
        b=K5ZsYS/+J/FeVU85ROcl6SjdnF0CwYD68Tc3eh7Fu2u9jZLhSSTCRF/K0ttUwPmxSQ
         DyQhtKojwXty2KvpvDd37u0icYzOq8s88qYVmAuPvcaLxyew6REhuvOb3Uswxt4dWMGw
         L3Ev7JolTOFOrAAaf3Y9eSTRKTydx+1vjc6a2LaDHvW665xNO0nWY/5t+eir4bWCT5CT
         Wn5+KD1mdL1EHed6Ng47yq2plecP8bVhXzkzFwclpfzY4wX49S4xs4iO3/hD7U0Ul9RV
         Sqyru1fuR2CunxTSZN+QZhKcsYubfa28O+It/cOvzrtyc3b8egdGpQ4Z5TD+z3MHHYvZ
         g0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fm3lcrWVDZK8pfhwKjwy6B9BRuqUge9fFdPgJZWxyEA=;
        b=iba8MTPkO2vt3XwJoufRwjW+njTh42vu7H+piA6Ug6SmEYBzdp4JG4Uy2tKUZmwIwQ
         19+xnZ73rb3a8xhvPKU+CBgXiem1U2YkVDSqMawKm7vlZtVvQ4SdI1LxC0YxZQ2gEiag
         XiY7RmVztfaTlCfYBec0kBHK3NV+zgGbRnA9x57x2R7CQBrxMGv0ZCE9hz8a9umZGVYw
         2vvX7Y4ALPbL7QbdFsZFEsYulJ64Jjl9pFCyoR78sE0AR73d5AXVTwf8V3vK/k9s2LSL
         BVs+s199Q6Ch8LCDqMVVVz0kiFSReUhChif0g8A/BQwNRn60VxZH9mtSuJH/rUSK/yIt
         dIwg==
X-Gm-Message-State: AEkoout7eH0cMehHN0vDnNI6lJxh269D5pXUhP1OfOTWK65wpraLpxDA/EXRAaxdkIWQmA==
X-Received: by 10.28.45.69 with SMTP id t66mr26075146wmt.41.1470242560069;
        Wed, 03 Aug 2016 09:42:40 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 3sm8959736wms.1.2016.08.03.09.42.39
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 03 Aug 2016 09:42:39 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, jnareb@gmail.com, tboegi@web.de,
	mlbright@gmail.com, e@80x24.org, peff@peff.net,
	Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v4 12/12] convert: add filter.<driver>.process shutdown command option
Date:	Wed,  3 Aug 2016 18:42:25 +0200
Message-Id: <20160803164225.46355-13-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160803164225.46355-1-larsxschneider@gmail.com>
References: <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160803164225.46355-1-larsxschneider@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Add the "shutdown" capability to the `filter.<driver>.process` filter
protocol. If a filter supports this capability then Git will send the
"shutdown" command and wait until the filter answers. This gives the
filter the opportunity to perform cleanup tasks. Afterwards the filter
is expected to exit.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 Documentation/gitattributes.txt | 12 ++++++-
 convert.c                       | 35 ++++++++++++++++++++
 t/t0021-conversion.sh           | 71 +++++++++++++++++++++++++++++++++++++++++
 t/t0021/rot13-filter.pl         |  7 ++++
 4 files changed, 124 insertions(+), 1 deletion(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 49514ab..5556cc0 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -400,7 +400,8 @@ packet:          git< git-filter-protocol\n
 packet:          git< version=2\n
 packet:          git< capabilities=clean smudge\n
 ------------------------
-Supported filter capabilities are "clean" and "smudge".
+Supported filter capabilities are "clean", "smudge", and
+"shutdown".
 
 Afterwards Git sends a command (based on the supported
 capabilities), the pathname of a file relative to the
@@ -453,6 +454,15 @@ After the filter has processed a blob it is expected to wait for
 the next command. When the Git process terminates, it will send
 a kill signal to the filter in that stage.
 
+If the filter supports the "shutdown" capability then Git will
+send the "shutdown" command and wait until the filter answers
+with "done". This gives the filter the opportunity to perform
+cleanup tasks. Afterwards the filter is expected to exit.
+------------------------
+packet:          git> command=shutdown\n
+packet:          git< result=success\n
+------------------------
+
 A long running filter demo implementation can be found in
 `t/t0021/rot13-filter.pl` located in the Git core repository.
 If you develop your own long running filter process then the
diff --git a/convert.c b/convert.c
index 130430a..41e3229 100644
--- a/convert.c
+++ b/convert.c
@@ -478,8 +478,10 @@ static int apply_single_file_filter(const char *path, const char *src, size_t le
 
 #define FILTER_CAPABILITIES_CLEAN    (1u<<0)
 #define FILTER_CAPABILITIES_SMUDGE   (1u<<1)
+#define FILTER_CAPABILITIES_SHUTDOWN (1u<<2)
 #define FILTER_SUPPORTS_CLEAN(type)  ((type) & FILTER_CAPABILITIES_CLEAN)
 #define FILTER_SUPPORTS_SMUDGE(type) ((type) & FILTER_CAPABILITIES_SMUDGE)
+#define FILTER_SUPPORTS_SHUTDOWN(type) ((type) & FILTER_CAPABILITIES_SHUTDOWN)
 
 struct cmd2process {
 	struct hashmap_entry ent; /* must be the first member! */
@@ -520,6 +522,35 @@ static void kill_multi_file_filter(struct hashmap *hashmap, struct cmd2process *
 	free(entry);
 }
 
+void shutdown_multi_file_filter(pid_t pid)
+{
+	int did_fail;
+	struct cmd2process *entry;
+	struct hashmap_iter iter;
+	static const char shutdown[] = "command=shutdown\n";
+	char *result = NULL;
+
+	if (!cmd_process_map_initialized)
+		return;
+
+	hashmap_iter_init(&cmd_process_map, &iter);
+	while ((entry = hashmap_iter_next(&iter))) {
+		if (entry->process.pid == pid &&
+			FILTER_SUPPORTS_SHUTDOWN(entry->supported_capabilities)
+		) {
+			did_fail = direct_packet_write_data(
+				entry->process.in, shutdown, strlen(shutdown), 1);
+			if (!did_fail)
+				result = packet_read_line(entry->process.out, NULL);
+			close(entry->process.in);
+			close(entry->process.out);
+
+			if (did_fail || !result || strcmp(result, "result=success"))
+				error("shutdown of external filter '%s' failed", entry->cmd);
+		}
+	}
+}
+
 static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, const char *cmd)
 {
 	int did_fail;
@@ -543,6 +574,8 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 	process->use_shell = 1;
 	process->in = -1;
 	process->out = -1;
+	process->clean_on_exit = 1;
+	process->clean_on_exit_handler = shutdown_multi_file_filter;
 
 	if (start_command(process)) {
 		error("cannot fork to run external filter '%s'", cmd);
@@ -575,6 +608,8 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 				entry->supported_capabilities |= FILTER_CAPABILITIES_CLEAN;
 			} else if (!strcmp(requested, "smudge")) {
 				entry->supported_capabilities |= FILTER_CAPABILITIES_SMUDGE;
+			} else if (!strcmp(requested, "shutdown")) {
+				entry->supported_capabilities |= FILTER_CAPABILITIES_SHUTDOWN;
 			} else {
 				warning(
 					"external filter '%s' requested unsupported filter capability '%s'",
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index c1a22f4..613e370 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -417,6 +417,77 @@ test_expect_success PERL 'required process filter should filter data' '
 	)
 '
 
+test_expect_success PERL 'required process filter should filter data with shutdown' '
+	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge shutdown" &&
+	test_config_global filter.protocol.required true &&
+	rm -rf repo &&
+	mkdir repo &&
+	(
+		cd repo &&
+		git init &&
+
+		echo "*.r filter=protocol" >.gitattributes &&
+		git add . &&
+		git commit . -m "test commit" &&
+		git branch empty &&
+
+		cat ../test.o >test.r &&
+		cat ../test2.o >test2.r &&
+
+		check_filter \
+			git add . \
+				<<-\EOF &&
+					1 IN: clean test.r 57 [OK] -- OUT: 57 [OK]
+					1 IN: clean test2.r 14 [OK] -- OUT: 14 [OK]
+					1 IN: shutdown -- [OK]
+					1 start
+					1 wrote filter header
+				EOF
+
+		check_filter_count_clean \
+			git commit . -m "test commit" \
+				<<-\EOF &&
+					x IN: clean test.r 57 [OK] -- OUT: 57 [OK]
+					x IN: clean test2.r 14 [OK] -- OUT: 14 [OK]
+					1 IN: shutdown -- [OK]
+					1 start
+					1 wrote filter header
+				EOF
+
+		rm -f test?.r testsubdir/test3-subdir.r &&
+
+		check_filter_ignore_clean \
+			git checkout . \
+				<<-\EOF &&
+					start
+					wrote filter header
+					IN: smudge test2.r 14 [OK] -- OUT: 14 [OK]
+					IN: shutdown -- [OK]
+				EOF
+
+		check_filter_ignore_clean \
+			git checkout empty \
+				<<-\EOF &&
+					start
+					wrote filter header
+					IN: shutdown -- [OK]
+				EOF
+
+		check_filter_ignore_clean \
+			git checkout master \
+				<<-\EOF &&
+					start
+					wrote filter header
+					IN: smudge test.r 57 [OK] -- OUT: 57 [OK]
+					IN: smudge test2.r 14 [OK] -- OUT: 14 [OK]
+					IN: shutdown -- [OK]
+				EOF
+
+		check_rot13 ../test.o test.r &&
+		check_rot13 ../test2.o test2.r
+	)
+'
+
 test_expect_success PERL 'required process filter should filter smudge data and one-shot filter should clean' '
 	test_config_global filter.protocol.clean ./../rot13.sh &&
 	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl smudge" &&
diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index ca6d5e4..654741b 100755
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -84,6 +84,13 @@ while (1) {
     print $debug "IN: $command";
     $debug->flush();
 
+    if ( $command eq "shutdown" ) {
+        print $debug " -- [OK]";
+        $debug->flush();
+        packet_write("result=success\n");
+        exit();
+    }
+
     my ($pathname) = packet_read() =~ /^pathname=([^=]+)\n$/;
     print $debug " $pathname";
     $debug->flush();
-- 
2.9.0

