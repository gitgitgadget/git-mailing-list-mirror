Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DACAC433EF
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 17:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237736AbiFBRxg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 13:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235859AbiFBRxf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 13:53:35 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC8C34BBE
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 10:53:34 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 30C061AE570;
        Thu,  2 Jun 2022 13:53:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1zSqxs4okbtQHOCJaJctzoaJS8NhpYJuasU0YI
        GHQVI=; b=lNfLD5Lwqmm39ICsr2Y/6soAYa8q5HQOJ41BwU+MUR4lfsoSFH8hrx
        YEYNMz+Z0t93LDJyEgcZMbjeiXxytgFW/OY0w/xsZhakGtOeLBf8OQH3D2NBnwsO
        Nu3XKtKlvM7lL5Z/TJuNuDAHgC+w/+Lekh+KNV55DLND4SSm3Fjjs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 271D61AE56F;
        Thu,  2 Jun 2022 13:53:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BEDDA1AE56C;
        Thu,  2 Jun 2022 13:53:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        christian.couder@gmail.com, johannes.schindelin@gmx.de,
        jrnieder@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Coup <robert.coup@koordinates.com>
Subject: Re: [PATCH v3 2/2] usage: add warn_once() helper for repeated warnings
References: <pull.1237.v2.git.1653658034086.gitgitgadget@gmail.com>
        <pull.1237.v3.git.1654046173.gitgitgadget@gmail.com>
        <8e29ac807c6a0cf94ea3a44ee3304011c2ad159c.1654046173.git.gitgitgadget@gmail.com>
        <220601.868rqg1qo2.gmgdl@evledraar.gmail.com>
        <8f96563b-87c5-2a8c-fe35-19fd0cc3c7d2@github.com>
        <xmqq35gorv7c.fsf@gitster.g>
        <376e65b1-3001-9bf8-8d08-dcfd9c6a8caf@github.com>
Date:   Thu, 02 Jun 2022 10:53:26 -0700
In-Reply-To: <376e65b1-3001-9bf8-8d08-dcfd9c6a8caf@github.com> (Derrick
        Stolee's message of "Thu, 2 Jun 2022 10:24:18 -0400")
Message-ID: <xmqqilpjne95.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E8138912-E29C-11EC-8379-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> Yes, you're right. I should use the output 'struct url_inf' from
> url_normalize() to construct the redacted URL. It has the downside
> that the output URL can be slightly different from the input URL,
> but a user should still be able to diagnose how to resolve the
> situation.

Ah, the error message is based on pre-normalization which may very
well be different, as that is the whole point of normalization ;-)

We'd redact password part in the error message anyway, so it may not
be a huge deal.
