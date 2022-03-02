Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9968C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 19:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240510AbiCBT1N (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 14:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241509AbiCBT1H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 14:27:07 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1519AC4B45
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 11:26:14 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2747811CE19;
        Wed,  2 Mar 2022 14:26:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=wYg5WC87RbM5
        DUSmYv109B1e0HikLCCpuowlt8nmkXk=; b=nf3SkwU0YjG2YfnglesqZrTMd2+d
        10JsX/AzMGBb9vle1tMlCTXNeLqdC9s5qlSr4HWSMMF2j15kj6wAUoOYZ3C9MjsG
        kgaajfIWtp4kJbGMBFt8aTz+0Q7WPpu8xNdnKWSEb2PjGfz7c8Djv6kZC+wG2Gyl
        YTI6qFY0hwPLvZU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E07511CE18;
        Wed,  2 Mar 2022 14:26:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 738B211CE15;
        Wed,  2 Mar 2022 14:26:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4 8/9] Makefile: use $(wspfx) for $(QUIET...) in
 shared.mak
References: <cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com>
        <cover-v4-0.9-00000000000-20220302T124320Z-avarab@gmail.com>
        <patch-v4-8.9-3733b0c8df1-20220302T124320Z-avarab@gmail.com>
Date:   Wed, 02 Mar 2022 11:26:12 -0800
In-Reply-To: <patch-v4-8.9-3733b0c8df1-20220302T124320Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 2 Mar
 2022 13:49:16
        +0100")
Message-ID: <xmqq8rtskvfv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9F7BD4F6-9A5E-11EC-BB1A-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the mostly move-only change in the preceding commit to use the
> $(wspfx) variable for defining the QUIET padding. This refactoring
> will make it easier to emit that exact amount of padding in functions
> that we might add to shared.mak in the future.
>
> Such a function is not part of this patch series, but a
> "TRACK_template" that I'd like to add as a follow-up to it makes use
> of this. Let's make this change now while modifying these QUIET rules
> is fresh in our minds.

I do not see why this change is still part of this series, then.

>  ## Used in "Makefile"
> -	QUIET_CC       =3D @echo '   ' CC $@;
> -	QUIET_AR       =3D @echo '   ' AR $@;
> ...
> +	QUIET_CC       =3D @echo $(wspfx_SQ) CC $@;
> +	QUIET_AR       =3D @echo $(wspfx_SQ) AR $@;
> ...

Look how much uglier these lines got.

Without the benefit TRACK_template brings us, whatever that is, this
change looks more of an unnecessary churn.  Let's leave it to the
later series that introduces the user that justifies this change.

