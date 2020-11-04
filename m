Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE4CC2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 18:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E16A820759
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 18:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HqrHSuNM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbgKDSZr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 13:25:47 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54944 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgKDSZq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 13:25:46 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C28AAA2781;
        Wed,  4 Nov 2020 13:25:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iDbQsMu4U8vw5BBEocseuRYNydA=; b=HqrHSu
        NMdq6ENYU/Jm3xAbJR5LRFThS4DJjwpzwfiirVmN6IFDcZCpGOPiAWhRYUovcSXb
        CX0Wv8IX1EZFhda0eF54m9XQmdnQwQj1mn0U30ByzbkUqdY5z6zxhtPU5LwJ+OcX
        HdBsD31VzUq0Iom/TNmZP9clKmMs4NpqOWGPM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KTeScBlH44fxKG5jtI+lJtEgNFemICyk
        XNfyp51GSvm+4mijkYLcp7JMA1CmgYpLEXOh/Ee2rsrlDdna7ka1o/iLvCKQLENH
        zP4VN3MPw4RscCRNh8kD7eVE/eg7655IS3iLcCmk/U5ziy0pwNpqKX9MHhxcOo1o
        M3ixdaVGPjY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B9AE9A2780;
        Wed,  4 Nov 2020 13:25:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3BDF7A277F;
        Wed,  4 Nov 2020 13:25:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Duvall <dan@mutual.io>
Cc:     Jeff King <peff@peff.net>, Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] upload-pack: allow stateless client EOF just prior to
 haves
References: <1604022059-18527-1-git-send-email-dan@mutual.io>
        <20201030044012.GA3259692@coredump.intra.peff.net>
        <CANo+1gv0otfjRexAVW6E+yPEvGLo55_tQWN-81mQMm4U0seCJQ@mail.gmail.com>
        <20201030090902.GA3268509@coredump.intra.peff.net>
        <xmqqeelaqh7m.fsf@gitster.c.googlers.com>
        <20201104133342.GB3030480@coredump.intra.peff.net>
        <CANo+1gu2pi+JXV6a3fBFA+w_zCfQb80fJze2T3Ed1ri7+=KZGA@mail.gmail.com>
Date:   Wed, 04 Nov 2020 10:25:44 -0800
In-Reply-To: <CANo+1gu2pi+JXV6a3fBFA+w_zCfQb80fJze2T3Ed1ri7+=KZGA@mail.gmail.com>
        (Daniel Duvall's message of "Wed, 4 Nov 2020 06:06:44 -0800")
Message-ID: <xmqqft5pm11z.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 275E92DE-1ECB-11EB-9045-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Duvall <dan@mutual.io> writes:

> On Wed, Nov 4, 2020 at 5:33 AM Jeff King <peff@peff.net> wrote:
>>
>> On Tue, Nov 03, 2020 at 01:10:53PM -0800, Junio C Hamano wrote:
>>
>> > Yeah, I'd agree that punting on v0 and making sure the current
>> > version would work well is good enough.
>> >
>> > I lost track and am not sure what's the current status of the topic
>> > is.  Is v3 [*1*] the latest and satisfactory one?
>>
>> Yeah, I just read over v3 again and it looks good to me. Thanks, Daniel!
>>
>> -Peff
>
> Contributing this tiny patch was a rewarding experience, getting to
> know Git more intimately and collaborating with you all. Thanks so
> much!

Thanks, both of you.  Marked v3 to be ready for 'next'.
