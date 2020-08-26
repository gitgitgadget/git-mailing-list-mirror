Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50326C433E1
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 19:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17587207BC
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 19:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HbpHRNG7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgHZTrB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 15:47:01 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58288 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbgHZTrA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 15:47:00 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CBC54E80D4;
        Wed, 26 Aug 2020 15:46:55 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=123IM9wycRIQZX81oRElcwg48
        WQ=; b=HbpHRNG7Y74F+VybVYp2JJnZkJdTZwOaDnQaYgKp0iI4RzIsbe3/SaQKe
        w7qT69LZAK+6iDrNk4zqe8K5wbQulFx0uRLsVqshZ8pcSQ/50f/EZmluD5fAIUEa
        KcUO7EPx/mx6rEkySbvefwQQSRrX0WOPp5RyFoz6/Q2wfa6LG4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=pizuB1daFCdRVsWMtuR
        DL0L5KIH+FAaTT7u8NsPK22H8Zi/GmqAEXuMpvdEycQn7vN/NB92bt5ogPoT4u8/
        XkJOSQDkT+n1NzeNTN9MOW/RJew2hvmedByGecIuoi71xRGMxpwM5MP2XAPIv9Sz
        QinY8/KIL6n5hjfzKvNJxfLM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C2F49E80D2;
        Wed, 26 Aug 2020 15:46:55 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 12090E80D1;
        Wed, 26 Aug 2020 15:46:52 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 1/2] transport-helper: do not run git-remote-ext etc. in dashed form
Date:   Wed, 26 Aug 2020 12:46:49 -0700
Message-Id: <20200826194650.4031087-2-gitster@pobox.com>
X-Mailer: git-send-email 2.28.0-454-g5f859b1948
In-Reply-To: <20200826194650.4031087-1-gitster@pobox.com>
References: <xmqqd03dwe2x.fsf@gitster.c.googlers.com>
 <20200826194650.4031087-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: E3E79064-E7D4-11EA-9804-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Running it as "git remote-ext" and letting "git" dispatch to
"remote-ext" would just be fine and is more idiomatic.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 transport-helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index defafbf4c1..c52c99d829 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -128,10 +128,10 @@ static struct child_process *get_helper(struct tran=
sport *transport)
 	helper->in =3D -1;
 	helper->out =3D -1;
 	helper->err =3D 0;
-	strvec_pushf(&helper->args, "git-remote-%s", data->name);
+	strvec_pushf(&helper->args, "remote-%s", data->name);
 	strvec_push(&helper->args, transport->remote->name);
 	strvec_push(&helper->args, remove_ext_force(transport->url));
-	helper->git_cmd =3D 0;
+	helper->git_cmd =3D 1;
 	helper->silent_exec_failure =3D 1;
=20
 	if (have_git_dir())
--=20
2.28.0-454-g5f859b1948

