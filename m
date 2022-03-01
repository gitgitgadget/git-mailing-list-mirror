Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0DDC433FE
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 20:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238307AbiCAUe3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 15:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238142AbiCAUe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 15:34:26 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982A13A5D9
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 12:33:44 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4C22818DF51;
        Tue,  1 Mar 2022 15:33:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=r+nhBHb4V24zW//DAXzBdbvo7o/bVrPEv86Dmy
        Gy7yE=; b=Lom5KBqQCgV18PAHP8zNAsTVfVbxzV5jp8AwTTEJFMOCAaSobGuWVR
        KQHEXKdo+HJfaUoxpQBz/24VwaIpuuDrEEX9OekjVWig7RpM/M0kh1jgubWz8e6U
        /uO+gTnsEvkQjOUmHTdCyBlS1cLouS/SipH9+zwJwXc9MQ3KLQhXI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4481618DF50;
        Tue,  1 Mar 2022 15:33:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7A18A18DF4F;
        Tue,  1 Mar 2022 15:33:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 09/10] fetch: fetch unpopulated, changed submodules
References: <20220215172318.73533-1-chooglen@google.com>
        <20220224100842.95827-1-chooglen@google.com>
        <20220224100842.95827-10-chooglen@google.com>
        <xmqqr17p5ujf.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2203012039080.11118@tvgsbejvaqbjf.bet>
Date:   Tue, 01 Mar 2022 12:33:39 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2203012039080.11118@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Tue, 1 Mar 2022 21:24:15 +0100
        (CET)")
Message-ID: <xmqq35k1pg4c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E1487EE0-999E-11EC-A10F-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Sat, 26 Feb 2022, Junio C Hamano wrote:
>
>> A few tests added by this patch have been failing on one specific
>> job (linux-gcc ubuntu-latest) at GitHub CI.
>>
>> https://github.com/git/git/runs/5341052811?check_suite_focus=true#step:5:3968
>> https://github.com/git/git/runs/5343133021?check_suite_focus=true#step:4:5520
>>
>>     Side note: you may need to be logged in to GitHub to view them.
>>     These two use different versions of CI to show the test traces;
>>     in the latter you may have to click on right-facing rectangle on
>>     the line with label "5520" to see the breakage.
>>
>> I think there is some baked-in assumption in the failing test what
>> the name of the initial branch by default is, which may be the reason
>> why this particular job fails while others don't.
>>
>> Can you take a look at it?
>
> The log says this:
> ...
> At least that's how _I_ tried to address similar issues in the test suite
> in the past.

Yes, I had a squashable fix/workaround queued since last night.
