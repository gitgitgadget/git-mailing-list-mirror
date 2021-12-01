Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22436C433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 19:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244557AbhLATDk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 14:03:40 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62884 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244354AbhLATDe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 14:03:34 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 596FB172098;
        Wed,  1 Dec 2021 14:00:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JzRKScpq4AxUXpcyegZaAgmkBGQEFDZsne3WMZ
        G5414=; b=gmE26OrtwqBzv88yhfoSVjjtZbYqt0ZeNfzN96vy+1SwhNq42Q/69h
        fISJ+kihGJ44aiAWZ1pQoqxVcaNppmgSS1XsJgb8FJhttiw5potsW9X015rmF+O3
        XsissJgog3rNzQ+YYYHtPGlWHg/rh0qnBFLMi7/bas83+VmpEuHm0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 51842172097;
        Wed,  1 Dec 2021 14:00:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C1BE3172088;
        Wed,  1 Dec 2021 14:00:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 4/6] refs: add REF_SKIP_REFNAME_VERIFICATION flag
References: <pull.1147.git.git.1637855761.gitgitgadget@gmail.com>
        <pull.1147.v2.git.git.1638211786.gitgitgadget@gmail.com>
        <0a297f0c3e884c2d4cfb24a6d3b9f1973fc83125.1638211786.git.gitgitgadget@gmail.com>
        <xmqqbl224k09.fsf@gitster.g>
        <CAFQ2z_M35tbF6+C2MkMRm7hO8CNdUSrGTcx+8Os348+rHu4ojg@mail.gmail.com>
Date:   Wed, 01 Dec 2021 11:00:04 -0800
In-Reply-To: <CAFQ2z_M35tbF6+C2MkMRm7hO8CNdUSrGTcx+8Os348+rHu4ojg@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Tue, 30 Nov 2021 11:31:39 +0100")
Message-ID: <xmqqh7bs177v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E57ABD82-52D8-11EC-A976-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Tue, Nov 30, 2021 at 12:31 AM Junio C Hamano <gitster@pobox.com> wrote:
>> > +     if (!(flags & REF_SKIP_REFNAME_VERIFICATION) &&
>> > +         ((new_oid && !is_null_oid(new_oid)) ?
>> > +                  check_refname_format(refname, REFNAME_ALLOW_ONELEVEL) :
>> > +                        !refname_is_safe(refname))) {
>>
>> So, if somebody passes REF_SKIP_REFNAME_VERIFICATION in flags, we
>> will not do the check.
>>
>> Again, like 3/6, this new bit is flipped on by test-helper
>> somewhere?  Again I do not see anybody doing so in these 6 patches,
>> but I should double check.
>
> The test helper takes the flag as an argument, in decimal. If you look
> for 2048, you should find it.

Awful---when the symbolic constants change in the code, the test
will silently break?

It has been this way since 80f2a609 (t/helper: add test-ref-store to
test ref-store functions, 2017-03-26), so it is nothing new, but at
some point, we should do a better job.  Even if it is used only as a
tool for testing, we shouldn't have to force developers to write in
assembly ;-)

Perhaps when the dust settles after this series graduates to be a
part of released version.  It may be a good bite-sized microproject
material for aspiring new developers.



