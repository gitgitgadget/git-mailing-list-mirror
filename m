Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 295FE20248
	for <e@80x24.org>; Sun, 17 Mar 2019 18:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfCQSQg (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 14:16:36 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56933 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfCQSQf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 14:16:35 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DFFE061177;
        Sun, 17 Mar 2019 14:16:33 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=0rvIC7fYpfxc6DKg/gv+hcNkE
        NI=; b=apUCWvzwPeXwpqQ/gFNbyqbfZRpbI2n0fb1A8ar9MzQnhwlHtuEGiVJ8H
        SFvMmmMf1m0mqrgQ20Ub9uItXTK+/PuI+AYfiJym4k9LxNQFIA16VSvaA4HeUN97
        TtAmSAFene3CnJdLQy9SYNx5WH6eH1z9FUCAdXNTA9v0LI50os=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=Jd826Vk0dQK4vLzykTN
        TSar28lu5FgWa4QahdWO5C19rKkGJR4Fw9Y5TQbtHSHpT5rSMZAjTkYTiEiXxM6e
        O0av5aofxmkyDjVkjjjcwh3fNqsKYqv5iu9NgxPG78UO3IuPQxqR0eG2CLuG8xEd
        MS0s6oI5lxr3+MeHgA69m9Hw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D95F061175;
        Sun, 17 Mar 2019 14:16:33 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.93.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5809861171;
        Sun, 17 Mar 2019 14:16:29 -0400 (EDT)
        (envelope-from tmz@pobox.com)
From:   Todd Zullinger <tmz@pobox.com>
To:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/4] t9902: test multiple removals via completion.commands
Date:   Sun, 17 Mar 2019 14:16:18 -0400
Message-Id: <20190317181620.26727-3-tmz@pobox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <CACsJy8BuR=syjT1gjTxXXKKaevzpbdRGp+je+rsX6jV96F3sbA@mail.gmail.com>
References: <CACsJy8BuR=syjT1gjTxXXKKaevzpbdRGp+je+rsX6jV96F3sbA@mail.gmail.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: C9EDA3B8-48E0-11E9-9686-EE24A11ADF13-09356542!pb-smtp21.pobox.com
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
 t/t9902-completion.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 3a2c6326d8..3f5b420bf8 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1483,6 +1483,12 @@ test_expect_success 'git --help completion' '
 	test_completion "git --help core" "core-tutorial "
 '
=20
+test_expect_failure 'completion.commands removes multiple commands' '
+	test_config completion.commands "-cherry -mergetool" &&
+	git --list-cmds=3Dlist-mainporcelain,list-complete,config >out &&
+	! grep -E "^(cherry|mergetool)$" out
+'
+
 test_expect_success 'setup for integration tests' '
 	echo content >file1 &&
 	echo more >file2 &&
