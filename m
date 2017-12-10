Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C98601F406
	for <e@80x24.org>; Sun, 10 Dec 2017 00:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751263AbdLJAIW (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Dec 2017 19:08:22 -0500
Received: from avasout04.plus.net ([212.159.14.19]:45572 "EHLO
        avasout04.plus.net.plus.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751073AbdLJAIV (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 9 Dec 2017 19:08:21 -0500
Received: from [10.0.2.15] ([80.189.70.158])
        by smtp with ESMTPA
        id NpAHejkEUzbmWNpAIeQ6Dp; Sun, 10 Dec 2017 00:08:19 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=P6pKvmIu c=1 sm=1 tr=0
 a=bpDj9VLvXCYHU65eeb/Fiw==:117 a=bpDj9VLvXCYHU65eeb/Fiw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=5rxgeBVgAAAA:8 a=FEwn8AxFsdz831qadf8A:9
 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22 a=PwKx63F5tFurRwaNxrlG:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] sequencer: make sign_off_header a file local symbol
Message-ID: <8caabe3e-4dc3-657a-236d-6cf91e1e6d03@ramsayjones.plus.com>
Date:   Sun, 10 Dec 2017 00:08:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLRLXDI9nQoNwGiurYWPKy4+ZTV2mwfwEVUIJVuFIYA9XfxsJbZ9eKYvZut1MX7pqYozk/cmQytKCnOmKuOYjPejl/+CKdPgQ/MKX8rZYl9bp7EowB7R
 2knniI/+a3Hi4Q6kAES4C3AvC/RMixAHxqoLmVu7rLf1q8AXkOHM5ZqBcZJU0BSk27OA5aFpXNdiFw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Commit d0aaa46fd3 ("commit: move empty message checks to libgit",
2017-11-10) removes the last use of 'sign_off_header' outside of
the "sequencer.c" source file. Remove the extern declaration from
the header file and mark the definition of the symbol with the
static keyword.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Junio,

Now that the 'pw/sequencer-in-process-commit' branch has
graduated to 'next', the static-check.pl script is barking on
that branch. This patch applies to the next (and pu) branches
without conflict. You mentioned that the previous version of
this patch (see [1]) conflicted with an in-flight patch series.
('ot/pretty' and 'lb/rebase-i-short-command-names' have nearby
changes, but don't conflict).

Was this an 'not in any integration branch, but I'm still holding
onto it' topic branch? If it is still a problem, please just ignore
this patch.

Thanks!

[1] https://public-inbox.org/git/%3Cd9d05477-5d2f-04fc-adee-10d18bc0947d@ramsayjones.plus.com%3E/

ATB,
Ramsay Jones


 sequencer.c | 2 +-
 sequencer.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 0f17b4d32..8c2af94ed 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -26,7 +26,7 @@
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
-const char sign_off_header[] = "Signed-off-by: ";
+static const char sign_off_header[] = "Signed-off-by: ";
 static const char cherry_picked_prefix[] = "(cherry picked from commit ";
 
 GIT_PATH_FUNC(git_path_seq_dir, "sequencer")
diff --git a/sequencer.h b/sequencer.h
index 77cb174b2..688b0276d 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -53,8 +53,6 @@ int check_todo_list(void);
 int skip_unnecessary_picks(void);
 int rearrange_squash(void);
 
-extern const char sign_off_header[];
-
 void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag);
 void append_conflicts_hint(struct strbuf *msgbuf);
 int git_sequencer_config(const char *k, const char *v, void *cb);
-- 
2.15.0
