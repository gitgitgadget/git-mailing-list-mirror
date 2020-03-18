Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5E1C5ACD6
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 19:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D3C20754
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 19:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KLlsMhdH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgCRTsk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 15:48:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50712 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgCRTsk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 15:48:40 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 277F23AD94;
        Wed, 18 Mar 2020 15:48:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/K2/23N15Ydu3G1JyzN/qmybWn0=; b=KLlsMh
        dH76I8z2qH62vnKXi7kcINH7Z8E1WFi5gHUqWyxA/Hlij9xc8AKVFps6KjqMM8c0
        VXbHfgE22V8R5gAwJoUZI3cLJl2GscRtcNyj9yh7ra+Sxt3f2Xmw/R8Q3yVZ/cxn
        F1Ky90sTkeKqQPsnseHaF4AmiivrhHtrd0xhw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OS4sg1M0sfMBeDVrWFCTk3vlyeDhRgpn
        Kj9ZiuIJJINabv4WV3eWyOw2jTRpBMOINdIHNFcCSzJZyntiYvSf5wJ4KfIWIc4X
        XWpUX2tp6/h8OO1f6BYUfGZG33Byy82kxSjB0mIi/hzmo2tO7YVscjGFv+T6jgUY
        nHgO8rjwPuI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E85E3AD93;
        Wed, 18 Mar 2020 15:48:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 95D623AD92;
        Wed, 18 Mar 2020 15:48:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de, newren@gmail.com,
        peff@peff.net, chriscool@tuxfamily.org, jnareb@gmail.com
Subject: Re: [RFC][Feature] submodule: teach subcommand 'summary' to give summary for nested submodules
References: <20200318163234.21628-1-shouryashukla.oo@gmail.com>
Date:   Wed, 18 Mar 2020 12:48:37 -0700
In-Reply-To: <20200318163234.21628-1-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Wed, 18 Mar 2020 22:02:34 +0530")
Message-ID: <xmqqh7ylfnqi.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 75B5973C-6951-11EA-972D-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> I was converting the subcommand 'summary'(of command submodule)
> from shell to C and I realised that the subcommand does not have a
> '--recursive' option in it, meaning it cannot give out summaries
> of nested submodules. My opinion on this is that an option should
> maybe exist for the same.
>
> What are the community's thoughts on this? Should the
> aforementioned option be added? Is there any feasibility of this
> option in this case?

If "git submodule summary --recursive" errors out with today's code,
no sane user would be using it for any useful purpose, so I would
think it is OK to add such a feature.

If it makes a usable UI for large projects that you can only choose
between "include no subsubmodules" (i.e. with --no-recursive) or
"include all sub(sub)*modules" (i.e. with --recursive) is another
matter, though.
