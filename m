Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AE1220248
	for <e@80x24.org>; Fri,  1 Mar 2019 17:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388775AbfCARe7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 12:34:59 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62068 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388333AbfCARe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 12:34:58 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8AACD43195;
        Fri,  1 Mar 2019 12:34:56 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=FVCd3kzDIr78oQASlHX0wgs0+
        Ro=; b=uG0jpW5hz9OEI/Z0LIg3yIpFC9hDC3bG1rsWYuel5KkAgjbjPeTrvgJpY
        pLtD6taMNQ037ewGxWfl25tZ6tI0n7tZ3Blmgt336aTuKENxWTSUi8quOr2ceDWG
        /kG/xKzYAog7spz2kiF+CY0rL4EzlwkjAZaM29xbTYByrZWfcs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=ErZzckNHkemV4rq9ihD
        2FLjZc7Ve6IVqjc5VbkPQtWJLgqPzrIuaRB3GVK1mNIUCFzfyJgsbvppyvV0x2zJ
        Ac99BT3sLnffkuHwj6qEqJxs6tvdg+acjJs2RucAcSBgFFjDFS2jV7bxScPu8HWy
        JeSpl8aF00wWRHxvR0M9V7j4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8271643194;
        Fri,  1 Mar 2019 12:34:56 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.93.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2846C4318F;
        Fri,  1 Mar 2019 12:34:52 -0500 (EST)
        (envelope-from tmz@pobox.com)
From:   Todd Zullinger <tmz@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/3] t9902: test multiple removals via completion.commands
Date:   Fri,  1 Mar 2019 12:34:42 -0500
Message-Id: <20190301173443.16429-3-tmz@pobox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190228230506.GA20625@sigill.intra.peff.net>
References: <20190228230506.GA20625@sigill.intra.peff.net>
MIME-Version: 1.0
X-Pobox-Relay-ID: 52C41122-3C48-11E9-8FCD-EE24A11ADF13-09356542!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

6532f3740b ("completion: allow to customize the completable command
list", 2018-05-20) added the completion.commands config variable.
Multiple commands may be added or removed, separated by a space.

Demonstrate the failure of multiple removals.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 t/t9902-completion.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 3a2c6326d8..dd11bb660d 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1483,6 +1483,14 @@ test_expect_success 'git --help completion' '
 	test_completion "git --help core" "core-tutorial "
 '
=20
+test_expect_failure 'completion.commands removes multiple commands' '
+	echo cherry-pick >expected &&
+	test_config_global completion.commands "-cherry -mergetool" &&
+	git --list-cmds=3Dlist-mainporcelain,list-complete,config |
+		grep ^cherry >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'setup for integration tests' '
 	echo content >file1 &&
 	echo more >file2 &&
