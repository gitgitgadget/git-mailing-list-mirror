Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CDE11F454
	for <e@80x24.org>; Fri,  8 Nov 2019 04:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfKHELp (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 23:11:45 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58795 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfKHELo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 23:11:44 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C00E19B7D6;
        Thu,  7 Nov 2019 23:11:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=I5IZF/vdXwtql2NKwCyFyMmC2MQ=; b=H66rN4
        4o0xQPKUESDYC5GHPsgnqSL8GMmNhsQ+8i/+WAjMmxy0ooEGaY1s7Xl1bGjRztY9
        I88X4DkeBBVoZicEB+3mIs5yOVBdCxlFTsMomD+ScXtAd7aVn6ryov32rixcrqet
        sfiMNePXJ9QlOWKy9sxuEd3h+WDEUfJmdMImA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Cp/neuqQW4Zte1fhwSNqlxqch0fliz/Z
        Sg2XWCpHLwWASrtex7UxNmp5gtIobAxB63PIhvNv2TCrl4O9LUMVmQiplXKDXBEv
        tuftRinaMjBo32MmWP6hnvK/WOGE3y/D+Niku+jDi7ktHGZn4yxqMT3dkFIxcKPk
        zNl7X8WClyc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B6C599B7D5;
        Thu,  7 Nov 2019 23:11:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E1AD79B7D2;
        Thu,  7 Nov 2019 23:11:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Utsav Shah <utsav@dropbox.com>
Cc:     Utsav Shah via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Utsav Shah <ukshah2@illinois.edu>
Subject: Re: [PATCH v3 1/1] unpack-trees: skip stat on fsmonitor-valid files
References: <pull.424.v2.git.1572967644.gitgitgadget@gmail.com>
        <pull.424.v3.git.1573016055.gitgitgadget@gmail.com>
        <4bea7075cfcac013f5947cd3e9254d38e86e675c.1573016055.git.gitgitgadget@gmail.com>
        <xmqqftj1th93.fsf@gitster-ct.c.googlers.com>
        <CAPYzU3P6M0s365gOEz360B0QqRN6JKaUB2Zc8+-XnVei0WF6WA@mail.gmail.com>
        <CAPYzU3OU45E_OQKOFFohxsqUvmMGXL9NNYNi2i27k3aRZ4oqVg@mail.gmail.com>
Date:   Fri, 08 Nov 2019 13:11:37 +0900
In-Reply-To: <CAPYzU3OU45E_OQKOFFohxsqUvmMGXL9NNYNi2i27k3aRZ4oqVg@mail.gmail.com>
        (Utsav Shah's message of "Thu, 7 Nov 2019 19:51:04 -0800")
Message-ID: <xmqqlfsrnh1i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD3D5A74-01DD-11EA-A9AD-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Utsav Shah <utsav@dropbox.com> writes:

> I will try to figure out how to use gitgitgadget to send a smaller
> patch within this thread to fix the fsmonitor and split index
> interactions.

If the current one is trying to handle two issues, then you'd need
to reduce this one and add another spearate topic, probably.

> I tried writing a test today that uses
> t7519/fsmonitor-watchman to simulate the bug, but it is flaky.

Are you aware of Kevin Willford's recent work?

<52eaf20f405b53743e27935dfe89f62e6f824a33.1572889841.git.gitgitgadget@gmail.com>

