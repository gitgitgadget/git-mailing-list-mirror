Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6832320A40
	for <e@80x24.org>; Tue,  5 Dec 2017 17:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752698AbdLERxA (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 12:53:00 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:41035 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752643AbdLERww (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 12:52:52 -0500
Received: by mail-it0-f65.google.com with SMTP id x28so3623658ita.0
        for <git@vger.kernel.org>; Tue, 05 Dec 2017 09:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/PWyyBKdDrJ3Ji6ooJojSWSsXDf+iDcUN+vVX8N9PMI=;
        b=OWkCrNkU98eWnmKjFS43vadf046EpiQ9UP1TPPzZhWqASE96plEiyBydzsxEvV1Ef9
         UI79Ae6dXrXuS4MqFbYakvhfSb0TUIcx6Zf6bdfBOP3S3GN9r7+xQRlRgBdWS+U7D1iP
         aP8/xgmPdZnde80nnb7j59U+mkgIkVsIsIUIqVhsFFAzNb+s8R9jbdY6hn7hwSAGyrPK
         vsTZ4uiV5xyR0PY3DufnGBamHi56GKYpVz7EE/SMMn9AXID+5srHbSAdU7VgTwq2mwOR
         XNL4D4bs6BpEoR/Pxn0lQCpOSt1goH5xoQfOdoV+fpvW2uFzhZTcq9KxWBqNVraq41Mo
         09SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/PWyyBKdDrJ3Ji6ooJojSWSsXDf+iDcUN+vVX8N9PMI=;
        b=n/rOQpwisFaKLVVRWgp1W0n4lg7k0o8SNBb2sPcRViMbVDKKXKZu6qfrJd41w0H9oQ
         yCqKdYeTjBsM6qUb9fSgSLGdHVc890+EdJnJ6KxhSa9N3mfGFPQeOnEzi7Tk1ek/RfxS
         Ng8RvuI0VNabKV1GuDvn+EMk5bl0gkUQkO2Knfz0S6Msie9er4o1KxnMUBLoRSLpKGq/
         9gPDpPciJ89Q4z2zBmunMDG5XnCshpUwJSpAXddX01O7UP5ZO32Hr6PY4AVKPTk4XF3m
         3jwNslg4rcS6Il5LNRU6V/0DSMdvn5Z6WrVNew32oWUPz6iHnhwIKh+vAGrNa6xnkzZo
         +kyQ==
X-Gm-Message-State: AJaThX7JDxWMtOlwmx85AclRh5C2bcPWuoHgJo+VEyMeNU3450gfmbtV
        /V5M1P1L++hK16MFo5fTvM4WNO+arEY=
X-Google-Smtp-Source: AGs4zMZkk4ffqPjYi+ZvnrFl1XvpJvjtWMn8N1BxYplOYfm0nX1Ee45RN8RF7MBpn0c82WyxEFZUgA==
X-Received: by 10.107.134.17 with SMTP id i17mr29169120iod.237.1512496371949;
        Tue, 05 Dec 2017 09:52:51 -0800 (PST)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id i195sm264737ioi.44.2017.12.05.09.52.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2017 09:52:51 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v3 3/9] rebase -i: set commit to null in exec commands
Date:   Tue,  5 Dec 2017 12:52:29 -0500
Message-Id: <20171205175235.32319-4-liambeguin@gmail.com>
X-Mailer: git-send-email 2.15.1.280.gbdce6e0789cb
In-Reply-To: <20171205175235.32319-1-liambeguin@gmail.com>
References: <20171127045514.25647-1-liambeguin@gmail.com>
 <20171205175235.32319-1-liambeguin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make sure commit is set to NULL when parsing exec instructions
from the todo list. If not, we may try to access an uninitialized
address later while updating the todo list.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 sequencer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sequencer.c b/sequencer.c
index fa94ed652d2c..5033b049d995 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1268,6 +1268,7 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 	bol += padding;
 
 	if (item->command == TODO_EXEC) {
+		item->commit = NULL;
 		item->arg = bol;
 		item->arg_len = (int)(eol - bol);
 		return 0;
-- 
2.15.1.280.g10402c1f5b5c

