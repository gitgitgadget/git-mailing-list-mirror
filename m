Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE45C433EF
	for <git@archiver.kernel.org>; Fri, 29 Apr 2022 16:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379282AbiD2QwO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Apr 2022 12:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378848AbiD2QwL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Apr 2022 12:52:11 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53674D5EA5
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 09:48:53 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9CC6211A269;
        Fri, 29 Apr 2022 12:48:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4sWhZ9b3loOJ
        rTINlTGyfEOUAYZ1ZPm2uIVVow5/Z2I=; b=UlTewZbLR6xUhOb8WGcEE2K6idUB
        +cgumiL3bcIu73irsmjlIvtiuAiONPVVHKdXK8EmzD4T2lSgonFofMNiKeLXnUQE
        3+Me/X00r7kmmUatbQLdqNL5zFu+Ec9VTpcNV58C0Boul2aa1gRMFgY90VT4rRll
        aQv1TYgeEyF+2jQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9513A11A268;
        Fri, 29 Apr 2022 12:48:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 057C611A267;
        Fri, 29 Apr 2022 12:48:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Vladimir Marek <Vladimir.Marek@oracle.com>, git@vger.kernel.org
Subject: Re: Fix for failing tests on Solaris
References: <20220429062337.bcpjizaujjmw65dt@virtual.cz.oracle.com>
        <20220429160913.wogvmyxosctdlosz@carlos-mbp.lan>
Date:   Fri, 29 Apr 2022 09:48:50 -0700
In-Reply-To: <20220429160913.wogvmyxosctdlosz@carlos-mbp.lan> ("Carlo
 Marcelo
        Arenas =?utf-8?Q?Bel=C3=B3n=22's?= message of "Fri, 29 Apr 2022 09:09:13
 -0700")
Message-ID: <xmqqr15fdedp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3FE5BDF8-C7DC-11EC-9E07-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

>> --- git-2.35.1/config.mak.uname
>> +++ git-2.35.1/config.mak.uname
>> @@ -162,7 +162,7 @@ ifeq ($(uname_S),SunOS)
>>         NEEDS_SOCKET =3D YesPlease
>>         NEEDS_NSL =3D YesPlease
>>         SHELL_PATH =3D /bin/bash
>> -       SANE_TOOL_PATH =3D /usr/xpg6/bin:/usr/xpg4/bin
>> +       SANE_TOOL_PATH =3D /usr/gnu/bin
>
> I haven't used Solaris for a while (since around OpenSolaris Indiana
> development stopped), but wouldn't this break in Solaris 10 and older?
>
>> Makes all tests but t7812 pass successfully. t7812 fails on locales an=
d
>> utf-8 which do behave differently in Solaris.
>
> And additional fix for that (since you seem to have access to a fresh
> Solaris 11.4 installation at least), would be forthcomming.
>
> Wondering also if there is a way to plug one of those from Oracle Cloud
> through a GitHub actions so we could prevent future issues by including
> Solaris in our CI runs.

I do not think we want to take this patch until we know how exactly
the tests failing for Vladimir fail without GNUism, which we do not
want to rely on.  If a test by mistake used "sed -i -e '<script>'"
GNUism which /usr/xpg[46]/bin/sed does not support, for example, we
want to know about it, so that we can move away from such a use of
GNUism.

Thanks.
