Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C946C433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 22:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbiI3WKP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 18:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbiI3WKF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 18:10:05 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653F43EA69
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 15:10:03 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A53031BEF0E;
        Fri, 30 Sep 2022 18:10:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5+B1HexXa8CI
        q+r9OYhAVPBg6KET6oVWnJZjEFMfMx0=; b=edAY/UJDTwg1QAp+PzGYKU1cR4pC
        kh6W2zFrb2Ktc34LUaeZAWqUA7I0JYQ0JVUVHuYu6fJED1bWwsx7n+5XFu9sT21H
        IaCRTTQorjNn9nIkOL5tdkbudRFmujOIE4SKvo0ZnzbwDvgXJCemQ9QCo1l3T4Cr
        OHV/r2/90pQcYEA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9D6021BEF0B;
        Fri, 30 Sep 2022 18:10:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8321F1BEF06;
        Fri, 30 Sep 2022 18:09:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 19/36] doc txt & -h consistency: add or fix optional
 "--" syntax
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
        <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
        <patch-v3-19.36-3bfdd3fb79e-20220930T180415Z-avarab@gmail.com>
Date:   Fri, 30 Sep 2022 15:09:58 -0700
In-Reply-To: <patch-v3-19.36-3bfdd3fb79e-20220930T180415Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 30 Sep
 2022 20:07:42
        +0200")
Message-ID: <xmqqtu4o7bux.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9FD8443E-410C-11ED-A627-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index ada68a4af5e..3cc8aad52ed 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -20,7 +20,7 @@
>  #include "packfile.h"
> =20
>  static const char rev_list_usage[] =3D
> -"git rev-list [<options>] <commit>... [-- <path>...]\n"
> +"git rev-list [<options>] <commit>... [[--] <path>...]\n"

As rev-list requires at least one commit, so <commit>... means one
or more of <commit>.  Now rev-list does not have to have pathspec,
but it is OK to have the double-dash, so

    git rev-list [<options>] <commit>... [--] [<path>...]

would be more correct, no?  <path>... may mean one or more pathspec
elements, but having it inside [] makes it zero or more.  But it is
not a crime to have "--" without any pathspec, yet [[--] <path>...]
requires one or more paths if you want to write "--".

