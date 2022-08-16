Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81783C25B0E
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 19:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236873AbiHPTgL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 15:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236566AbiHPTgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 15:36:09 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05C0895CD
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 12:36:07 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F41ED1AC439;
        Tue, 16 Aug 2022 15:36:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=5H+iNl4TE3oiVOZ1hHR0I0JqnA5IvTJRdbOIksVOQrs=; b=W88s
        Ppg3FhjH9rLu9cXiGBdnh2GJU+H8msyWmj6Gkyf4dFXk5m/M5RTrzKEE/p0aLWCE
        RXohhNvBXt6YVdam77Lj92AcJrWDgcmZDXLJSimA0Umw9X3oNW8BNnTvwcRLAMKA
        uk+lRF1rnVjsuZ467N1fAbyewE4ckKs/AaQlPlI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EC78A1AC435;
        Tue, 16 Aug 2022 15:36:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 98DB41AC434;
        Tue, 16 Aug 2022 15:36:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v8 08/14] merge-resolve: rewrite in C
References: <20210317204939.17890-1-alban.gruin@gmail.com>
        <20220809185429.20098-1-alban.gruin@gmail.com>
        <20220809185429.20098-9-alban.gruin@gmail.com>
        <08ea1eec-58fb-cbfa-d405-0d4159c99515@gmail.com>
        <xmqqilmzkd7p.fsf@gitster.g>
        <qs23r0n8-9r24-6095-3n9n-9131s69974p1@tzk.qr>
Date:   Tue, 16 Aug 2022 12:36:02 -0700
Message-ID: <xmqqedxgt1zx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AA39A110-1D9A-11ED-9ED8-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I'm all in favor of adding such a good example there, but there is no
> reason to hold back `git merge-resolve` from being implemented in C.

You did not address the primary point, i.e. why the particular
change is a bad one.  Sure, you lost a scripted porcelain or two
that are not used much, but in exchange for what?  That is _the_
issue and you skirt around it.

The series makes us lose all strategies that are actively tested
that are spawned as a subprocess, which is the way all third-party
strategies will be used.  After this, we have less test coverage of
the codepaths we care about, which is *not* a scripted "resolve"
strategy, but the code that runs third-party strategies as
externals.
