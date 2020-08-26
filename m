Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EC9C433DF
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 01:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30FFF2078A
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 01:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZlbRakK7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgHZBRa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 21:17:30 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55282 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgHZBR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 21:17:27 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 89D2BE64AC;
        Tue, 25 Aug 2020 21:17:25 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=AZA8eK+RMPJ/B0VPtL6OkzKSA
        EQ=; b=ZlbRakK7qU6MjSZMKH+8XxQOAM4Ev/yXKWkSRP4WzYcrYZXdU6xv4/Cc/
        RXvLOWLCrFLypwknAb8/3XbqqIkLmcTCC66vUP3xFZkzuFCym8RZHXCsJhLEZv5L
        0d/+81i2KsBRbd2WT3nAd7sqJ5gjuIED1yl3IenFy46sSHpw7U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=BCCqiM+vilKm1i4e/mJ
        OdKba7CIbXMZ1UsK9MV3fKaukStSsBoKCZbdFDguXg0X0JB++ryGWy/vBSBVMyq+
        enWHCctt31xiKYuMzvkDewqpUTpPBVNs/3g5wCJ3YsB1ofXya3hphkHkPhbpoWsE
        mzudQAazvhSKEeqHiOhf1chA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6AA86E64AB;
        Tue, 25 Aug 2020 21:17:25 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E2BC1E64AA;
        Tue, 25 Aug 2020 21:17:22 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v1 1/3] transport-helper: do not run git-remote-ext etc. in dashed form
Date:   Tue, 25 Aug 2020 18:17:16 -0700
Message-Id: <20200826011718.3186597-2-gitster@pobox.com>
X-Mailer: git-send-email 2.28.0-454-g5f859b1948
In-Reply-To: <20200826011718.3186597-1-gitster@pobox.com>
References: <xmqq1rjuz6n3.fsf_-_@gitster.c.googlers.com>
 <20200826011718.3186597-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: E5013D9C-E739-11EA-A9D9-843F439F7C89-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Runing them as "git remote-ext" and letting "git" dispatch to
"remote-ext" would just be fine and is more idiomatic.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 transport-helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index defafbf4c1..fae3d99500 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -128,7 +128,8 @@ static struct child_process *get_helper(struct transp=
ort *transport)
 	helper->in =3D -1;
 	helper->out =3D -1;
 	helper->err =3D 0;
-	strvec_pushf(&helper->args, "git-remote-%s", data->name);
+	strvec_push(&helper->args, "git");
+	strvec_pushf(&helper->args, "remote-%s", data->name);
 	strvec_push(&helper->args, transport->remote->name);
 	strvec_push(&helper->args, remove_ext_force(transport->url));
 	helper->git_cmd =3D 0;
--=20
2.28.0-454-g5f859b1948

