Return-Path: <SRS0=iF2w=72=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E06C433E1
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 16:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6FCD2078A
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 16:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mOV8O0Dc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgFMQ0F (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Jun 2020 12:26:05 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57770 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgFMQ0E (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jun 2020 12:26:04 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AF855D8A70;
        Sat, 13 Jun 2020 12:26:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2O5aiE8ezCa6MKSSW5Ai5jIJaws=; b=mOV8O0
        DcI9viXPL3DlVFD03DPDFpPuGpoQRwe5R7LaTU2rLBJ6sMvFJwGz8DTOwkfF7ev4
        H2+exlN+UuLKHOPjUZKA8ppXurDZ1Bu6s0krt0OnupOyXm/aEJtuGrzMfQs6NSL7
        AdEYowSrF0ykrsC2K8XrzZEr2tQNmjoMlJoYo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kgf4joOpC3VOC+uPSKBEBTNMIk6OAbib
        hjyvDq3NwthwWVIx/0fPRJ4ZZ2QiVJknp5T8I9JR/Mpwsoy2JXoL6OKiOhydCffe
        g+KEbAcrOxFA9zV1W2SYnDGr/gaX674g2VXxGjAIN2b+1HmJBmql8tphz/D4U6Cx
        82SPdhgCAiw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A84D8D8A6F;
        Sat, 13 Jun 2020 12:26:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EECD5D8A69;
        Sat, 13 Jun 2020 12:25:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Matt Rogers <mattr94@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        don@goodman-wilson.com, stolee@gmail.com, Jeff King <peff@peff.net>
Subject: Re: Re* [PATCH 8/9] fast-export: respect the possibly-overridden default branch name
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
        <1efe848f2b029e572cea61cadcfe36b9d3797836.1591823971.git.gitgitgadget@gmail.com>
        <CAOjrSZvm9QNUttUNVBEUMPJ8zgYEoAnSPN5_6N5uwpiM1sVrcQ@mail.gmail.com>
        <20200610233912.GU6569@camp.crustytoothpaste.net>
        <CAOjrSZvV6+ApfmOBa7rdXDPQJbExRsOfodO16i_1N5QjjhCB1w@mail.gmail.com>
        <xmqq3672cgw8.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2006111559300.56@tvgsbejvaqbjf.bet>
        <xmqqpna5bq2l.fsf_-_@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2006121451100.56@tvgsbejvaqbjf.bet>
        <xmqqy2os2u55.fsf@gitster.c.googlers.com>
        <405521ec-aed7-ff76-5b48-70e9d11018e6@kdbg.org>
Date:   Sat, 13 Jun 2020 09:25:56 -0700
In-Reply-To: <405521ec-aed7-ff76-5b48-70e9d11018e6@kdbg.org> (Johannes Sixt's
        message of "Sat, 13 Jun 2020 13:49:13 +0200")
Message-ID: <xmqqv9jvylt7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8FF079D4-AD92-11EA-91A9-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 12.06.20 um 17:14 schrieb Junio C Hamano:
>> 	/*
>> 	 * Anonymize the name used for the primary branch in this
>> 	 * repository, but reserve `ref0` for it, so that it can
>> 	 * be identified among other refs in the output.
>> 	 */
>> 
>> is the minimum I would expect before calling it an improvement.  We
>> could add
>> 
>> 	It is often `main` for new repositories (and `master` for
>> 	aged ones) and such well-known names may not need
>> 	anonymizing, but it could be configured to use a secret word
>> 	that the user may not want to reveal.
>> 
>> at the end to explain the motivation behind anonymizing even more,
>> if we wanted to.
>
> IMO, making the primary branch identifiable is a reasonable
> justification to treat it specially. But then, why does it have to be
> renamed to 'ref0'? Couldn't it just be renamed to Git's default primary
> branch name, be it 'master' today or 'main' or whatever in the future?

That comes from https://lore.kernel.org/git/xmqqtuzha6xn.fsf@gitster.c.googlers.com/

But I agree with you 100% if you literally mean 'master' (or 'main')
hardcoded without any end-user customization.  What I rejected and
replaced with the vanilla "ref0" was to return the configured name
that will be used for the primary branch in new repositories.  The
above proposal suggested a faulty:

-	if (!strcmp(refname, "refs/heads/master"))
-		return refname;
+	if (!strcmp(refname, get_primary_branch_name(DO_NOT_ABBREV)))
+		return get_default_branch_name(DO_NOT_ABBREV);

A corrected code should return a hardwired constant 'main' (it
probably gets behind a C preprocessor macro, but the point is that
we do not want end-user customization) for the reason stated in that
message.

Thanks.
