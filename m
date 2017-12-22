Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AD4E1F406
	for <e@80x24.org>; Fri, 22 Dec 2017 18:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756198AbdLVSV1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 13:21:27 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52491 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755458AbdLVSV0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 13:21:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 43835BCDEF;
        Fri, 22 Dec 2017 13:21:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=p3v7V44fOZvbTdEnz1rwIJJ4TVk=; b=ElW7FR
        4LjH0awCvpSuieZU6GzPYRrU9XGB6OUfbenG/hOy4usSi+wiWsM0N13s9W5v3ZF/
        TslsKylc+5Mn2FtmE4UH7GpQrUPXYV66All2W9Ybu1l1gdyqqGKheCKQaBQjKQiZ
        Od250kqZBcEh2bzJKbKp1eItykVrFhU+y67Wo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KDQBHnw9EWlufp63OkKu3myw7WcuA0La
        wlHcTtDfF5988l2OPaUhlWsMU2X2sJT+Xvz1D/6T1VjyYJoS879JsM9IjgGOeUwI
        lB9QqSNNlN9pWWzkN12145Nld15FWb5aLnSMlfhZBzuU+29tifpcjNoqdWa8Av/t
        DOaT6Rxn56E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3ACEDBCDEE;
        Fri, 22 Dec 2017 13:21:25 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9C606BCDEB;
        Fri, 22 Dec 2017 13:21:24 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
        peff@peff.net, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 1/5] core.aheadbehind: add new config setting
References: <20171221190909.62995-1-git@jeffhostetler.com>
        <20171221190909.62995-2-git@jeffhostetler.com>
        <20171221204356.GA58971@aiede.mtv.corp.google.com>
Date:   Fri, 22 Dec 2017 10:21:23 -0800
In-Reply-To: <20171221204356.GA58971@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Thu, 21 Dec 2017 12:43:56 -0800")
Message-ID: <xmqq3742tyho.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EB1ED07E-E744-11E7-B88C-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> Created core.aheadbehind config setting and core_ahead_behind
>> global variable.  This value defaults to true.
>>
>> This value will be used in the next few commits as the default value
>> for the --ahead-behind parameter.
>>
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>> ---
>>  Documentation/config.txt | 8 ++++++++
>>  cache.h                  | 1 +
>>  config.c                 | 5 +++++
>>  environment.c            | 1 +
>>  4 files changed, 15 insertions(+)
>
> Not a reason to reroll on its own, but this seems out of order: the
> series is easier to explain and easier to merge down in stages if the
> patch for --ahead-behind comes first, then the config setting.
>
> More generally, new commandline flags tend to be less controversial
> than new config settings since they cannot affect a script by mistake,
> and for that reason, they can go earlier in the series.
>
> As a bonus, that makes it possible to include tests.  It's probably
> worth adding a test or two for this new config setting.
>
> [...]
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 9593bfa..c78d6be 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -895,6 +895,14 @@ core.abbrev::
>>  	abbreviated object names to stay unique for some time.
>>  	The minimum length is 4.
>>  
>> +core.aheadbehind::
>> +	If true, tells commands like status and branch to print ahead and
>> +	behind counts for the branch relative to its upstream branch.
>> +	This computation may be very expensive when there is a great
>> +	distance between the two branches.  If false, these commands
>> +	only print that the two branches refer to different commits.
>> +	Defaults to true.
>
> This doesn't seem like a particularly core feature to me.  Should it be
> e.g. status.aheadbehind (even though it also affects "git branch") or
> even something like diff.aheadbehind?  I'm not sure.

FWIW, I do not think it is core at all, either; sorry for not
anticipating that a wrong name will be picked without a proper
guidance when I saw the "not limited to status" mentioned in the
discussion, but I was sick and offline for a few days, so...

> I also wonder if there's a way to achieve the same benefit without
> having it be configurable.  E.g. if a branch is way behind, couldn't
> we terminate the walk early to get the same bounded cost per branch
> without requiring configuration?

Hmm, that is an interesting thought.
