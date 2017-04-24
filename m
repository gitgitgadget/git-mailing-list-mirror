Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA1A8207BD
	for <e@80x24.org>; Mon, 24 Apr 2017 00:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163807AbdDXApJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 20:45:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64836 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1163792AbdDXApI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Apr 2017 20:45:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BFF497C50A;
        Sun, 23 Apr 2017 20:45:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mCFi22/u/OubMYBzfM4EnnQIGMU=; b=LecJid
        r5SMolcHI8mCqiG4zBi8SE5g4ms2U9ht/49M3Va9l3vqKNh4qaV7zv4RJoLs4ulV
        GbtSSd4Ct+jNR0SH4xzK32/Y/+zHo/LnqRIVB2jE7hvodDWSDz+J09iOheCUkMJg
        P+XHJd8FS0XXWwCaQii1FgVDCkPxGAFVDW4Gk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=s/D4TY5ybY8SGUUVeoUJYTaDOCPd2xsk
        O80KKBF2JlcatqTdHM0GBmvvlruoD+AoRmG7ZJlCgZoyT7hcPT/BNA+ic6+w/XTB
        EQJpmL1y3RPWSEu2rXZ70oW4oM2doAvnZQ+7raxNX1PAyNiQhAePhUAmRPx9S/0r
        Qcl7S5Kqy+Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B8B947C509;
        Sun, 23 Apr 2017 20:45:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 17D797C508;
        Sun, 23 Apr 2017 20:45:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 00/15] Handle fopen() errors
References: <20170420112609.26089-1-pclouds@gmail.com>
        <xmqqlgqu7cq8.fsf@gitster.mtv.corp.google.com>
        <xmqqk26e5swj.fsf@gitster.mtv.corp.google.com>
        <20170421062915.he5tlgjqq7kj5h32@sigill.intra.peff.net>
        <CACsJy8D1LuH6qVp15MSkCM_oQphVUUK0r9SeKC5AzX+9Xi2dcw@mail.gmail.com>
        <CAPc5daXPgEFibr28-EZjk9_vYrrO2qt9VLXW6PepmFXUChpk7Q@mail.gmail.com>
        <CACsJy8CCW+gQ6n2VOC4nmRBukHSLyxYizQhowQoNOc8weZzJjA@mail.gmail.com>
        <20170421170700.qyjtrvew54u2epue@sigill.intra.peff.net>
Date:   Sun, 23 Apr 2017 17:45:04 -0700
In-Reply-To: <20170421170700.qyjtrvew54u2epue@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 21 Apr 2017 13:07:00 -0400")
Message-ID: <xmqq60hu4orz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4298D692-2887-11E7-8869-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Apr 21, 2017 at 07:27:20PM +0700, Duy Nguyen wrote:
>
>> On Fri, Apr 21, 2017 at 6:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> > Yes, but (1) we'd need to be careful about --quiet
>> 
>> Yeah. It's a real pain point for making changes like this. At some
>> point we should just have a global (maybe multi-level) quiet flag.
>
> I don't think it's too bad here. Isn't it just:
>
>   FILE *fh = quiet ? fopen(x, y) : fopen_or_warn(x, y);
>
> It is a little annoying to have to repeat "x", though (which is
> sometimes a git_path() invocation).

Sure, but you could do

	fopen_or_warn(quiet, x, y)

if it is a problem ;-)
