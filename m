Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43978C433E0
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 20:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11E26206D7
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 20:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EU4MxhVg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgGXURI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:17:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52403 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGXURI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 16:17:08 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A45A087055;
        Fri, 24 Jul 2020 16:17:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DeeRgaUwL9ZQROOfxXEaJw7Fhww=; b=EU4Mxh
        VgZuGQfU5BvLN2DchtakOpuuUnIEauPX8b1pBFrI7spIYF51lpO6M9Bqt4dP0Peg
        oYg1T0bZvXB7f295jAvh3AVJWxHYCVXm6ojGu1I9M5tu8eVFa4yIjgBxtECM1oaQ
        NnAbcrrrAiiBAI4y2UhG4s4p2Xpr2IIS0XVHs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kneZLZBo4sPs/+t1KLncKqYUOcqGqXU+
        PVfyOQe8SKw41JSRg+cYmyK/NEg7UA2ghOtl7BTQ9n4TjCBRe8unOOKTdX0X5wFV
        XSsg6ciBsQ6LGiliBKuqZ31ksk2QEVyTx4S+XSopyAsBcBDbGE04UxWap26CShFS
        L1Iiu7p3FTI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A00F87054;
        Fri, 24 Jul 2020 16:17:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1512587051;
        Fri, 24 Jul 2020 16:17:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 11/18] maintenance: auto-size incremental-repack batch
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
        <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
        <478c7f1d0b858755c2c4b98605405214910b6f4c.1595527000.git.gitgitgadget@gmail.com>
        <xmqqa6zpq3nt.fsf@gitster.c.googlers.com>
        <d50fbb33-9be3-1c48-2277-8bf894df734f@gmail.com>
Date:   Fri, 24 Jul 2020 13:17:04 -0700
In-Reply-To: <d50fbb33-9be3-1c48-2277-8bf894df734f@gmail.com> (Derrick
        Stolee's message of "Fri, 24 Jul 2020 15:51:55 -0400")
Message-ID: <xmqqft9gllbz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A451BE88-CDEA-11EA-B413-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> tl,dr: the incremental-repack isn't the most space-efficient
> thing we can do, and that's by design.

I am not very surprised by the fact that many packfiles that were
obtained by thin pack transfer have many duplicate objects (due to
having to include the delta bases), and it is natural to expect that
deduplication would save many bytes.  It's not all that interesting.

I am more interested in making sure that we can assure that in the
combined single pack, (1) objects are ordered for good locality of
access and (2) objects are getting good delta compression.

