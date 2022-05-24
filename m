Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53A5C433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 19:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240968AbiEXTiy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 15:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiEXTix (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 15:38:53 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3327520C
        for <git@vger.kernel.org>; Tue, 24 May 2022 12:38:51 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B00D812ADC7;
        Tue, 24 May 2022 15:38:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=shO2YbzuTdK+
        G1FSqrVwp1dEMH7yMNOQ9jRuF8mQQMk=; b=pWRZPoi++zIwPI8jOsJ+VBBaTjHS
        h/Qm+amj8tblBHMC6V+EdswaX6bOJwPCYnsVv5uBrQUN+SF3wTKqMk76asXjUv7i
        6CMxYCvJ6+eqLhSQP/afsUG+cdPldCCH2Ua8CMRynBlv/YIXa2+znbV7xvDC8piN
        gOQdbx4RlgWx6ZE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A74C612ADC6;
        Tue, 24 May 2022 15:38:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1630112ADC5;
        Tue, 24 May 2022 15:38:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>
Subject: Re: [PATCH] diff: fix a segfault in >2 tree -I<regex> and
 --output=<file>
References: <a6a14213-bc82-d6fb-43dd-5a423c40a4f8@web.de>
        <patch-1.1-f7fd645468c-20220523T182954Z-avarab@gmail.com>
        <xmqqleusqaff.fsf@gitster.g>
        <220524.86leurw3my.gmgdl@evledraar.gmail.com>
Date:   Tue, 24 May 2022 12:38:49 -0700
In-Reply-To: <220524.86leurw3my.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 24 May 2022 13:38:16 +0200")
Message-ID: <xmqqmtf6hgae.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 22BEF764-DB99-11EC-AC47-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I.e. the "right" thing to do in this case would require a much more
> involved fix. We've somehow ended up not supporting --output=3D<file>, =
-I
> and probably many other options in the combined-diff mode, which both i=
n
> testing and in this part of the implementation seems to have become an
> afterthought.

OK, a hopefully final question.

How much less involved is it to add a new code (without doing
anything in this patch) to detect and die on the combination of
combined-diff with these two options, so that we can document the
fact that we do not support them?  It would give us much better way
forward than leaving the command silently ignore and give result
that is not in line with what was asked, wouldn't it?  That way, the
much more involved "fix" will turn into a change to add a missing
feature.

Thanks.

