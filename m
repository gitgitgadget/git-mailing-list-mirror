Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25580C433ED
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 23:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CED9561380
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 23:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235557AbhDEXJk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 19:09:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57689 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbhDEXJh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 19:09:37 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A011FAA75E;
        Mon,  5 Apr 2021 19:09:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+DXr2rSL/hzEAyJVVLhNYi9weI0=; b=Uu5PdA
        40R2IM8JMlu9kPdcls+jygH16tYbPiMYOfHutI33dMeZM875FwlQPa5Ozn+fzA7k
        vpWUaYJ8UTfsQD4BhXI0Rr0UAlc3CABOUqtPnpFt4M/GpX7EyzVEToMaKlP+Edhx
        ncX2bsMBbsnGntiR0VrAAfjeHAKLIwW53lQ5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jXVcSn+pwH5AORlc4Cg5zmMboD1qT2DT
        QkCY8sB+5pvg34x6NImFhguIRiaMC7fNR9AzHy0+8HmRIdooCz+csC8qbNdv1WDJ
        doyefubjVjBrsdR8UEoUWqZD+J3Pb9jVXcQ47iHPFnkfR3chgtv55FHZu3BcKE+v
        ZD49bkn5apc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 981D2AA75D;
        Mon,  5 Apr 2021 19:09:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1D0DEAA75C;
        Mon,  5 Apr 2021 19:09:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Albert Cui <albertqcui@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Albert Cui via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] hooks: propose project configured hooks
References: <pull.908.git.1616105016055.gitgitgadget@gmail.com>
        <pull.908.v2.git.1616723016659.gitgitgadget@gmail.com>
        <ec031dc8-e100-725b-5f27-d3007c55be87@gmail.com>
        <CAMbkP-S-9cccMpU4HG0Wurqap-WkTmD2zk50nKd9kJ_oWO__qw@mail.gmail.com>
Date:   Mon, 05 Apr 2021 16:09:29 -0700
In-Reply-To: <CAMbkP-S-9cccMpU4HG0Wurqap-WkTmD2zk50nKd9kJ_oWO__qw@mail.gmail.com>
        (Albert Cui's message of "Mon, 5 Apr 2021 15:45:10 -0700")
Message-ID: <xmqqmtuc49cm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F9C6621E-9663-11EB-AB59-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Albert Cui <albertqcui@gmail.com> writes:

>> Requirements like these make me think that these repositories would be
>> better off with a script that configures the hooks after checking if
>> these things actually exist on the PATH (and installs them if not). I
>> would lower the priority of this one for now.
>>
>
> As mentioned, for enterprise deployments, this can be solved by administrators
> installing any necessary software automatically.
>
> Otherwise, I think ensuring the tool is installed feels out-of-scope
> (as written in
> the doc); it's not like Git makes sure compilers or build tools are
> installed today,
> and even today, users could set up Husky hooks that rely on $PATH tools, so
> we're not introducing a new problem.

I am afraid that this compares apples and oranges.  

I may "git clone" and try "make" to find out that I needed a special
compiler, and that would not be the end of the world.  It is
guaranteed that "git clean -f -x -d" followed by installation of
necessary toolchain followed by "make" would work.  And that is
partly because "git clone" does not do any more than just clone and
checkout the initial tree.

If a new version of "git clone" told me "I can install the project
recommended hooks to use", I answer "yes", and then failed while
installing and configuring the project-recommended hooks because of
missing dependencies, then I wouldn't know in what state the result
would be in.  In some projects, it may be enough to just install the
missing dependencies, and in some others, it may not be enough and I
have a broken half-configured mess depending on how the "installing
and configuring" step failed.
