Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B41C320282
	for <e@80x24.org>; Wed, 14 Jun 2017 13:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752559AbdFNNH4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 09:07:56 -0400
Received: from mout.gmx.net ([212.227.15.18]:61756 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752531AbdFNNHy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 09:07:54 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Ltqb7-1dmWFC3RMz-0117O9; Wed, 14
 Jun 2017 15:07:39 +0200
Date:   Wed, 14 Jun 2017 15:07:39 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v5 04/10] rebase -i: do not invent onelines when expanding/collapsing
 SHA-1s
In-Reply-To: <cover.1497444257.git.johannes.schindelin@gmx.de>
Message-ID: <4eb4ea601185225c05f391c0855d80711797a994.1497444257.git.johannes.schindelin@gmx.de>
References: <cover.1497444257.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:96VXP0wcBmY8h/2k9bEdfuoZ1krmgaBJOY9zRNEAyiMy/9xtwQG
 Oge1kGEE9uttmrP1F7JJ/6u0saqqMaNZWZaz00ZMlwt2hZvD19BEvaBhIUNjC3VNCkPPegY
 5VYYmklibhC5Ifmra/IZisr8+Xd5JvCVm8Ot+NzN/I51bz7iiKUzq0rbFlhC6u42zrJafzb
 4n+KwyMMEATqxL+NJ82Vw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nm5A0/zS+Uw=:oJFXf8eKFGUMerBWPV0xdV
 +Z5oUhQbz8+Lv/h5KGHIyWxIsEv+N1seWdEOMv/oDMRXHNlxQO1WAPZsOWYKLO9uNT5UTY7pq
 0n8tmLwSfzvJ+K0A5GLgpi/iZNAwZqOf+KVrXQGnAuiQAG/yaRlSBOlviSygIJCZ/5aOTLz8q
 62BTKeyUaKSoDJ4lMwGKm/rYxWJOxvLKKaM0fSVw2GiUYbAu7P7ibsXFidnpxCzDgr2Ijgzod
 uRVtyqSdRErQWdrLWY3fqSBLHkPLnj8CyjDz+aHBveWxMo8kuDIDE8yRZ5s0YTArsXK3q3HPw
 Pts9c+XzFOaDfz4yEszeSSKXvSuqWoKhXerxUT6lEO/ZD4JUfhTRXqnXafOR1PHIZa5PwvBNv
 x/i4vZWO1csaSRe7hDEN2QqYI6V6pRIe2NkggWcPXKxEuE1wPmcdYFs751eaTgK6NlllOpOMC
 eioFHAIBrYcrwN+wFVnLU3aRxlKoxoG2qfWGQTkaUMZtm7MZTuGUgXRQqCe+EzO4pf67wVC8S
 ZgDzfYkyA4v9avYL7DfXTQioUyZxhg3iGv6L/FJRFdR6YnbVo6RgOLEt6ARwtPBYLLl8pO/q5
 mAztm0Fn5NLgFdwvhiSgUqPmPwey4i22AC71pYFAEX/oaxa+WojXaijxKkMZRX7v7TpLIc4kD
 Jq57aVYpNrEsZf8hyyDBM1vQl+ctDsNTK4WNz5rNemG2te5/Nh7+6MCxPhfDOT/5s2Lh1Uwbl
 qzLGY1g1E/5q0XTwvWo+s9+3h7SW711/SH2yJVIvqshjsg+UIiP7YACm6rwyNWHE1YjLlYrS+
 068WuNv
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
index 93372c62b2e..9d65212b7f1 100644
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
2.13.1.windows.1.1.ga36e14b3aaa


