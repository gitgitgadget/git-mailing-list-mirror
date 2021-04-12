Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B220CC433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83C2361278
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239771AbhDLVkj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:40:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52488 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237701AbhDLVki (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 17:40:38 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 72743AC8C4;
        Mon, 12 Apr 2021 17:40:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mt5E5LC5A0e42RpmAey/j/ueOmM=; b=I+Dygc
        SHvJkBBNeRt0lPcw+QdOoq12VMVLciorpuOO7+x+UNVHF333K3/HBRfk+Db4agVA
        cOKUYJuDkD0IBTnLA/92OtOMCRSDFadK11kq003apFet8kpxgSGtvytqa25Ec9Sr
        dICaOemhPzFz5v950JPgRng61rbFjTKmt4fNM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Q2kigiWOFiA/RDJoc3dLmUiJlbs1HtE9
        uo6liVxFSaN2wsqKY2Youco8rfQWgBtloVVo6pUlFb+32E5P7CKt0vQkjaHkssP1
        mi30d4f4HtZSqXg5FuBpdZ4v2dDWEateOoiW49JW+2GnQYg58NvDu5sy61mJhog6
        Fxd75/fj6JA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E73FAC8C3;
        Mon, 12 Apr 2021 17:40:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9AD6DAC8C2;
        Mon, 12 Apr 2021 17:40:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
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
        Derrick Stolee <stolee@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v6 07/20] reftable: reading/writing blocks
References: <pull.847.v5.git.git.1615580397.gitgitgadget@gmail.com>
        <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
        <9297b9c363f6d922443d261375759046e303351d.1618255553.git.gitgitgadget@gmail.com>
Date:   Mon, 12 Apr 2021 14:40:17 -0700
In-Reply-To: <9297b9c363f6d922443d261375759046e303351d.1618255553.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Mon, 12 Apr 2021
        19:25:39 +0000")
Message-ID: <xmqq8s5nb2ri.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ACF0F6CE-9BD7-11EB-8D26-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am seeing this on the receiving end.  Thanks.

<stdin>:832: indent with spaces.
        left = *destLen;
<stdin>:833: indent with spaces.
        *destLen = 0;
<stdin>:836: indent with spaces.
        left = 1;
<stdin>:837: indent with spaces.
        dest = buf;
<stdin>:853: indent with spaces.
        if (stream.avail_out == 0) {
warning: squelched 13 whitespace errors
warning: 18 lines add whitespace errors.
