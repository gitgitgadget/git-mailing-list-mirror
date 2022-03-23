Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F76DC433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 23:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245569AbiCWXML (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 19:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239570AbiCWXMF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 19:12:05 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F60870936
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 16:10:35 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C5EA12B449;
        Wed, 23 Mar 2022 19:10:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lSlbhtOa4p3Ipn+2LsuO6XuvR3QFQz5UbpRMFI
        qHDic=; b=WDNI2/5S/CH+5dQfrLJq7QDGo3zzN/w3cs5I5g+0Q89YiKcZusnCFE
        XWVIB1U/tMdkFv7hVzeTmld+qGyXuP+8tKVfSdHlHOjrDXU0uQcIR9hu5NOqjRMW
        jrNHllLeO6U+tNRXqtciUy5GmOiAZnK8+lxa6DKqtmCKJGnPrL/ho=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4332C12B448;
        Wed, 23 Mar 2022 19:10:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A2DB212B447;
        Wed, 23 Mar 2022 19:10:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, chakrabortyabhradeep79@gmail.com
Subject: Re: [PATCH] test-lib-functions: fix test_subcommand_inexact
References: <pull.1185.git.1647894845421.gitgitgadget@gmail.com>
        <540936ba-7287-77fa-9cee-e257ed3c119d@github.com>
        <xmqqmthgu3e6.fsf@gitster.g>
        <e5331972-512a-c498-6a1b-927f21ef9de2@github.com>
        <YjuVAgjaiqrcT7P1@nand.local>
Date:   Wed, 23 Mar 2022 16:10:32 -0700
In-Reply-To: <YjuVAgjaiqrcT7P1@nand.local> (Taylor Blau's message of "Wed, 23
        Mar 2022 17:45:38 -0400")
Message-ID: <xmqqfsn8p8nr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 710E5FF2-AAFE-11EC-BA76-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Wed, Mar 23, 2022 at 10:55:37AM -0400, Derrick Stolee wrote:
>> > So, perhaps #3 ;-)?
>>
>> I'll default to #3 (do nothing), but if this shows up again
>> I'll plan on adding a comment to the helper to be clear on
>> how "inexact" the helper really is.
>
> I wonder if we could sidestep the whole issue with
> test_subcommand_inexact by testing this behavior by looking at the
> contents of the packs themselves.
>
> If we have a kept pack, and then add some new objects, and run "git
> repack --write-midx -adb", the new pack should not contain any of the
> objects found in the old (kept) pack. And that's the case after this
> patch, but was broken before it.

Sounds quite sensible.

Instead of saying "we are happy as long as we internally run this
command, as that _should_ give us the desired outcome", we check the
resulting packs ourselves, and we do not really care how the
"repack" command gave us that desired outcome.
