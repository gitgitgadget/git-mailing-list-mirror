Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B29C2D0EC
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 23:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2941820719
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 23:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Wp2x8Nkt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgDGXFH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 19:05:07 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63002 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgDGXFH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 19:05:07 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0DFC4CA5A9;
        Tue,  7 Apr 2020 19:05:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=p4ot5rh0iIBfF0h06ijQM4V6n64=; b=Wp2x8N
        ktsf3WhtrYb4WdneNtQJTRjX9DfiQy5MjuC6DzkPJHR+sju9w0/nbB1Datnk+PE0
        /Xp7Skab9p89oq0jjPp5vJF73Co5uwpbpU1ztBd7pjwezMojbKVXBjCJhAP0nYmt
        pgqhl/fHPRZtX0vcykqarmDPo8Phmg/s8irgw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Akegybs2EBD/+SiEMtsxOdWE4aCYtehE
        PVHFMwv7AS7XGprt5Gk+B+eZjer2cX0IVm3rs2qJ9itkmXhXdQlWIRTs746jxojG
        TWwCEmUxqFbiP59HItfNszHrxb5RPGeu080fm231avxNBqnbCIe9KfzyfCL5zJXG
        Vqf0QS1CWyg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 05053CA5A8;
        Tue,  7 Apr 2020 19:05:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DE706CA5A6;
        Tue,  7 Apr 2020 19:05:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Paul Gevers <elbrus@debian.org>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: Re: [PATCH] sequencer: honor GIT_REFLOG_ACTION
References: <pull.746.git.git.1585773096145.gitgitgadget@gmail.com>
        <b187cb5f-a6c8-2908-e3fd-e1210e6970e0@gmail.com>
        <CABPp-BE_mimSRg5wf0Yzn2s-dX=64ZS1jGszqwHzr3aju0bj=A@mail.gmail.com>
        <09397e37-a22b-5159-b760-bae238ae3ed6@gmail.com>
        <nycvar.QRO.7.76.6.2004071649190.46@tvgsbejvaqbjf.bet>
        <CABPp-BFXT1QkTLUFSAju2TwzVdSRjKSyLQYp2KaoW2+S2U8KJw@mail.gmail.com>
        <nycvar.QRO.7.76.6.2004080037080.46@tvgsbejvaqbjf.bet>
Date:   Tue, 07 Apr 2020 16:05:00 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2004080037080.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 8 Apr 2020 00:37:24 +0200 (CEST)")
Message-ID: <xmqqwo6qrj6r.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 35F57CEC-7924-11EA-932F-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > FWIW I was also about to comment on that. Maybe that warrants even a code
>> > comment above the `prev_reflog_action`?
>>
>> Yeah, if it tripped you both up, I'll add such a comment to the code
>> to help explain it.
>
> Thank you!

Thanks, all.
