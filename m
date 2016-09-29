Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02FB820987
	for <e@80x24.org>; Thu, 29 Sep 2016 21:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934293AbcI2VAl (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 17:00:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65378 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934277AbcI2VAi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 17:00:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 70D46429A9;
        Thu, 29 Sep 2016 17:00:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=X0d1
        jNl5bNVG1kp4cHNdWFeNdyM=; b=tvttxeyEb3p4pSujlG4NprZnLKR1zvmrXv1/
        zbhI7Qqqw5clYR8c6XhV5fuJOUcjNg3+6iFdDa5J5IqC9cpptlg9h2+jf+Y4s0Oe
        xUEe/pJUn8ktQ4TADv+aOjb4KrgjVjaj8seEeWPXNfoFKpD0NXlXpGj0M+gniYYy
        6AcToyc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references; q=dns; s=sasl; b=DpS3gN
        Ooi6cL8SCpfKSyzbO2pXEn946mCmP2ESXk0mTDum8SJoYjOfCBwxtmfbbi+2yrL2
        TFmiAM3Lkp2LXQRUKsG9Rzfi+Nz+BJbH2o7/hXUSm20LMT1HeSKc6rfcPrqPENV3
        USDxdpW8heA6gRJmO0gfQZXKADkLBeFu6WI1A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F006429A8;
        Thu, 29 Sep 2016 17:00:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CBF1A429A7;
        Thu, 29 Sep 2016 17:00:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 8/9] worktree: honor configuration variables
Date:   Thu, 29 Sep 2016 14:00:13 -0700
Message-Id: <20160929210014.3874-9-gitster@pobox.com>
X-Mailer: git-send-email 2.10.0-589-g5adf4e1
In-Reply-To: <20160929210014.3874-1-gitster@pobox.com>
References: <20160929210014.3874-1-gitster@pobox.com>
X-Pobox-Relay-ID: C53279B6-8687-11E6-9FA7-C26412518317-77302942!pb-smtp1.pobox.com
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
 builtin/worktree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 6dcf7bd9d270..5c4854d3e4a6 100644
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
2.10.0-589-g5adf4e1

