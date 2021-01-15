Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59839C433E0
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 01:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21AD123A5B
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 01:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731732AbhAOBuz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 20:50:55 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62563 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731608AbhAOBuy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 20:50:54 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D6E55111DB3;
        Thu, 14 Jan 2021 20:50:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZSgtUJgdyh25ct394jTcz7GCrJA=; b=VYQEIu
        aTVl3OEhWrLYGMcOlQ6vML8Ljed9IMBWSDd6gFu1zIEGa8hkkWYySbXsw2mAA2U3
        hikgwjjPhh3aeUtUUP6bvSA9nG30LXfi8ShUUC/i+7y5XXQ7j5OH9at49xBAaLhM
        UMwg3KCfn8uP8ZDYftJwW3GKjtibEIIGbn2ps=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Jj5MgWew4xGyCiI4KZyUu+q3Rxn0SGsi
        PROJ7ULYEcG+mRIDMYnYgeFPAsxt/61LXGkv5dppsOfHYwIvArnYyS1Ld/GJX6O0
        fTerNgJMfPtKVYBkG4/1qvD2HOiUQ3+csMrsW1ocxTe9rzKwgWNkNNmaaN/2sdzN
        9JN0SG/MKJM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CEB06111DB2;
        Thu, 14 Jan 2021 20:50:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1FA72111DB1;
        Thu, 14 Jan 2021 20:50:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: What's cooking in git.git (Jan 2021, #02; Fri, 8)
References: <xmqqk0sni68g.fsf@gitster.c.googlers.com>
        <YADOf41CcaRuToD7@google.com>
Date:   Thu, 14 Jan 2021 17:50:08 -0800
In-Reply-To: <YADOf41CcaRuToD7@google.com> (Emily Shaffer's message of "Thu,
        14 Jan 2021 15:06:39 -0800")
Message-ID: <xmqqsg73ufxr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0034D4A2-56D4-11EB-8CF9-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> On Fri, Jan 08, 2021 at 11:22:23AM -0800, Junio C Hamano wrote:
>> * ds/maintenance-part-4 (2021-01-05) 4 commits
>>   (merged to 'next' on 2021-01-08 at 1f98c859ea)
>>  + maintenance: use Windows scheduled tasks
>>  + maintenance: use launchctl on macOS
>>  + maintenance: include 'cron' details in docs
>>  + maintenance: extract platform-specific scheduling
>> 
>>  Follow-up on the "maintenance part-3" which introduced scheduled
>>  maintenance tasks to support platforms whose native scheduling
>>  methods are not 'cron'.
>> 
>>  Will merge to 'master'.
>
> This series again has troubles running inside a directory with regex
> metachars in the path. Courtesy of Jonathan Nieder, I think this fix
> matches the intent a little better; but if we don't like this, the same
> lines could be diffed just to add --fixed-value instead.

Thanks.

>  	# start registers the repo
> -	git config --get --global maintenance.repo "$(pwd)" &&
> +	pwd >expect &&
> +	git config --get --global maintenance.repo >actual &&
> +	test_cmp expect actual &&

> Before this patch, the test said "Is there something configured in
> maintenance.repo that looks like $PWD?" and after this patch, the test
> says, "Does the config in maintenance.repo look like $PWD?" - so it is
> not quite semantically identical but I think may be clearer.

Sounds sensible.  Derrick (CC'ed), thoughts?
