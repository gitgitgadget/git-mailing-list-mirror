Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC39C433EF
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 20:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343922AbiC1UgQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 16:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346263AbiC1UeP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 16:34:15 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7933D32EF8
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 13:32:34 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B775412F3E6;
        Mon, 28 Mar 2022 16:32:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=xLbJHOnO7ldK
        +F2dvKk/6IHS6Qoea3yzC1VJcN9FXhc=; b=uIf5IlTLksKFOyl++kiJWaBpH/i8
        EdjaNXDq6otmV46b7ZODASrSgS4ZI8NviHYWtlmb28r6k8iqiB0W3+oIcyG2XgFJ
        YD4fPvDb5LM7E0jnceQCt+jmrIA+6wmVogUgAJtcldKvBjJM2JvjZLvzbJxC7gs4
        lnLmQcwwVCemzjY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AED1F12F3E5;
        Mon, 28 Mar 2022 16:32:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 15A7A12F3E4;
        Mon, 28 Mar 2022 16:32:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Tao Klerks <tao@klerks.biz>, Glen Choo <chooglen@google.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3] tracking branches: add advice to ambiguous refspec
 error
References: <pull.1183.v2.git.1647940686394.gitgitgadget@gmail.com>
        <pull.1183.v3.git.1648450268285.gitgitgadget@gmail.com>
        <xmqqwnge2ghe.fsf@gitster.g>
        <kl6l7d8et314.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqilry2dq7.fsf@gitster.g>
        <CAPMMpojYJ9sB7nbAAt1b_yH0Um1O-+TpSRYXTkZ6aDHobhS59A@mail.gmail.com>
        <220328.86y20t3o5s.gmgdl@evledraar.gmail.com>
Date:   Mon, 28 Mar 2022 13:32:32 -0700
In-Reply-To: <220328.86y20t3o5s.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 28 Mar 2022 20:50:43 +0200")
Message-ID: <xmqqk0cd24yn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 32426828-AED6-11EC-B8B6-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> But as to not penalizing those who don't have the advice enabled,
> something like this (untested)?:

Unconditionally computing what you need only in the error path is
the primary sin in the patch, and that should be addressed first.

If we need to do new things (like adding the do_advice member), it
becomes questionable if it is worth doing.  In this case, I think
the update is simple enough and the control flow makes it clear what
is and what isn't needed only for advice-message generation, so it
might be an overall win.

Thanks.
