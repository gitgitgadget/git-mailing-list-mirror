Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E70C433F5
	for <git@archiver.kernel.org>; Sat, 15 Jan 2022 01:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbiAOBTj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 20:19:39 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64717 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbiAOBTj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 20:19:39 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E756B16B895;
        Fri, 14 Jan 2022 20:19:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GzMKtinMBvCF
        9D9lBq/vGB+AFd/SsGNEgh3i2IOYfEU=; b=x16YeOV4y2WiqDC2eV/094SYRuhl
        4NhctSCQfsR8/vfIUKvkhLgLZeU1eSMHrxqxWTvkDyUuGojfI/z+Jyy0zFcqap19
        OQaIZ28yH7Cx0mHTIkazaOV39XJ4hTZfbV0WfvaqIUPvZRajSQX51fhUoIGsIPQ0
        plZxHAVzrE+nh94=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DEEC516B892;
        Fri, 14 Jan 2022 20:19:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 599B716B888;
        Fri, 14 Jan 2022 20:19:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: [RFC PATCH v1 0/1] ls-remote: inconsistency from the order of
 args and opts
References: <cover.1642129840.git.dyroneteng@gmail.com>
        <xmqqfspqeun5.fsf@gitster.g>
        <220114.867db2rs0n.gmgdl@evledraar.gmail.com>
        <YeHnT1BcisbVvQHB@camp.crustytoothpaste.net>
        <220115.86pmotrgjo.gmgdl@evledraar.gmail.com>
        <xmqqr1996cw2.fsf@gitster.g>
        <220115.86czktrelu.gmgdl@evledraar.gmail.com>
Date:   Fri, 14 Jan 2022 17:19:35 -0800
In-Reply-To: <220115.86czktrelu.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 15 Jan 2022 02:02:15 +0100")
Message-ID: <xmqq8rvh6biw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 33F9C36E-75A1-11EC-988A-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Hence suggesting that the user just add "--" to resolve the ambiguity,
> as gitcli already discusses.

Sadly, requiring "--end-of-options" is a solution for a problem that
we didn't have to create.  If we didn't take options written after
arg,

    git rm --end-of-options foo -r
    git rm foo ./-r

to force "-r" to be interpreted as a filename wouldn't have been
necessary.  The presence of "foo" before "-r" would have been
sufficient.

I agree with you that, unfortunately, we'd need to teach a way (i.e.
"--" or "--end-of-options") to defeat this misguided GNUism in some
commands.  Even if users stick to "options and then args", sadly,
they need to know it.

But we do already explain "--" and "--end-of-options" in gitcli.txt
so we should be OK.
