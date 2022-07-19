Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC85BC43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 16:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbiGSQrx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 12:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbiGSQrr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 12:47:47 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25BD57254
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 09:47:45 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AED4614BD1A;
        Tue, 19 Jul 2022 12:44:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=R9dmQa1BpDsg8actaupge36fUgTcrM4BYBc7tJ
        JqjI4=; b=C9EvCLYasI/FuNpaY43cUXm54A5uiAWdQL2eSY7k+IBcWsqstMg7mR
        n1SuMSQrLUYUEZhFvyXq2hM04bftaRX+Rg5seweN/uYcdB3SdpR+Io/QQDxl1uqP
        89FSo1NIucZlBMtoN8u1wAn/BXJeG9r0CGZF3leTXF4hvSqmq1OIU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A64C914BD19;
        Tue, 19 Jul 2022 12:44:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0A5A514BD18;
        Tue, 19 Jul 2022 12:44:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 07/12] rebase: add --update-refs option
References: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
        <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
        <3ec2cc922f971af4e4a558188cf139cc0c0150d6.1657631226.git.gitgitgadget@gmail.com>
        <20220718090557.GA5616@szeder.dev>
        <11aa9b43-adea-4e90-9c70-ab3579aa445f@github.com>
        <xmqq4jzefc3e.fsf@gitster.g>
        <6b6746cb-2456-0733-32ed-c0a7a3f57087@github.com>
Date:   Tue, 19 Jul 2022 09:44:16 -0700
In-Reply-To: <6b6746cb-2456-0733-32ed-c0a7a3f57087@github.com> (Derrick
        Stolee's message of "Tue, 19 Jul 2022 11:53:01 -0400")
Message-ID: <xmqqo7xlaw7z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 080DD2C2-0782-11ED-862B-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 7/18/2022 3:35 PM, Junio C Hamano wrote:
>> Derrick Stolee <derrickstolee@github.com> writes:
>> 
>>> ... I think I should use "branches" here, but
>>> keep the name "--update-refs". The biggest reason is that it provides
>>> a nice parallel with the "update-ref" sequencer command. This command
>>> allows updating _any_ ref, such as lightweight tags in refs/tags/*
>>> or even refs in refs/my/namespace/*.
>>>
>>> The --update-refs option doesn't create the commands to update tags
>>> or refs in places other than refs/heads/*.
>> 
>> I guess it would make the choice of "branch" the most appropriate.
>> 
>> I was hoping that we can repoint refs in private namespaces that are
>> not branches with the option.  But as long as the underlying
>> "update-ref" instruction can be used by advanced users, that is OK.
>
> I would like to keep the --update-refs name for a couple reasons:

I do not think anybody proposed to change the name of that option.

I was reacting to your "I should use branches here", with the
understanding that "here" is this place where you used "local refs".

>> +		OPT_BOOL(0, "update-refs", &options.update_refs,
>> +			 N_("update local refs that point to commits "

If "rebase --update-refs" uses "update-ref" insn (which is capable
of repointing non-branch refs) only for local branches, then the
help text for the "--update-refs" option can safely say "update
local branches" without being inaccurate.  That is where my "branch
is the most appropriate" comes from.


