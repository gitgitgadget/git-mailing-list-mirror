Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB4CA207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 21:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1947846AbdD1Vc3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 17:32:29 -0400
Received: from mout.gmx.net ([212.227.15.18]:56137 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1422822AbdD1Vc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 17:32:27 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MGj8j-1dH5f705bd-00DUFO; Fri, 28
 Apr 2017 23:32:16 +0200
Date:   Fri, 28 Apr 2017 23:32:14 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 04/10] rebase -i: do not invent onelines when expanding/collapsing
 SHA-1s
In-Reply-To: <cover.1493414945.git.johannes.schindelin@gmx.de>
Message-ID: <82f415322e786479f9da2f882a2cbcef05bbe74b.1493414945.git.johannes.schindelin@gmx.de>
References: <cover.1493207864.git.johannes.schindelin@gmx.de> <cover.1493414945.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:TkwnWAX/H8Suh9jbGCk1Wd1RGtmLx3Bqtphgl8QKSj7WIZjh5QM
 jwMALbrSJzJF3KIEJ3Rtb8Qabrsd8nn7jLYBJX3G8ttrPmJHre/8q3a1Ckazi073fxOzAoW
 VlGzIgBevtLUi7B90hhc/FUqBBG+RDDw10ODHfOP73WW/h3N0Hdcq1uzangweZNJvuKVhkB
 NGCK4hSskLR1Me2pH7wXg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sqgsvO3xGxw=:q7k0pwX56obqqynCeVFFE0
 sBAz0Ny316kbX/k5LA1YlC88P/hrY12O74LE4EInenZXwzVj98Atys0XyE5CxXI8KkifR5yve
 54X/5u/WmqfzUBcb7aj/lPWvjNacK6qG7jlYvUufywHkrs0B2B13lKApdEUmV2mLOMeq7alUE
 xWlC/kWB9Ull1GDLNugRXT8HOJGOTCi/7TTYwaNJNYFIHtGOxbtpTyDK7ZtkefxWbIVNfjYpi
 vNdYqCNvJpEPdYLlabAYzfw8cNCjgVilBj3UiH5FdZrt5I/DPDR8KR/64ookK8hv/UYpS5Uyp
 Z/erAcUoIlh6TpeQlZpDDC6pi6hk0FSp10nGMjiywpWV5AcrRawlD6YI3Ni0Dapb7gz+KvfPT
 OBP8wk+RPhDXpBXSnViMoB/dFZs6CZ69c1EfPo+9d1BDTCCWj/GzB2/8rfnhD77vZ7x4bjO4h
 uwdH90+F6kXExiq5mzNINSPTeFEYd162PfExQ4O4px8iosCCljeEZgFr0GnS3KfQvZI+2Eu6o
 C9h1v2n9r6nGEtNagmv5Bx8hDOjEVYwqHHrSZDG7u3uzcedh6J3nOmw4/emKojWYxBYHf4bBJ
 UjiTySy611cdPqg3TPCvhsWLQLYzH0kbdGrepN7YJq4zc++AgPbkGQJlvhpEnDDIt70NKYpjC
 xbxO9mibTT2+0ESLgZuQctNyNTa779EdXfklgfKbnVmqtbQhlRwyFFLBd+TkxSjgP+s4pwdo4
 hzvuUzIdwyfxNrRsFtLdXNgf5QZ9ZHlC5g9pUDpjR9h4qSe56dcD5XgTxoSN9tIPaejNlH6vr
 6Bk4iOX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To avoid problems with short SHA-1s that become non-unique during the
rebase, we rewrite the todo script with short/long SHA-1s before and
after letting the user edit the script. Since SHA-1s are not intuitive
for humans, rebase -i also provides the onelines (commit message
subjects) in the script, purely for the user's convenience.

It is very possible to generate a todo script via different means than
rebase -i and then to let rebase -i run with it; In this case, these
onelines are not required.

And this is where the expand/collapse machinery has a bug: it *expects*
that oneline, and failing to find one reuses the previous SHA-1 as
"oneline".

It was most likely an oversight, and made implementation in the (quite
limiting) shell script language less convoluted. However, we are about
to reimplement performance-critical parts in C (and due to spawning a
git.exe process for every single line of the todo script, the
expansion/collapsing of the SHA-1s *is* performance-hampering on
Windows), therefore let's fix this bug to make cross-validation with the
C version of that functionality possible.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index c40b1fd1d2e..214af0372ba 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -760,7 +760,12 @@ transform_todo_ids () {
 			;;
 		*)
 			sha1=$(git rev-parse --verify --quiet "$@" ${rest%%[	 ]*}) &&
-			rest="$sha1 ${rest#*[	 ]}"
+			if test "a$rest" = "a${rest#*[	 ]}"
+			then
+				rest=$sha1
+			else
+				rest="$sha1 ${rest#*[	 ]}"
+			fi
 			;;
 		esac
 		printf '%s\n' "$command${rest:+ }$rest"
-- 
2.12.2.windows.2.800.gede8f145e06


