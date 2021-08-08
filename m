Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC5CC4338F
	for <git@archiver.kernel.org>; Sun,  8 Aug 2021 17:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B78BE60E96
	for <git@archiver.kernel.org>; Sun,  8 Aug 2021 17:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbhHHR4P (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Aug 2021 13:56:15 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58379 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbhHHR4O (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Aug 2021 13:56:14 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 43A9F15782B;
        Sun,  8 Aug 2021 13:55:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Wj00JDjjcc1kIvYvoMqsuWtEF5IwuCHL0FHKrf
        4ysD8=; b=DrqpLIWGx8czgBClhRyIChowN2Cz30MgcPV2s69SDVQsa8s8N0vktp
        W8mqPAdtQBUybMauzXCsdAupeQjhxKsQ75pZAXrik7K0VSPKun3TLcc9ZwYfq7DL
        w976hbhDybiIlgP7TWoU+pKiKF6w3frwcpQnBch54xij+ePaME9Ro=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 39F4215782A;
        Sun,  8 Aug 2021 13:55:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 33EF5157826;
        Sun,  8 Aug 2021 13:55:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org,
        Hudson Ayers <hudsonayers@google.com>,
        Taylor Yu <tlyu@mit.edu>, Joshua Nelson <jyn514@gmail.com>
Subject: Re: [PATCH] Revert 'diff-merges: let "-m" imply "-p"'
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210520214703.27323-1-sorganov@gmail.com>
        <20210520214703.27323-11-sorganov@gmail.com>
        <YQtYEftByY8cNMml@google.com> <YQyUM2uZdFBX8G0r@google.com>
        <xmqqh7g2ij5q.fsf@gitster.g> <xmqqczqqihkk.fsf@gitster.g>
        <YQ2UFmCxRKNMOtrD@google.com>
Date:   Sun, 08 Aug 2021 10:55:49 -0700
In-Reply-To: <YQ2UFmCxRKNMOtrD@google.com> (Jonathan Nieder's message of "Fri,
        6 Aug 2021 12:57:10 -0700")
Message-ID: <xmqqeeb3hlcq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DE77F0E8-F871-11EB-94FC-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>> For example, 1e20a407 (stash list: stop passing "-m" to "git log",
>> 2021-05-21) that dropped "-m" must be reverted as well, no?
>
> No, that change is fine.  The "-m" doesn't have an effect one way or
> another after this revert.

Ah, we are saved by the fact that "--first-parent" was made to imply
"-m", so a "-p" coming from the command line of "git stash list"
would do "log --first-parent -p" that shows the patch we want
without the need for "-m"... nice.
