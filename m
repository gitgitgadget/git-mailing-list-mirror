Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5684CC433E0
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 15:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6EE9206C3
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 15:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aNpk19rD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbgFKP2S (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 11:28:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63093 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbgFKP2R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 11:28:17 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4C5F171169;
        Thu, 11 Jun 2020 11:28:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vEimSuknEz0Un/IJ4+/ERr42AC4=; b=aNpk19
        rDQ/kekkBJ7sGwXpj+0rIX9H+nN/bE+HA4VZ6JYleQv56abP8WTLxl3yGlvsohmp
        KvMpqsY6tbfCZ8biT7H5fKV1+uLI+Lq5Ue5vw7Vg7xfZR134zeb2s5wgfP6msark
        6426THjj9sZs8Ekwm2YWmDZbWIU1oPtQWI5Zg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BAN0FQTFubo2RSjGASp47dneFo8W6Y2T
        FRgQsBAYfzEmP/HQLd1/FKmx/w+xie6QjkI4rkTK4SVr5VOtsC1UGlU0SgSLtdJt
        Afuqplk/7VWJ6NtSt4GDDlysmqrQ+bQOb79zS0DxPavJw6HVjKXTfpzvUyDskSKO
        oMrK6CxHurM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 449DC71168;
        Thu, 11 Jun 2020 11:28:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BE5B671167;
        Thu, 11 Jun 2020 11:28:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Don Goodman-Wilson via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Don Goodman-Wilson <don@goodman-wilson.com>
Subject: Re: [PATCH 1/9] init: allow overriding the default branch name for new repositories
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
        <90912e32da1192cfc3b39a18cb606caa46e85b1c.1591823971.git.gitgitgadget@gmail.com>
        <CAPig+cSnEvVB5vsffFXidG1-XNxDX10u2XhD9NqV3pwh8zyxxw@mail.gmail.com>
        <nycvar.QRO.7.76.6.2006111607450.56@tvgsbejvaqbjf.bet>
Date:   Thu, 11 Jun 2020 08:28:14 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2006111607450.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 11 Jun 2020 16:09:30 +0200 (CEST)")
Message-ID: <xmqqd065bp0x.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2AE40506-ABF8-11EA-B375-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Overall, the internal logic regarding duplicating/freeing strings
>> would probably be easier to grok if there were two separate functions:
>>
>>     char *git_default_branch_name(void);
>>     char *git_default_ref_name(void);
>>
>> but that's subjective.
>
> For such a tiny nuance, I'd rather keep it as one function...

And you'd need two functions, default and primary, possibly full and
short.  Splitting these into two here would mean you'd need four.
