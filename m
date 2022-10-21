Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15064C433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 01:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiJUBnW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 21:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiJUBnT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 21:43:19 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205742339BD
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 18:43:19 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 63D1F15249A;
        Thu, 20 Oct 2022 21:43:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=5adGmETgf5HFJv72L2yZ6tl2vu5r2wZgvNOTbGcDd+k=; b=pwzL
        K7C8KrZMV9DYGjkev64RnE1b+bG1tPtetcjbiHLcMZmf8JWSTONxTqVV7UpO1hrW
        2OxQD095Nksd9S10nKim+LWb0+qQijfHcuIgy2Ll14gmhgLeFV1nmc3luw4vErE1
        +zAvYuUqm5bI4BSDeo+4z/u9f+FALKohkiAHH5o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4BC36152499;
        Thu, 20 Oct 2022 21:43:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9C696152498;
        Thu, 20 Oct 2022 21:43:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heather Lapointe <alpha@alphaservcomputing.solutions>
Cc:     Heather Lapointe via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 0/9] archive: Add --recurse-submodules to git-archive
 command
References: <pull.1359.v2.git.git.1665660960.gitgitgadget@gmail.com>
        <pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com>
        <xmqqo7u9t1zf.fsf@gitster.g>
        <CAFwvh9BwV=NEtF_gsh9Tr8gHz02=78m4MCBQbuXk5SzKCAm4RA@mail.gmail.com>
        <xmqqy1tbssa8.fsf@gitster.g> <xmqqwn8vpmr3.fsf@gitster.g>
        <xmqqfsfjnvbu.fsf@gitster.g>
Date:   Thu, 20 Oct 2022 18:43:16 -0700
Message-ID: <xmqq8rlaossr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BC5F6ABC-50E1-11ED-BE58-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> It seems to have cleared the "submodule tests no longer can use
> submodules with file:// without tweaking the config" issue I saw
> earlier.  It seems to give us a segfault in win+VS test, though.
>
> https://github.com/git/git/actions/runs/3285647856/jobs/5413033844#step:5:245

Here is a pair of CI run that attributes the breakage to this topic:

  https://github.com/git/git/actions/runs/3293333066

is one CI run on 'seen' that has this topic and everything else in
flight.  This topic is at the tip of 'seen' when this CI run was
done, and win+VS test (8) seems to be failing the same way as the
previous one I reported earlier above.

Dropping the merge of this topic (i.e. "git reset --hard HEAD^") out
of 'seen' and running CI again: 

  https://github.com/git/git/actions/runs/3293553109

we can see that all tests pass there, which unfortunately is a rare
event these days (well, the segfaulting code is something this topic
adds, so it is not surprising that the rest of the topics in flight
would not segfault the same way).

Do you need help from somebody equipped with Windows knowledge and
build/test environment?  As I do not do Windows or macOS, I cannot
offer to be one myself, but the development community is full of
capable folks and help is often a request away.

Thanks.
