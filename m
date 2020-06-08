Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C171C433E0
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 17:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D41E8208A9
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 17:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kmS5nAPp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729939AbgFHReY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 13:34:24 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62700 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgFHReW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 13:34:22 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8DC1FC69CE;
        Mon,  8 Jun 2020 13:34:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PsadHKesF3Rf4vF0AoqgBanlqIE=; b=kmS5nA
        PpbQloaXu8TWoVIqnn+4Iv+zgoKEv3v/kgfmPSSWHBTmP1VxyPMlikVYipV1BzAl
        BS4+Kw+dO6Iaw3Zoy/v5egENLCILPrQVs1C9WlxYWIW0z0tPD+pYEq38+YtYwejD
        c9LGvoZYf69sz7Z7nMsw867cdCTQhLG4sE+wY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=n8JeAVkb0cYYf1BOGIO84+Vpts6FQ3NF
        tNXlNbNzGv2kU381uOa5gLs66M5gNWavAJJAcskHhIyhHdobfdfm31lbVFsEmdMS
        wppUz5KDt1CCx0Z+iikXjSfAp1PrPSTKkcEexMOZ/+R2pkqQhKsgo/Mls3YF+bIs
        W9PQwjaJnpo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 83EF0C69CD;
        Mon,  8 Jun 2020 13:34:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CDDEEC68E4;
        Mon,  8 Jun 2020 13:34:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        John Lin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Lin <johnlinp@gmail.com>
Subject: Re: [PATCH] Recommend "git gc --auto" instead of "git prune"
References: <pull.651.git.1591546715913.gitgitgadget@gmail.com>
        <20200607162556.GJ6569@camp.crustytoothpaste.net>
        <xmqq8sgyn6o4.fsf@gitster.c.googlers.com>
        <20200607204531.GA2313@generichostname>
Date:   Mon, 08 Jun 2020 10:34:16 -0700
In-Reply-To: <20200607204531.GA2313@generichostname> (Denton Liu's message of
        "Sun, 7 Jun 2020 16:45:31 -0400")
Message-ID: <xmqqd069law7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4794B160-A9AE-11EA-933F-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

>> Correct.  When running manually, after noticing the need to do a GC,
>> it is a mental bug to add "--auto" to it, I would think.
>
> Sorry about the confusion, when I was responding to the original
> issue[0], I mistakenly typed the wrong thing. I meant to suggest
> replacing it with `git gc --prune=now`, _not_ `git gc --auto` but I
> guess I had my wires crossed. With this in mind...
>
> The rationale behind this change is that John wanted to add bash
> completions for `git prune`. However, I noted that prune is a plumbing
> command and users should opt to use `git gc` instead. He mentioned that
> sometimes when auto gc runs, it tells the user that they should run
> `git prune` so I suggested (meant to suggest) replacing the command with
> `git gc --prune=now` instead so that users could call the porcelain.

Nice to know.  The reasoning behind the change should be available
to those who only look at "git show".

John, if you are to send an updated patch, please make sure you have
a meaningful log message in it.

Thanks.
