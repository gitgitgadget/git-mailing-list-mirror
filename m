Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D37C433F5
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 05:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238155AbiC1FpK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 01:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbiC1FpH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 01:45:07 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D5C50065
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 22:43:24 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E8D35128F60;
        Mon, 28 Mar 2022 01:43:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pnD17u0zkefgdWOzckc11IN3HONKoUwtGZ6HIZ
        Tu6qQ=; b=Ix+cf9z6PSNO5BjfOlyACucPPqTIMwG2wqqhIB7e2GwN2RdKln+sJg
        U7L58t4hiKd5RiiS8FgtdVKKiGabgWZz1sM1ywQi7/ef0E9ffsQVuz8NqmdRqT8r
        NcFI2L9s6cJ2s6g7ru1P6y3EC0ot1twT1Rx3ACBpo1/zug2ete2qs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DFDF8128F5F;
        Mon, 28 Mar 2022 01:43:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 49755128F5E;
        Mon, 28 Mar 2022 01:43:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Fernando Ramos <greenfoo@u92.eu>, git@vger.kernel.org,
        davvid@gmail.com, sunshine@sunshineco.com, seth@eseth.com,
        levraiphilippeblain@gmail.com, rogi@skylittlesystem.org
Subject: Re: [PATCH v6 3/3] vimdiff: add tool documentation
References: <20220327112307.151044-1-greenfoo@u92.eu>
        <20220327112307.151044-4-greenfoo@u92.eu>
        <2d1b3c6d-4345-8b7d-b8b8-4baf1edd91f0@gmail.com>
Date:   Sun, 27 Mar 2022 22:43:21 -0700
In-Reply-To: <2d1b3c6d-4345-8b7d-b8b8-4baf1edd91f0@gmail.com> (Bagas Sanjaya's
        message of "Mon, 28 Mar 2022 11:48:08 +0700")
Message-ID: <xmqqbkxq639i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FAB69CA2-AE59-11EC-B5A8-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 27/03/22 18.23, Fernando Ramos wrote:
>> +When using these variants, in order to specify a custom layout you will have to
>> +set configuration variables `mergetool.gvimdiff.layout` and
>> +`mergetool.nvimdiff.layout` instead of `mergetool.vimdiff.layout`
>> +
>
> What about this wording?
>
> "These variants also have corresponding layout configuration named
>  `mergetool.gvimdiff.layout` and `mergetool.nvimdiff.layout`, respectively."

Hmph.  The wording aside, is it a good design that you have to set
gvimdiff.layout if you use gvim and your setting to vimdiff.layout
has no effect when you are using nvim or gvim?

What is the reason why a user may want to specify them separately?

 * I want to use this layout when using plain vim but gvim is so
   different that I want to use a different one from usability's
   point of view.

 * The layout I want to use with plain vim, when fed to gvim or
   nvim, would totally make them misbehave.  I cannot reuse the same
   layout even if I wanted to.

 * Depending on the kind of conflict I deal with, I want to use
   different layouts, but there is no easy mechanism to choose
   between multiple values I give to mergetool.vimdiff.layout, so I
   use one layout for vimdiff and another for gvimdiff, and
   depending on the layout I want to use, I switch between vimdiff
   and gvimdiff.

 * Something else?

If on the other hand, a user may want to stick to a single layout no
matter which variant of vim is used, it may make more sense to just
use a single mergetool.vimdiff.layout across all the different
variants of vim implementations, and possibly, have their own one
override the most generic "vimdiff" one.  E.g. gvimdiff would use
mergetool.gvimdiff.layout if exists, or mergetool.vimdiff.layout
otherwise.

I dunno.
