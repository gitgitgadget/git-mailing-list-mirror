Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E603C433E6
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 00:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B1D764E2A
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 00:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbhBJAL7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 19:11:59 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57788 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234790AbhBJAHo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 19:07:44 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C3899A410;
        Tue,  9 Feb 2021 19:07:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Zs7Kfq2+3TQZ
        Ko6pFBtYD+fKH/E=; b=x4x+B98q1b579db//KahpKuSQUTPCTvgxTNJ5nAEA408
        VKFd6nr14IOviIZiCFMsNQJBAIz30rDoOJwOutXfGxT7W8CKq6QhLeU/RbhjSB6f
        1NyT194FQe4dRv5IuAo+3GGWyYdeqNoRruO/bPxov5vcnGHaP+hyQK6URqA8ZUg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=CKfoRF
        yfmqr7MehVapRwVAwu520iYbs/gFYo03UMrJmaMhGUM4hztH6Jl7rg9gT1hkBCMh
        jhxRL6ldTgKLvkM2087pWwxsJFr5WbIamO0HgjXBkjA2v6RUK0MSZoo6b9dcsumb
        YJsHDYAufhINn4SVZBVJ7liKZPyVL5ugVZiu8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 91D259A40F;
        Tue,  9 Feb 2021 19:07:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EC7DC9A40E;
        Tue,  9 Feb 2021 19:06:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 12/12] test-lib-functions: split out {debug,path,text}
 helpers
References: <20210209214159.22815-1-avarab@gmail.com>
        <20210209214159.22815-13-avarab@gmail.com>
Date:   Tue, 09 Feb 2021 16:06:59 -0800
In-Reply-To: <20210209214159.22815-13-avarab@gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 9 Feb 2021 22:41:59 +0100")
Message-ID: <xmqqpn18yee4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E553212E-6B33-11EB-A60E-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Split out the debug, path and text miscellaneous helpers into their
> own files. The "test -[efsd]" etc. helpers were not all in one place
> in test-lib-functions.sh, I think moving them into their own file
> makes it easier to follow the code.

I'd prefer not to see this done.  It would be fine to move them in
different sections but still in the same file to group related
helpers together, but I am having enough trouble when deciding to
look into which between test-lib.sh and test-lib-functions.sh in the
current organization already.  And it will make the situation even
worse if we did this, no?
