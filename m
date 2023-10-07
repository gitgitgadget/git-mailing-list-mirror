Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B19E92FFD
	for <git@archiver.kernel.org>; Sat,  7 Oct 2023 06:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343587AbjJGGty (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Oct 2023 02:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343577AbjJGGtw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Oct 2023 02:49:52 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB470B9
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 23:49:51 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 36CC91F3FE;
        Sat,  7 Oct 2023 02:49:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=ygunUwCbBZlWwmcEaG05hsT1J77TIwmXi1gsOG
        CblrI=; b=BHshyLhfpuLzMvC5ww+6tQid5iep+wlaXYyh1UsvzAKFKoPTJ+Btur
        BDUgnIbjCXWUmwtcXEAoiODxDgYhv7F+IfqdPDpCgAhXXicuWX0gKECPaprwKNzm
        w7od1+AdVHjvuLHUOcIHIcuygTYidenn/xbimfj5TJYLoSNxs76zw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 232131F3FD;
        Sat,  7 Oct 2023 02:49:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 90E951F3FC;
        Sat,  7 Oct 2023 02:49:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] diff-merges: improve --diff-merges documentation
In-Reply-To: <xmqqjzrz5hgn.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        06 Oct 2023 18:50:16 -0700")
References: <20230909125446.142715-1-sorganov@gmail.com>
        <20231004214558.210339-1-sorganov@gmail.com>
        <20231004214558.210339-2-sorganov@gmail.com>
        <xmqq34yog3ux.fsf@gitster.g>
        <CABPp-BFsrt0zS3NHsVAyOSW6vGioe8Z-iN2M3_JNBpP2fWVq9g@mail.gmail.com>
        <xmqq7cnzaav0.fsf@gitster.g>
        <CABPp-BGxVnhnmoajWyqY_gMvQ42W5S6VX5EOXq3PW=GLVQwe0g@mail.gmail.com>
        <xmqqjzrz5hgn.fsf@gitster.g>
Date:   Fri, 06 Oct 2023 23:49:46 -0700
Message-ID: <xmqqmswv3p11.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B4A17926-64DD-11EE-BBFD-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Elijah Newren <newren@gmail.com> writes:
>
>> In my opinion, --remerge-diff does this better; wouldn't we want a
>> ...
> I personally find that a very trivial merge resolution is far easier
> to read with --cc than --remerge-diff, the latter being way too
> verbose.
>
> Also, --cc and -c should work inside a read-only repository where
> you only have read access to.  If remerge needs to write some
> objects to the repository, then you'd need some hack to give a
> writable object store overlay via the alternate odb mechanism, or
> something, right?

Well, the above did not come out as well as I intended, as I forgot
to prefix it with something I thought was obvious from what I said
in the recent discussion in the earlier iteration of this topic,
where I said that it would be "--remerge-diff", if I were to pick an
option that is so useful that it deserves short and sweet single
letter.  Narutally, it came after we gained experience with "--cc",
so it would be surprising if it did worse.  Just like it is natural
to expect that "--cc" would give more useful output than "-m -p"
that predates everybody else.

In short, I would say "--remerge-diff" would give output that is the
easiest to grok among the three modern variants to show the changes
a merge introduces.

The above two cases, where I said cc does better than remerge-diff,
were meant as _exceptions_ for that general sentiment.
