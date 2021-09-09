Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38E0C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 19:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2F44610A3
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 19:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237677AbhIITxQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 15:53:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63934 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbhIITxP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 15:53:15 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 11D04EFAC4;
        Thu,  9 Sep 2021 15:52:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Et2g2BzRTP+j
        R/MsIuEktgQFSOCUgfkC0U9ibeUGjqY=; b=NmbOduSGSbaiNz6N+xgta2zW+Hnc
        noHJnjFbMUb3izFPOCkGxPRzL4Ro+h6vsNqVCrAW6OdetqkYFeV+jUrTAlIJlYki
        cNednx7HUOXcniKX1YNt0gySNy5f4Dhy1Ug67o+Vg2CU5ySMwunazviSvZex5r1v
        R9DNua/+Brdi7yI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0851DEFAC3;
        Thu,  9 Sep 2021 15:52:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6CC83EFAC0;
        Thu,  9 Sep 2021 15:52:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH 9/9] pack-objects: rename .idx files into place after
 .bitmap files
References: <cover.1630461918.git.me@ttaylorr.com>
        <cover.1631157880.git.me@ttaylorr.com>
        <d8286cf1075dc85231128145c5abb0db3881032b.1631157880.git.me@ttaylorr.com>
        <878s06fa14.fsf@evledraar.gmail.com>
Date:   Thu, 09 Sep 2021 12:52:03 -0700
In-Reply-To: <878s06fa14.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 09 Sep 2021 09:54:44 +0200")
Message-ID: <xmqqr1dxy1b0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 680E944E-11A7-11EC-904C-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>     We fsync() the file descriptors we're writing out for all the
>     auxiliary files, but we don't yet fsync() the file descriptor for
>     the containing directory. Therefore our data might have been writte=
n
>     out, but it's anyone's guess what the state of the directory
>     containing the file is after we write the *.idx.
>
>     In practice modern OS's are known to be forgiving on that point, so
>     this will probably solve races in practice for most users. It will
>     almost certainly make them better than they were before when we
>     didn't write *.idx files last. We should more generally improve our
>     use of fsync() to cover containing directories, but that'll
>     hopefully be addressed by some follow-up series.

I'd probably drop the last paragraph, and replace it with a single
sentence "we may want to fsync the containing directory once after
placing *.idx file in place, but it is outside of the scope of this
series", if I were doing this series.

Other than that (and I made a few comments on other patches), these
were pleasant read.

Thanks.
