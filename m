Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959C1C00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 15:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiHJP4M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 11:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbiHJPzq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 11:55:46 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D8C7A527
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 08:53:56 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 226F819C248;
        Wed, 10 Aug 2022 11:53:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=jrbM4bF2UqL6
        eAFXPHtBGsm4D4dROh2dz3H+lBn+mBo=; b=TAW1hktE9EgCH8bSwbtAwr6QuxsM
        iQ7iZoKmcKj7DbyiJ9Zpv+80sD1YVgyssTes1YsjHzDZLrU6CnMU+dAB0KsE9f96
        dgKx9JpGN8TPkBW6437FZzvVayAMRcnTGxaS+99YEjbduiui6r2k6huq6Ms70wZn
        Lfd/Sb6eGHemVvQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 07EA919C246;
        Wed, 10 Aug 2022 11:53:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8F09219C244;
        Wed, 10 Aug 2022 11:53:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Calvin Wan <calvinwan@google.com>,
        Alexander Meshcheryakov <alexander.s.m@gmail.com>,
        git@vger.kernel.org
Subject: Re: [BUG] Unicode filenames handling in `git log --stat`
References: <20220809182045.568598-1-calvinwan@google.com>
        <xmqqsfm4prqk.fsf@gitster.g>
        <20220810084017.gnnodcbt5lyibbf6@tb-raspi4>
Date:   Wed, 10 Aug 2022 08:53:28 -0700
In-Reply-To: <20220810084017.gnnodcbt5lyibbf6@tb-raspi4> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Wed, 10 Aug 2022 10:40:17
 +0200")
Message-ID: <xmqqiln0p01z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 941DF9D8-18C4-11ED-A41F-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>  git log --stat
> [snip]
>  Arger.txt  | 1 +
>  =C3=84rger.txt | 1 +
>    2 files changed, 2 insertions(+)
>
> From this very first experiment I would suspect that we use
> strlen() somewhere rather then utf8.c::git_gcwidth()

Yeah, that does sound like the case, and quite honestly, knowing
that the diffstat code is way older than unicode-width code, which
was added by you in mid 2014, I am not all that surprised if we used
to use strlen() throughout and we still do by mistake.

Thanks for a doze of sanity.
