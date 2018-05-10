Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D04301F42E
	for <e@80x24.org>; Thu, 10 May 2018 09:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934089AbeEJJwX convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 10 May 2018 05:52:23 -0400
Received: from plockton.cent.gla.ac.uk ([130.209.16.75]:59761 "EHLO
        plockton.cent.gla.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756984AbeEJJwU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 05:52:20 -0400
X-Greylist: delayed 2744 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 May 2018 05:52:19 EDT
Received: from cas08.campus.gla.ac.uk ([130.209.14.165])
        by plockton.cent.gla.ac.uk with esmtp (Exim 4.72)
        (envelope-from <John.W.Marshall@glasgow.ac.uk>)
        id 1fGhX0-0003M5-7q
        for git@vger.kernel.org; Thu, 10 May 2018 10:06:34 +0100
Received: from pc228-127.tcrc.gla.ac.uk (130.209.228.127) by
 cas08.campus.gla.ac.uk (130.209.14.165) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 10 May 2018 10:06:33 +0100
Date:   Thu, 10 May 2018 10:06:25 +0100
From:   John Marshall <John.W.Marshall@glasgow.ac.uk>
To:     <git@vger.kernel.org>
CC:     John Marshall <John.W.Marshall@glasgow.ac.uk>
Subject: [PATCH] completion: add diff --color-moved and config diff.colorMoved
Message-ID: <20180510090625.GA60244@pc228-127.tcrc.gla.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Originating-IP: [130.209.228.127]
X-ClientProxiedBy: cas07.campus.gla.ac.uk (130.209.14.164) To
 cas08.campus.gla.ac.uk (130.209.14.165)
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Complete the --color-moved option wherever we complete --diff-algorithm.

Signed-off-by: John Marshall <John.W.Marshall@glasgow.ac.uk>
---
Complete this recently-added option in a slightly over-the-top number of
places. Patch based on the maint branch.

Cheers,

    John

 contrib/completion/git-completion.bash | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b09c8a236..4e09aebd0 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1383,9 +1383,12 @@ __git_diff_algorithms="myers minimal patience histogram"

 __git_diff_submodule_formats="diff log short"

+__git_diff_colormoveds="no default plain zebra dimmed_zebra"
+
 __git_diff_common_options="--stat --numstat --shortstat --summary
-                       --patch-with-stat --name-only --name-status --color
-                       --no-color --color-words --no-renames --check
+                       --patch-with-stat --name-only --name-status
+                       --color --no-color --color-moved --no-color-moved
+                       --color-words --no-renames --check
                        --full-index --binary --abbrev --diff-filter=
                        --find-copies-harder --ignore-cr-at-eol
                        --text --ignore-space-at-eol --ignore-space-change
@@ -1406,6 +1409,10 @@ _git_diff ()
        __git_has_doubledash && return

        case "$cur" in
+       --color-moved=*)
+               __gitcomp "$__git_diff_colormoveds" "" "${cur##--color-moved=}"
+               return
+               ;;
        --diff-algorithm=*)
                __gitcomp "$__git_diff_algorithms" "" "${cur##--diff-algorithm=}"
                return
@@ -1702,6 +1709,10 @@ _git_log ()
                __gitcomp "full short no" "" "${cur##--decorate=}"
                return
                ;;
+       --color-moved=*)
+               __gitcomp "$__git_diff_colormoveds" "" "${cur##--color-moved=}"
+               return
+               ;;
        --diff-algorithm=*)
                __gitcomp "$__git_diff_algorithms" "" "${cur##--diff-algorithm=}"
                return
@@ -2165,6 +2176,10 @@ _git_config ()
                        "
                return
                ;;
+       diff.color[Mm]oved)
+               __gitcomp "false true $__git_diff_colormoveds"
+               return
+               ;;
        diff.submodule)
                __gitcomp "log short"
                return
@@ -2393,6 +2408,7 @@ _git_config ()
                credential.username
                credentialCache.ignoreSIGHUP
                diff.autorefreshindex
+               diff.colorMoved
                diff.external
                diff.ignoreSubmodules
                diff.mnemonicprefix
@@ -2741,6 +2757,10 @@ _git_show ()
                        " "" "${cur#*=}"
                return
                ;;
+       --color-moved=*)
+               __gitcomp "$__git_diff_colormoveds" "" "${cur##--color-moved=}"
+               return
+               ;;
        --diff-algorithm=*)
                __gitcomp "$__git_diff_algorithms" "" "${cur##--diff-algorithm=}"
                return
--
2.17.0


[University of Glasgow: The Times Scottish University of the Year 2018]
