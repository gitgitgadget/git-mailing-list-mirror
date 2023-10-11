Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A19CDB484
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 21:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376351AbjJKVmv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 17:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbjJKVmu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 17:42:50 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99423AF
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 14:42:48 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2B3CD31BDE;
        Wed, 11 Oct 2023 17:42:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=/oVtgtH2PDIxIq3JPF9QwQDFXalMyiSxpUCywD
        c1ToU=; b=R8Y4slKOs75nUPu/6xCaslkRBMme0lIFntHN0X7bG0qYYjhRP8euef
        BpStXll8312/PN8hZC/Ndq6c7V6STtq1bVzJiaZ4O+SSeBPp0NtO5wcQVeqCqO6l
        HrRNJAUeUUjA1hx3uvLGit/eLqT2cGmuaIOpwKm4Zj1fEKrZxGAWs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 22F6C31BDD;
        Wed, 11 Oct 2023 17:42:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 56E5131BDC;
        Wed, 11 Oct 2023 17:42:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com, linusa@google.com,
        calvinwan@google.com, rsbecker@nexbridge.com
Subject: Re: [PATCH v8 2/3] unit tests: add TAP unit test framework
In-Reply-To: <00d3c95a81449bf49c4ce992d862d7a858691840.1696889530.git.steadmon@google.com>
        (Josh Steadmon's message of "Mon, 9 Oct 2023 15:21:21 -0700")
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
        <cover.1696889529.git.steadmon@google.com>
        <00d3c95a81449bf49c4ce992d862d7a858691840.1696889530.git.steadmon@google.com>
Date:   Wed, 11 Oct 2023 14:42:42 -0700
Message-ID: <xmqqwmvskf8t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1C85DF06-687F-11EE-85E4-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> +	/* Initialized strbufs should always have a non-NULL buffer */
> +	if (buf->buf == NULL)
> +		return 0;

This upsets Coccinelle (equals-null).  I'll queue this on top for
now to work around CI breakage.

Thanks.

----- >8 -----
Subject: [PATCH] SQUASH???

Coccinelle suggested style fix.
---
 t/unit-tests/t-strbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/unit-tests/t-strbuf.c b/t/unit-tests/t-strbuf.c
index c2fcb0cbd6..8388442426 100644
--- a/t/unit-tests/t-strbuf.c
+++ b/t/unit-tests/t-strbuf.c
@@ -28,7 +28,7 @@ static void setup_populated(void (*f)(struct strbuf*, void*), char *init_str, vo
 static int assert_sane_strbuf(struct strbuf *buf)
 {
 	/* Initialized strbufs should always have a non-NULL buffer */
-	if (buf->buf == NULL)
+	if (!buf->buf)
 		return 0;
 	/* Buffers should always be NUL-terminated */
 	if (buf->buf[buf->len] != '\0')
-- 
2.42.0-345-gaab89be2eb

