Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDB931F731
	for <e@80x24.org>; Tue,  6 Aug 2019 19:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfHFTMB (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 15:12:01 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53489 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfHFTMA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 15:12:00 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CB3F384201;
        Tue,  6 Aug 2019 15:11:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uVqYsJ0w9IVtiVlJL5VUN9nfMXY=; b=AYUr11
        MF7KZRvqskOyPlNbX71bdBHmIiHh49CsPnvBsDYwZoyntBEt+hdhAABySlli+bWK
        gTEe8aBz2o2PUO8CcGJWstAGRo48NRMnVZNcNragasilS4OAuu83u5ntWPYyHwTN
        641tpgntukytcySfuhE69Hb2UnRgVYmGhsf4M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KXR21Qt5h62wMTjkkfmf1jrLCDX0zIIK
        29+Gc50NR7sq0mnZ7gCbKYO33Q1c+Y6Sw25E7G/qLXDPeEa9Naxl40wq5uWGoHXb
        A8uPt2mtZ5EeDSQDsp2oCQBKFnYTZG4k/K4cGdBJpAfCNm02JgFlFV2MY0NcyyUu
        n1PNFNeXuqQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C35B7841FF;
        Tue,  6 Aug 2019 15:11:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EFEE7841FE;
        Tue,  6 Aug 2019 15:11:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Lukas Gross <lukasgross@u.northwestern.edu>,
        git@vger.kernel.org
Subject: Re: amend warnings with no changes staged
References: <CAOY1tUUmkRBEDkF3GiP45WSi50uUGBaamx9-PGej0Z-yt0ioPg@mail.gmail.com>
        <20190806013030.GA61803@google.com>
        <CAOY1tUVpeUftgHNuZg-2fMD9D+Qz08hfvRvQDe1f8+MV2xYv2w@mail.gmail.com>
        <20190806021618.GC61803@google.com>
        <20190806041911.GA9243@sigill.intra.peff.net>
Date:   Tue, 06 Aug 2019 12:11:53 -0700
In-Reply-To: <20190806041911.GA9243@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 6 Aug 2019 00:19:11 -0400")
Message-ID: <xmqqblx2jeh2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0E7CFC9C-B87E-11E9-88AD-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>   git commit -m 'buggy commit'
>   echo fix >>file.c
>   git commit --amend ;# oops, should have been "-a"
>   git push
>
> But perhaps that gets to the heart of the matter. Could we perhaps be
> providing a more detailed summary of what happened for an --amend? I.e.,
> to summarize _both_ sets of changes (and if one set is empty, say so)?
> ...
> judgement about whether it's an error, since it may well be that you
> were simply rewording the commit message).

Perhaps "git range-diff HEAD@{1}...HEAD" being an empty is a sign
that either the user intentionally or accidentally did not do
anything other than "touch"ing the commit.

"git commit --amend --[no-]range-diff" that shows what you changed
with the amending may be an interesting possibility; I am not yet
ready to seriously encourage anybody to explore it, though, because
"git diff HEAD@{1}" is much easier to see what code got changed, but
one (and probably only) downside is that it does not cover the
change in the log message.
