Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B99C433E1
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 22:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D011F20717
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 22:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IE+zS0aZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgGUWF3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jul 2020 18:05:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60204 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbgGUWF3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jul 2020 18:05:29 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 40C778324B;
        Tue, 21 Jul 2020 18:05:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iaUNm5CP4jQ6ipykbLYm+OdPNcg=; b=IE+zS0
        aZ9qXWOJPRdFGdfO6daXcgpKnLjuFMKDOMq87l7Dldu9d9/Gw9twVwKtJHJA86fm
        FFT0WwOrfGF86rhB3T1tR+G2ooHKoVAwjIwbEVjxkwbF6ThIgsV9B2zquO37lavo
        Ba4/p4w2HtV5Lo8gzfNvIdqJ+3U8gPhGCxdrw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eEjRABnh3UviOaf/TmxCT2BkasjreM8d
        0lpz1Vf16YMK4mbK/Eag82s/F9zf0LiJ62FKAiZLrI1ipZc3A6RgJQhHRI8GtROp
        OZ6CIyQbbyK0Co4uP/Txg71ti7vLmmBBtwWuH7M44DPyXwpaeX5fIoVHcorts2Uz
        Rbe5zyUKgao=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 365E78324A;
        Tue, 21 Jul 2020 18:05:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A451683249;
        Tue, 21 Jul 2020 18:05:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, chriscool@tuxfamily.org
Subject: Re: [PATCH 0/4] upload-pack: custom allowed object filters
References: <cover.1593720075.git.me@ttaylorr.com>
        <xmqqwo2w7hv4.fsf@gitster.c.googlers.com>
        <20200721202740.GA34538@syl.lan>
Date:   Tue, 21 Jul 2020 15:05:25 -0700
In-Reply-To: <20200721202740.GA34538@syl.lan> (Taylor Blau's message of "Tue,
        21 Jul 2020 16:27:40 -0400")
Message-ID: <xmqqd04o7cd6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4853A41E-CB9E-11EA-AC5A-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Aye. Am I reading that correctly that it's git clone dying with a
> SIGPIPE instead of a segfault? If so, this is what Szeder pointed out a
> little lower in the thread (tl;dr is that 'git clone' is not resilient
> to this whereas 'git fetch' is, and so we still need an `ok=sigpipe`
> somewhere in t5616).
>
> The new version that I'm preparing has these appropriately, so feel
> free to discard this until I send a new version your way...

If it is known and under control, I have nothing to worry about ;-)

Thanks.
