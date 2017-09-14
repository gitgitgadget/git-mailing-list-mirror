Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2852E20A21
	for <e@80x24.org>; Thu, 14 Sep 2017 13:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbdINNPk (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 09:15:40 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:56961 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751305AbdINNPh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 09:15:37 -0400
Received: from localhost ([130.75.46.4]) by mrelayeu.kundenserver.de (mreue004
 [212.227.15.167]) with ESMTPSA (Nemesis) id 0Ly8sz-1dP2xj0rsD-015ZUr; Thu, 14
 Sep 2017 15:15:30 +0200
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     Ekelhart Jakob <jakob.ekelhart@fsw.at>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH 3/3] merge-base: find fork-point outside partial reflog
Date:   Thu, 14 Sep 2017 15:15:20 +0200
Message-Id: <f16c671b268432199a0b2e0d22bb1b786a44bb2a.1505394278.git.git@grubix.eu>
X-Mailer: git-send-email 2.14.1.712.gda4591c8a2
In-Reply-To: <68633b20-9e2b-ae23-2ede-8728283250f0@grubix.eu>
References: <68633b20-9e2b-ae23-2ede-8728283250f0@grubix.eu>
In-Reply-To: <cover.1505394278.git.git@grubix.eu>
References: <cover.1505394278.git.git@grubix.eu>
X-Provags-ID: V03:K0:S81EBAtUsIbfguWbRPz2g07B2NCIjyc6SxVtL5nYMANAeHuU2//
 Fd2E4NEjad72ar1qQLt4o37QXUlDX+E5KjubrOtYFLRB3Id7BmHio/V7YXhoVrr36MK+rqw
 ByHcXUiJl5mNzl6SMhGGISUMBh2bp5Wu1oaMDDv8s3SQn+UWM1/jlOJPXy84Xwhi91Vf7xa
 49IQ620noq6uM2YqmoOmQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1zQ/EKx4Lgk=:j+26UXhGH/iHj757+kY/FX
 C+AtxjXzBdQY9/op7j3cqi8AzlsJIs3vzAZY9RanrWSWNfPaxr1oJbG8VF7h06b39ju1yEISm
 q98cisdKbS+QYe0S2935QxXjqs9MBj9fXLu0Jfqs7o3uErg0cxMynxg030Pfd9vLwZNd4wpbr
 2QGOzqCAkCz/8cJXckzWkUnJeFUdLItLf2lsTtLvjQsbqrkAcTc8NDM9OpgHGNfXFx9lL6x/m
 gNHmsdv3jZ4SvF+dsvn25QSzOMAZwRFnNjQzQTxE/v8e0RkQSZXnNaLk8dPbr65gaj9q2CCOI
 HUOT1e9T04DneTh2y6pIH7Dd8IxbyOtfOdp5xBZ/hfL2/5VxPeZUNttvF2tB0KPgxVoTcAvxV
 3HD9M1HoZIWLazHGUW5cmeMd7ETCgePWE1AxA1N6RJCw7X5QVLOFfT+0Brw/0t97rbEzEj+RE
 NUArpFH8wTmoSp1KgAgtwZQ7w2dLiRUoMPOKpzxnQRjvwVpBEfzHfDyelxrsO2lM05gGPXXA5
 Ca6BXwTew7GUqTRkCIRhlk/LY2PgShNDAN+xemYJOlATWffbk5I9kjifGBSTJvV7B1ZIIZD6r
 +qfDONejFLKAbjjGwJLltuaPAaa1UkWdgG4S3UIGlkTTl4BK2IIdy7SofCy3iFbSOqNVFOnRO
 5TQkz/OHOTmhxxoDCTR9UeKi2WrH4rL2ccleODreq0lUPNVRDp4LspcmXrsBHjCn5Cjba0ZJn
 t7czZaHN1VAJ3tk15blfVVF5xkkvM4jy9TBneg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In fork-point mode, merge-base adds the commit at refname to a list of
candidates to walk from only when the reflog is empty. Therefore, it
fails to find merge bases that are descendants of the most recent reflog
entry.

Add the commit at the tip unconditionally so that a merge base on the
history of refname is found in any case, independent of the state of the
reflog.

Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 builtin/merge-base.c  | 2 +-
 t/t6010-merge-base.sh | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 926a7615ea..b5b4cf7eac 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -174,7 +174,7 @@ static int handle_fork_point(int argc, const char **argv)
 	revs.initial = 1;
 	for_each_reflog_ent(refname, collect_one_reflog_ent, &revs);
 
-	if (!revs.nr && !get_oid(refname, &oid))
+	if (!get_oid(refname, &oid))
 		add_one_commit(&oid, &revs);
 
 	for (i = 0; i < revs.nr; i++)
diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
index 850463d4f2..78342896c7 100755
--- a/t/t6010-merge-base.sh
+++ b/t/t6010-merge-base.sh
@@ -275,6 +275,14 @@ test_expect_success '--fork-point works with merge-base outside reflog' '
 	test_cmp expect actual
 '
 
+test_expect_success '--fork-point works with merge-base outside partial reflog' '
+	git -c core.logallrefupdates=true branch partial-reflog base &&
+	git rev-parse no-reflog >.git/refs/heads/partial-reflog &&
+	git rev-parse no-reflog >expect &&
+	git merge-base --fork-point partial-reflog no-reflog >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'merge-base --octopus --all for complex tree' '
 	# Best common ancestor for JE, JAA and JDD is JC
 	#             JE
-- 
2.14.1.712.gda4591c8a2

