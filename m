Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C9941F4B6
	for <e@80x24.org>; Wed, 26 Jun 2019 18:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfFZSvO (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 14:51:14 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50356 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfFZSvO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 14:51:14 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5DE3D626DF;
        Wed, 26 Jun 2019 14:51:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=wcezD0axQKBq
        iBgkH0LQ6xp55Us=; b=PGMiCFiMcX2Od0CQ1rwWEGvCo3MFJbAUUHBz8y8TtakV
        MGXiLbc+OROCCLNBSHuBn+Mi/ugOGyp4tg4Ko83jn6HGpXiuZzC8jyT/TF6O3CYq
        sjssgi4wvzjk57Tr9sLvyXOkoqUO+Jkkxq6ZPt9TpAU/d9wtgP1We7qFHez5UZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=AD3CbM
        z/pIAyBldmrxV9S/x4N/nP96HS3LaeknCAepHI6Cdx3Ygnpu9jNuo8wcdyMVd5lS
        gnyJwpUF1wUsnbtZukd0tYLAKjNk8K3A3V3Itm8fqUM/vujcCj+AjS17JZP3FEJu
        Jgw+052Xbt2dQiA4XIOSBmWtsLFIQLlB1Dt1I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 56132626DE;
        Wed, 26 Jun 2019 14:51:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 71435626DB;
        Wed, 26 Jun 2019 14:51:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, kyle@kyleam.com, Heiko.Boettger@karlstorz.com
Subject: Re: [PATCH/RFC] get_oid: new extended SHA-1 syntax to control resolution process
References: <8C0042D8869AEA4AA334B49AFBBCEF820243C01B6A@TUT-EX01-PV.KSTG.corp>
        <20190626084139.30246-1-pclouds@gmail.com>
Date:   Wed, 26 Jun 2019 11:51:07 -0700
In-Reply-To: <20190626084139.30246-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Wed, 26 Jun 2019 15:41:39 +0700")
Message-ID: <xmqqk1d8ch9g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5C9233DA-9843-11E9-9F61-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> The problem is we try every possible way to resolve a rev. Let's have
> some annotation to express that we only want to resolve a rev in a
> certain way:
>
> - <hash>@{hash} only accepts a full hash or a short hash. If it's a
>   short hash, it cannot be ambiguous.

This is to defeat something like refs/heads/deadbeef (the branch
whose name is "deadbeef") interfering an object whose name begins
with that hexadecimal substring.  Makes sense.

> - <ref>@{literal} only accepts full ref. No turning "master" into
>   "refs/heads/master".

This is already doable by saying "refs/heads/master", isn't it?  Any
ambiguous ones like a branch or a tag whose name is 'refs/heads/master'
(i.e. refs/heads/refs/heads/master and refs/tags/refs/heads/master
respectively) won't interfere once you use the explicit prefix refs/
like so.  I'd rather not to see this one added.

> - <output>@{describe} interprets <output> as git-describe output
>   only, not an object name or a reference.

Again this is to defeat refs/heads/v2.22.0-221-gdeadbeef branch
interferring with the object "deadbeef" thusly described.  Makes
sense.

In the above, my two "Makes sense" only refer to the capability the
syntax allows us to have, not the suggested syntax itself (which I
am not convinced is a good use of @{<token>} yet).

Thanks.

