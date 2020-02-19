Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C77EC34022
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 21:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44E321D56
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 21:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TFbOLMMK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgBSVvx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 16:51:53 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58330 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgBSVvx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 16:51:53 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B922A3EB79;
        Wed, 19 Feb 2020 16:51:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xR9sT59YpQxWvgPjgTa8c90tFZQ=; b=TFbOLM
        MKGFAp5OkIEZtqnGqfgd7PZTNEtn7Q8tw9uwYeNDhmFCyN6FVAdJoES5c+lzCDSm
        Vk9u013znffJATNI01GtpsotGMvbbX/1uqAUx3SlBRJyVbCBot96kDZTsztOiaM1
        j2TMIHi4x5hSUyBOfguNhiEiJR+WgPGyk1Usk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KWf2ls5QtcvsTX3UJmZi3PRCXPUCvrQG
        u+YKwfKW4TxxN3jTiKMcHM44f+rFGOIKDXyMN5RlbPxuYzo8AYhx9zyoS1Km7vY1
        TslYIwYWnEI9+INshw98UBIbRc17nxECvUpC4TddZ7OEHlq/5ITx/v6rm9UVYQ5c
        YHxrfmSjArM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B1C323EB78;
        Wed, 19 Feb 2020 16:51:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 268733EB77;
        Wed, 19 Feb 2020 16:51:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2020, #04; Mon, 17)
References: <xmqq36b8lvdl.fsf@gitster-ct.c.googlers.com>
        <20200219195822.GA5101@syl.local>
Date:   Wed, 19 Feb 2020 13:51:49 -0800
In-Reply-To: <20200219195822.GA5101@syl.local> (Taylor Blau's message of "Wed,
        19 Feb 2020 11:58:22 -0800")
Message-ID: <xmqqy2syckju.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0909CF9A-5362-11EA-8672-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Mon, Feb 17, 2020 at 02:08:38PM -0800, Junio C Hamano wrote:
>
>> * tb/commit-graph-split-merge (2020-02-12) 3 commits
>>  - builtin/commit-graph.c: support '--input=none'
>>  - builtin/commit-graph.c: introduce '--input=<source>'
>>  - builtin/commit-graph.c: support '--split[=<strategy>]'
>>
>>  The code to write out the commit-graph has been taught a few
>>  options to control if the resulting graph chains should be merged
>>  or a single new incremental graph is created.
>>
>>  Waiting for the discussion to settle.
>>  cf. <20200212205028.GE4364@syl.local>
>
> I think that this discussion is still "settling", although the thread
> hasn't had any activity for a few days now.
>
> I wanted to get feedback from my response to Eric Sunshine before saying
> that we have consensus, but otherwise I think this is moving along.

Did you mean Szeder?

https://lore.kernel.org/git/cover.1581486293.git.me@ttaylorr.com/

