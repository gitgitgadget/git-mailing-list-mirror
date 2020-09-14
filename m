Return-Path: <SRS0=aDBb=CX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02328C433E2
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 20:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1FEC208DB
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 20:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="McPMva29"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgINUIC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Sep 2020 16:08:02 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58583 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgINUIA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Sep 2020 16:08:00 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C814F102F42;
        Mon, 14 Sep 2020 16:07:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=4DVSTCtBoqmFK8RWpZqRMLxef
        m8=; b=McPMva29YgJ85YE1DpNatFpz3z9a+oLMWuNZOCkttzM3X3VudDG2GLVEE
        vAZv+biIpAH9oUq+gVVrF2zCbnZDmSvYw3Dy5k+OJ+EScm8HuRyxmibng5kDtQ2G
        heRFA2L8ZhR3IFpNWzHUc//yWlPs50eprOKLOrSaTxAUyqnVw8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=c/oh/3OOyd8wQsxy7V+
        3MoNiBbqkzoWetTgw2rPOrs4k/RRVIo8a3tUi6f/WcfKgnYX9Nf8E3K56nC9hEiY
        E+SRosMxGP2gzEfUnJzQDXoACLf0W2M59ROlbspWWQvir1xfDs9FsE5tix6tiAbO
        T0KuGaCRH6IaWP5jqPpdVzus=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BFC67102F41;
        Mon, 14 Sep 2020 16:07:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 141B0102F3E;
        Mon, 14 Sep 2020 16:07:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "sunlin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Lin Sun <lin.sun@zoom.us>,
        sunlin <sunlin7@yahoo.com>
Subject: Re: [PATCH v18] Support auto-merge for meld to follow the vim-diff behavior
References: <pull.781.v17.git.git.1594596738929.gitgitgadget@gmail.com>
        <pull.781.v18.git.git.1599895268433.gitgitgadget@gmail.com>
Date:   Mon, 14 Sep 2020 13:07:51 -0700
Message-ID: <xmqqr1r4jf54.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F8C62C20-F6C5-11EA-AF74-843F439F7C89-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"sunlin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Lin Sun <lin.sun@zoom.us>
>
> Make the mergetool used with "meld" backend behave similarly to "vimdif=
f" by
> telling it to auto-merge non-conflicting parts and highlight the confli=
cting
> parts when `mergetool.meld.useAutoMerge` is configured with `true`, or =
`auto`
> for detecting the `--auto-merge` option automatically.
>
> Helped-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gmail=
.com>
> Helped-by: David Aguilar <davvid@gmail.com>
> Signed-off-by: Lin Sun <lin.sun@zoom.us>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>     Enable auto-merge for meld to follow the vimdiff beharior
>    =20
>     Hi, the mergetool "meld" does NOT merge the no-conflict changes, wh=
ile
>     the mergetool "vimdiff" will merge the no-conflict changes and high=
light
>     the conflict parts. This patch will make the mergetool "meld" simil=
ar to
>     "vimdiff", auto-merge the no-conflict changes, highlight conflict p=
arts.

Thanks.
