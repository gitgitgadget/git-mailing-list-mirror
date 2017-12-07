Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8360020954
	for <e@80x24.org>; Thu,  7 Dec 2017 20:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752650AbdLGUWz (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 15:22:55 -0500
Received: from mout.web.de ([212.227.15.3]:59647 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750993AbdLGUWy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 15:22:54 -0500
Received: from [192.168.178.36] ([91.20.50.52]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0ML8Az-1eMlZr2wfx-000I7K; Thu, 07
 Dec 2017 21:22:50 +0100
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] fmt-merge-msg: avoid leaking strbuf in shortlog()
Message-ID: <b2238da3-9eba-1521-f4ca-3b805f103555@web.de>
Date:   Thu, 7 Dec 2017 21:22:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:26YVqV4MwYQCbcup17WTMUEqXZ+WKwkC7PgEG2ghLsdye+7R0dm
 IOHprDEqVG93Ja/yG327qd0d8BQBTP/L8Z/qwK442X8mMaP3zUnufZQg4Dcnt8rZCZrPaKB
 8gGQpKTfN40CxWSi6CYOyH0jkLjTFcGkvvn677QOxZySX1iRU3A6lU6zxXGxMhPM8KvnwCa
 kend7Jy1MCQCJERTzV7Pw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mUT0aSuK/gw=:IMd7JdyGIh1Ab7G0gbbi2X
 nouhhLyxEK59i32Mn1yt8RAI4L5v+RaWejZMSeat8O2W5qPXjlSTYJLPC7vECPKYQ6tyhhIs+
 sPH7T8znuMurwA1NK2jZqdiciNkmfSctHgjdCsxtCEQnlxW3qa5uSKENToXBkTlqMuP8ZXRBY
 SqjglrjKzI9cSs1g7/XA/GHBVBvSpsP+ey+w3ZgnJ7kJcwNpS/KgCKNU8lBD6RPzczrTF8gzq
 uezaI5Py+1QMFVkZaxq/EurF4fKmbAnP7G+SE9eyBi0SXV0LTbo5ZlUJC5y8jAJudaxCPMdnk
 qwKsS1zOaukO5dpXkj1Trdz56wXpT+lQsWILal8qD4b+RAHusTc68WQnPT1mmYCo8eVXAxFD0
 +PxytGqLoIYtg7lKBhkNj6zkNMfQKBHwbXejv/qGQ9g2oQmcWhJIaMD4j/2w+4biYNVVBBLAl
 MA30g8BTYpUWiiWMeXWXJmhX9RLxhG1tMJsK1Bdyeiin3hIWobpIEe6hzsDWuq3vu2nK+0xQn
 CwM3xD0YV2YVmuyNb8id1RJRbHg5w7A8D5UnAIedaLIuQT4yDnfgK2c3+Yw5ViKgv3RD7TyXO
 nJfPUzZiBIvDBQCCj1ps00FzgIY/gGPdZiDMMQJThER+XU3qYa4zCIjR8UnEtU57cFlvUK/6l
 PknGpJQolfrCwfghXqyQPTSO834jR3/xSOx7cI6ZzTstT0oSKldK+xN3G2ZZ9hb99vnUo1lTi
 WA1ZGGtzSOJyKMm0/OHyI8XuIxNAanSrDj0p7pKoPmp9/SjxV4A/zVt2iZrjF1tDsoRlBSimT
 NRJioY6a7iU4DqIkrUAOAfRgvgMemf1OWT+93+VngnD/S7fJTk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use string_list_append_nodup() instead of string_list_append() to hand
over ownership of a detached strbuf and thus avoid leaking its memory.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/fmt-merge-msg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 22034f87e7..8e8a15ea4a 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -377,7 +377,8 @@ static void shortlog(const char *name,
 			string_list_append(&subjects,
 					   oid_to_hex(&commit->object.oid));
 		else
-			string_list_append(&subjects, strbuf_detach(&sb, NULL));
+			string_list_append_nodup(&subjects,
+						 strbuf_detach(&sb, NULL));
 	}
 
 	if (opts->credit_people)
-- 
2.15.1
