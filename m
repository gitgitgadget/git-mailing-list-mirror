Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE94C433F5
	for <git@archiver.kernel.org>; Mon, 16 May 2022 05:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbiEPF1L (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 01:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiEPF1K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 01:27:10 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F325BC14
        for <git@vger.kernel.org>; Sun, 15 May 2022 22:27:08 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E68C1129468;
        Mon, 16 May 2022 01:27:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=yCHzmCS5Csu8HtnGkJE9N2u0nBOfBh9MLLVP/hcMxzo=; b=aylI
        SNPSdefcy+s145kbGcooE4ooVh8kgrBQ/s/ZomKmaEyQ++R5h04TBozDNSy4GSIY
        rp1fUxN2Rq/94w3g3cPBJWGf2LfK5tdmn/egd8M+gutad1vVQY1YtGNi8CSHt8fE
        V0Wx4JHpnpRhq6uee5mtMeQVVA27UCS5HEt+NhU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C822D129466;
        Mon, 16 May 2022 01:27:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DA48F129465;
        Mon, 16 May 2022 01:27:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, bagasdotme@gmail.com,
        johannes.Schindelin@gmx.de,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 3/4] t0034: add negative tests and allow git init to
 mostly work under sudo
References: <20220510174616.18629-1-carenas@gmail.com>
        <20220513010020.55361-1-carenas@gmail.com>
        <20220513010020.55361-4-carenas@gmail.com>
        <xmqqee0ycjos.fsf@gitster.g>
        <CAPUEspj1JTG2Ujuk4O6ogo6qEQEwe-2aHF8J95xjX+OpY4cenQ@mail.gmail.com>
        <xmqqr14u7n4l.fsf@gitster.g>
        <CAPUEsphNOf37WB_xUuRNdfcz1TRRsSocbUoCbrmA3OjS_BTpdw@mail.gmail.com>
Date:   Sun, 15 May 2022 22:27:04 -0700
Message-ID: <xmqqo7zy59p3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D2F7FB3E-D4D8-11EC-B50C-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

>> Hmph, it may not be needed, but it should still work, in which case
>> it probably is still worth testing, even with the optional patch #4.
>
> Just because it works, it doesn't mean we have to test it.

Yes.  It all depends on the answer to this question: Is it
reasonably expected that any half-way intelligent Git user would not
be surprised to learn that "sudo sudo git status" would be a way to
work on a repository that is owned by root as root?  Given that
"sudo git status" is a good way to work on a repository that is
owned by you as root, perhaps the answer is yes, but I am not
a representative sample ;-)

If the answer is yes, then we would want to make sure it will
continue to work by having a test to protect it from future
breakage.  If not, and "sudo sudo git" (or worse "sudo sudo sudo
git") is something that would be imagined by the most wicked mind
and no sane person would imagine it would be a way to achieve
something useful, no, it does not have to be protected from any
future breakage.

So...
