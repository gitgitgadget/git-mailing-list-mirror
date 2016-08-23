Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36B3A1FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 16:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753595AbcHWQOb (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 12:14:31 -0400
Received: from mout.gmx.net ([212.227.17.21]:63465 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752947AbcHWQOa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 12:14:30 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Mh9cj-1bpcM740tV-00MNbT; Tue, 23 Aug 2016 18:07:55
 +0200
Date:   Tue, 23 Aug 2016 18:07:54 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 14/15] sequencer: do not die() in do_pick_commit()
In-Reply-To: <cover.1471968378.git.johannes.schindelin@gmx.de>
Message-ID: <3b72bde2c086996166b28d9937e0b940da594a9b.1471968378.git.johannes.schindelin@gmx.de>
References: <cover.1471968378.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:U2ahpEnOmEVNkGx3h+9ssVhy3WzDw8i0S0p16SsfCpQyjnbK+tN
 EOopAGTlm7/vmg2nj29tlz6veuGy9U0GYlPVlD08PznHHAJvNCvB801YC2G990CVQGCc8Bu
 WlxfqJC9MfCuNgv9oxGIf6YjXsVpZiB2mfGgDGC2OsPCgmCeq//UzwBOgaYTEoroER8SQ/J
 xFA31cX55qImyTdmo5ykA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hvsW3V3J4Bk=:wuGXn4/WZW0cnAu3RUr71H
 iA9BfruRcOK8q79TR8WmKYtxTcmKk6SX9Cx2lGrYrQfAS/lcmxP7OKkgtUG2yccly7SQHtKf4
 ZSt1yQ5IOzVHmyX0J+oYFN2VQ5NHkpndj+ioJdJdtUCEpYhZwXMPNIHSFYT6nd6vvP6lUmyOq
 m9CiVzqzWSsjQxZukP3VMdGdIYFSVtEOef8CHn8wfNvjCFY6VtrAqtZtGHrELb3OBIdbdcwGP
 wYu2fVOv6Oc23PdC0A2oT6yxI5kIWfVi21r9XmlnoAK+DowIGB9qTFxG06nNKW50QOcaHA+0D
 rp/M1NghUmGiWN1Gq6i4L4HDJV7PsZ8pMbr52UNMayjAYygA2X3uHVKuwhqobG2OqicCrqcy/
 0VTkcs+Rm2ubxEVXmIYalklwom0MSKeqDiDVg1gEy3alMJvG7ljEnI1NNfhrCHNCkEOzT3Fct
 SsWSxyAEJoezt6Y08mfAUBDYSicxgWv6SQdawKOJeLtzk1v5P7hJ3uwg5sTUfweVK171TtKF6
 niDWrNjiz6khaYLxhiUBlHPvjf0wHB7/4tBZigFLBfpDqe4MfVvI+Z4to2kiJg/5H47QttTuP
 PbJPxbCeCtd2MBvH81il6N0NFBi6tsAmo2B+1A4Rx+U/pWixMUbIlpezaEOGn+hBrHq7yg0QE
 mxIqsVeDahRdCGnYPqYl++qBjUTbdCcJb/0CkBff37j9aIojetcbJHo7nbVT8jzM3tKqeBJ/R
 pKzEoJqfQYcdk3MvopQavztPjZ8OVUx6yx/RmpUwJ6s5BXboLQdbymX09GqSsrCAdP/NRm+6r
 DYWPzSZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 324463f..c29de64 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -589,12 +589,14 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	 * However, if the merge did not even start, then we don't want to
 	 * write it at all.
 	 */
-	if (opts->action == REPLAY_PICK && !opts->no_commit && (res == 0 || res == 1))
-		update_ref(NULL, "CHERRY_PICK_HEAD", commit->object.oid.hash, NULL,
-			   REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
-	if (opts->action == REPLAY_REVERT && ((opts->no_commit && res == 0) || res == 1))
-		update_ref(NULL, "REVERT_HEAD", commit->object.oid.hash, NULL,
-			   REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
+	if (opts->action == REPLAY_PICK && !opts->no_commit && (res == 0 || res == 1) &&
+	    update_ref(NULL, "CHERRY_PICK_HEAD", commit->object.oid.hash, NULL,
+		       REF_NODEREF, UPDATE_REFS_MSG_ON_ERR))
+		res = -1;
+	if (opts->action == REPLAY_REVERT && ((opts->no_commit && res == 0) || res == 1) &&
+	    update_ref(NULL, "REVERT_HEAD", commit->object.oid.hash, NULL,
+		       REF_NODEREF, UPDATE_REFS_MSG_ON_ERR))
+		res = -1;
 
 	if (res) {
 		error(opts->action == REPLAY_REVERT
-- 
2.10.0.rc1.99.gcd66998


