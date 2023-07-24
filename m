Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23964EB64DD
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 20:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjGXUjR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 16:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjGXUjP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 16:39:15 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA9D198
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 13:39:14 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B235E35A6F;
        Mon, 24 Jul 2023 16:39:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EWMlrrx5oslGp+N1HaUSu0RfRLXIIu3xzRd74u
        4YYzs=; b=vff1goORZfRDnZM2RVEhLos50rN64CP/Bri/Ws2ooeVz4W6j/BcJjJ
        EPqu2T5E7wQACJsyenmjvriBw9tPYov0wZsyXvDHQEWGRsgcJXgWOX/Vp6Li4ekd
        zKqB1NFgiPSFmCW4J5x2KHzz+Z2VPu6mq4OmCq8yyJTB/djmgfEy4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AA5F335A6E;
        Mon, 24 Jul 2023 16:39:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4B9DD35A6C;
        Mon, 24 Jul 2023 16:39:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Siddharth Singh <siddhartth@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH v4 1/2] ref-filter: add multiple-option parsing functions
References: <20230719162424.70781-1-five231003@gmail.com>
        <20230723162717.68123-1-five231003@gmail.com>
        <20230723162717.68123-2-five231003@gmail.com>
        <xmqqa5vlqktr.fsf@gitster.g> <ZL6_DlDIE8Hfl_T6@five231003>
Date:   Mon, 24 Jul 2023 13:39:09 -0700
In-Reply-To: <ZL6_DlDIE8Hfl_T6@five231003> (Kousik Sanagavarapu's message of
        "Mon, 24 Jul 2023 23:42:30 +0530")
Message-ID: <xmqqmszlnixe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2489DB36-2A62-11EE-A0CE-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kousik Sanagavarapu <five231003@gmail.com> writes:

> What do you mean by "share code"?
>
> They are similar in their functionality, that is parsing the option and
> grabbing the value (if the option has a value, otherwise we do what we
> did here). The difference is the way we do such a parsing.
>
> In pretty, we directly skip_prefix() the placeholder. So we check for ')'
> to see if we have reached the end of "to_parse".
>
> In ref-filter (the current patches), we deal directly with the options
> ("arg" here), that is we can't do a check for ')' to see if we have
> exhausted our option list. So we can't really use the same functions, but
> there is the possiblity that we can modify them to be used here too.

That is the kind of "sharing" to reduce repetition I had in mind.

I haven't checked the callers, but another way would be to update
the caller of for-each-ref's side to match the calling convention of
how pretty calls the parser, wouldn't it? After all, they parse the
same "%(token:key=val,key=val,...)" so...?
