Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 053741F461
	for <e@80x24.org>; Wed, 10 Jul 2019 22:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfGJWdy (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jul 2019 18:33:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51341 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfGJWdx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jul 2019 18:33:53 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B788316A957;
        Wed, 10 Jul 2019 18:33:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1BVlCcBijUz0
        p1GhqKNpTX+qles=; b=S8wdk3VadOaYWVg/BGaGTD5o35e4c5VrKUj/4jdRUT96
        0MO0xUEESdSZix3bqJPFthj0wtQcD5/0udvTguVNolBwhOPJZcmM4bOpl7t+yv8b
        A/7EDTIgg3D4zeliN8EUoyD4qFETGf5lybI0U0jFzTE9BcAiAfZn1nYt5VUCx58=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=fbNmoT
        7XR7tZTdZHlFOoLAsBdz+4ON06Q4Jqje4rZHRmaFmzKQEpIIE5QEA9A/5sOUcyn4
        ocq5O280M10jq06XvUBZHRBtoiFlE3XixMce6n44Al/vfaYdIdNgIUi6YhCI0H5p
        Tt1dGKIdtb4TX8igDxbQ9opuiO0okrQtkztnY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AFDA016A956;
        Wed, 10 Jul 2019 18:33:49 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 24DDE16A955;
        Wed, 10 Jul 2019 18:33:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] ci: don't update Homebrew
References: <20190629170108.GF21574@szeder.dev>
        <20190703104748.32533-1-szeder.dev@gmail.com>
        <20190709163237.GA62761@TaylorsMBP6986.attlocal.net>
Date:   Wed, 10 Jul 2019 15:33:47 -0700
In-Reply-To: <20190709163237.GA62761@TaylorsMBP6986.attlocal.net> (Taylor
        Blau's message of "Tue, 9 Jul 2019 11:32:37 -0500")
Message-ID: <xmqqmuhlseno.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C9587388-A362-11E9-A320-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Hi G=C3=A1bor,
>
> On Wed, Jul 03, 2019 at 12:47:47PM +0200, SZEDER G=C3=A1bor wrote:
>> Lately our GCC macOS build job on Travis CI has been erroring out
>> while installing dependencies with:
>>
>>   +brew link gcc@8
>>   Error: No such keg: /usr/local/Cellar/gcc@8
>>   The command "ci/install-dependencies.sh" failed and exited with 1 du=
ring .
>
> Thanks for working on this. I think that the patch below is ultimately =
a
> better approach than what we had discussed in a previous thread [1].
> ...
> I think that this may in fact be better than what we have now. If we
> find ourselves wanting a newer version of, say, Git LFS, then I think
> we'd be benefited by upgrading the image itself. Perhaps we should look
> into that shortly, although I'm not aware of any urgency to do so (at
> least as it pertains to Git LFS).

Thanks all.  Let's fast-track this fix down to 'maint'.  We left the
macOS build broken for too long.


