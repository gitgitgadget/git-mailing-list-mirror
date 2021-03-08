Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9217CC433E0
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 19:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 643D265287
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 19:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhCHTeh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 14:34:37 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62776 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbhCHTef (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 14:34:35 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F74FB9CE0;
        Mon,  8 Mar 2021 14:34:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vagc+nlj3pe7RTZQQQCtbaFs7Pg=; b=YtMPKZ
        3u7lKPIvLATyT2/cxCpAx227Tm9AMqD9yalARlCpj31//4pzSwCC+/48V5OLmBT0
        vr/hrRmZY/dzqtOUdyg2Vd/vgcgIe9GmIJnVzsBw83PMs26cyl0Q3kWiM303wPUj
        FThB300ch8FnKnbBLH9EsvyWGnKmbYsTJEY0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XbT8lGO+qbkYqJgiNrZRoOC6rVryJv48
        u4GdRmInpXEHdk+lhMYXiliqnhjfkiDlZjQ67w0Mlo3HBQRu1RtsMtNfed+eY287
        IIOdiqZKsMLANHK046FzTkqKN1q0GHM37s5+Gey7Yn57YPa2RX4VboKbvQDZKD6E
        Ch8Z3yM6msY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 17628B9CDF;
        Mon,  8 Mar 2021 14:34:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 97D1EB9CDD;
        Mon,  8 Mar 2021 14:34:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, nmulcahey@google.com
Subject: Re: [PATCH] fetch-pack: do not mix --pack_header and packfile uri
References: <xmqqv9a58a18.fsf@gitster.c.googlers.com>
        <20210308191424.12149-1-jonathantanmy@google.com>
Date:   Mon, 08 Mar 2021 11:34:33 -0800
In-Reply-To: <20210308191424.12149-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Mon, 8 Mar 2021 11:14:24 -0800")
Message-ID: <xmqqft155tiu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4FE4132E-8045-11EB-B916-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> I dunno how involved the necessary surgery would be, though.  If
>> this is easy to work around, perhaps it might be a better option for
>> the overall project to ship the upcoming release with this listed as
>> a known breakage.
>
> I don't think it's too difficult - I think we'll only need to filter out
> the --pack_header when we figure out the arguments to pass for the
> packfiles given by URI. I'll take a look.

What you sent earlier is a much better band-aid than "keep the
single args array but filter an element out in only one codepath"
band-aid, I would think.

Any change that is more involved than a single-liner trivial bugfix
would be too late for this cycle, as we'd be cutting -rc2 by the end
of tomorrow.

Thanks.
