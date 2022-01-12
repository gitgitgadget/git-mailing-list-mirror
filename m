Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066F2C433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 19:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356603AbiALTQ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 14:16:27 -0500
Received: from pb-sasl-trial20.pobox.com ([173.228.157.50]:59113 "EHLO
        pb-sasl-trial20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344128AbiALTQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 14:16:25 -0500
X-Greylist: delayed 338 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Jan 2022 14:16:25 EST
Received: from pb-sasl-trial20.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial20.pobox.com (Postfix) with ESMTP id 0E0E12500D;
        Wed, 12 Jan 2022 14:10:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bVDyL3Y/GD/XtlqwzldUG+GbCSc=; b=iVkIWY
        X7mhI3AHZFbxMwXWz8F5zBY77Y3VRjeuxevatg6bLN24tY+/xi9EQisYWa6qCPU9
        roD6VjSjXPFxy6N+ZdstJx9JyIYi8VKs0gxVIzkjpU1YNw1oslY//XDtndlyPAX9
        33KWn8JNn6d/QQmKLOuTCQkrJEslXfW3xyXCM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fIqRWfXL+xru3K3hDOKeW5r1Ro03vOdM
        4GGbTig8p+ezJ3pAFlUCnCOiaKkdVgpHLanO6vWOhMiMHr4t+V1/eJvosKcGKDr6
        I51puN/GXe5LwYSjQwbt7y7QIW2AukO+1WhrOT2qjqLm6m46YGxkLt4GHVGenooF
        2Ufeoib4rto=
Received: from pb-smtp20.sea.icgroup.com (pb-smtp20.pobox.com [10.110.30.20])
        by pb-sasl-trial20.pobox.com (Postfix) with ESMTP id F26322500A;
        Wed, 12 Jan 2022 14:10:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4AEA5159BB2;
        Wed, 12 Jan 2022 14:10:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Anders Kaseorg <andersk@mit.edu>, Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Christopher =?utf-8?Q?D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <daniel@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>
Subject: Re: [PATCH v7 8/8] branch: protect branches checked out in all
 worktrees
References: <20211201221547.1796213-1-andersk@mit.edu>
        <20211201221547.1796213-9-andersk@mit.edu>
        <CANYiYbHBjM-1oezX_1Z+te+wvQpdj=rwggHHCLPepos_Njwqvw@mail.gmail.com>
        <CANYiYbGdUE_NQFTA31EnEr57E00umfJQoUPMc=OZ3snO+GWZ=w@mail.gmail.com>
Date:   Wed, 12 Jan 2022 11:10:34 -0800
In-Reply-To: <CANYiYbGdUE_NQFTA31EnEr57E00umfJQoUPMc=OZ3snO+GWZ=w@mail.gmail.com>
        (Jiang Xin's message of "Wed, 12 Jan 2022 14:31:33 +0800")
Message-ID: <xmqqa6g0vkgl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 52A5EF1C-73DB-11EC-9363-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> I see Bagas has sent a patch for this:
>
>  * https://lore.kernel.org/git/20220111123627.58625-1-bagasdotme@gmail.com/

Yup, picked up and will merge down before -rc1.

Thanks, all.
