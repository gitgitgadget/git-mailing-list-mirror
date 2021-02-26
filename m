Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41269C433E0
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 22:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9CE164ECE
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 22:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhBZWcX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 17:32:23 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61556 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhBZWcW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 17:32:22 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 83FC810B3A5;
        Fri, 26 Feb 2021 17:31:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WQFqdrNdQtRv
        QbrMSQCaaCQUKxg=; b=m9rgP3WIfpdBnhVn6jf/f8zUZlA9sQbWL3oKNZOY3MOh
        qT3hvKmUxyBYGggxnz4XG10vxTGBYG/dCrEaWiQjZ7krMlYBl0UfOQi8Dt/MNy7O
        A4IsgtIWPWvvOWP68SkSDNkqvqXdDniwrcQbgSr7tiPNtMni0wn9bOKUfOqQ4YM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Og1PLH
        xNpRg/4/0lieIy5vk9To1zK6O0BggzNx+wUqUzMpa7zjlJsi0Jn3KzHoOtqCDCEz
        Q+nQlpnp1ipPQoRkGNxjaFIQFHkeI4rZAPsF1YzAcWXAv6onMobamG1qPpyNGlQp
        TzYdw+41j/rgRf2rj2ucx2vPcF/l0cF2qxmjI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7C6FA10B3A2;
        Fri, 26 Feb 2021 17:31:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C4BFC10B3A1;
        Fri, 26 Feb 2021 17:31:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jean-Marie Lemetayer <jeanmarie.lemetayer@gmail.com>,
        git@vger.kernel.org
Subject: Re: [RFC] new subcommand: git sync
References: <CAAdc0hwmR7BF53_66LNaceLrkFPDphU-y2sLEGB_1YoR5ErQsg@mail.gmail.com>
        <87tupy7sx6.fsf@evledraar.gmail.com>
Date:   Fri, 26 Feb 2021 14:31:36 -0800
In-Reply-To: <87tupy7sx6.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 26 Feb 2021 16:25:09 +0100")
Message-ID: <xmqq35xisbp3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 63ABC854-7882-11EB-8AEA-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> B.t.w. you can probably speed up & simplify your script a lot by making
> use of IFS=3D"" in the shell and not calling N for-each-ref commands wh=
en
> it seems to me that one invocation would do. Just dump the N fields you
> need split on some token, and split on that token in your loop.

A hidden gem in for-each-ref is its ability to quote the placeholder
values in a language specific way, and that is to allow the --format
to generate a script that can be eval'ed.  E.g.

  $ git for-each-ref --shell \
    --format=3D'doit %(authorname) %(subject)' refs/heads/ab/\* |
    head -n 3
  doit '=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason' 'branch: show "HEAD detac=
hed" first ...'
  doit '=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason' 'CoC: update to version 2=
.0 + local ...'
  doit '=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason' 'config.mak.uname: remove=
 unused NEE...'

so that you can prepare

	doit () {
		person=3D$1 subject=3D$2
		... do things on the branch data ...
	}

beforehand and then eval the output from the script you wrote with
"git for-each-ref".


