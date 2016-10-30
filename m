Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F01802022A
	for <e@80x24.org>; Sun, 30 Oct 2016 02:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754811AbcJ3CKK convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 29 Oct 2016 22:10:10 -0400
Received: from dmz-mailsec-scanner-6.mit.edu ([18.7.68.35]:57445 "EHLO
        dmz-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754496AbcJ3CKJ (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 29 Oct 2016 22:10:09 -0400
X-AuditID: 12074423-6afff700000061af-a3-5815567e9a18
Received: from mailhub-auth-1.mit.edu ( [18.9.21.35])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by  (Symantec Messaging Gateway) with SMTP id 8C.33.25007.E7655185; Sat, 29 Oct 2016 22:10:08 -0400 (EDT)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id u9U2A5ba001638;
        Sat, 29 Oct 2016 22:10:05 -0400
Received: from localhost (buzzword-bingo.mit.edu [18.9.64.24])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id u9U2A3mB004953
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sat, 29 Oct 2016 22:10:04 -0400
Date:   Sat, 29 Oct 2016 22:10:02 -0400 (EDT)
From:   Anders Kaseorg <andersk@mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
cc:     842477@bugs.debian.org, git@vger.kernel.org,
        Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH] git-sh-setup: Restore sourcability from outside scripts
Message-ID: <alpine.DEB.2.10.1610292153300.60842@buzzword-bingo.mit.edu>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixCmqrNsQJhphsLxJzGLh3EvMFl1Xupks
        GnqvMFt0zlzC7sDicWHrJBaPi5eUPfruTmfz+LxJLoAlissmJTUnsyy1SN8ugSvj7tWDTAV3
        eCpm7Z3C2MC4mauLkZNDQsBE4v2jf8xdjFwcQgJtTBIb98+AcjYySjT/uMkKUiUksJtJYv32
        ChCbRUBb4ufCXWBxNgE1iQ9Hv4LZIkD2xLZDLCA2s0C8xLbPd5lAbGEBD4nPazqA4hwcvED2
        sxX6IGFRAV2JQ//+sIHYvAKCEidnPoFqVZc48OkiI4StLXH/ZhvbBEa+WUjKZiEpm4WkbAEj
        8ypG2ZTcKt3cxMyc4tRk3eLkxLy81CJdM73czBK91JTSTYyg0GR3Ud7B+LLP+xCjAAejEg8v
        w1uRCCHWxLLiytxDjJIcTEqivPsdRSOE+JLyUyozEosz4otKc1KLDzFKcDArifB2eQPleFMS
        K6tSi/JhUtIcLErivP/dvoYLCaQnlqRmp6YWpBbBZGU4OJQkeJNCgRoFi1LTUyvSMnNKENJM
        HJwgw3mAhv8JARleXJCYW5yZDpE/xagoJc77DCQhAJLIKM2D64WkDgeJV4ziQK8I80aArOAB
        ph247ldAg5mABqcVioAMLklESEk1MMo55oZ3b2I+PCUkhr3t9vbK9R29OxiX2vRd8eWIu6bl
        enAO86GnrU5dRu89fr13CWf27mLe2F9SLsrK01GzIlIw2Ovn/dusS3I+f1/tYHjqNPOFuitc
        DN+aTR/qyXP8rRH+uPks+/ym4qaSK2tOu0+S6MhwKOrTOXfqoZ2QU0HtqeILBiavlViKMxIN
        tZiLihMB++1r7/gCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2.10.0-rc0~45^2~2 “i18n: git-sh-setup.sh: mark strings for
translation” broke outside scripts such as guilt that source
git-sh-setup as described in the documentation:

$ . "$(git --exec-path)/git-sh-setup"
sh: 6: .: git-sh-i18n: not found

This also affects contrib/convert-grafts-to-replace-refs.sh and
contrib/rerere-train.sh in tree.  Fix this by using git --exec-path to
find git-sh-i18n.

While we’re here, move the sourcing of git-sh-i18n below the shell
portability fixes.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---

Is this a supported use of git-sh-setup?  Although the documentation is
clear that the end user should not invoke it directly, it seems to imply
that scripts may do this, and in practice it has worked until v2.10.0.

 git-sh-setup.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index a8a4576..240c7eb 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -2,9 +2,6 @@
 # to set up some variables pointing at the normal git directories and
 # a few helper shell functions.
 
-# Source git-sh-i18n for gettext support.
-. git-sh-i18n
-
 # Having this variable in your environment would break scripts because
 # you would cause "cd" to be taken to unexpected places.  If you
 # like CDPATH, define it for your interactive shell sessions without
@@ -46,6 +43,9 @@ git_broken_path_fix () {
 
 # @@BROKEN_PATH_FIX@@
 
+# Source git-sh-i18n for gettext support.
+. "$(git --exec-path)/git-sh-i18n"
+
 die () {
 	die_with_status 1 "$@"
 }
-- 
2.10.1

