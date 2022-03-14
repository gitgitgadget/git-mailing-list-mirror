Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017DCC433EF
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 06:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiCNGXr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 02:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiCNGXp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 02:23:45 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E27D403CF
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 23:22:36 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 885E312219F;
        Mon, 14 Mar 2022 02:22:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uCeXknByRg9Yed2MmQG58JmzZvntQf32LKXaVK
        7hnH0=; b=KTnZIxiICCd18jXh5LA/4SVP6hKhogRVkQwfypiEzoAvrAbb59Ci1+
        GRD2X32Rn2Kjvr+yNeNoPhpO9ODcTG2JjxZ/mBQmLO454mby8m3Sjpjo55tju7Wx
        hboKh3PVs/MX46Tmaavj27WFBfAIKh9gEPl3+RCoFJ0DzZhnEbdVs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7FA5B12219E;
        Mon, 14 Mar 2022 02:22:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D7EDF12219D;
        Mon, 14 Mar 2022 02:22:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 0/5] Separate '--skip-refresh' from '--quiet' in
 'reset', use '--quiet' internally in 'stash'
References: <pull.1170.git.1647043729.gitgitgadget@gmail.com>
Date:   Mon, 14 Mar 2022 06:22:32 +0000
In-Reply-To: <pull.1170.git.1647043729.gitgitgadget@gmail.com> (Victoria Dye
        via GitGitGadget's message of "Sat, 12 Mar 2022 00:08:44 +0000")
Message-ID: <xmqqwngxrr2v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 232D9736-A35F-11EC-AEB8-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> ... 1) 'reset' does not refresh
> the index if '--quiet' is specified (as of [1]) and 2) 'git stash' needs the
> index to be refreshed after the reset.

The latter is not surprising, but I have to agree with the series
that the former is unbelievably bad design taste, and I am happy to
see that this series separates out refreshing decision from the
verbosity.

