Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B97C433DF
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 22:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF3BF2078D
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 22:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BKbNeECQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgHSWIs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 18:08:48 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52538 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgHSWIp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 18:08:45 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A8210F19B0;
        Wed, 19 Aug 2020 18:08:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Un8Y2LK1uViInuRvPiCRh1p2fv4=; b=BKbNeE
        CQfZelTEF2x7i/vz8vaBOdlsWKfzRgionRMksvnsIf8wShPZpTq7K5f9cvE7v2Ff
        xUI4WSYuvWzEOfXyFxxNO5IJhIUy0wuCSrkdzbss3CZdEAOSbiFZePyb8xWO5s2j
        pRwpG/vNK8g+kG6IuAW36xhJOrttAKfOatSvc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YJoWNdr3FBrwnzp9WFkBQQa9ZR2ha8nH
        Srpc8fJbOGuiM5TqpsjfasTgfF+ox77/QOCxftkPO1LR6PLN9NiqTLhB6/NprFTj
        5H+Dmhd0CmEMsfZrlbbA9f+f/zyFgH+DYhnUCCLX10n1FRda4t3gYrOcdXC2wiea
        DErA4V/ZkCI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A124CF19AF;
        Wed, 19 Aug 2020 18:08:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id ECC41F19AD;
        Wed, 19 Aug 2020 18:08:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH 2/2] ref-filter: 'contents:trailers' show error if `:` is missing
References: <pull.707.git.1597841551.gitgitgadget@gmail.com>
        <7daf9335a501b99c29e299f72823fcb7e549e748.1597841551.git.gitgitgadget@gmail.com>
        <xmqqv9hettag.fsf@gitster.c.googlers.com>
        <xmqqmu2qtpxp.fsf@gitster.c.googlers.com>
        <CAPig+cS398dm4W5Q2DnK+bGvw0mOG3916dHPbZ=y1JNrqz1G-w@mail.gmail.com>
Date:   Wed, 19 Aug 2020 15:08:39 -0700
In-Reply-To: <CAPig+cS398dm4W5Q2DnK+bGvw0mOG3916dHPbZ=y1JNrqz1G-w@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 19 Aug 2020 15:39:07 -0400")
Message-ID: <xmqqsgcis2zc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8A1CEC26-E268-11EA-A076-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Aug 19, 2020 at 3:07 PM Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> > "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> >> +static int check_format_field(const char *arg, const char *field, const char **option)
>> >> +{
>> >> +            else if (*opt == ':') {
>> >> +                    *option = ++opt;
>> >> +                    return 1;
>> >> +            }
>>
>> And the helper does not have such a breakage.  It looks good.
>
> One minor comment (not worth a re-roll): I personally found:
>
>     *option = ++opt;
>
> more confusing than:
>
>     *option = opt + 1;
>
> The `++opt` places a higher cognitive load on the reader. As a
> reviewer, I had to go back and carefully reread the function to see if
> the side-effect of `++opt` had some impact which I didn't notice on
> the first readthrough. The simpler `opt + 1` does not have a
> side-effect, thus is easier to reason about (and doesn't require me to
> re-study the function when I encounter it).

That makes the two of us ... thanks.
