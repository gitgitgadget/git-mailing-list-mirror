Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B7EA1F404
	for <e@80x24.org>; Tue, 23 Jan 2018 21:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932212AbeAWVM6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 16:12:58 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54974 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932146AbeAWVM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 16:12:57 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6550AC936F;
        Tue, 23 Jan 2018 16:12:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=f63zER1Du81iDCXgTrGjXzz0WLg=; b=WNTX1N
        PVmRbH3rJBdbgD6g+KBvAmrRuXTqQbwsTg6ANKfp2tzbUL/CR2YoN0d+J2YcuQLy
        VJK/hVv0mW0fSrwrVw+fuE7m1IhJl1wQIxtlGMZW4LjFik4s3GLcqpj/D7GF48/j
        9cexKYIWn6xcvUKiVPrZ/deD6udZPtnga2PHg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tsyOQxjB7KyPwESMnL2/ewdF3BxpAvJy
        K4UMuzno5k2WKTSGCepSmM1S+08jkV88sXxXayGfuMuFVsuoaq5TjUGZqa9r4FBZ
        AqIHyvw2JrntP1o3S8gEcbLACmoY1ISvnv3z4HDb+DGO0HlcspFvsmSBGuFeuv/G
        Zj3u69LYgJw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D2C0C936E;
        Tue, 23 Jan 2018 16:12:57 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BD91EC936D;
        Tue, 23 Jan 2018 16:12:56 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Simon Ruderich <simon@ruderich.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        lars.schneider@autodesk.com, git@vger.kernel.org, tboegi@web.de,
        j6t@kdbg.org, sunshine@sunshineco.com, ramsay@ramsayjones.plus.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v4 5/6] convert: add 'working-tree-encoding' attribute
References: <20180120152418.52859-1-lars.schneider@autodesk.com>
        <20180120152418.52859-6-lars.schneider@autodesk.com>
        <20180121142222.GA10248@ruderich.org>
        <05265803-BD74-4667-ABB5-9752E55A5015@gmail.com>
        <20180123005401.GG26357@sigill.intra.peff.net>
        <20180123102558.GA3878@ruderich.org>
        <20180123162016.GD13068@sigill.intra.peff.net>
Date:   Tue, 23 Jan 2018 13:12:55 -0800
In-Reply-To: <20180123162016.GD13068@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 23 Jan 2018 11:20:16 -0500")
Message-ID: <xmqqo9lkffe0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2EF7AAFE-0082-11E8-BB69-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> But with Coccinelle, it's a lot easier to apply the change tree-wide, and
> to convert topics in flight as they get merged. The maintainer still
> gets conflicts with topics-in-flight that touch converted areas, though.
> So I'd be curious to hear if Junio's opinion has changed at all.

There are two distinct kinds of cost on such a tree-wide change.
Conflicts with in-flight topic cannot be avoided other than truly
avoiding, i.e. refraining from touching the areas in flux, but it is
primarily what the maintainer does, and with help with rerere it can
be reasonably well automated ;-)

But the cost of reviewing could become a lot smaller when our tools
are trustworthy.  As long as we can be reasonably certain that the
tree-wide change patch does one thing it is intended to do and
nothing else (e.g. comes with mechanical reproduction recipe that
allows the patch to be independently audited), I do not have much
problem with such a clean-up.

The "avoid tree-wide change" rule still applies for things that
allows a lot of subjective judgment and discretion.  I do not know
of a good way to reduce reviewer costs on those kind of changes.

Thanks.
