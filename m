Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDA7CCA482
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 19:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349245AbiFMTYP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 15:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349942AbiFMTXU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 15:23:20 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5588C51E76
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 10:19:18 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F0195196B2C;
        Mon, 13 Jun 2022 13:19:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YEcI2C4GV2NrD+XsEU8B44EU3e2MmneJFQ/+OO
        Fy4C8=; b=R6gdv/+XTIYE4x6DKcA2hGgTGkYESRL49flI0VhwEgrV3B5lAyjEBu
        7CanH3Oc/wCY6AbY9FXVMMDUfPuHCg9rRf0/oj+FrZe9vAPiXRb4FkDMHpgfT4ca
        w7Jv5XQLm/OFXU3r+cKTH80Y5tYDMRaIjuXWZAG8rLPUXGY0/Fn2o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D6758196B28;
        Mon, 13 Jun 2022 13:19:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 80888196B16;
        Mon, 13 Jun 2022 13:19:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] ls-files.c: add --object-only option
References: <pull.1250.git.1654509678718.gitgitgadget@gmail.com>
        <pull.1250.v2.git.1654778272871.gitgitgadget@gmail.com>
        <xmqq35gdk44i.fsf@gitster.g>
        <CAOLTT8SNOYYVmk3fvEc=Vp9MuRp+1H--wh72rP=ORRtffonUfQ@mail.gmail.com>
Date:   Mon, 13 Jun 2022 10:19:12 -0700
In-Reply-To: <CAOLTT8SNOYYVmk3fvEc=Vp9MuRp+1H--wh72rP=ORRtffonUfQ@mail.gmail.com>
        (ZheNing Hu's message of "Sun, 12 Jun 2022 18:24:26 +0800")
Message-ID: <xmqqwndk7a7j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F22FA96E-EB3C-11EC-9F32-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

> I think those atoms are undoubtedly necessary to keep
>
> %(tag)
> %(objectmode)
> %(objectname)
> %(stage)
> %(path)

I am not sure what you mean by "keep".  You cannot keep what you do
not have yet ;-)

If ls-files needs (that is a big if; it is a plumbing to be used by
whatever program that want to assemble the pieces, and it shouldn't
have to learn such assembly itself) to support "--format", so that
people can reinvent its "-s" output (but why?  There already is "-s"
output available), then the above would be necessary (assuming that
via the "--format" the user will be able to supply inter-field
spaces and tabs properly).  I do not know if there are other things
available in output other than the "-s" option produces offhand, but
if there are, they would need to be added for completeness.
