Return-Path: <SRS0=AD9v=6R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55DEC3A5A9
	for <git@archiver.kernel.org>; Sun,  3 May 2020 00:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96A2320757
	for <git@archiver.kernel.org>; Sun,  3 May 2020 00:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mEx8qQq1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgECAon (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 May 2020 20:44:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55269 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgECAon (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 May 2020 20:44:43 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DADF64B431;
        Sat,  2 May 2020 20:44:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=L7DjykZbxJ3/
        yFFU23Y/8LAkIbc=; b=mEx8qQq1vFreBc45cPfl/8+oq3G0U8neKGZkoMqv+yPw
        N/YjUjF49FSLRdv/mVSiRuAAJGMHxKwrZjy0TmOHXL+j1DsVpttFySoBgyKJPaJ2
        M8DSjE3Yl3hX/O1sQN5kzJ3140cj6eVKyCfN3Hs/+my8ilqvpnb3CvvaCxek59A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=T+pQVv
        9QSouVfsvrAgTMofXe3OgoeS23XsmVpUV2llOMmtoJs4rfUsAGPKtQPkRR4ga5sz
        lhCzGvoLxi9wrtppWlADWYCwMBJiu9d8tX1TYWRqivKEmEuOMuqw/fs5gN1LmSAH
        fdpCKPdyw7iLhHEucm8AjGQ5Kl8jlJ+PnwQa8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D18F34B42E;
        Sat,  2 May 2020 20:44:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 291484B42B;
        Sat,  2 May 2020 20:44:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, dirk@ed4u.de, sunshine@sunshineco.com,
        peff@peff.net, jrnieder@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v10] credential-store: ignore bogus lines from store file
References: <20200430160642.90096-1-carenas@gmail.com>
        <20200502181643.38203-1-carenas@gmail.com>
        <xmqqo8r6jc8i.fsf@gitster.c.googlers.com>
        <20200502215348.GC41113@Carlos-MBP>
Date:   Sat, 02 May 2020 17:44:39 -0700
In-Reply-To: <20200502215348.GC41113@Carlos-MBP> ("Carlo Marcelo Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Sat, 2 May 2020 14:53:48 -0700")
Message-ID: <xmqqk11tkft4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 459AB40C-8CD7-11EA-A169-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

> and with the strchr I am introducing a regression (compared against 2.2=
6.0)
> in cases where the '\r' gets appended to the path and therefore gets ig=
nored
> for matching (unless useHttpPath is true, which is not the default)
>
> will add 2 more test cases to cover those, and guess we are going to 11=
 :(
>
> Carlo
>
> PS. thanks for all your patience and reviewing

Among those 11, I also am responsible for a few while we ere
pursuing the approach to warn X-<.

Thanks for _your_ patience.

