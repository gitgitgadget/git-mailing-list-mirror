Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8989BC433F5
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 18:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345406AbiCPSFi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 14:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236096AbiCPSFh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 14:05:37 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4602E0A5
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 11:04:21 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8458611EB32;
        Wed, 16 Mar 2022 14:04:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=byNdHdl0aehu
        QgjtVqaPrucTHvKinw7AH2ZJUg9Kn6k=; b=jrhONUj0HydPHVj+TqEs9cdvJJ+u
        ZIJi0CRDH7lV+GB9qaeC5AppC1dhjTIaPEjIovC87igT/dQWbNyFLrTEkhnwr33l
        mv746SKdCduNeJKsPAh2rVeKN734w/4U2J8VXfOJnn8hnJV+4WhRpdu9mMyTMT17
        PU0IpH6QaB9vrzQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C76211EB31;
        Wed, 16 Mar 2022 14:04:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E309811EB30;
        Wed, 16 Mar 2022 14:04:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] curl: streamline conditional compilation
References: <20220316140106.14678-1-gitter.spiros@gmail.com>
        <20220316140106.14678-2-gitter.spiros@gmail.com>
        <220316.86h77ydkfl.gmgdl@evledraar.gmail.com>
Date:   Wed, 16 Mar 2022 11:04:18 -0700
In-Reply-To: <220316.86h77ydkfl.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 16 Mar 2022 15:43:09 +0100")
Message-ID: <xmqqy219lqot.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 80909E78-A553-11EC-9352-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> The way it was being done before was intentional & discused on list.
>
> See my original
> https://lore.kernel.org/git/patch-v3-7.7-93a2775d0ee-20210730T092843Z-a=
varab@gmail.com/
> which did it pretty much like that, and Junio's subsequent
> follow-up. I.e. this breadcrumb trail:
> https://lore.kernel.org/git/?q=3DCURL_SOCKOPT_OK
>
>> -#if LIBCURL_VERSION_NUM < 0x071505
>> -#define CURL_SOCKOPT_OK 0
>> +#if LIBCURL_VERSION_NUM >=3D 0x071505
>> +#define GIT_CURL_HAVE_CURL_SOCKOPT_OK 1
>>  #endif
>
> IOW we should drop this.

I think that depends on the worldview.

In a world in which [PATCH 2/2] is a good idea, i.e. "we have a
comprehensive catalog of available cURL features, but it expresses
its knowledge in one particular way, i.e. HAVE_X", the above,
together with the change at the only use site in http.c, are very
sensible changes.

Given that we do not want to have too many conditionally compiled
codepath, I certainly understand that the current approach to keep
an ad-hoc list of features we care about may be your preference.

I am not sure if that is viable longer term, though.  I still am not
decided.

Thanks.
