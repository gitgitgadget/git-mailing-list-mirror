Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC66C4332F
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 17:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60CF161073
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 17:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhKCRXQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 13:23:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60318 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbhKCRXO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 13:23:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 84919F3AFD;
        Wed,  3 Nov 2021 13:20:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=yQHM37HlB8Ac
        tLqtWwoSA0SZ07Xy4oPsNlr9keoBnKI=; b=ctTR95YJzLaALQwgjYiaBUIMgsrM
        AWgAytUD/0rFMUDCBtlJ5yO0eTgfJFLhPpEQI9T0jKLXA860GJ8isAVCJGewzUVU
        dhvItnQqTtaMmHt/ngT9FvX19CYX/umrqeFbOUcOAlt5g0uXU5Y2WZfstpFxrOE7
        z5XUeCURLxBes9k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6FFBFF3AFC;
        Wed,  3 Nov 2021 13:20:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D52C3F3AFB;
        Wed,  3 Nov 2021 13:20:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: disallow directional formatting
References: <pull.1071.git.1635857935312.gitgitgadget@gmail.com>
        <211102.86tugu1svc.gmgdl@evledraar.gmail.com>
        <YYFdu/+j8ba+hjCF@nand.local>
Date:   Wed, 03 Nov 2021 10:20:34 -0700
In-Reply-To: <YYFdu/+j8ba+hjCF@nand.local> (Taylor Blau's message of "Tue, 2
        Nov 2021 11:48:11 -0400")
Message-ID: <xmqq35od88bh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5B908A12-3CCA-11EC-B86F-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Tue, Nov 02, 2021 at 04:01:57PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>> There's a parallel discussion about doing something to detect this in
>> "git am", which for the git project seems like a better place to put
>> this.
>
> I don't think that one impacts the other necessarily. Having `git am`
> guard against this would probably be sufficient to protect Junio
> accidentally apply something containing directional formatting to his
> tree unknowingly.
>
> But the idea that we rely on the import mechanism to protect against
> this doesn't sit well with me. Ultimately, we should be relying on a
> static check like below to ensure that directional formatting hasn't
> entered the tree by any mechanism (not just 'git am').

Yes.  Quite honestly, such a check shouldn't be in "am" proper at
all.

Rather, for am users who care, they should protect themselves with
something like the pre-applypatch hook, which can perform the same
check as their pre-commit hook to protect their other commits.
