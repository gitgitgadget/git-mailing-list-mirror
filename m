Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BFDC433E0
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 18:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4067652AB
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 18:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhCHSGo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 13:06:44 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59793 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhCHSG2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 13:06:28 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6BB9EA04BE;
        Mon,  8 Mar 2021 13:06:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=m21hTJxj9zRE
        AqZqftpzzXLRhXo=; b=GmsgqbYSQ1MY7bWJHsAxyKpTNzLKWsabhlq1Bs1hpGKo
        s/ye5YuslvutYW61t5/PWV/gykwuMmUNXnCix7rEr6SxyWpxcEV5peFjnk+gObA6
        dlU5yLaUaoWsAbppxClipyIFS6jz8JRa6EGzi14XGoOobbZpZ8JlTpcvenmBLyE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=G+98bs
        abt6T6tiSvC8ZZ1E/+/2Fz61YC79MeVR3FJKpk3qJZ8z3L0+v4FSjvhmyxa2Xra7
        U3zfF2Xk8W9Zd9y8LKmTzw6rAsUZYO7N6g5quWb5xS6xRCwlAr2UsHvJsUGV+t97
        SISIAqtU2r2mt0VlfNk8bxqS1deMNXTf850Ic=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 648ABA04BC;
        Mon,  8 Mar 2021 13:06:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E3540A04BB;
        Mon,  8 Mar 2021 13:06:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 2/6] tree.c API: move read_tree() into
 builtin/ls-files.c
References: <20210306193458.20633-1-avarab@gmail.com>
        <20210308022138.28166-3-avarab@gmail.com>
Date:   Mon, 08 Mar 2021 10:06:27 -0800
In-Reply-To: <20210308022138.28166-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 8 Mar 2021 03:21:34 +0100")
Message-ID: <xmqq5z217c64.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 00C6EA3E-8039-11EB-89F1-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Now builtin/ls-files.c is the last user of this code, let's move all
> the relevant code there. This allows for subsequent simplification of
> it, and an eventual move to read_tree_recursive().

A nice goal to keep in mind while reading the series.

Is one already a subset of the other, or does the surviving version
need to gain a bit more feature or performance to replace the other?

Thanks.
