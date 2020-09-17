Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E19C43461
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 15:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4E5722275
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 15:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LtXJW21v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgIQPbo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 11:31:44 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50800 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbgIQPbb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 11:31:31 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A293DEF886;
        Thu, 17 Sep 2020 11:30:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6mjrlBifFxER
        Vqwq5wLM+qEvVE4=; b=LtXJW21vpLHqw8saRzZSNZoY+89H2Ew93qqzlULvkZun
        hTJdYmStMzZXvp5ULrMmmzWrRWEaxdEvQcb0nJ+Tbhe6AmYNwVIV/RuE532F69Ig
        RrNFfPCKzpiKc94cd5YYfvRWrbGoMG4aa3l5eUQzPoZ8oZtLPtuZsCMxlZmkmAI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=KIiSzj
        QRyzL7vPefy6En+8rRDHjCybIvzTbWjs1gp3lzQceqDsLubSHcofRhL9GelqClbv
        vt4T9HNTPvux2jzc2W1NtQcfXrg1Tk05qYCP1LrpNtxy3BxnfLS65/yBmxFzA4UT
        0/+2J8YtVEZL/NJrGB6s4e3wcqFMBkh1rF11w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9A221EF885;
        Thu, 17 Sep 2020 11:30:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DB713EF884;
        Thu, 17 Sep 2020 11:30:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Git Mailing List <git@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jacob Vosmaer <jacob@gitlab.com>
Subject: Re: [PATCH] enable core.fsyncObjectFiles by default
References: <20180117184828.31816-1-hch@lst.de>
        <xmqqd128s3wf.fsf@gitster.mtv.corp.google.com>
        <87h8rki2iu.fsf@evledraar.gmail.com>
        <CA+55aFzJ2QO0MH3vgbUd8X-dzg_65A-jKmEBMSVt8ST2bpmzSQ@mail.gmail.com>
        <20180117235220.GD6948@thunk.org> <87sgbghdbp.fsf@evledraar.gmail.com>
Date:   Thu, 17 Sep 2020 08:30:51 -0700
In-Reply-To: <87sgbghdbp.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 17 Sep 2020 13:06:50 +0200")
Message-ID: <xmqq4knwto7o.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C635D7EC-F8FA-11EA-97F5-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> [I didn't find an ideal message to reply to in this thread, but this
> seemed to probably be the best]
>
> Just an update on this since I went back and looked at this thread,
> GitLab about ~1yr ago turned on core.fsyncObjectFiles=3Dtrue by
> default.
>
> The reason is detailed in [1], tl;dr: empty loose object file issue on
> ext4 allegedly caused by a lack of core.fsyncObjectFiles=3Dtrue, but I
> didn't do any root cause analysis. Just noting it here for for future
> reference.
>
> 1. https://gitlab.com/gitlab-org/gitlab-foss/-/issues/51680#note_180508=
774

Thanks for bringing the original discussion back.  I do recall the
discussion and the list of issues to think about raised by Peff back
then in [2] is still relevant.


2. https://public-inbox.org/git/20180117205509.GA14828@sigill.intra.peff.=
net/



