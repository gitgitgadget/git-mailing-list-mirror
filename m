Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A30C352A3
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 06:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C8E320714
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 06:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="a8E3rfrs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgBKGIV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 01:08:21 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61440 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbgBKGIV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 01:08:21 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B6BBABCA3F;
        Tue, 11 Feb 2020 01:08:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vziw6wv5wFG3lEn8OjeEbbetYMc=; b=a8E3rf
        rsgKXiieDOfbTOcinDqNiP6pq8DFQJ6+3mGPq7MKbkfodMj5pyhS/z5h84BDLN3B
        hr+1JYM6tAzThIOR1PrMgdqN/rF4vc3zUFnWbn4gTHKTELx7wEKG8y+JUBawi2t2
        7ijTpH9kkljHgDRVlxd9LyQ0yxmaiyifv5M4o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ieM518/+O2iFRT63SWKr3u5GUEiOMGLO
        fLD6Fjv+36mVhm0FeoOILhADJALHWoEODtg1jShleCKazH+veiUQXXagj2gOvnHc
        d/se7ViCE0SDuJEzsrDzxORJK2f8heycEFQHf9yv+fSpyqvMwqsV1OGW7FjUBMzH
        Rcw/hlQMdF4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AF3C3BCA3E;
        Tue, 11 Feb 2020 01:08:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DB4CDBCA3C;
        Tue, 11 Feb 2020 01:08:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heba Waly <heba.waly@gmail.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] advice: refactor advise API
References: <pull.548.git.1581311049547.gitgitgadget@gmail.com>
        <xmqqeev2xdq8.fsf@gitster-ct.c.googlers.com>
        <CACg5j26RAEdABySzpDEYmo4m+HDPn9jNDP087d3K9gCro4m-Sg@mail.gmail.com>
Date:   Mon, 10 Feb 2020 22:08:15 -0800
In-Reply-To: <CACg5j26RAEdABySzpDEYmo4m+HDPn9jNDP087d3K9gCro4m-Sg@mail.gmail.com>
        (Heba Waly's message of "Tue, 11 Feb 2020 15:01:33 +1300")
Message-ID: <xmqqa75py7u8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E599BE90-4C94-11EA-A70E-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heba Waly <heba.waly@gmail.com> writes:

> On Tue, Feb 11, 2020 at 11:46 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>>
>> As I outlined in [1], I think the over-simplified
>> "advise_ng(<advise.key>, _(<message>), ...)"  would be too limited
>> to replace the current users, without a pair of helper functions,
>> one to just check for the guarding advise.key, and the other to
>> unconditionally show the message (i.e. the latter is what the
>> current advise() is).
>>
>
> I agree with adding the first helper, specially after Peff's comments,
> but I don't see why we would keep the current advise() which
> unconditionally shows the message...

Look again at the message you referenced in your message that
started this round, and read its comment:

	if (advise_ng_enabled("frotz")) {
		char *result = expensive_computation(...);

		/*
                 * advise_ng("frotz", _("message %s about frotz", result));
                 * is fine as well, but slightly less efficient as
                 * it would involve another call to *_enabled(), so use
		 * the unconditional form of the call
		 */
		advise_ng_raw(_("message %s about frotz", result));

		free(result);
	}

