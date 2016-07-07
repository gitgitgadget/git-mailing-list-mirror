Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 612EF2070D
	for <e@80x24.org>; Thu,  7 Jul 2016 15:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753108AbcGGPxE (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 11:53:04 -0400
Received: from mout.gmx.net ([212.227.17.22]:61461 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752853AbcGGPxA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 11:53:00 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LjJCt-1bqwOG2iKN-00dWhX; Thu, 07 Jul 2016 17:52:55
 +0200
Date:	Thu, 7 Jul 2016 17:52:54 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/3] rebase -i: demonstrate a bug with --autosquash
In-Reply-To: <cover.1467906747.git.johannes.schindelin@gmx.de>
Message-ID: <46a5e7960232dc89a1db7728983c8f2e6c939c69.1467906747.git.johannes.schindelin@gmx.de>
References: <cover.1467210629.git.johannes.schindelin@gmx.de> <cover.1467906747.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:r+1vYuzn0i9WEFWFIQa3XwD+E7lDViv1OY9HwlyiVLUHlLeCVZZ
 L2BLZh9CdzwDiw78vcb8y/+kq15a1eKMJz7okDZKkXEF4FV/m7zoN+5SCamD5PTpbJhSI+w
 fPsUBvRnLzkExUd/nYzhYUIu54L4ZmGdMJBY70q+zcEsVU8yvBAjMWFUenSW5Y18+pju+ph
 uXRRRfcLBKiDgc2gbinfQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:DuMW2TMoWpc=:WRhbTSnFOgkU2x9NQv7p/z
 ooMPxgiNbWslBYSsEWREpRVkwHso+6GiXqq+xQioLWEeSehm8DCmYqVNOj22LsP0iXzPTghTV
 72naU7IDHEiw9/dFBeKo2Mr4UKyOmbywvVbG4Vx95H2NaSz+Q+J5EKttbeWSf/HQOhWXWOU0S
 k/LhBCNF69d88ZxT67plfY7Nx0Yo382mhE+zpHz0fByd4y/yJlltGaglNuwGKetHof4sckJ/2
 pRYj6Qi7tbK5v747tsFaBbCIetbvO3BK5m4aElgHV6RW2Niembe6issf4Gc9DkvW5eAzXFRwm
 O2MvYPda71GxEade6fIrthZVgDDMQxXW3xJMOq4js/AiB46qjqy/vau5cd378IoWNOxkEYWsV
 yF79GrKRyJma3iwrllgC7FDLh33s94EI12zRvLx8xt/TsPrxJW+ndYGOnQqBjYU0NB1muDCcd
 vP645TJI3V+8kcNK+lXfuJx4eYMX405rVsa8OwpGrAvuDzxtTLqSP02YSXzhj//DxvAD6LEea
 KTG7f3DELSH/c74np2UA7NdK1d6S9GLIZJlgES8BZiD5GFfg5kAgO9k2Sq8HIlqWCK0yle4dF
 a4q4OpM0GrX0tZzMTUJ2xM6x+INJLhGLqMNeYGl8N9R19zLxxul539sx2y6vVIoIVKYPeS7+X
 Jy9tuusegHhup0r8jF4kzE0hQvlRU/kyeYIm8ULOJ4GVoox0Amjr4BOpyy6aFkEc0kdTKRjGa
 QmxNS0rAzVgkJuFeMm/URr0I4b2xaAH2VbBn369q7r8LDpOSbtzVAH0IZBBEID4VKRSJclVYC
 P9LVpBu
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When rearranging the edit script, we happily mistake the comment
character for a command, and the command for a SHA-1. As a consequence,
when we move fixup! and squash! commits, our logic to skip lines with
already handled SHA-1s mistakenly skips anything but the first
commented-out pick line, too.

The upcoming rebase--helper patches will address this bug, therefore we
do not need to make the current autosquash code even more complex than
it already is, just to fix this bug.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3415-rebase-autosquash.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 8f53e54..9b71a49 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -271,4 +271,28 @@ test_expect_success 'autosquash with custom inst format' '
 	test 2 = $(git cat-file commit HEAD^ | grep squash | wc -l)
 '
 
+set_backup_editor () {
+	write_script backup-editor.sh <<-\EOF
+	cp "$1" .git/backup-"$(basename "$1")"
+	EOF
+	test_set_editor "$PWD/backup-editor.sh"
+}
+
+test_expect_failure 'autosquash with multiple empty patches' '
+	test_tick &&
+	git commit --allow-empty -m "empty" &&
+	test_tick &&
+	git commit --allow-empty -m "empty2" &&
+	test_tick &&
+	>fixup &&
+	git add fixup &&
+	git commit --fixup HEAD^^ &&
+	(
+		set_backup_editor &&
+		GIT_USE_REBASE_HELPER=false \
+		git rebase -i --force-rebase --autosquash HEAD~4 &&
+		grep empty2 .git/backup-git-rebase-todo
+	)
+'
+
 test_done
-- 
2.9.0.278.g1caae67


