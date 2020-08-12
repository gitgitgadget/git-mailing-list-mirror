Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18084C433E0
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 22:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E19B2076B
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 22:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="P3WUZPdu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgHLWHf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 18:07:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64379 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbgHLWHf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 18:07:35 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DA1FD6E02F;
        Wed, 12 Aug 2020 18:07:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EQB9fUcrPke72vJupeQHivBeKjk=; b=P3WUZP
        duIDazFGFcRjAPWcv4GKMfE+9rFyIIo8BbY5ZDlnda1cLAv4Nzdrm9D2qFyDhVjO
        cMn1swmxQwOjJtBG3RT57iH+k+NKv/EV++CDrpGBMqjImP6GMrrH+jZobxHkY153
        ElF/3QEGDhWZc5n0wynfTNOAs5pzMTyDwMYBU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=b2pH7JCpVYi6OhYvdMrL6sYx3GlGOaeX
        ExRjhhIDXa3aEk6bH03IOje2WeatFiGqrIinO8lH6G6z7ubtGVRAQm66zVT5P6yW
        k/zxnqpU+8rEGFO+gLZ6uiEE42FCkvxWJ+1QnwPSN+v/vrjlUc3PTcrnWqk8OA+B
        7gDo4RtodYw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D02D26E02E;
        Wed, 12 Aug 2020 18:07:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5E8DB6E02D;
        Wed, 12 Aug 2020 18:07:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 01/11] maintenance: create basic maintenance runner
References: <pull.695.git.1596728921.gitgitgadget@gmail.com>
        <2b9deb6d6a23e53bec75e109f2e3ef9217420425.1596728921.git.gitgitgadget@gmail.com>
        <20200812210326.GA104953@google.com>
Date:   Wed, 12 Aug 2020 15:07:31 -0700
In-Reply-To: <20200812210326.GA104953@google.com> (Jonathan Nieder's message
        of "Wed, 12 Aug 2020 14:03:26 -0700")
Message-ID: <xmqqsgcr4ixo.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 385879DA-DCE8-11EA-90F5-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> +static int maintenance_run(struct maintenance_opts *opts)
>> +{
>> +	return maintenance_task_gc(opts);
>> +}
>> +
>> +int cmd_maintenance(int argc, const char **argv, const char *prefix)
>> +{
>> +	static struct maintenance_opts opts;
>> +	static struct option builtin_maintenance_options[] = {
>> +		OPT_BOOL(0, "auto", &opts.auto_flag,
>> +			 N_("run tasks based on the state of the repository")),
>> +		OPT_END()
>> +	};
>
> optional: these could be local instead of static

Do we have preference?  I think it is more common in our codebase to
have these non-static but I do not think we've chosen which is more
preferable with technical reasoning behind it.  As the top-level
function in any callchain, cmd_foo() does not have multiple instances
running at the same time, or it does not have to be prepared to be
called twice, so they can afford to be static, but is there any upside
for them to be static?

>> +
>> +	memset(&opts, 0, sizeof(opts));
>
> not needed if it's static.  If it's not static, could use `opts = {0}`
> where it's declared to do the same thing in a simpler way.

Okay, so that's one upside, albeit a small one.

