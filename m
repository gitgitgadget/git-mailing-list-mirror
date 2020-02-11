Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4037C3B187
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 19:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B98246A6
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 19:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bHIDUfR2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730968AbgBKTgi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 14:36:38 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52590 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730960AbgBKTgh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 14:36:37 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 190B443A5A;
        Tue, 11 Feb 2020 14:36:36 -0500 (EST)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=P8bfxmlvXDpJ+Lj7jl1I5VlIK
        WM=; b=bHIDUfR2aoIvZvHVEtuoH1MxqKiaIM7eSDllFpp8FG/9I4DLCGOAblxdC
        k7E8aiN0XFiFKOw83w+6te/1k2R1Kz7X/xhjiQ+DNKvv6YSe3YYmPdPOfMtIBHo+
        0sqRcp76F78bsJ510obTRQxp41Kq7hO9h/oCH2SmT80/xBoyMw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=HrcJc1Md7ds4ts1iUuH
        TIEK5U+HRU/M88B2xEjvzEe+o338fZosxu8aFHfi3LLfeuijf/hActPOijY2q9Wq
        mjFOPPQs7RtDPKuiEaVMjoQYHTyuJndc11LzpH23FnV8obPC7ceFpiGvknv0U//t
        f79rx43g8CNS1VH2DnEIVBhw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 065CB43A59;
        Tue, 11 Feb 2020 14:36:36 -0500 (EST)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6BD5C43A58;
        Tue, 11 Feb 2020 14:36:35 -0500 (EST)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Eyal Soha <shawarmakarma@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 3/3] color.c: alias RGB colors 8-15 to aixterm colors
Date:   Tue, 11 Feb 2020 11:36:25 -0800
Message-Id: <20200211193625.231492-4-gitster@pobox.com>
X-Mailer: git-send-email 2.25.0-453-g769eb9f0f1
In-Reply-To: <20200211193625.231492-1-gitster@pobox.com>
References: <20200121165623.151880-1-shawarmakarma@gmail.com>
 <20200211193625.231492-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: D0635D4E-4D05-11EA-9916-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eyal Soha <shawarmakarma@gmail.com>

This results in shorter output, and is _probably_ more portable. There
is at least one environment (GitHub Actions) which supports 16-color
mode but not 256-color mode. It's possible there are environments
which go the other way, but it seems unlikely.

Signed-off-by: Eyal Soha <shawarmakarma@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 color.c          | 7 ++++++-
 t/t4026-color.sh | 4 ++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/color.c b/color.c
index 0c0ec4672f..64f52a4f93 100644
--- a/color.c
+++ b/color.c
@@ -136,11 +136,16 @@ static int parse_color(struct color *out, const cha=
r *name, int len)
 		else if (val < 0) {
 			out->type =3D COLOR_NORMAL;
 			return 0;
-		/* Rewrite low numbers as more-portable standard colors. */
+		/* Rewrite 0-7 as more-portable standard colors. */
 		} else if (val < 8) {
 			out->type =3D COLOR_ANSI;
 			out->value =3D val + COLOR_FOREGROUND_ANSI;
 			return 0;
+		/* Rewrite 8-15 as more-portable aixterm colors. */
+		} else if (val < 16) {
+			out->type =3D COLOR_ANSI;
+			out->value =3D val - 8 + COLOR_FOREGROUND_BRIGHT_ANSI;
+			return 0;
 		} else if (val < 256) {
 			out->type =3D COLOR_256;
 			out->value =3D val;
diff --git a/t/t4026-color.sh b/t/t4026-color.sh
index 78c69de90a..c0b642c1ab 100755
--- a/t/t4026-color.sh
+++ b/t/t4026-color.sh
@@ -82,6 +82,10 @@ test_expect_success '0-7 are aliases for basic ANSI co=
lor names' '
 	color "0 7" "[30;47m"
 '
=20
+test_expect_success '8-15 are aliases for aixterm color names' '
+	color "12 13" "[94;105m"
+'
+
 test_expect_success '256 colors' '
 	color "254 bold 255" "[1;38;5;254;48;5;255m"
 '
--=20
2.25.0-453-g769eb9f0f1

