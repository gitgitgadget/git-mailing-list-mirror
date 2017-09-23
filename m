Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E1C72047F
	for <e@80x24.org>; Sat, 23 Sep 2017 19:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751714AbdIWTz7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 15:55:59 -0400
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:59938
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751462AbdIWTz5 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 23 Sep 2017 15:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1506196556;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=/w3lh75nHyJRroT22KSDl53HC6OvHBZUm4N8avyJHDU=;
        b=Alg0HyUPc69bd0g0xYNDyht7KrGbsnkGyM/inC1Cbn3J5j0Oj+AW4KF439Ihy207
        APCbZ0YUeeVoQ2ycw1Eb8uzI4o24cyawFkv8N8l0mfvQM65e+xkiDlpfRcpAnmQSlsg
        Tts/ZUdI9G++hr1tD3B5DWrkANqPL1lJRXJdcuNU=
From:   Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Message-ID: <0102015eb04f8927-439213ae-a464-4638-affa-f0d6484086c0-000000@eu-west-1.amazonses.com>
In-Reply-To: <CAP8UFD3tG3fOgftFJAB4mKD2N+uAH0aac4RmFmdXZ=ORHmKzQQ@mail.gmail.com>
References: <CAP8UFD3tG3fOgftFJAB4mKD2N+uAH0aac4RmFmdXZ=ORHmKzQQ@mail.gmail.com>
Subject: [PATCH v2 1/9] perf/run: add '--config' option to the 'run' script
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Sat, 23 Sep 2017 19:55:56 +0000
X-SES-Outgoing: 2017.09.23-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is error prone and tiring to use many long environment
variables to give parameters to the 'run' script.

Let's make it easy to store some parameters in a config
file and to pass them to the run script.

The GIT_PERF_CONFIG_FILE variable will be set to the
argument of the '--config' option. This variable is not
used yet. It will be used in a following commit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/run | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/t/perf/run b/t/perf/run
index beb4acc0e428d..1e7c2a59e45dc 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -2,9 +2,14 @@
 
 case "$1" in
 	--help)
-		echo "usage: $0 [other_git_tree...] [--] [test_scripts]"
+		echo "usage: $0 [--config file] [other_git_tree...] [--] [test_scripts]"
 		exit 0
 		;;
+	--config)
+		shift
+		GIT_PERF_CONFIG_FILE=$(cd "$(dirname "$1")"; pwd)/$(basename "$1")
+		export GIT_PERF_CONFIG_FILE
+		shift ;;
 esac
 
 die () {

--
https://github.com/git/git/pull/408
