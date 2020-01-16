Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40292C33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 20:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11AA22077B
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 20:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FO1opd6K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733285AbgAPUF4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 15:05:56 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53855 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729075AbgAPUFz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 15:05:55 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A18C995681;
        Thu, 16 Jan 2020 15:05:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HUtjhIVfW41/FxuVedaCdDg2faI=; b=FO1opd
        6KIeDMT3+L2LmSh578VV7/pshPZFFx4sOuBAhzWxwnNoytbTlyvPUOa6j0LmiXVE
        e+qEF2pu6D1ZS/XzqkPCmmIbDaWgF7/U/cWORUif9uS/DbWra8OYzKnW9EJgha0t
        jJjH/envwgf/EgZdnKqc+Ni8w9/iSFxjyJybc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QlseXxzNVj6ZUzyEQzLz3mxmNyndtMgJ
        5MDVNW/AO4dn+37yA5uLoS5QyusW1BTPndA1qHJH6ei5nt6uxZbQyZiTnSs9J3ku
        5vkOrOPB+tt/9K0FuaVkD4X/deIYfELwaYigQzMr5VKn8BuXejt5luvicXBVkz8t
        VyHEekPZ8Ic=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9870495680;
        Thu, 16 Jan 2020 15:05:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D94659567D;
        Thu, 16 Jan 2020 15:05:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>,
        Pavel Roskin <plroskin@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 15/15] rebase: change the default backend from "am" to "merge"
References: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
        <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
        <044853fd612ee8cf6928bb7c4ebb1eacaa172aa3.1577217299.git.gitgitgadget@gmail.com>
        <20200110231436.GA24315@google.com>
        <CABPp-BEGwJ=0+6TMYXvMzpds0h6bz4gZA8Pi95SH9M4CKBtfOw@mail.gmail.com>
        <052fdedc-2beb-91ab-c5c3-53fb99e64810@gmail.com>
        <nycvar.QRO.7.76.6.2001120942460.46@tvgsbejvaqbjf.bet>
        <CABPp-BGqWDo0vkY_zBZ6n+2T92W2iR90=41oJO_Ae1yZP8NO0A@mail.gmail.com>
        <20200116075810.GB242359@google.com>
Date:   Thu, 16 Jan 2020 12:05:48 -0800
In-Reply-To: <20200116075810.GB242359@google.com> (Jonathan Nieder's message
        of "Thu, 16 Jan 2020 07:58:10 +0000")
Message-ID: <xmqqwo9rgo9v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 97FA3064-389B-11EA-997E-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> The deployment examples above seem like examples where the user would
> want the script to run on "git am" (and on "git merge --ff-only", for
> that matter) but not on the intermediate commits in "git rebase",
> since when rebasing a multi-commit series, deploying earlier rebased
> commits would cause the deployment to lose the benefit of later fixes.

Agree.  The same thing can be said to "git am" accepting a series of
multiple patches, though.

