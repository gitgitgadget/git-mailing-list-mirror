Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A596C28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 04:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiHVESh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 00:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiHVESg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 00:18:36 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1871463DC
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 21:18:31 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 31AD5154C28;
        Mon, 22 Aug 2022 00:18:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=byfmsKg2rBRz
        U5X502E9RyRdCpNXO0JDaTyqUJ0VTu8=; b=sDMxFuGMulhUYDmaRH3FyXjb81Cx
        H1y6V6xLi3zemMNjWwjJJ1KsewVhCCiIlRjzOC/+qZWiEbnVJuYFra9AsL4q8uwR
        96jQryjQ9Y8OZHFv2UM86PNai/SCBGaN5zYPhS/qw5zTbdljTBpGCvNAEqjwWnJL
        Db+ZL4QN+5FfTl0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 17034154C26;
        Mon, 22 Aug 2022 00:18:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6D0D6154C24;
        Mon, 22 Aug 2022 00:18:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        meta@public-inbox.org
Subject: Re: `git patch-id --stable' vs quoted-printable
References: <20220822022503.M873583@dcvr> <xmqqczcsgbvn.fsf@gitster.g>
Date:   Sun, 21 Aug 2022 21:18:26 -0700
In-Reply-To: <xmqqczcsgbvn.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
        21 Aug 2022 21:06:52 -0700")
Message-ID: <xmqq7d30gbcd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7942EA22-21D1-11ED-ACA8-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> So, I'm wondering if the search indexing code of public-inbox
>> should s/^$/ /mgs before feeding stuff to `git patch-id'; and/or
>> if `git patch-id' should be assuming empty lines and lines with a
>> single SP are the same...

Another potential source of issues (not for the patch from Ren=C3=A9 that
was used as an example) is that a patch producer can use different
diff algorithm from the setting you would use to index resulting
commits via "git show | git patch-id".

    $ git show -U5 | git patch-id
    $ git show | git patch-id

likely result in different patch IDs. =20

The --patience and the --histogram options affect how common lines
are matched up, again affecting the shape of the patches you compute
patch-ids over.
