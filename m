Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E32EE14C1
	for <git@archiver.kernel.org>; Wed,  6 Sep 2023 17:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243348AbjIFRwf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Sep 2023 13:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjIFRwf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2023 13:52:35 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BF4E59
        for <git@vger.kernel.org>; Wed,  6 Sep 2023 10:52:22 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A4AD0278B6;
        Wed,  6 Sep 2023 13:52:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Jg/1aSwDTQ80
        zZ8oK5ZSU7avR/FZZkNydvfg74qrD1E=; b=u/JMwpZ5UXQpeIuA3jbEHOBj43JL
        OT7N07noxcIH9AkpJ1sdYXn+48Od1zmAcEVHobGxgoB2Uv9TcAJYlJeXnkXnmtMV
        GzTVDWG9QxMTs+dzoBBjMvXIN2IEbxv+c48igkTaEOQDIFhdkhKUACFBAWaWngOk
        FZmXhdeojOd0Lak=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9CDF6278B5;
        Wed,  6 Sep 2023 13:52:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 28CC4278B4;
        Wed,  6 Sep 2023 13:52:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc:     "Eric Sunshine" <sunshine@sunshineco.com>,
        "Tao Klerks" <tao@klerks.biz>,
        "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        "Taylor Blau" <me@ttaylorr.com>, "Patrick Steinhardt" <ps@pks.im>,
        git <git@vger.kernel.org>
Subject: Re: Is "bare"ness in the context of multiple worktrees weird?
 Bitmap error in git gc.
In-Reply-To: <2ba66542-9ae2-4b13-ae6b-f37dec6b72c7@app.fastmail.com>
        (Kristoffer Haugsbakk's message of "Wed, 06 Sep 2023 18:00:26 +0200")
References: <CAPMMpoixKnr4BkKd8jeU+79Edhqtu4R7m8=BX4ZSYKdBHDzK=w@mail.gmail.com>
        <b5833396-7e04-465f-96f6-69d5280fa023@app.fastmail.com>
        <CAPig+cQoiqeZF52Jr45an+cZF+ZQbHPXtLVn+VmyegjMQaJqCg@mail.gmail.com>
        <2ba66542-9ae2-4b13-ae6b-f37dec6b72c7@app.fastmail.com>
Date:   Wed, 06 Sep 2023 10:52:16 -0700
Message-ID: <xmqq5y4nnq9b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1F037034-4CDE-11EE-ADF7-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> But not with =E2=80=9Cworktree=E2=80=9D:
>
>   =E2=80=9C A repository can have zero (i.e. bare repository) or one or=
 more
>     worktrees attached to it. ...
>
> Since this entry claims that =E2=80=9Cbare repository=E2=80=9D and =E2=80=
=9Czero worktrees=E2=80=9D are
> equivalent.

I wrote that "(i.e. bare repository)" in 2df5387e (glossary:
describe "worktree", 2022-02-09) but did not mean that way. =20

A non-bare repository can reduce the number of its worktrees, but it
cannot go below one, because the directory with working tree files
and the .git/ subdirectory, i.e. its primary worktree, must exist
for it to be a non-bare repository.  Consequently a repository with
zero worktree is by definition a bare repository.

But that does not have to mean all bare repositories can have no
worktrees.

