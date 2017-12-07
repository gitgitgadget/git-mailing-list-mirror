Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C1F820C34
	for <e@80x24.org>; Thu,  7 Dec 2017 17:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756825AbdLGRat (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 12:30:49 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60141 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757023AbdLGRai (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 12:30:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DD8B6C1EE9;
        Thu,  7 Dec 2017 12:30:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=b2pn
        ShGc+IpwIGhY8BL+xOjS8XQ=; b=Oev118WjpQruIJUh/Uh4SrHdRrI/jaXvcNPV
        HGT+hMZo4VfJ6/bKxCNyh2oVb/OdYOtSRNj2KyBkzvFBEBakUsc1S134oNDE8wKN
        3k2gdTWBLQN3xwYzXO/OnrY0hK8wEcluiqVOMXo5dAW2K7rh4W6m9dgdhKsUoIEn
        kbQZzh4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        BKVrPAgOsT2B6hf5YCkSEWnyTJA9XuCUMVtvYaRtQf2573+DM6tDG2I9Dbu6Y9CR
        URmPyiLqSKP6vkEAwAgGgWjBwKtbK/tByi2dal8a9nPkXsX+RU+wPQt7Y67eu8aZ
        lnhago2YFW+LZEoK7PPWJXtHj7dyIZHgZOYo1+/4XBA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D4FAAC1EE8;
        Thu,  7 Dec 2017 12:30:37 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 43458C1EE7;
        Thu,  7 Dec 2017 12:30:37 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, peff@peff.net, jacob.e.keller@intel.com
Subject: [PATCH v2 5/7] diff: use skip-to-optional-val in parsing --relative
Date:   Thu,  7 Dec 2017 09:30:32 -0800
Message-Id: <20171207173034.12865-2-gitster@pobox.com>
X-Mailer: git-send-email 2.15.1-480-gbc5668f98a
In-Reply-To: <20171207173034.12865-1-gitster@pobox.com>
References: <20171207003517.11729-1-jacob.e.keller@intel.com>
 <20171207173034.12865-1-gitster@pobox.com>
X-Pobox-Relay-ID: 568DDAD0-DB74-11E7-89E1-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index cd032c6367..e99ac6ec8a 100644
--- a/diff.c
+++ b/diff.c
@@ -4563,11 +4563,10 @@ int diff_opt_parse(struct diff_options *options,
 		options->flags.rename_empty = 1;
 	else if (!strcmp(arg, "--no-rename-empty"))
 		options->flags.rename_empty = 0;
-	else if (!strcmp(arg, "--relative"))
+	else if (skip_to_optional_val_default(arg, "--relative", &arg, NULL)) {
 		options->flags.relative_name = 1;
-	else if (skip_prefix(arg, "--relative=", &arg)) {
-		options->flags.relative_name = 1;
-		options->prefix = arg;
+		if (arg)
+			options->prefix = arg;
 	}
 
 	/* xdiff options */
-- 
2.15.1-480-gbc5668f98a

