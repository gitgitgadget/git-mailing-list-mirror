Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A722B207D6
	for <e@80x24.org>; Wed, 26 Apr 2017 11:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2999088AbdDZL7d (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 07:59:33 -0400
Received: from mout.gmx.net ([212.227.17.20]:61207 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1954315AbdDZL72 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 07:59:28 -0400
Received: from virtualbox ([95.208.59.147]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lr46Z-1dhe5z36Ad-00eYk3; Wed, 26
 Apr 2017 13:59:20 +0200
Date:   Wed, 26 Apr 2017 13:59:20 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>, Jeff King <peff@peff.net>
Subject: [PATCH v3 3/9] rebase -i: do not invent onelines when expanding/collapsing
 SHA-1s
In-Reply-To: <cover.1493207864.git.johannes.schindelin@gmx.de>
Message-ID: <d82ccad6fa09da821f19ca57cc6e418996e88e8c.1493207864.git.johannes.schindelin@gmx.de>
References: <cover.1493128210.git.johannes.schindelin@gmx.de> <cover.1493207864.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:93rtsOrNY6nXhMrV+6pXhf29NRV5C47LX38o3iHfHcn+0ZKCiL2
 QLxI7Dj09EZ1SD+9WmPlwrcrOwEON9HAVJyTtELeFvP/2p+W+3XTBx2EmlMVQNQFQ5ajKOW
 EjasqtP01uNyrvmJIOiJqxQn053syOIpVqDkA+TkK/ybUQW+TKS6Tt9Lpc6IbcBOrP5BFtU
 K5hzwk262pCOA3k6E9sFA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZHeevDgJoeU=:MPnqOSxSdKnga3uOO3KU4k
 OSTgE2dlREJb243StxEwHUc5tbuMyoKVEHV0t2HVidc3IbsdUgwCFpL6/slnfRVzkSOBINC9N
 BXKIED3CvB4sNDYAaWbsIKlR8CLNDjZrDXxQ2EvwyZfw000FaIMZGhyRtR0UzGgFsF9EkSR56
 UB7UoiLbXmPAFvIpKd2aJmOEz+iTz7HY2mlFSSl8+hXsDVFHQQTqUcnTyY/bp64+JeFibE81i
 Rlh8KiRSnCgbgb8qevE72+SPROv1ipX12fDXt9NTU3TnkQYkh0Vp2WGqcS9gxQCLZw35DqGiW
 nUwcpQXFo+ooqE+Pd1Q3NnXyPmHeGizJ1Yg2j0Xp0Eb7RCe0T1IRilboMYbb9OxuYJI3vyR+U
 gDZoDm2wuHqWNBDdvNE5+5kWl+1upMByPVbniWD/TkrqK0FpNAmPywS7dMeufblTjsyM/XEcA
 Y10/6QrTiFK87f7dhkJXG0sUGC6Mg4JsiD18qrmCAfW3wB8oToGgf+pm4eWrKJGrJ3jAi7nb6
 dqbywDrXivihq2MPkAD6JEdxFxOV2Z/UgssckoVe0+wfWzAE1JdwG40vbuIbMsesf87Wpg2HN
 MagJAGuiHhOa8SRTLFC6CHFacWK62QHUx9XvcgLZKL5opA5GfDI0qm7ZAlrAIDVwBh+vRD9Lv
 ESCD5gHolXv3dOlADS7WVhTE60P7RExmgc43HHpYwOizFvz5aj74ZLMJSN0ihdg6E8q5rQzae
 N6MV07dke0wjFUZhpcgNgkJWG/RHtunAbKUTXRDXXXwCsdh4ffiDQAwUQgixv+8vkrRUFilvs
 dNlP/4T
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
2.12.2.windows.2.406.gd14a8f8640f


