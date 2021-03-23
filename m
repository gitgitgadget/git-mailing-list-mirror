Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB7CC433C1
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 20:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86296619CB
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 20:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhCWUNR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 16:13:17 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60450 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbhCWUMy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 16:12:54 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3653912D31A;
        Tue, 23 Mar 2021 16:12:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=g78Vb86gNiapBMqL+vJQH9nHtSo=; b=t6S/c6
        ErlMR5fMtkVGmzJL+sxIqwehxFIMxKdxqexj2Jq0X7Ob9Jsu6smuic1KwH+03u6Z
        aXJm+hU9dURMPG4xLMk4QDKV929hR1XJ8AKhCSUuRptWQZCuzn0rL5Lft0FgI1CM
        Dy+zCby1E7uRFmMBHo/lyc88JXsWwGbAp7wtU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=F9MiyeAOKlQyZ6LWiWLiV2pwfPOGjM2p
        4L4ZpBC4S/4m1ucYTc1d676EkdfIB0ZD3Q08y9faZz1Q5KxwLJxD8ARDcr62SGGO
        7vfN734bwO1bXYUtx98+o7iTYFGJxwHdw+jbuNVn6HCG1bPNYvdAUPMmU5Uutmf/
        IbHxbTraZ+M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2E7D812D319;
        Tue, 23 Mar 2021 16:12:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 57A3012D318;
        Tue, 23 Mar 2021 16:12:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v5 13/15] Reftable support for git-core
References: <pull.847.v4.git.git.1607522429.gitgitgadget@gmail.com>
        <pull.847.v5.git.git.1615580397.gitgitgadget@gmail.com>
        <bdb19af22cc7c4f3383f03f42cb4906c3ec5c5f3.1615580397.git.gitgitgadget@gmail.com>
        <e754900a-1d5d-d4cc-aba6-737b37d66f74@gmail.com>
Date:   Tue, 23 Mar 2021 13:12:48 -0700
In-Reply-To: <e754900a-1d5d-d4cc-aba6-737b37d66f74@gmail.com> (Derrick
        Stolee's message of "Tue, 23 Mar 2021 07:40:24 -0400")
Message-ID: <xmqq4kh139z3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2473BBD8-8C14-11EB-BB60-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 3/12/2021 3:19 PM, Han-Wen Nienhuys via GitGitGadget wrote:
>> diff --git a/Documentation/config/extensions.txt b/Documentation/config/extensions.txt
>> index 4e23d73cdcad..82c5940f1434 100644
>> --- a/Documentation/config/extensions.txt
>> +++ b/Documentation/config/extensions.txt
>> @@ -6,3 +6,12 @@ extensions.objectFormat::
>>  Note that this setting should only be set by linkgit:git-init[1] or
>>  linkgit:git-clone[1].  Trying to change it after initialization will not
>>  work and will produce hard-to-diagnose issues.
>> ++
>
> I noticed while resolving conflicts with my series, which also edits this
> file, that the "+" line above should be removed. That likely munges the
> fact that the config entry below should be its own list item, not a
> continuation of the previous one.

Yup, I noticed them, too, while merging.  If I recall correctly,
even though using a blank line to separate the list items is
semantically more correct, using the plus-alone line produced either
identical, or visually indistinguishable, rendering when I tested.
