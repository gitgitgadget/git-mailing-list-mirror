Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C74C4332F
	for <git@archiver.kernel.org>; Tue, 13 Dec 2022 06:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbiLMGUT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Dec 2022 01:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiLMGUR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2022 01:20:17 -0500
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86341C138
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 22:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1670912410; bh=TfCsMo5WU/MwnxZvlCwFXUoiiJbJg7L9xDPdtnu9ov4=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=QvckWDggdU6J7D5a+My6tC4m0PVZDHoBPr8nn376WYTJ6gfJvbw+xEwfCGQptzCH0
         ofcPIN/hjEphnhVjswK00/SRLddSvSSEOH3buS/ddnQMzig1k0hSJMKCjHismQMr6l
         AlxbBavZDKv1ithOKrgSGIndlbqy/1fDJf9gyJK4M6Ucsn4DY4d1p3edlTY2fYj0aV
         XXGEeCZ0Ak2x0rkYCArOdWODBQVPI3MqfIticEYRl2KZbvRBSRl22vOi+EZTz5Zdud
         eKL+vxobPRwnilGrWtrLiJtbhNrJ4rK71/L3DZVWSwz7cAjIZeL2B+uIlhoOcm8qb5
         0q1DdDLiJ3IoA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MN6FV-1pO1V927sb-00J5cL; Tue, 13
 Dec 2022 07:20:10 +0100
Message-ID: <a53d4df3-4b2c-585a-e8ad-2a9b9017fb8c@web.de>
Date:   Tue, 13 Dec 2022 07:20:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] reflog: clear leftovers in reflog_expiry_cleanup()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R8H6LmkY1DLDP6gE3bYjWUGXxDTrZvgTa66uL3M3LU7ujtGQNFT
 NZi7Hiudnnf0DG+4XKszIYWZ9oPnnB0DL/d+pyWbusDTmd/1NENGLl0B0jegbUbp9fbX29B
 3Nh6dKECRD1Zwm1S01nZdSJotZww8Ii+RgohMRThrf5DLdD8YWKZx4zSlUrXjIiGAiUNIJr
 lA6lQN/4N7mqtFvFBJxrQ==
UI-OutboundReport: notjunk:1;M01:P0:Qy5xBBu3zBw=;Jamjc6n9NPrt288scm2Uj+Hyajb
 RNSn/3ITfHSn0HL5jA4ni3CwRUzEFZoEv2cln2g2pn6V5Bp04THhIN6dRP507zZEIDh60u2JA
 YrAMcWgZuKYRDL8bEUFpd8r6YIS4eOKBqPflhcp3aziwSRDEmg+56su1H6S62PuUl2vRFl3aI
 UcpeHTxpxyJdlMnZzwoketeROTGRYojpeXF4NwJzwijAE/Z76SyHEhaF1muvFrVrDGyqn0bkq
 H276LCfAoIQmdoQ3lD43XrKvZ9OP3LZvs2rUmc5WDuLkm+voq6otVtCDQca6dAiiLGdCnYY2X
 8XGYeUxsYoDlb+86GpuO7EEr15c0pUiPGGvtEe069odVOK4lAEPPEtTdemI6cWk/ForBWjKAq
 GAasa0sZQ00nN9y2QWuDrYDwy6ayxkzuIFM1voPZneyF410XkBCoJnGbtH/lDTr72h7onTcss
 QslWm12BjVm0SWH+HgQpveJoCWxjcM1WxY5zDhyyRGXfYT6zMfDA1JkPa1sI57f1quLvmgflp
 sxYeXpBVcxCKLdtSkbJxIZBpodpE4x1FP5MGgvR7Fx2NOyNFIU+S7UAUJyb5XTbDWNQ5qjNhM
 hC667BNZnpLQ/GTWw0o/9n7z8ItLqsJpztEYc1sLBNyYEnmTvmzCDlGD72GiD4veTD5YjAno1
 yyHWNwQoISqlYW5+ZEE/8wL8GJMUiZxfztXfUpgf2sycLuOcb82cZsk6U5zAMdBbR5lrTudcj
 4QXXSVTt2rfIVhhds+Wmwy2cAsvKuQb0EsB9j13Jp+jhpFUmZg2vqZxlML2eM2H/ge3a/+xRm
 tFS9YA47sxc+cq43g36A3k0jjQtCKBUH5iyQn/ccae8DDzRHeznGjSl8TLjYAe6x5evzGBtp1
 aZSLbhBWQtiUVkgEQ/nQX+JQUpcwPJaOOMEnXlpwnhgiQysfL76rm1P06fp5zNlm7NYBX45A+
 BFTjYA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

reflog_expiry_prepare() calls mark_reachable(), which recurively flags
commits as REACHABLE.  The traversal stops beyond a certain age
threshold; the boundary commits also marked as REACHABLE and put back
into mark_list at the end.  unreachable() finishes the traversal down to
the roots if necessary -- but if all interesting commits are younger
than the age threshold then only recent commits need to be visited.

When this optimization works then the boundary commits still sit there
in mark_list at the end.  Clear their REACHABLE flag and release the
commit list allocations.

While at it remove a duplicate code line from mark_reachable(); the same
flag is already set five lines up.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Formatted with -U5 for easier review.

 reflog.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/reflog.c b/reflog.c
index 78e9350e20..04630f56ec 100644
=2D-- a/reflog.c
+++ b/reflog.c
@@ -191,11 +191,10 @@ static void mark_reachable(struct expire_reflog_poli=
cy_cb *cb)
 		commit->object.flags |=3D REACHABLE;
 		if (commit->date < expire_limit) {
 			commit_list_insert(commit, &leftover);
 			continue;
 		}
-		commit->object.flags |=3D REACHABLE;
 		parent =3D commit->parents;
 		while (parent) {
 			commit =3D parent->item;
 			parent =3D parent->next;
 			if (commit->object.flags & REACHABLE)
@@ -369,10 +368,13 @@ void reflog_expiry_cleanup(void *cb_data)
 		break;
 	case UE_NORMAL:
 		clear_commit_marks(cb->tip_commit, REACHABLE);
 		break;
 	}
+	for (elem =3D cb->mark_list; elem; elem =3D elem->next)
+		clear_commit_marks(elem->item, REACHABLE);
+	free_commit_list(cb->mark_list);
 }

 int count_reflog_ent(struct object_id *ooid UNUSED,
 		     struct object_id *noid UNUSED,
 		     const char *email UNUSED,
=2D-
2.38.2
