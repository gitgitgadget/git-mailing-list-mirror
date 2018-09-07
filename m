Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0F681F404
	for <e@80x24.org>; Fri,  7 Sep 2018 22:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbeIHD1x (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 23:27:53 -0400
Received: from mout.gmx.net ([212.227.15.18]:42767 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbeIHD1x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 23:27:53 -0400
Received: from p2520la.fritz.box ([217.235.87.235]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LgZdt-1fUnEy3RUT-00nxpa; Sat, 08
 Sep 2018 00:44:33 +0200
From:   Tim Schumacher <timschumi@gmx.de>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, avarab@gmail.com,
        pclouds@gmail.com
Subject: [RFC PATCH v4 2/3] Show the call history when an alias is looping
Date:   Sat,  8 Sep 2018 00:44:29 +0200
Message-Id: <20180907224430.23859-2-timschumi@gmx.de>
X-Mailer: git-send-email 2.19.0.rc2.1.g4c98b8d69.dirty
In-Reply-To: <20180907224430.23859-1-timschumi@gmx.de>
References: <20180905085427.4099-1-timschumi@gmx.de>
 <20180907224430.23859-1-timschumi@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:95F2LPiPtTJPt6oD0k4KeKHgch/vhQIL5cwT7aLE97wRfVcTLtq
 rf2pkdUxREwTUz56YwDtKL68iywOKfhGTq2KtyeBa8a/e5Sw2z82uzbnchnzGb0mAB8xPoK
 yLT3uSIeheZjkBHxXxOHf7C8bIq6ka2Ik9Au/aiEvtXl0dSWeEkPcVsQg+jFLcwZYZYjL74
 Umo6chno/9KeAeKRyfYYg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FSodja/o1rE=:KOHVhfiAwtKs07a/ugGy0z
 Y+JgKip8OHWnODRQmzp1zoorm+nvwknm3pxx0OJD1Kk1k/9KKATCiVNXtdHXJm1o+HQPJpFVa
 Gwr4Hpf6LUz9gVhgopl/F66JHQTa+ncqw9twW3KyYZxMopi4MKU9P/heeTwROcy4g72Y+Fbxu
 heYHvO/SVffdvDE2nEqloo7hCofetiJSWtz+eWEnRH//steILSlqKVQupLM6n0ZEjz9PnFnym
 y90gPrDSncpt7BRbpRVXtwnaIH5mmamijBrWIYfgKjkI0f1KfET+UkzVsS+Mz+oJacRJFk/K1
 YrleYhRjBqy4UcCFeYrjyWrQj7YU1xi2dKbTvBqvp1hRhbSgj7KaW1hxBDllYtfKC28awt2bC
 hUOTqNNDaVile7y1qOHHuExgq3AHRnL643YYz86rYgFs60zJaxLQbj/bk8qtg9AuJZyy2mg4D
 qyBRJdOJQtBsHqLGlH1c75tZx0SFHvJZTexkKNFwvzweYqt4sZ0vbfzWB5r3mSvPXrRZPR7rJ
 fgEOTkmJ8O51rRW3Y82ZIf8X4LM6GmYjZKCUYBi7ul93BIqAyEpqicgnBtCvoFQ4CM8s5JfdE
 xf/qhzTPQzpuPlfpWkUU0yjUUonTATnkmtNJMMd2tVdUcjKf6cblbwwXjqdSFM4YMLZF5Tld+
 UTl8Movo/yzY4/WePcAYwtOQa1qnlL77OnOqoNkqGPPWA5ap2ascOS8tWezZFewC1sv4SbK0e
 iKfprOiE5dDtYhxdYvgSHDt0OeM6gkgdkcIp06v5nigDN/Uaq3L8WnQvCYE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just printing the command that the user entered is not particularly
helpful when trying to find the alias that causes the loop.

Print the history of substituted commands to help the user find the
offending alias. Mark the entrypoint of the loop with "<==" and the
last command (which looped back to the entrypoint) with "==>".

Signed-off-by: Tim Schumacher <timschumi@gmx.de>
---

I now went with Peff's suggested code and I added in an arrow that points
away from the last command (which caused the loop). A "full" arrow (i.e.
starts at the last command, goes upwards and ends at the entrypoint) would
be more obvious/better, but adding much more code just for having a
vertical line wasn't worth it for me.

 git.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/git.c b/git.c
index 15727c17f..a20eb4fa1 100644
--- a/git.c
+++ b/git.c
@@ -675,6 +675,7 @@ static int run_argv(int *argcp, const char ***argv)
 {
 	int done_alias = 0;
 	struct string_list cmd_list = STRING_LIST_INIT_NODUP;
+	struct string_list_item *seen;
 
 	while (1) {
 		/*
@@ -692,9 +693,21 @@ static int run_argv(int *argcp, const char ***argv)
 		/* .. then try the external ones */
 		execv_dashed_external(*argv);
 
-		if (unsorted_string_list_has_string(&cmd_list, *argv[0])) {
+		seen = unsorted_string_list_lookup(&cmd_list, *argv[0]);
+		if (seen) {
+			int i;
+			struct strbuf sb = STRBUF_INIT;
+			for (i = 0; i < cmd_list.nr; i++) {
+				struct string_list_item *item = &cmd_list.items[i];
+
+				strbuf_addf(&sb, "\n  %s", item->string);
+				if (item == seen)
+					strbuf_addstr(&sb, " <==");
+				else if (i == cmd_list.nr - 1)
+					strbuf_addstr(&sb, " ==>");
+			}
 			die(_("alias loop detected: expansion of '%s' does"
-			      " not terminate"), cmd_list.items[0].string);
+			      " not terminate:%s"), cmd_list.items[0].string, sb.buf);
 		}
 
 		string_list_append(&cmd_list, *argv[0]);
-- 
2.19.0.rc2.1.g4c98b8d69.dirty

