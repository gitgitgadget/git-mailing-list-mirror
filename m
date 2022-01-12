Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4F8C433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 19:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241933AbiALTS0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 14:18:26 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50994 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238677AbiALTSY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 14:18:24 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 053141156CE;
        Wed, 12 Jan 2022 14:18:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=O6ZsO3dDAhjwlKErvaVj0ZgIM75zmgyt4wOR8O
        cgu4E=; b=IDo6M9LSTM4CR5jaH2KgtEEDLVBgC596e33MMgVJZtyhkeyDPUX81Z
        7c2/on+eirK/5agGYcB/9A3pcwcvrHhjOaN3Kil+TzAtUBZvpoCWWwEmFSdrASAn
        uoImIqL2DnytlcEDj3ZjcvPad8xcrKYOpOSMTNVaZT8+O6ijlrkQ4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F0DB51156CD;
        Wed, 12 Jan 2022 14:18:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 59AF71156CC;
        Wed, 12 Jan 2022 14:18:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     <rsbecker@nexbridge.com>
Cc:     "'Taylor Blau'" <me@ttaylorr.com>, <git@vger.kernel.org>
Subject: Re: [BUG] Re: Git 2.35.0-rc0
References: <00fd01d80691$c87e3ad0$597ab070$@nexbridge.com>
        <Ydzw+RqR6IfbT/oM@nand.local>
        <010b01d80697$0c848770$258d9650$@nexbridge.com>
        <Ydzyv8ZCEpDDRBXT@nand.local>
        <010d01d8069e$8d330480$a7990d80$@nexbridge.com>
Date:   Wed, 12 Jan 2022 11:18:20 -0800
In-Reply-To: <010d01d8069e$8d330480$a7990d80$@nexbridge.com>
        (rsbecker@nexbridge.com's message of "Mon, 10 Jan 2022 22:51:39
        -0500")
Message-ID: <xmqqzgo0u5j7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 67D869B8-73DC-11EC-977D-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

> diff --git a/config.mak.uname b/config.mak.uname
> index a3a779327f..9b3e9bff5f 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -576,6 +576,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
>         NO_SETENV = YesPlease
>         NO_UNSETENV = YesPlease
>         NO_MKDTEMP = YesPlease
> +       NO_UNCOMPRESS2 = YesPlease
>         # Currently libiconv-1.9.1.
>         OLD_ICONV = UnfortunatelyYes
>         NO_REGEX = NeedsStartEnd
>
> Could we get that into rc1?

Sure, with an appliable patch that is properly signed off.

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
Date: Mon, 10 Jan 2022 22:51:39 -0500
From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [PATCH] build: NonStop ships with an older zlib

Notably, it lacks uncompress2(); use the fallback we ship in our
tree instead.

not-Signed-off-yet-by: Randall S. Becker <rsbecker@nexbridge.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index a3a779327f..9b3e9bff5f 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -576,6 +576,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	NO_SETENV = YesPlease
 	NO_UNSETENV = YesPlease
 	NO_MKDTEMP = YesPlease
+	NO_UNCOMPRESS2 = YesPlease
 	# Currently libiconv-1.9.1.
 	OLD_ICONV = UnfortunatelyYes
 	NO_REGEX = NeedsStartEnd
