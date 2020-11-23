Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2A0C63798
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 22:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A4D2206B7
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 22:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xLNPLzkj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732297AbgKWWjX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 17:39:23 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54879 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728567AbgKWWjW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 17:39:22 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 38CCFF14E9;
        Mon, 23 Nov 2020 17:39:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CwYADBf4FF0QZsrjiW7LWswK9gg=; b=xLNPLz
        kjPa9SvJ0jbdleJ7oM77H9te/qJlT/1EYZT07OrahsQHKxZmL0OMX2o/0+E+0O/Y
        Xhz2LvC18rxIOlasgKDsau18fcAq5S4Rqm9dMBRlr21rc680tmS/IBY/sB3GVkPg
        HX3gZPx/IIffWOEXrrOiniraif+dIsGfuqPLY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KkqKgZT+lFyyQ/LKugyrIDEVDf4PqZwe
        4jxL4BgD0k6D9CQXpeDe09Jb0G3asO94170TG+43L0vj7c3bwK9+4xHenKtdHnPb
        KeRhB2NWo89YBPmmtSXnct7RZyWGt12lZPxf6qwXs1tl46t7IRRNm6xf3jxcTvjP
        rd6N7HKY9wk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1D8C4F14E8;
        Mon, 23 Nov 2020 17:39:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6C00CF14E7;
        Mon, 23 Nov 2020 17:39:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Alex Henrie <alexhenrie24@gmail.com>,
        =?utf-8?Q?V?= =?utf-8?Q?=C3=ADt?= Ondruch <vondruch@redhat.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Pick the right default and stop warn on `git pull`
References: <742df4c2-2bc5-8a4b-8de1-cd5e48718398@redhat.com>
        <CAMMLpeRLsE=zNDjCRKmEMFxJBYcnTOdDGxEL9cZuVhuDMF=sLg@mail.gmail.com>
        <20201123191355.GA132317@mit.edu>
        <CAMP44s3cKVxKa0gOPfi3XRKbGbV=DweFE5pL0HM+v0kECFyPWA@mail.gmail.com>
        <20201123202003.GB132317@mit.edu>
        <CAMP44s27oEjScrJjeDVoNcWcvRsn173L_Kx+TOPfchOwge9zUQ@mail.gmail.com>
        <X7wuMvHRURK1QS/Q@coredump.intra.peff.net>
Date:   Mon, 23 Nov 2020 14:39:16 -0800
In-Reply-To: <X7wuMvHRURK1QS/Q@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 23 Nov 2020 16:48:34 -0500")
Message-ID: <xmqq360zn1ez.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8FD0B24-2DDC-11EB-A8D9-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I don't recall whether there is any active plan to move away from the
> merge default, though.

I don't, either, but if we were to do so, keeping the warning/advice
being discussed is crucial to avoid breakage.  

Hopefully by now most existing users who would have depended on
unconfigured default behaviour of merging have explicitly shown
their preference by setting the configuration to squelch the
message, so it might not be such a huge backward compatibility
nightmare.  I dunno.

