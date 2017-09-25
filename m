Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E38020281
	for <e@80x24.org>; Mon, 25 Sep 2017 08:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934051AbdIYIAz (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 04:00:55 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:56628 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934048AbdIYIAw (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 Sep 2017 04:00:52 -0400
X-AuditID: 1207440e-bf9ff70000007085-e8-59c8b7b36a22
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id F8.8C.28805.3B7B8C95; Mon, 25 Sep 2017 04:00:51 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCDF6.dip0.t-ipconnect.de [87.188.205.246])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8P80N6V027347
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 25 Sep 2017 04:00:49 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 11/21] mmapped_ref_iterator_advance(): no peeled value for broken refs
Date:   Mon, 25 Sep 2017 10:00:08 +0200
Message-Id: <3503719f7934556516ede5daf3197a5e8d097c1f.1506325610.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1506325610.git.mhagger@alum.mit.edu>
References: <cover.1506325610.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsUixO6iqLt5+4lIg1sXBCzWPrvDZPF8/Ql2
        i64r3UwWDb1XmC36l3exWdxeMZ/ZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4fPsZ5
        LNhU6vGsdw+jx8VLyh6fN8kFsEdx2aSk5mSWpRbp2yVwZUyfdJS14Ax7xbMfk9gaGHvYuhg5
        OSQETCQO77jN3sXIxSEksINJYsfs46wQzikmiXd3noFVsQnoSizqaWYCsUUE1CQmth1iASli
        FljJLDFp6xVWkISwQKTEvPdngIo4OFgEVCV2N/OAhHkFoiS2XbjHArFNXuLcg9vMIDangIXE
        mzNHwOYLCZhLnL9xi3UCI88CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbrGermZJXqpKaWb
        GCEhx7eDsX29zCFGAQ5GJR7eiH/HI4VYE8uKK3MPMUpyMCmJ8t7lOxEpxJeUn1KZkVicEV9U
        mpNafIhRgoNZSYT32GqgHG9KYmVValE+TEqag0VJnFdtibqfkEB6YklqdmpqQWoRTFaGg0NJ
        gnffNqBGwaLU9NSKtMycEoQ0EwcnyHAeoOHLQWp4iwsSc4sz0yHypxiNOW48vP6HiaPj5t0/
        TEIsefl5qVLivPEgpQIgpRmleXDTYGnjFaM40HPCvAtBqniAKQdu3iugVUxAq3qngq0qSURI
        STUwznF8LPL5mnIP31y/ezqSe8MP39zmrncy97LH4h+GutaPUnd3v3hS8WHWnV+s1h85r6kc
        KFolWRSry/W7X8z5mcm26EvK2W37JYX9PJ4cCU7yu/gqc+r9d/Z7WqduvZutaLyaq6Kl+oLJ
        7leflv6Y9YzvnHsfl/c7X9baCfurTNyVLwjcrT9roMRSnJFoqMVcVJwIABrh/432AgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a reference is broken, suppress its peeled value.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 312116a99d..724c88631d 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -234,9 +234,15 @@ static int mmapped_ref_iterator_advance(struct ref_iterator *ref_iterator)
 
 		/*
 		 * Regardless of what the file header said, we
-		 * definitely know the value of *this* reference:
+		 * definitely know the value of *this* reference. But
+		 * we suppress it if the reference is broken:
 		 */
-		iter->base.flags |= REF_KNOWS_PEELED;
+		if ((iter->base.flags & REF_ISBROKEN)) {
+			oidclr(&iter->peeled);
+			iter->base.flags &= ~REF_KNOWS_PEELED;
+		} else {
+			iter->base.flags |= REF_KNOWS_PEELED;
+		}
 	} else {
 		oidclr(&iter->peeled);
 	}
-- 
2.14.1

