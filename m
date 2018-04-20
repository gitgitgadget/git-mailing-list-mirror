Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 823FD1F42D
	for <e@80x24.org>; Fri, 20 Apr 2018 21:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752380AbeDTVHW (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 17:07:22 -0400
Received: from mout.gmx.net ([212.227.17.21]:39161 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752160AbeDTVHV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 17:07:21 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MO7Ca-1f6JKj2FnA-005Zvy; Fri, 20
 Apr 2018 23:07:17 +0200
Date:   Fri, 20 Apr 2018 23:07:01 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 1/4] rebase -i: demonstrate bugs with fixup!/squash! commit
 messages
In-Reply-To: <cover.1524258351.git.johannes.schindelin@gmx.de>
Message-ID: <a0ed6c98095b73e5c2475de3a3526c93f1967b94.1524258351.git.johannes.schindelin@gmx.de>
References: <CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com> <cover.1524258351.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Kn9bkjjFICYlEPzaxqBPlGHoe37He4sGmygIj1ENGhFQSHm1/lx
 WJoMb2R6xqAO4QGBc7hKMFOsJVhLEr3xJm5SmPnS98oO0cZt6q5EMewjSlK/CW9CP/cp4Rt
 98w16pA8QLGQefQdbrpjdknpOYGmR8JWlCGE5LoaPuQ/JzX5es3Pau802cv8L9wzOY4ZXRx
 i/pTJ2STTanEkYXgp5s/Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ppWJE1a2xsc=:QEPfe1qBX20L38SCUcaYs/
 f8N5UZSIi8ERMKuIALsxE+kYfT941fUDeX/ifkAW1NkXLXZ2RNE7OXkXUlIp5IZC2s/G7rkF7
 uqFINgUS7psz1M0wG4in2BGdn/ZrEFuJrENoQLW94wrG5AagzeI8lquBHKTCrk7W4z/cO2Y+l
 GUMH+XQldGLsJydiluzgMgt7YrfjjFkC19Bg/KDIhs3/i7qa2XzpwDeg5B5fgtXfxkCf8s9MX
 qLuhJpWb/ELh5ga54FqynlYczlFaoMlSTZrnQ9uBR0MGgiogscVHHVN7cYW6D4Xv3NqaX7Nmn
 +jK0NU7u3VHO+hOpvcZPFkov1CdLlHAsP1CGH40DN5XUNX6OT6L7ZDVA7V8ReMGZQsmxYc5xb
 PrcFMwCD0n3/l/pP48oWl7NPmvSbtfNiBLkrfj1SItB4vgffJF4+V3Ly7o7G+/vc+j05QB6uR
 ay+2r+jllvvOWCGGVOcgrm90KgTFonGdnsIxBeeURsM626tf1CNNjCyUrkR9/H0x+OH1kXKeB
 fXojhsJslQLrlLDm5nEW7oBpyA2wBqihNcA1Hacheq6LhJAMOcx+w90+jvfbTbC7DzsKXdGX5
 fu6VhPK16jy/UGb17nVoXhaPGekNjo61QPhEtTb5PuzLni0lothFVGF3rN1wIxUGO59MttGcC
 ewji3AE06fsrDPQ//KmgsJB5eGyxU/5XK+bza0VNBDubBQveF8cxyHrcmtEUvu5ILRNX9cBYG
 HSEnpKTdLTQLpKqIW5z5nEZstb/LEvOUJTMAuJ/3J7XYgI/cIAb3Uvhnm1W+HhjOBRWywy0Ji
 oigy0nAL01B/oFTRmbUXg3IAjOVcqS9HcQ25ABwnljjwyVRft0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When multiple fixup/squash commands are processed and the last one
causes merge conflicts and is skipped, we leave the "This is a
combination of ..." comments in the commit message.

Noticed by Eric Sunshine.

This regression test also demonstrates that we rely on the localized
version of

	# This is a combination of <number> commits

to contain the <number> in ASCII, which breaks under GETTEXT_POISON.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3418-rebase-continue.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 9214d0bb511..6ddf952b7b9 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -88,6 +88,28 @@ test_expect_success 'rebase passes merge strategy options correctly' '
 	git rebase --continue
 '
 
+test_expect_failure '--skip after failed fixup cleans commit message' '
+	test_when_finished "test_might_fail git rebase --abort" &&
+	git checkout -b with-conflicting-fixup &&
+	test_commit wants-fixup &&
+	test_commit "fixup! wants-fixup" wants-fixup.t 1 wants-fixup-1 &&
+	test_commit "fixup! wants-fixup" wants-fixup.t 2 wants-fixup-2 &&
+	test_commit "fixup! wants-fixup" wants-fixup.t 3 wants-fixup-3 &&
+	test_must_fail env FAKE_LINES="1 fixup 2 fixup 4" \
+		git rebase -i HEAD~4 &&
+
+	: now there is a conflict, and comments in the commit message &&
+	git show HEAD >out &&
+	test_i18ngrep "This is a combination of" out &&
+
+	: skip and continue &&
+	git rebase --skip &&
+
+	: now the comments in the commit message should have been cleaned up &&
+	git show HEAD >out &&
+	test_i18ngrep ! "This is a combination of" out
+'
+
 test_expect_success 'setup rerere database' '
 	rm -fr .git/rebase-* &&
 	git reset --hard commit-new-file-F3-on-topic-branch &&
-- 
2.17.0.windows.1.15.gaa56ade3205


