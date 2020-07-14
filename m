Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC95BC433E2
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 07:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B19120857
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 07:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z43mND0S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgGNHpH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jul 2020 03:45:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41931 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725780AbgGNHpH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jul 2020 03:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594712706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KSiDOcYmz96KPL6hpK2DuaskU2ocj97tkOj+SHixBgs=;
        b=Z43mND0SVbX6hizcYsaCGr2wGzh5UfLLKQthYLNbk5iaBPkt0PYREoRMHvrAMufuAE6y8B
        tVkqv0FQVCPp5eVXjp85GIvdmAPYK6aPiHi+XoP880nmAFn+HYbp3TiOfAe5ewHqiTAITw
        M6f0Nx5JkFpU+3LYf4eI2TduVAkFSZw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-e8m5zAmUPo2b24dt7lv9Ng-1; Tue, 14 Jul 2020 03:45:03 -0400
X-MC-Unique: e8m5zAmUPo2b24dt7lv9Ng-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 463851080;
        Tue, 14 Jul 2020 07:45:02 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.193.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 085E15FC38;
        Tue, 14 Jul 2020 07:45:00 +0000 (UTC)
From:   Michal Privoznik <mprivozn@redhat.com>
To:     git@vger.kernel.org
Cc:     matheus.bernardino@usp.br, kolyshkin@gmail.com, gitster@pobox.com
Subject: [PATCH] completion: add show --color-moved[-ws]
Date:   Tue, 14 Jul 2020 09:44:51 +0200
Message-Id: <da0bef7b856388d7f4613c30d3a7c962ddba96b2.1594712582.git.mprivozn@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The completion for diff command was added in fd0bc175576 but
missed the show command which also supports --color-moved[-ws].

This suffers from the very same problem [1] as the referenced
commit: no comma-separated list completion for --color-moved-ws.

[1]: https://github.com/scop/bash-completion/issues/240

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---
 contrib/completion/git-completion.bash | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c21786f2fd..d23cf181ef 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2732,6 +2732,14 @@ _git_show ()
 		__gitcomp "$__git_diff_submodule_formats" "" "${cur##--submodule=}"
 		return
 		;;
+	--color-moved=*)
+		__gitcomp "$__git_color_moved_opts" "" "${cur##--color-moved=}"
+		return
+		;;
+	--color-moved-ws=*)
+		__gitcomp "$__git_color_moved_ws_opts" "" "${cur##--color-moved-ws=}"
+		return
+		;;
 	--*)
 		__gitcomp "--pretty= --format= --abbrev-commit --no-abbrev-commit
 			--oneline --show-signature --patch
-- 
2.26.2

