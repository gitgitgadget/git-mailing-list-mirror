Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C29E20987
	for <e@80x24.org>; Fri, 21 Oct 2016 12:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932807AbcJUM0h (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 08:26:37 -0400
Received: from mout.gmx.net ([212.227.17.20]:57952 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754368AbcJUM0g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 08:26:36 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0M3zG2-1co17r1iGw-00rUZO; Fri, 21 Oct 2016 14:26:01
 +0200
Date:   Fri, 21 Oct 2016 14:26:00 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 20/27] sequencer: roll back lock file if write_message()
 failed
In-Reply-To: <cover.1477052405.git.johannes.schindelin@gmx.de>
Message-ID: <ff044c6d0215b9391411a953a7e114022adb4c35.1477052405.git.johannes.schindelin@gmx.de>
References: <cover.1476450940.git.johannes.schindelin@gmx.de> <cover.1477052405.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:9izpv2VGbFWE6/foaya9B4Hv4meVZXOnQCaMc4EKfMkWOf2omgQ
 zEbXlZJGOgPtPRzgphVeZpc/ameQ3Hw/rhcSJcOsdeFZJ0pMrACzqAenE1BBBnWTyLcFNXi
 TSPB76m5o4SsfLWAOjjlQmM7VREPCor7JzGdxMKcOrVEQZhlyqK3hBl4uwlRxE1HROWnQ9I
 1V3fgUvf+ghBQTNc/qsmg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2pAE6jm+qLU=:vUVqkkm4YCpamlxyPvX93s
 Bowb3wXP2gcyapWOC4tCUIz5KEevc0Ub9QCI/XSmugytxVMMLIXYrzEihNMzTrO1xOj9b67zJ
 +ySaKEIMbwoxpWMAf6eX8BUmgS9Ni8xpZYpJKNZP/e5Mr2C+kHXNlJJ39uAdDnScdCAE66w5w
 8nZYxAJXqOsLhWmtyZxotn6n7OgCZqAJdt0KSgWy7u9+7JxajZSTR76GOdGy75+C0EklxClj0
 IDwlt+g30xFYni9vaqYa5WvIrBIoco6bF6MuoITLwD71fM43NoPDlRuKhj4f/O4xCTYqRlJZY
 mmBdmavBiQIoc5rfQ48cRwRcH9ymbcjpUu9Qf4AAuBB5/arTqJ705iKbhek1VII2ihJudw/o2
 MYOwFvAyiFOpbG0geYFzAkiIWzm5alfb0AhO5DPyjcqNmT3Ibpb4mTb92+VhMmhdz9VfNu5bZ
 QFWbUP2kJdZG6LfD1ELNF2R+K22jg9qrdMYU2XNxrpQgvyLj3/UnRXFU9K6AI+a1S2xmPyWLI
 xfoi83lihTnvfzJiSVmCiMJbFckIKyXKBNdUYu5kdjAD59sA5xfI+csHDNyDk9I0EkBozymo0
 aGn9diYln4wM8475SDJ/QWnaL4lPNu1paphsnTC8Za1QgJNiVdhkJqHI/RD77J7DhV9jbDRwi
 sc/oqQ43uZI3NLKYlsZF6IRmXeItUc4Yvw1qMVCfXPe6wT0lfqIne3uT9YLtBo/QQSvBk1gj7
 LeUDjJT6ihHzm/3Uj0kXr+VJLcP50N4reWnymuVYm/gnr1Ti4epP7mj0/5SYWDpsLHaz1Au52
 qHbxBIH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is no need to wait until the atexit() handler kicks in at the end.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 745c86f..9fced42 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -241,10 +241,14 @@ static int write_message(struct strbuf *msgbuf, const char *filename)
 	int msg_fd = hold_lock_file_for_update(&msg_file, filename, 0);
 	if (msg_fd < 0)
 		return error_errno(_("Could not lock '%s'"), filename);
-	if (write_in_full(msg_fd, msgbuf->buf, msgbuf->len) < 0)
-		return error_errno(_("Could not write to %s"), filename);
-	if (commit_lock_file(&msg_file) < 0)
+	if (write_in_full(msg_fd, msgbuf->buf, msgbuf->len) < 0) {
+		rollback_lock_file(&msg_file);
+		return error_errno(_("Could not write to '%s'"), filename);
+	}
+	if (commit_lock_file(&msg_file) < 0) {
+		rollback_lock_file(&msg_file);
 		return error(_("Error wrapping up %s."), filename);
+	}
 
 	return 0;
 }
-- 
2.10.1.583.g721a9e0


