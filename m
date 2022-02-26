Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96484C433EF
	for <git@archiver.kernel.org>; Sat, 26 Feb 2022 18:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbiBZSyE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Feb 2022 13:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiBZSyD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Feb 2022 13:54:03 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46981A2723
        for <git@vger.kernel.org>; Sat, 26 Feb 2022 10:53:28 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 30D9510C331;
        Sat, 26 Feb 2022 13:53:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sktRyaOSc2ealeYB96JedXa2q3DE7fw6VSFs43
        tZZJo=; b=McZjh1NOo59n7yIK/nOB+l6CuptrBWUna+7k87RzVP3LGs0d5uhyud
        6uleJ4WoEsWtERinQtmKuP7hVoEXP/WTYV0dJ67QG+1YsUbqrQqCZgn0/A98lU/h
        DPdVFJN3o/ZreUa3x1UCoVDXxzteLKRl7vShO2aL+mIvxPzEfHgPs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2922F10C32F;
        Sat, 26 Feb 2022 13:53:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8F68C10C32E;
        Sat, 26 Feb 2022 13:53:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 09/10] fetch: fetch unpopulated, changed submodules
References: <20220215172318.73533-1-chooglen@google.com>
        <20220224100842.95827-1-chooglen@google.com>
        <20220224100842.95827-10-chooglen@google.com>
Date:   Sat, 26 Feb 2022 10:53:24 -0800
In-Reply-To: <20220224100842.95827-10-chooglen@google.com> (Glen Choo's
        message of "Thu, 24 Feb 2022 18:08:41 +0800")
Message-ID: <xmqqr17p5ujf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 60E150D0-9735-11EC-AD87-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A few tests added by this patch have been failing on one specific
job (linux-gcc ubuntu-latest) at GitHub CI.

https://github.com/git/git/runs/5341052811?check_suite_focus=true#step:5:3968
https://github.com/git/git/runs/5343133021?check_suite_focus=true#step:4:5520

    Side note: you may need to be logged in to GitHub to view them.
    These two use different versions of CI to show the test traces;
    in the latter you may have to click on right-facing rectangle on
    the line with label "5520" to see the breakage.

I think there is some baked-in assumption in the failing test what
the name of the initial branch by default is, which may be the reason
why this particular job fails while others don't.

Can you take a look at it?

Thanks.
