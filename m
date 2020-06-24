Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06AFC433E0
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 15:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B70B20738
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 15:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Kz8wJySu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404558AbgFXPvS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:51:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63310 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404166AbgFXPvR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 11:51:17 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F11C5FF8A;
        Wed, 24 Jun 2020 11:51:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NXlla8WYT4N7CCKtPwDg5Eis7bo=; b=Kz8wJy
        SuduT1aUOGHFvwqqBHX/gdgm6euVuxAQ2c6KNKq+iLnKAsOejipihVKW1uqV08e5
        nS32mHQNBTjCZQYIhxMFutifBIejDO0+skVm2yXBd8z5Nc89TAG39pg1i21tChnw
        7b8njq0K3+LckDC5e3y0oXzEBGWh9Kj2fFNBk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iBDVQvum+FUqWK2KbG1mf5Xh3EaUodN1
        XbYPk2joi0hTPdn0EghS67GmVnLvYr0k3TKi2387fJuJ64lYOI+Y4AdHcTd+niHF
        EkiicEtPw7wbly50BHvalp/NIEEJfXZu+07MLM/AUt/2+22XRQ9JuxXlDra2955t
        lg1Rm+K81I4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 34EAD5FF88;
        Wed, 24 Jun 2020 11:51:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A33CC5FF86;
        Wed, 24 Jun 2020 11:51:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] diff-files --raw: handle intent-to-add files correctly
References: <pull.654.git.1591879139.gitgitgadget@gmail.com>
        <pull.654.v2.git.1592916485.gitgitgadget@gmail.com>
        <640e225550886727594ca9dfaee6c9e6ea4b1014.1592916485.git.gitgitgadget@gmail.com>
        <20200624071116.GA79097@mail.clickyotomy.dev>
        <nycvar.QRO.7.76.6.2006241528290.54@tvgsbejvaqbjf.bet>
Date:   Wed, 24 Jun 2020 08:51:14 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2006241528290.54@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 24 Jun 2020 15:34:19 +0200 (CEST)")
Message-ID: <xmqqh7v08nt9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 88C251CA-B632-11EA-B4CD-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > +  :000000 100644 0000000 $(git rev-parse --short $hash_e) A$(printf "\t")empty
>> > +  :000000 100644 0000000 $(git rev-parse --short $hash_n) A$(printf "\t")not-empty
>>
>> Changing the test-case to reflect to the hash of the blob also makes
>> sense.
>
> Yes, that's the post-image side. The pre-image side is marked with 0000000
> (which is Git's way to say "dunno! no current information in the index").

The post-image side for (A)dded and (M)odified can have 0{40} when
Git wants to say "we don't have it in precomputed form.  you can
grab the working tree files and figure it out, if you need it", as
you said, but the pre-image side for (A)dded entries are "we know
there is nothing because we are Adding, but we need to have
something here, so we have 0+ as a filler".

