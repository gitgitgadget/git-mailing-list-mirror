Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E3BC433DF
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 19:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BB6C207BC
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 19:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kKVk/i3k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgHZT7L (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 15:59:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50594 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgHZT7J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 15:59:09 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 744F67EEBD;
        Wed, 26 Aug 2020 15:59:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KEMJCBvmLPgTQ7Y/ff4RHIN5loo=; b=kKVk/i
        3kh6TmiDp05k6RuEBPHjtEdB2MfIaObg0iXZEFBUp1OeKRhgVk+Ln/RZU9Nby2qL
        wr6syOtKmUQ7M2NiNkiU/ddp++PbcT8qXNGEam4QdOW4YuyF+SWjebrkPRQVK8p8
        tuaX2G0wYyGCq3It4Mf7/HRIJ5LewcaVmebsg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kqgz0Mr7ZnDyTPVOJOr7t6iWFo9EqmcO
        xxhoJlZtEzgssWArE3sB+EYJLIbVxvPQa9A/H+X9PA5q4XU7xqaC/zbKx6FYKz9o
        EJu8BDYUx4Kf3V1oGJNnS1NPHINHj8hxDLBcsKguPt42ddwW4AAMWHc3gNnjFVN7
        d9GZPswAMzs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C1587EEBC;
        Wed, 26 Aug 2020 15:59:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DA9C17EEBB;
        Wed, 26 Aug 2020 15:59:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Sean Barag via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Sean Barag <sean@barag.org>
Subject: Re: [PATCH] clone: add remote.cloneDefault config option
References: <pull.710.git.1598456751674.gitgitgadget@gmail.com>
        <xmqqlfi1utwi.fsf@gitster.c.googlers.com>
        <eeebff99-d585-5575-009e-83bfef5294e3@gmail.com>
Date:   Wed, 26 Aug 2020 12:59:06 -0700
In-Reply-To: <eeebff99-d585-5575-009e-83bfef5294e3@gmail.com> (Derrick
        Stolee's message of "Wed, 26 Aug 2020 15:04:32 -0400")
Message-ID: <xmqqeentuqk5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 994C778E-E7D6-11EA-969A-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 8/26/2020 2:46 PM, Junio C Hamano wrote:
>> "Sean Barag via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>> This commit implements
>>> `remote.cloneDefault` as a parallel to `remote.pushDefault`,
>>> with prioritized name resolution:
>> 
>> I highly doubt that .cloneDefault is a good name.  After reading
>> only the title of the patch e-mail, i.e. when the only available
>> information on the change available to me was the name of the
>> configuration variable and the fact that it pertains to the command
>> "git clone", I thought it is to specify a URL, from which "git
>> clone" without the URL would clone from that single repository.
>> 
>> And the name will cause the same misunderstanding to normal users,
>> not just to reviewers of your patch, after this change hits a future
>> Git release.
>> 
>> Taking a parallel from init.defaultBranchName, I would probably call
>> it clone.defaultUpstreamName if I were writing this feature.
>
> I was thinking "clone.defaultRemoteName" makes it clear we are naming
> the remote for the provided <url> in the command.

I 100% agree that defaultremotename is much better.

>> ...  For example
>> 
>> 	git -c remote.cloneDefault="bad.../...name" clone parent
>> 
>> should fail, no?
>
> This is an important suggestion.

To be fair, the current code does not handle the "--origin" command
line option not so carefully.

Back when the command was scripted, e.g. 47874d6d (revamp git-clone
(take #2)., 2006-03-21), had both ref-format check and */*
multi-level check, and these checks been retained throughout its
life until 8434c2f1 (Build in clone, 2008-04-27) rewrote the whole
thing while discarding these checks for --origin=bad.../...name

It would make an excellent #leftoverbits or #microproject.

Thanks.
