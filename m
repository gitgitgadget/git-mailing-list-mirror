Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E77411F461
	for <e@80x24.org>; Thu,  5 Sep 2019 22:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388876AbfIEWtJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 18:49:09 -0400
Received: from mout.gmx.net ([212.227.17.22]:57959 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730236AbfIEWtJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 18:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1567723738;
        bh=kZ4PIVq8I4HWgF5VcmvcZuxLH14THGtMwl2ooK4dPYY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=L1Vq3rtfUnKhe1p11wdvb0GkJT5+gh821FMSYCY0TnQ7/yFhMkF4HhDRzj8DBM/OV
         sHTZweljftpEHwVfHaRXpJjpY9vmXBBB+aN6kWiwBrUmtanaA//hfDtcvmucmQpZKJ
         Kd5PBa9eCP1AY7l4G5piFsQHMbyjoTVr2sP0P7H4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([88.70.128.63]) by mail.gmx.com
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MyKHc-1iMQuU08mS-00yew7; Fri, 06 Sep 2019 00:48:58 +0200
From:   Stephan Beyer <s-beyer@gmx.net>
To:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Paul Tan <pyokagan@gmail.com>, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Shawn O. Pearce" <spearce@spearce.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org
Subject: [PATCH v2 3/4] pack-objects: fix maybe-uninitialized warning for index_pos
Date:   Fri,  6 Sep 2019 00:48:32 +0200
Message-Id: <20190905224833.24913-3-s-beyer@gmx.net>
X-Mailer: git-send-email 2.23.0.43.g31ebfd7ae6.dirty
In-Reply-To: <20190905224833.24913-1-s-beyer@gmx.net>
References: <20190905224833.24913-1-s-beyer@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0Q03FKfpMFrbAPeACOKYgdFRjnuzvKhotT5noYxILPqVEz8LCXV
 7sQOeZuLlD90ZS4THjs8Y89VRHJGfVyzn7aV2FlZmo3wIUYB9pRSY38gkgKCvLR35zuHTxW
 yxQ5c/D/YXfPyDDKY0RXCjpKNkvK83wWbxitWU4J5cABKUgR8LpM/VMAV5+eS5Iwlj4defH
 ZBXxsLrFkifS1BUtFauVQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EQbrF2MI1+k=:34KHzZ1nS/inUVNI+tM9fL
 BZuKAoK73nHT32ya8kvIFmsYkCzsILSzgym7FIGjy/6GQHgESKeZz0poEf6P035D3do1rfzuq
 D6+D0PwgrB/COuV1PuWyn+FKU/OTWZ3O1sFC04WMmwMM3qFjBaP2rdePP4qWLtrsdIZa/CNDe
 WqBLPoTmK1kbO22A4lOhE+n2OjOJ3882x0qz/Gn5G8BjrwepmBiPuNp0PZVbzwzk6rGcrpqTS
 WN3t3+WZUuIGtTb4jv+xZkzfMzag+Kr+viuapXwN9QgNw1VDxl2+/7zQi2noAzm0rnPtr5dTF
 ErunfRr4xMvoVIkxTr/94wCHNVKym3C9DPHRrsyq/0WB7kHQ23iIUuA3h32UBXuqUENNyiKZZ
 XgyMSFD9RZMCCOwOjE0jMQCCYVgleARFfrpQW6nE4dA4eu7sVn+B9MPm76m9je9z34dnD8iby
 0Pnz/BV93o+LGzzE6y1i6fG2Sp1Lg8X8iFoxd+1zlUXFoQgj2pBJGZL36enCBwVuSgiwM1/Nb
 06Rw0Hx2vB8TL3EsrZW+y+8bNRSTtbqLzCkz21IgaEiCMajNCDeBn8n/i84toamArrQzksObi
 zs0glEeryEb5zWZfv32wUEMyDrTkILHrLnxEU21YfnVSE0HdKbYSLrf8x2INE9Qd957LFZzRr
 VXX/hqfLfITfY4ZP7S9AF3mO6qwrJf8dQ719VsCUofQnAcoT+oTobiSIYyZ0AWwGvp8/X95Za
 JK/r/+IBqioAxoehO8XR1cQQMEao52FQOek/vqDYi+i+qrpYhF8unpvp8VXu6MecTMddxr5sw
 FF95pbTf9JD5OQ7Rg2YNy49Vy7xY+u3nSpIyPW//uHv6X2E0B/BX8Z2T9waYBbDcFSxrw7QPN
 9sMi4p0hDbq4pLskJXvAevQwd2o3dkCV0g4/2kfGJf31p9kjyITNBOP1Bbjy85oY56fro5jJ2
 Cc6oi7BWwrnee9L9sm67jTd8odDbfxDzhnHPMuh2AVxdwiDZl4KrfetJ20LOBMKI990AgKrhF
 bWSFdQ0G2GTO7VyCZv2xQ078uFc3XSaYPdiAxmK3l+E5GOgKznr1LuGqUXrY/Ov9ZJ1Kc/cTo
 CEZ7nMrw5o842UGKu1y4Yfn3yG8EoJDYP6vZTY/NJ+Jp80chEpCa/OamIFsPHhALJL1Mqequt
 XO1vzVyIeRVIiJiN+LISukG3uCyKbCAOVF+mUm4vgOzwG+EA9TDAV4Uk569e1Fa8wS8l8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

gcc 9.2.1 with -flto shows a maybe-uninitialized warning for index_pos
in builtin/pack-objects.c's add_object_entry().  Tracking it down,
the variable should be initialized in pack_objects.c's packlist_find().

The return value of locate_object_entry_hash(), which becomes index_pos,
is either (in case of found =3D 1) the position where the (already include=
d)
OID is, or (in case of found =3D 0), index_pos is the position where the
(not yet included) OID will be after insertion (which takes place in
packlist_alloc() if the hash table is still large enough).

However, packlist_find() does not invoke locate_object_entry_hash() if
the index size is zero (which might be the case on the first run).
This is the only case where index_pos is undefined; and it is irrelevant
since the first run will increase the size of the hash table to 1024 and
then the undefined value index_pos is ignored.

This patch sets index_pos to zero on the first run to silence the warning.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
=2D--
 pack-objects.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/pack-objects.c b/pack-objects.c
index 52560293b6..726147a75d 100644
=2D-- a/pack-objects.c
+++ b/pack-objects.c
@@ -74,8 +74,11 @@ struct object_entry *packlist_find(struct packing_data =
*pdata,
 	uint32_t i;
 	int found;

-	if (!pdata->index_size)
+	if (!pdata->index_size) {
+		if (index_pos)
+			*index_pos =3D 0; /* silence uninitialized warning */
 		return NULL;
+	}

 	i =3D locate_object_entry_hash(pdata, oid, &found);

=2D-
2.23.0.43.g31ebfd7ae6.dirty

