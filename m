Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF663C001DB
	for <git@archiver.kernel.org>; Fri,  4 Aug 2023 16:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjHDQk3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Aug 2023 12:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjHDQk2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2023 12:40:28 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B019B2
        for <git@vger.kernel.org>; Fri,  4 Aug 2023 09:40:27 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 13E4419EBD;
        Fri,  4 Aug 2023 12:40:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/CVqMR5m3jbU
        Dj6+rKBM0aQzHs5O+bDNUZI/5Z0vZYA=; b=TB0iLOa/WRGLaOHuxRBbon0GPlPO
        uUWF9Yf03WDbNosxkPfxEmkB27lVcRN+WQ6GJi4QrCncrwNQ2+xrdoMQ70egEj6C
        nyjFwyOHeubBMJ0t8OWCZIun8OaXe15nu6LpULqM5vFYHDCc0b1jEf6UNO1I33EJ
        Y+yGZ0HS0ADY9BE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F3A2019EBC;
        Fri,  4 Aug 2023 12:40:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 802C019EBA;
        Fri,  4 Aug 2023 12:40:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] ls-tree: fix --no-full-name
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
        <xmqqo7k9fa5x.fsf@gitster.g>
        <a6326aaa-4f05-4d00-8906-2f50ea8e1e7a@web.de>
        <xmqq351hz5xp.fsf@gitster.g>
        <43ca3f01-ba11-6c29-a8e8-4e6c262a68cc@web.de>
        <xmqq4jlxuiuu.fsf@gitster.g>
        <1535f30e-3cf9-1a0a-04af-4ba4a7c46d15@web.de>
        <xmqqr0oxnnx4.fsf@gitster.g>
        <9e8225dd-1e8b-8af2-c3e1-0c5834694244@web.de>
        <xmqqh6ptnies.fsf@gitster.g>
        <a19879db-d45a-ee42-1ad5-497e4e9eb8df@web.de>
        <b17b4f6b-199f-973b-3aa9-ef995a61bb3d@gmail.com>
        <31b71333-de8b-d9a8-3ec4-1bad9cae2bf3@web.de>
        <xmqqjzug14jo.fsf@gitster.g>
Date:   Fri, 04 Aug 2023 09:40:21 -0700
In-Reply-To: <xmqqjzug14jo.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        31 Jul 2023 08:31:07 -0700")
Message-ID: <xmqqbkfm3gne.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9B0E8596-32E5-11EE-9CA8-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> A bit more verbose still: Document the negative form on its own line
>> with a generated description -- requires no new syntax:
>>
>>     -v, --invert-match         show non-matching lines
>>     --no-invert-match          opposite of --invert-match, default
>>     -I, --no-index             find in contents not managed by git
>>     --index                    opposite of --no-index, default
>
> I would expect _("opposite of %s, default") is acceptable by l10n
> folks, and assuming it is, the above would be a good approach.

I was seeing what is likely to be in the -rc1 that will happen in
next week, and noticed that this discussion is left unconcluded.  I
am tempted to declare that the latest iteration that shows the
negation of "--no-foo" as "--[no-]no-foo" is "good enough" for now,
and leave the above improvement as one potential future direction.

Objections?  Otherwise the 5-patch series will be in 'next'.

Thanks.
