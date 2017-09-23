Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C689C20281
	for <e@80x24.org>; Sat, 23 Sep 2017 19:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751823AbdIWT4F (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 15:56:05 -0400
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:42066
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751617AbdIWTz6 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 23 Sep 2017 15:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1506196556;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=5plRyyCphWm4wlcNf7jCxK1K0BRZBwie6H0Sj425qWE=;
        b=CSvYOJiCj53Pza/WLS1BnPMfZCbkRqNAI9OgKoYrl9Q6wyNGpLLdp4zKbiZZ76YL
        ynOdntM5/74EEJld5d/KjbHRr74VJEe0G9MCwxRAjGbWbX/2U0c8iABl8Zm4wMXjY+d
        SbEDje45L2JEQXc5hQzBCW2EfwsfkxCXb9C/Qdek=
From:   Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Message-ID: <0102015eb04f8a04-b3e697a7-eb71-4453-a5ae-692b523c6e29-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015eb04f8927-439213ae-a464-4638-affa-f0d6484086c0-000000@eu-west-1.amazonses.com>
References: <0102015eb04f8927-439213ae-a464-4638-affa-f0d6484086c0-000000@eu-west-1.amazonses.com>
Subject: [PATCH v2 8/9] perf/run: show name of rev being built
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Sat, 23 Sep 2017 19:55:56 +0000
X-SES-Outgoing: 2017.09.23-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is nice for the user to not just show the sha1 of the
current revision being built but also the actual name of
this revision.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/run | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/perf/run b/t/perf/run
index cb8687bfcf98d..43e4de49ef2be 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -37,6 +37,7 @@ unpack_git_rev () {
 
 build_git_rev () {
 	rev=$1
+	name="$2"
 	for config in config.mak config.mak.autogen config.status
 	do
 		if test -e "../../$config"
@@ -44,7 +45,7 @@ build_git_rev () {
 			cp "../../$config" "build/$rev/"
 		fi
 	done
-	echo "=== Building $rev ==="
+	echo "=== Building $rev ($name) ==="
 	(
 		cd build/$rev &&
 		if test -n "$GIT_PERF_MAKE_COMMAND"
@@ -71,7 +72,7 @@ run_dirs_helper () {
 		if [ ! -d build/$rev ]; then
 			unpack_git_rev $rev
 		fi
-		build_git_rev $rev
+		build_git_rev $rev "$mydir"
 		mydir=build/$rev
 	fi
 	if test "$mydir" = .; then

--
https://github.com/git/git/pull/408
