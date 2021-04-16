Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5536FC433ED
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 18:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17448610FB
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 18:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238884AbhDPSdZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 14:33:25 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51550 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236085AbhDPSdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 14:33:25 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EECC21158E0;
        Fri, 16 Apr 2021 14:32:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dhkKqwcooglI
        ByIImQ7b4+DR+hw=; b=pNRgNkwLoneK45YdHDIQbGqOawEpjYOnw3qa7sGISL6y
        xQ1X8E9IzfzWoobEeZ4wKlwSG9AO+TboSeqdNFNq57W+982rQ3TFVsFBO6KcK/V4
        IWE9NqiqPTQlx9VQJr+bhiJT9787VBYQQKObGwb/HMifl9F0byQisTW1cXWg9Yw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=sbMfiI
        /UofCKc61NluKmfdjLaOqLD71/GvAxVNzafE0u5JzArslUH4JUV9+bEaYODa1PFn
        8Z1QWKqOb1+gId1+1HK5URlI9iVVmi441cWZHQ/OPy0C6rfej+/c9cw60GY5wGIZ
        PA+v3m42WdZmGhGoyViJsWqGwj3QpPJKXlWi0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E7A011158DF;
        Fri, 16 Apr 2021 14:32:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2B6401158DE;
        Fri, 16 Apr 2021 14:32:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] diff tests: rewrite flakyness-causing test "aid"
References: <patch-1.1-f0542cd902c-20210413T121930Z-avarab@gmail.com>
        <cover-0.2-00000000000-20210413T122645Z-avarab@gmail.com>
        <patch-2.2-c2cb52b6605-20210413T122645Z-avarab@gmail.com>
        <CAHd-oW4G+7z3UM3qjhPp=2oqOPE4a49fweew0n+gheGtQEy5VA@mail.gmail.com>
        <87fszu2elw.fsf@evledraar.gmail.com>
        <CAHd-oW6D7Tmp2TmrmGvXDt-NnT_wxhfr_bn_P_7=ot=m_2eyyA@mail.gmail.com>
        <874kg92xn0.fsf@evledraar.gmail.com> <xmqqim4pz83e.fsf@gitster.g>
        <871rbd2u47.fsf@evledraar.gmail.com> <xmqqblahz4hx.fsf@gitster.g>
        <87y2dl18mg.fsf@evledraar.gmail.com> <xmqqlf9krmkx.fsf@gitster.g>
        <8735vrvg39.fsf@evledraar.gmail.com>
Date:   Fri, 16 Apr 2021 11:32:55 -0700
In-Reply-To: <8735vrvg39.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 15 Apr 2021 15:21:14 +0200")
Message-ID: <xmqqsg3qm65k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2A268EBC-9EE2-11EB-93E0-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Are you thinking of the case where someone wants to add N new lines to
> the "while read magic cmd" loop?

No.  I think stopping with BUG is fine.  Adding a new test is a
serious event and I'd prefer to make it stop to give it undistracted
attention by the developer, instead of letting many to be handled at
once.

Of course, we _could_ instead remember the fact that we deposted
newly proposed expectation pattern that the user must audit, still
keep going and list the new files at the end, but I do not think it
is necessary.  Your newly added BUG is perfectly fine.=20

>>> In any case, I think it's best to just drop this series.
>>
>> That is a sad and wrong conclusion.  We should just realize what we
>> really wanted to fix in the first place and keep the improvement;
>> otherwise all the review time was wasted.
>
> To be clear that's not some "I can't have the change I want so I'm
> taking my toys and going home" tantrum. I don't mind making changes in
> response to reviews etc.
>
> As noted above I'm genuinely still unable to see how I'd selectively
> untangle the change I made in a way that both wouldn't either fix bugs
> in the test, or introduce new bugs while I was at it, and that I'd be
> comfortable putting my name behind.

I fail to see why the "rewrite flakyness-causing test aid" that you
set out to perform should need more than a two-liner change.  There
is no reason to touch '&& rm "$actual" actual expect' at the end.
It is the success case where the flakyness-causing "aid" does not
even kick in.

 t/t4013-diff-various.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git c/t/t4013-diff-various.sh w/t/t4013-diff-various.sh
index 6cca8b84a6..da6da13920 100755
--- c/t/t4013-diff-various.sh
+++ w/t/t4013-diff-various.sh
@@ -229,8 +229,8 @@ do
 			rm -f "$actual" actual expect
 		else
 			# this is to help developing new tests.
-			cp "$actual" "$expect"
-			false
+			mv "$actual" "$expect.new"
+			BUG "No $expect; check $expect.new and use it perhaps?"
 		fi
 	'
 done <<\EOF
n
