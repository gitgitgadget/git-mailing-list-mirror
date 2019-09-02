Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E24B1F461
	for <e@80x24.org>; Mon,  2 Sep 2019 17:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfIBRd5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 13:33:57 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52675 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfIBRd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 13:33:56 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AA3C98B93C;
        Mon,  2 Sep 2019 13:33:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dzoGsKXkdiSc2RrrEfx5PkANnzI=; b=E8piRt
        rk3pc9hoRmKEpnvl8YIMI6EpkI2ykUbgASMd0qSGV9icGifya4s9yLoS3/M2zOdE
        pXaIdscOFsB7FWGzruN+lLqSiz2dkdbbE1wvWprfFNYpZbFv+xfxUS36Q4P5IjO5
        gTNs0WRmwYrQO9BLXr9mSC3cHBFcy6P7QOJ9s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ohciA7TztrRX0JFIR41LPJ1P8PIwYDZH
        mFANc+32YgxlQIExoT2mq7Wike2dSr4ekByI8W/z55moyADcJxrpcMRvLmc04SAo
        Xi7Z0uKQV0e9/ZkxucvZmIeOgwBE7CSO9r8AFYGLvwE1fE/gFwSNGpp3D+AKDx9q
        cQEgP2MNqK8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8D68F8B93B;
        Mon,  2 Sep 2019 13:33:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B5BBC8B93A;
        Mon,  2 Sep 2019 13:33:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben <ben@wijen.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Szeder =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v6 1/2] builtin/rebase.c: make sure the active branch isn't moved when autostashing
References: <20190829164757.7301-1-ben@wijen.net>
        <20190830151607.4208-1-ben@wijen.net>
        <20190830151607.4208-2-ben@wijen.net>
        <xmqqsgpiwgts.fsf@gitster-ct.c.googlers.com>
        <bf659b1d-b9a4-cb9e-e660-fa743b4db84c@wijen.net>
        <xmqqr250uhtr.fsf@gitster-ct.c.googlers.com>
        <57de794a-52a7-2d00-8267-127317ac9bee@wijen.net>
Date:   Mon, 02 Sep 2019 10:33:49 -0700
In-Reply-To: <57de794a-52a7-2d00-8267-127317ac9bee@wijen.net> (ben@wijen.net's
        message of "Sun, 1 Sep 2019 18:27:29 +0200")
Message-ID: <xmqqef0yvc02.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D45D41D6-CDA7-11E9-B0D2-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben <ben@wijen.net> writes:

>> As long as you make it clear that you are 100% happy with the
>> fixed-up result that appeared in 'pu', there is no need to resend
>> (if you want to make any other changes, I do want to avoid me
>> screwing up by listening to you and hand applying those changes; I'd
>> rather want updated patch(es) be sent in such a case).
>> 
>
> Hi Junio,
>
> I am 100% happy with with your fixed-up result.
> I have no (planned) updates ATM.
>
>
> Thank you all for the thorough reviews.

Thanks. 

I meant to say "(and it is pretty clear already in this case)" after
the "... appeared in 'pu'," but forgot to do so; sorry for making
you send an extra round of response.
