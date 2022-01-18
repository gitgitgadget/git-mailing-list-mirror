Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42ED8C433FE
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 17:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347230AbiARR0E (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 12:26:04 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52905 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347105AbiARR0D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 12:26:03 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DABBD169A2E;
        Tue, 18 Jan 2022 12:26:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NN5hAk8OiggN
        89Jp/R6078PQMDDI3LxTHb3enA4Alfk=; b=seFthwTEjoiQcnK0VwOlc9hZMkrL
        jF0WhqTCy3H5j1QLlIdcbDq9WTrctjxpFmo9OjBE3lKB8itQH4P7DSEP+FfrmThu
        jloCrrMGf7CoiV4Zb1xLtvlDsDQ0oJ/uU9Zx0SsCaQGm0BLbVXnEaJPTmf4ev6m3
        tvsszcLIx0Gqa2s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D44FE169A2D;
        Tue, 18 Jan 2022 12:26:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3F5E6169A29;
        Tue, 18 Jan 2022 12:26:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, rsbecker@nexbridge.com,
        Taylor Blau <me@ttaylorr.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 2/2] wrapper: use a CSPRNG to generate random file names
References: <20220104015555.3387101-1-sandals@crustytoothpaste.net>
        <20220117215617.843190-1-sandals@crustytoothpaste.net>
        <20220117215617.843190-3-sandals@crustytoothpaste.net>
        <220118.86zgntpegy.gmgdl@evledraar.gmail.com>
        <3a2b17ac-6ce2-cc29-6993-a9718df61741@web.de>
Date:   Tue, 18 Jan 2022 09:25:59 -0800
In-Reply-To: <3a2b17ac-6ce2-cc29-6993-a9718df61741@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 18 Jan 2022 15:42:32 +0100")
Message-ID: <xmqq7daxt0pk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B44EF1C6-7883-11EC-AA43-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>> This series really feels like it's adding too much complexity and
>> potential auditing headaches (distributors worrying about us shipping =
a
>> CSPRNG, having to audit it) to a low-level codepath that most of the
>> time won't need this at all.
>
> Good point.  Please let me think out loud for a moment.

Yeah, I agree you and =C3=86var that the topic may be over-engineering
the solution for problem that we shouldn't be the ones who solve.

I agree with your analysis that the "diff" tempfiles do need suffix,
we SHOULD create them in $TMPDIR (not in the working tree or
$GIT_DIR) to support operation in a read-only repository, but we can
create a unique temporary directory and place a file (even under its
original name) in it as a workaround.

Thanks.

