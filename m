Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C3941F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 23:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755013AbcI1XeG (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 19:34:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53121 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754297AbcI1Xa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 19:30:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A68543183;
        Wed, 28 Sep 2016 19:30:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=vV8B
        BVoA5KGhtwHLSAip/2FFISA=; b=nWSuwGljs6F4X4oKarvMV8ykQK3pnBCBIdHZ
        NluynusqZEFrGxgppTTo6VrkGRsa8fzV4KGjTdXQX6/54QcHs8LbER7fX0lZLOpQ
        30h4GSxlxCfYstotSkCyyDy3lZ+SMKAkzvADCFSUNZnhn9fWhUTzCIq+aTgcBdnu
        NzIBdb0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        YoRQ6ja699QOaTHKEgTrxOi/hN2URC0tcwfuzyvXml1pmjbZ2zv0b187SV1vQlaR
        lL+zrEpn7pakvE5rr5AuEKG0A4kPld3SP3WusfGzACIPhkUoSJ7iQYUC7gU68zcO
        kGJixTl6OlNiVTQl4pdKgWP3REgI0x3L7j+ypLgKp04=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4361243182;
        Wed, 28 Sep 2016 19:30:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BB3D643181;
        Wed, 28 Sep 2016 19:30:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, torvalds@linux-foundation.org
Subject: [PATCH 3/4] worktree: honor configuration variables
Date:   Wed, 28 Sep 2016 16:30:46 -0700
Message-Id: <20160928233047.14313-4-gitster@pobox.com>
X-Mailer: git-send-email 2.10.0-584-gc9e068c
In-Reply-To: <20160928233047.14313-1-gitster@pobox.com>
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
 <20160928233047.14313-1-gitster@pobox.com>
X-Pobox-Relay-ID: 9B150806-85D3-11E6-8E5D-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The command accesses default_abbrev (defined in environment.c and is
updated via core.abbrev configuration), but never makes any call to
git_config().  The output from "worktree list" ignores the abbrev
setting for this reason.

Make a call to git_config() to read the default set of configuration
variables at the beginning of the command.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is already queued separately from this series.

 builtin/worktree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 6dcf7bd..5c4854d 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -528,6 +528,8 @@ int cmd_worktree(int ac, const char **av, const char *prefix)
 		OPT_END()
 	};
 
+	git_config(git_default_config, NULL);
+
 	if (ac < 2)
 		usage_with_options(worktree_usage, options);
 	if (!prefix)
-- 
2.10.0-584-gc9e068c

