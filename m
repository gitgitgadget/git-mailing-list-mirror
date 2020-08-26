Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2070C433E1
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 17:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA7F020737
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 17:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="U+dnIwmk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgHZRDv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 13:03:51 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52029 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbgHZRDt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 13:03:49 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 60386E6D8F;
        Wed, 26 Aug 2020 13:03:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=I6nHOGnp40zbxDuuRT+H6nN+dso=; b=U+dnIw
        mkbrjdo186DZXLE6aGdJZwlp5FYVlApdZQoNtfUcaWasc1rUclB1Daw6ks6CWven
        Socv74y5whHlGEqyGbNd9wSg3xmLXF98Q6js9v8EfyrBg4wb8Z8xUsjRl7SyI7e2
        O6cstpXwmsQyn+S6iRIx7RHQgxEyQQultHcrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ht0fTFNVhKJnzD8Ov9n40k1zjuZRNc/W
        8Gtap49GRu1S9PJVLF/2e7CuQYqf6xuPTjdb+7Es+ieCommX7WE5kG1DIj6R6LPa
        hry0JCuDlhYGKqw92suTNON7L7IS2YH0E5gZDpP7QYsoWig3AO6dTjVd2ROcrmzU
        Bz43JRKTpXg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 57381E6D8D;
        Wed, 26 Aug 2020 13:03:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 88C84E6D89;
        Wed, 26 Aug 2020 13:03:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 2/7] maintenance: store the "last run" time in config
References: <pull.680.git.1597857408.gitgitgadget@gmail.com>
        <pull.680.v2.git.1598380805.gitgitgadget@gmail.com>
        <e3ef0b9bea4a31c72ce88841639e88355408f0c1.1598380805.git.gitgitgadget@gmail.com>
        <xmqqh7sqz93k.fsf@gitster.c.googlers.com>
        <4fe41132-c8f5-6b85-414f-5a1e5fcccdc9@gmail.com>
Date:   Wed, 26 Aug 2020 10:03:41 -0700
In-Reply-To: <4fe41132-c8f5-6b85-414f-5a1e5fcccdc9@gmail.com> (Derrick
        Stolee's message of "Wed, 26 Aug 2020 09:34:41 -0400")
Message-ID: <xmqqzh6huyoi.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 18E6A46A-E7BE-11EA-92F9-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>>>  1. The time the task takes to execute should not contribute to the
>>>     interval between running the tasks.
>> 
>> ... as long as the run time is sufficiently shorter than the
>> interval, that is.  If a task takes 10-30 minutes depending on how
>> dirty the repository is, it does not make sense to even try to run
>> it every 15 minutes.
>
> Definitely. The lock on the object database from earlier prevents these
> longer-than-anticipated tasks from stacking.

Hmph, I actually was (anticipating|hoping) that you would give a
good argument for having maintenance subsystem in change of
scheduling rather than cron, as it can monitor how the already
running job is goind and skip one cycle if needed.  The above is
instead a good argument that independent cron jobs can still
coordinate and there is no central and custom scheduler in the form
of 'maintenance run'.

>>>  2. If the task fails for some unforseen reason, it would be good to
>>>     indicate that we _attempted_ the task at a certain timestamp. This
>>>     will avoid spamming a repository that is in a bad state.
>> 
>> Absolutely.

Somebody already mentioned that using the configuration file for
recordkeeping may not be a good idea, and I tend to agree, by the
way.  I may want to periodically take a snapshot of my configuration
to notice and remember changes I made myself intentionally
(e.g. switched access method of a hosting site from ssh:// to
https://, added a new branch that builds on something else, etc.) by
comparing the snapshot with previous ones (and might even put it
under version-control) and mechanical noise would interfere with it.

