Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41127C4BA21
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 20:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA8A24653
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 20:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AluAw067"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbgBZUoe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 15:44:34 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62588 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbgBZUod (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 15:44:33 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EEA70B9190;
        Wed, 26 Feb 2020 15:44:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sAajU8xBI4nXC3I0X0jQtmtucsE=; b=AluAw0
        67wA7UvTIdIWB/n+GTneNmE/IkSzVhiHgNfv5sn1+meGFLcU1/aHVey3/keXX1k5
        Jaq3ELErF7EsAd9XfhhLjnU4RgizZ838E+yggVB27n7EKMG4NOa8tT2Ovu1rh/7Q
        aidkLsG2lNFDLA/8d0wVZM8fu/rOqEG2GUM7c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OyFdsq85j8xpwOQbLMm649pAoUt6Seew
        tFSo3d3J97GrEd6mBiqOB4nPmJ7VO9ss45PAcgA/4sCAhWcVDY1hCjBix5at56kX
        aRQAJAloYwq9vP0XhdRbqrY9lQ1/SfagbAaw2a8cZS5I+Wn2WfO9jedG7HVLkh+Z
        CVSK+7KBFm0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E70A9B918F;
        Wed, 26 Feb 2020 15:44:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2255EB918E;
        Wed, 26 Feb 2020 15:44:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heba Waly <heba.waly@gmail.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] advice: revamp advise API
References: <pull.548.v4.git.1582557199.gitgitgadget@gmail.com>
        <pull.548.v5.git.1582628141.gitgitgadget@gmail.com>
        <b7f10d060a41c1ef3d25e4c07be3747c7902b997.1582628141.git.gitgitgadget@gmail.com>
        <xmqqsgiymupf.fsf@gitster-ct.c.googlers.com>
        <CACg5j27SfWsj2t_z8zxOvjc6MSot2yMi1J+R4HJinFhHgTpveg@mail.gmail.com>
        <xmqqy2sql405.fsf@gitster-ct.c.googlers.com>
        <CACg5j25EdX2fPHpAq3TEhaJPiQg4dA52soOyCMm17wg_O-c4Ng@mail.gmail.com>
        <xmqq8skqkq35.fsf@gitster-ct.c.googlers.com>
        <CACg5j24F=rU1EKPpq-TnMOUNLZqT3HTJZXuCXORVtPPa=hK-Cg@mail.gmail.com>
Date:   Wed, 26 Feb 2020 12:44:26 -0800
In-Reply-To: <CACg5j24F=rU1EKPpq-TnMOUNLZqT3HTJZXuCXORVtPPa=hK-Cg@mail.gmail.com>
        (Heba Waly's message of "Thu, 27 Feb 2020 09:28:20 +1300")
Message-ID: <xmqq7e09hydx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C8B2FAB2-58D8-11EA-B49F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heba Waly <heba.waly@gmail.com> writes:

> variable. On the other hand, I understand that you'd prefer to skip
> the extra step of converting the enum to string.
> hmmm ok, I'll change the enum and send a new version soon.

To avoid misunderstanding, I do not object to enum based approach at
all.  In fact, I'd rather prefer it over bunch of const strings that
can be checked by the compiler.  What I do not prefer compared to
either of these approaches is to accept enum from the caller and
convert it to string to consult config API every time, which is
worse than "bunch of const strings".

Thanks.
