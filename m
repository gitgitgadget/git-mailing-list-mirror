Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16BBC433F5
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 20:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239450AbiBRU0c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 15:26:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbiBRU0b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 15:26:31 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA40123411
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 12:26:14 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3E5AA18E487;
        Fri, 18 Feb 2022 15:26:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=sBPlHorBLfnO
        GsJaBP0z+1NPeztiwKFKLcNPWoTCwAM=; b=jQV8q0Io3ki2TmLK3eOZxmmMwGeU
        iovFjV/s8a/Hhb5RMEsNKtXNkp6t40AGhSqq3oS3cpqRLKmuZ6lSQ0DtU2d9wXzw
        YTcL5gb0B2+seuitxuSx1EYXfEOpVe6pfH8Ah8n7m9k0Hcs9xZ99sck/FIJ1EuPB
        ktIGs/ju9z3dGVw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3735118E486;
        Fri, 18 Feb 2022 15:26:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A3E2F18E485;
        Fri, 18 Feb 2022 15:26:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 2/3] reflog: call reflog_delete from reflog.c
References: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
        <e4c0047a17ca1b5f824acfb209884a59a93ea523.1645209647.git.gitgitgadget@gmail.com>
        <220218.86sfsggf0e.gmgdl@evledraar.gmail.com>
Date:   Fri, 18 Feb 2022 12:26:10 -0800
In-Reply-To: <220218.86sfsggf0e.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 18 Feb 2022 20:15:18 +0100")
Message-ID: <xmqqczjjzztp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 03374422-90F9-11EC-AFCA-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Maybe others will disagree, but per my comment on 1/2 I found reviewing
> this locally much easier with this squashed into 1/2 (without the {}
> changes I suggested).

Oh, I am pretty much on the same page.

The if() block has to retain {} after all but not for the reason you
cite (i.e. help "diff --color-moved"), but for correctness reasons
it has to have some "early return to avoid using NULL" to replace
"continue", which means the body of the if() statement needs to stay
a two statement block.

