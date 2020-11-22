Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73573C5519F
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 20:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02D8A20789
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 20:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FO7F0/NK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgKVUeK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Nov 2020 15:34:10 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64834 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbgKVUeJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Nov 2020 15:34:09 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E5F591005DB;
        Sun, 22 Nov 2020 15:34:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AmBvaVZ525k+61iW5DJ918e0jsQ=; b=FO7F0/
        NK54ipxAkUVnfGmQ2SeYS4dH2jFsfFRt/SR9zPwckrgKsiYvFcQxAlNhHJkXkmEL
        Zp+0nVlNU5VG6Q8HHjMcSDpKtd40ice/YO7uUKdOsrHGr+FbIkM4huHpYo8hK/4s
        qpV9Vj4ykMhSufJmTSD44UXs/o25upfQVkPeg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bkvO+QXj44bHu+W09aox0RTj0sPlYCgk
        JiQRfzEgxmDXNWNpwrNdoPF0syrVKiPi+Lcgzo9egMLAsoXHI/1t+LVT1ako/S7I
        4/QajlNL/rH+2TBy/GLrwR7limuFIZ+PgB7wgLbjAEHT2X4b9t54kS0lB5+X8K2o
        1CxDffUQNCg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DE8551005DA;
        Sun, 22 Nov 2020 15:34:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 37A1E1005D9;
        Sun, 22 Nov 2020 15:34:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, peff@peff.net
Subject: Re: [PATCH 08/23] ewah: implement bitmap_or()
References: <cover.1605123652.git.me@ttaylorr.com>
        <dce9b6da0ad38da0a92b39d780d7b56f83d52950.1605123652.git.me@ttaylorr.com>
Date:   Sun, 22 Nov 2020 12:34:03 -0800
In-Reply-To: <dce9b6da0ad38da0a92b39d780d7b56f83d52950.1605123652.git.me@ttaylorr.com>
        (Taylor Blau's message of "Wed, 11 Nov 2020 14:43:03 -0500")
Message-ID: <xmqq3611qgg4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1059B772-2D02-11EB-BFE1-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> From: Jeff King <peff@peff.net>
>
> We have a function to bitwise-OR an ewah into an uncompressed bitmap,
> but not to OR two uncompressed bitmaps. Let's add it.
>
> Interestingly, we have a public header declaration going back to
> e1273106f6 (ewah: compressed bitmap implementation, 2013-11-14), but the
> function was never implemented.

So we have had decl, no impl, but it did not matter because there
was no user?  Presumably we will see a real user soon in the series
;-)

