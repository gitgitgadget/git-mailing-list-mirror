Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F05AC43461
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 16:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4256207DE
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 16:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fYgJWvvd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731889AbgIHQy6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:54:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61276 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731710AbgIHQZf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 12:25:35 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3885C8918B;
        Tue,  8 Sep 2020 12:25:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fS1XsGsY4/FdzPsg/It7LFxTwgQ=; b=fYgJWv
        vd8QMqtSn7pLyUIiIWZp/c4wiNdJPfPI773UxjvIxYU743tV2oIjlR+M4/O9HcBb
        +2HuHo9NRDGENuvRO5OHnGj+9kysUPQQUCPzCCxDMUod4DLeYF94C8e6DSmqMXSB
        K/LeshecCYBqJSRGP5Jw7NgVF1a07uCs1GHak=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Nb6Adg2d4ZKrVKNmxYFYnJjrgdwRyMEe
        YJ5BjwzKVWuw6O8FAmoHZtbvZNcFeNcsjwdhNSy7f1FOaH3TQWYGvc2kbznJ7mH5
        XdtSLgDDAzAVi+m3ZhZ1+9JjTNNWPcqmC3wxrvwPdKGcqp1KRhDznUKGfnYmLcYL
        viRIMFmIMJE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2FF918918A;
        Tue,  8 Sep 2020 12:25:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A796A89188;
        Tue,  8 Sep 2020 12:25:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Tom Hale <tomnott@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] add--interactive.perl: specify --no-color explicitly
References: <20200907080632.GA1261825@coredump.intra.peff.net>
        <20200907081739.GB1263923@coredump.intra.peff.net>
        <20200907082510.GA1264377@coredump.intra.peff.net>
Date:   Tue, 08 Sep 2020 09:25:31 -0700
In-Reply-To: <20200907082510.GA1264377@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 7 Sep 2020 04:25:10 -0400")
Message-ID: <xmqqo8mgz150.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EACDABDC-F1EF-11EA-A691-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> By the way, this is an instance of a more generic bug, which is that:
>
>   git -p my-script
>
> will cause any sub-programs of git-my-script to think their stdout is
> going to a pager, even if my-script redirects them to a file or another
> pipe.
>
> I had a solution long ago in:
>
>   https://lore.kernel.org/git/20150810052353.GB15441@sigill.intra.peff.net/
>
> but it raises a bunch of interesting portability questions. Since this
> comes up so rarely, I never really pursued it further.

That indeed is from long ago ;-) and I still kind of like it.  Is
the issue that some platforms do not even have inum of the "thing"
connected to a file descriptor?  I think a fallback code for such a
system can just return a constant pipe ID to anybody asks, so that
an exported GIT_PAGER_PIPE_ID would always match, which gives the
behaviour identical to what we currently do with GIT_PAGER_IN_USE,
and that would be one way to help those capable of giving useful IDs
while not harming others.

Thanks.
