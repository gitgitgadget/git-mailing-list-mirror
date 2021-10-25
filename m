Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A9BC433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 17:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B58560F70
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 17:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbhJYRTU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 13:19:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58598 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbhJYRTR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 13:19:17 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 457CDF7B62;
        Mon, 25 Oct 2021 13:16:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=X2BnokjZfnE3Ju2cOuQBhWeP/1sVT5CkchfzwW
        zCqfg=; b=gt6/VUQ09js7fVFNXY6bEKT0mujGUiU7h8ebRMJzu7K6PYi068QzYY
        VjOdpBXoyW0QgmyZipga3etpf2FvcpRg/6kvvnlmo980MhllYxZrla53/yw065pT
        i2f5Nkams0Xe1Q/RyGDTq+mi0Dvtjtogc4/ehITtA+hIkBpuN5iu8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3AEEBF7B61;
        Mon, 25 Oct 2021 13:16:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 464F9F7B5E;
        Mon, 25 Oct 2021 13:16:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH 1/6] ssh signing: extend check_signature to accept
 payload metadata
References: <20211022150949.1754477-1-fs@gigacodes.de>
        <20211022150949.1754477-2-fs@gigacodes.de>
        <xmqqfssr8hd5.fsf@gitster.g>
        <02fff111-865d-a2a0-ba06-d0166edfb9dd@gigacodes.de>
Date:   Mon, 25 Oct 2021 10:16:52 -0700
In-Reply-To: <02fff111-865d-a2a0-ba06-d0166edfb9dd@gigacodes.de> (Fabian
        Stelzer's message of "Mon, 25 Oct 2021 10:28:58 +0200")
Message-ID: <xmqqwnm110u3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 592DB534-35B7-11EC-9130-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

> On 24.10.21 01:13, Junio C Hamano wrote:
>>
>> One possible downside is that sigc has been mostly output-only
>> structure, and turning it into a structure that also has some input
>> members might make it too confusing.  I dunno.
>
> However if everyone is ok with changing the struct to be used for input
> as well then i would adjust the function to have it as the first parameter.
>
> The sigc struct already has a payload member (only used for verbose
> output) which is populated by the check function with a xmemdupz. I
> would then change it to a const char, add the length var and use it to
> pass the payload into the function as well. This way we also avoid the
> unnecessary mem copy.
>
> The function would just become:
> check_signature(struct signature_check *sigc, const char *signature,
> size_t slen)

I do not offhand think of a huge downside going that route myself.
We seem to end up with unusually large number of folks on the CC
list for some reason, so hopefully somebody will stop us if it is a
stupid idea ;-)

Thanks.
