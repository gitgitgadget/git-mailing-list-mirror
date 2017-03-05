Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C7812013E
	for <e@80x24.org>; Sun,  5 Mar 2017 16:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752669AbdCEQS6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Mar 2017 11:18:58 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:35928 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752638AbdCEQS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Mar 2017 11:18:57 -0500
Received: by mail-qk0-f172.google.com with SMTP id 1so121582189qkl.3
        for <git@vger.kernel.org>; Sun, 05 Mar 2017 08:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=SSWrqS9BqpEfCuYoL1kUqMKu3YCbOPzOnkQIRolQcXc=;
        b=R3XBmFVSKqPhHibbhKQL2gMoMVY5XiLOzUbr6YriX+Mcky1n/NITk6GW+BPM54HYgT
         2F8yFS+LK8+KRC2on5jiEctpjWBDd2zZeUi3xjU/nxwRVAy4k8DCqYIZ8Z9idjRTN+iR
         si4OlcQbXlBsYg1CW678Nn9s+70GZKn+Gs/SVJwO8tZimwUqonn7nm/F0ZxgZIHJPRqx
         5U7OKnskleEJ713u19x3uxdB3iHE53NpmhuOMYFEIG/h573RBWLAY7uH0yfWDEWKkAQu
         h76VUWAdjKIZlz8v4Oya0DlaOG0VRNRJm4vpumtbM5/liFs+Z48uxjpptj3j4zT6J9P1
         8FAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=SSWrqS9BqpEfCuYoL1kUqMKu3YCbOPzOnkQIRolQcXc=;
        b=ZOSclSjo0Gc9PhkZJtwwZ9EKOuiGHawTUsHyaVQRc8vY3kp2Y3klmAQmw6dOqXvTNS
         kq6/ckM2uTazKAqnd7jcn4oDCB8/845tP/VXr59HoBN7Sf1cok8RqKX70Ip/uUo5FyKn
         k6uaLZj7HkQKy3n/ttCAmDkqe1XPJD3K7IQLMkcfEn6pkID+iOV91JexDTB3qpxMDC4J
         cJQWaqAjTLDms0IQIwvkAOqM5oJnsUUoONuVsquopAyBxN8Ba7gl4mdkNDpajfHgiWHX
         3K6YCR1J1Xp1OMuU2yNtT7v6g0Qa+ISreWqITL8kcOPivXPUmKRWbk9Bi7v3ApL22SVo
         2Paw==
X-Gm-Message-State: AMke39netyix5ffSO4YRIVr4eTLqwkIiZy6sCvbOJlAiPa1QYEvIRLgiaNgS9GiaNhW3D3TCWBlryiYMGQovYQ==
X-Received: by 10.55.54.143 with SMTP id d137mr11647579qka.258.1488730735328;
 Sun, 05 Mar 2017 08:18:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.52.6 with HTTP; Sun, 5 Mar 2017 08:18:54 -0800 (PST)
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Sun, 5 Mar 2017 10:18:54 -0600
Message-ID: <CAOc6etbwE3wyVEUKJq8WCPe=hYBobWo-RtDonH46XCHF157+BQ@mail.gmail.com>
Subject: difflame improvements
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

Since my last post the biggest improvement is the ability to detect
that the user has requested a "reverse" analysis.

Under "normal" circumstances a user would ask difflame to get the diff
from an ancestor (call "difflame treeish1 treeish2" so that merge-base
of treeish1 treeish2 equals treeish1). In this case the blame result
is done using straight blame output for added lines and additional
analysis to detect where a line was deleted (analysis has improved a
lot in this regard.... I haven't heard anything from Peff, though).
But if the user requests the opposite (call "difflame treeish1
treeish2" so that merge-base of treeish1 treeish2 is treeish2) then
the analysis has to be driven "in reverse".

Here's one example taken from difflame itself:

normal "forward" call (hope output doesn't get butchered):

$ ./difflame.py HEAD~3 HEAD~2
diff --git a/difflame.py b/difflame.py
index e70154a..04c7577 100755
--- a/difflame.py
+++ b/difflame.py
@@ -365,7 +365,7 @@ def get_full_revision_id(revision):
 e5b218e4 (Edmundo 2017-02-01 365)         # we already had the revision
 50528377 (Edmundo 2017-03-04 366)         return REVISIONS_ID_CACHE[revision]
 d1d11d8a (Edmundo 2017-02-02 367)     # fallback to get it from git
       b1a6693 use rev-list to get revision IDs
-b1a6693 (Edmundo 2017-03-04 368)     full_revision =
run_git_command(["show", "--pretty=%H", revision]).split("\n")[0]
+b1a66932 (Edmundo 2017-03-04 368)     full_revision =
run_git_command(["rev-list", "--max-count=1",
revision]).split("\n")[0]
 50528377 (Edmundo 2017-03-04 369)     REVISIONS_ID_CACHE[revision] =
full_revision
 e5b218e4 (Edmundo 2017-02-01 370)     return full_revision
 91b7d3f5 (Edmundo 2017-01-31 371)

"reverse" call:
$ ./difflame.py HEAD~2 HEAD~3
diff --git a/difflame.py b/difflame.py
index 04c7577..e70154a 100755
--- a/difflame.py
+++ b/difflame.py
@@ -365,7 +365,7 @@ def get_full_revision_id(revision):
 e5b218e4 (Edmundo 2017-02-01 365)         # we already had the revision
 50528377 (Edmundo 2017-03-04 366)         return REVISIONS_ID_CACHE[revision]
 d1d11d8a (Edmundo 2017-02-02 367)     # fallback to get it from git
       b1a6693 use rev-list to get revision IDs
-b1a66932 (Edmundo 2017-03-04 368)     full_revision =
run_git_command(["rev-list", "--max-count=1",
revision]).split("\n")[0]
+b1a6693 (Edmundo 2017-03-04 368)     full_revision =
run_git_command(["show", "--pretty=%H", revision]).split("\n")[0]
 50528377 (Edmundo 2017-03-04 369)     REVISIONS_ID_CACHE[revision] =
full_revision
 e5b218e4 (Edmundo 2017-02-01 370)     return full_revision
 91b7d3f5 (Edmundo 2017-01-31 371)

Notice how the revision reported in both difflame calls is the same:

$ git show b1a66932
commit b1a66932704245fd653f8d48c0a718f168f334a7
Author: Edmundo Carmona Antoranz <whocares@gmail.com>
Date:   Sat Mar 4 13:59:50 2017 -0600

   use rev-list to get revision IDs

diff --git a/difflame.py b/difflame.py
index e70154a..04c7577 100755
--- a/difflame.py
+++ b/difflame.py
@@ -365,7 +365,7 @@ def get_full_revision_id(revision):
        # we already had the revision
        return REVISIONS_ID_CACHE[revision]
    # fallback to get it from git
-    full_revision = run_git_command(["show", "--pretty=%H",
revision]).split("\n")[0]
+    full_revision = run_git_command(["rev-list", "--max-count=1",
revision]).split("\n")[0]
    REVISIONS_ID_CACHE[revision] = full_revision
    return full_revision


If this "detection" to perform reverse analysis hadn't been done, then
there wouldn't be a lot of useful information because there are no
revisions in HEAD~2..HEAD~3 and so the output would have been
something like:

diff --git a/difflame.py b/difflame.py
index 04c7577..e70154a 100755
--- a/difflame.py
+++ b/difflame.py
@@ -365,7 +365,7 @@ def get_full_revision_id(revision):
 e5b218e4 (Edmundo 2017-02-01 365)         # we already had the revision
 50528377 (Edmundo 2017-03-04 366)         return REVISIONS_ID_CACHE[revision]
 d1d11d8a (Edmundo 2017-02-02 367)     # fallback to get it from git
       b1a6693 use rev-list to get revision IDs
%b1a6693 (Edmundo 2017-03-04 368)     full_revision =
run_git_command(["rev-list", "--max-count=1",
revision]).split("\n")[0]
       e5b218e printing hints for deleted lines
+e5b218e4 (Edmundo 2017-02-01 368)     full_revision =
run_git_command(["show", "--pretty=%H", revision]).split("\n")[0]
 50528377 (Edmundo 2017-03-04 369)     REVISIONS_ID_CACHE[revision] =
full_revision
 e5b218e4 (Edmundo 2017-02-01 370)     return full_revision
 91b7d3f5 (Edmundo 2017-01-31 371)

Notice how both the added line and the deleted line are reporting the
_wrong_ revision. It should be b1a66932 in all cases.


One question that has been bugging me for a while is what to do in
cases where treeish1, treeish2 are not "direct" descendants" (as in
merge-base treeish1 treeish2 is something other than treeish1 or
treeish2). Suppose a line was added on an ancestor of treeish1 but it
hasn't been merged into treeish2. In this case if we diff
treeish1..treeish2 we will get a _deleted_ line. However analysis to
find a deleting revision in treeish1..treeish2 will fail. I'm
wondering if it would be ok in this case to blame the deleted line on
the ancestor if treeish1 where the line was _added_.

Another thing I added is the support to use tags.

Best regards!
