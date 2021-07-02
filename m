Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBE4C11F68
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 15:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24601613E0
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 15:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhGBPz5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 11:55:57 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61210 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhGBPz4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 11:55:56 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9121214CB6F;
        Fri,  2 Jul 2021 11:53:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=xcDGGpwzg0eB
        eEKN5vaI414c/nzWS3mFbil/h9WcwHg=; b=aQCqAGncDfRnpgV8ISM+4vU0PUcB
        djM/H+eSLLstkuu391PrtzZ+XIn9xTOx8t8a03sPgSK+iAPON1rvjRKaDWPOy5rE
        PFIS5BFx4mAE2vlJntgWCe23KHtpXG0kJvlmsMU5jprdgAteDZRBMd2J/BVGNIWP
        WoN9rhxKZ/jOypE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 893E514CB6E;
        Fri,  2 Jul 2021 11:53:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D09DC14CB6D;
        Fri,  2 Jul 2021 11:53:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Subject: Re: [PATCH] Documentation/Makefile: don't re-build on 'git version'
 changes
References: <874kdn1j6i.fsf@evledraar.gmail.com>
        <patch-1.1-911881ce19f-20210702T115617Z-avarab@gmail.com>
Date:   Fri, 02 Jul 2021 08:53:20 -0700
In-Reply-To: <patch-1.1-911881ce19f-20210702T115617Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 2 Jul
 2021 13:58:47 +0200")
Message-ID: <xmqqmtr4pv9r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A09FBBDE-DB4D-11EB-AA23-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Since 9a71722b4df (Doc: auto-detect changed build flags, 2019-03-17)
> we've been eagerly re-building the documentation whenever the output
> of "git version" (via the GIT-VERSION file) changed. This was never
> the intention, and was a regression on what we intended in
> 7b8a74f39cb (Documentation: Replace @@GIT_VERSION@@ in documentation,
> 2007-03-25).

I am not sure.  Even if there were no changes in say
'Documentation/git-cat-file.txt' and the sources it depends on
between 'master' and 'next', after doing this:

    $ git checkout next
    $ make prefix=3D$HOME/git-next/ install install-doc
    $ git checkout master
    $ make prefix=3D$HOME/git-master/ install install-doc
    $ $HOME/git-master/bin/git help cat-file | tail -n 1

I should see that the documentation should say it is from the
'master' branch in its footer, no?

In other words, I think 7b8a74f39cb's reasoning (not the
implementation), especially the last sentence of its log message, is
flawed, where it said:

    Documentation: Replace @@GIT_VERSION@@ in documentation
   =20
    Include GIT-VERSION-FILE and replace @@GIT_VERSION@@ in
    the HTML and XML asciidoc output. The documentation
    doesn't depend on GIT-VERSION-FILE so it will not be
    automatically rebuild if nothing else changed.

Thanks.
