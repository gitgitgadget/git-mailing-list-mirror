Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F046EE49A6
	for <git@archiver.kernel.org>; Thu, 24 Aug 2023 20:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243624AbjHXUzd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Aug 2023 16:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243601AbjHXUzE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2023 16:55:04 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34DC1993
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 13:55:02 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DDA061AB4F1;
        Thu, 24 Aug 2023 16:55:01 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=20eAVldOeq8tMGTOgnR9vhish
        saUKZGgjFLPb9RIl6s=; b=qIlmTr05FtLbqnQpMGriyuWZVTS2gL6qkrRtKaqvu
        EbbiucdBwAFRaKh/jFhQrMq2RS+qFcuHSNx2sqhOmslwksjYhEmJw6U6kpzY5Iyv
        pUjHAt9IvouFlMYD0d73ubO1JsPmAfvN5VX8OqsWf1G38xiCnBhz9gMY412dgwAJ
        ME=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 91FE41AB4EF;
        Thu, 24 Aug 2023 16:55:01 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4E8AA1AB4EE;
        Thu, 24 Aug 2023 16:55:00 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 2/4] rerere: fix comment on handle_file() helper
Date:   Thu, 24 Aug 2023 13:54:54 -0700
Message-ID: <20230824205456.1231371-3-gitster@pobox.com>
X-Mailer: git-send-email 2.42.0-29-gcd9da15a85
In-Reply-To: <20230824205456.1231371-1-gitster@pobox.com>
References: <20230824205456.1231371-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 7D99244A-42C0-11EE-A72E-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The return value from handle_path() is returned to the caller of
handle_file() in the normal cases, and it is not the number of
hunks. It is just a normal C Boolean, "do we (!=3D0) or do we not (0)
have conflict?" plus "a negative return value signals an error".

And all the callers of handle_file() understands its return value as
such.  Update the comment to match the reality after 221444f5
(rerere: only return whether a path has conflicts or not,
2018-08-05), which apparently forgot to update this comment when it
turned the returned value of this function from the number of
conflict hunks to a boolean plus error.

Signed-off-by: Junio C Hamano <gitster@pobox.com>

---
cc: Thomas Gummerer <t.gummerer@gmail.com>
---
 rerere.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rerere.c b/rerere.c
index 73cdc8392f..4ce1270a94 100644
--- a/rerere.c
+++ b/rerere.c
@@ -454,7 +454,7 @@ static int handle_path(unsigned char *hash, struct re=
rere_io *io, int marker_siz
=20
 /*
  * Scan the path for conflicts, do the "handle_path()" thing above, and
- * return the number of conflict hunks found.
+ * return true iff conflict hunks were found.
  */
 static int handle_file(struct index_state *istate,
 		       const char *path, unsigned char *hash, const char *output)
--=20
2.42.0-29-gcd9da15a85

