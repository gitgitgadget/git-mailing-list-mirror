Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F0F120356
	for <e@80x24.org>; Tue, 18 Jul 2017 19:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751569AbdGRTEC (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 15:04:02 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58131 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751430AbdGRTEB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 15:04:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 731C67BDC0;
        Tue, 18 Jul 2017 15:03:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/L1Xqntszp0DruGyjTuXcHyDTBE=; b=UBGHIC
        E2F389BolwKe1ADx5xUO9eB/o+dG1E7bdTsVUeIgH+y770Bx+Tv/QSny1bqnw9bO
        uCbNinzbTQmdl8srXHdXKz3TDCjghAvX5aK5zT/5UmxKI+h8Z/6VutVKjqf3jMhj
        NJzsSuVIrgI0c68EHHSQvd6/fteqoO8ilqFd4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RXxN+in4oUQIl8xQbmOUUm7wQfjr2o0U
        dyKzTGA0RaXKn5Ue1EaMm6V3QbzkxcJKb2JVP97bzG0v8l2z4DjUNytSSh/CJjr/
        xR6DLryTgRBKoj2HzIdB+3C5vQaQ32UkVT0r/dKI7kJWPj4YrTZnhvCPMwMXskcU
        lchPDtZgPRU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6CBB47BDBE;
        Tue, 18 Jul 2017 15:03:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CAEA57BDBD;
        Tue, 18 Jul 2017 15:03:52 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] RFC: A new type of symbolic refs
References: <20170711010639.31398-1-sbeller@google.com>
        <xmqqvamqg2fy.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kY=j-sgrAFwAhP-_9EKBsa6FXARaVuCxM6gPHV7M+1OAA@mail.gmail.com>
Date:   Tue, 18 Jul 2017 12:03:51 -0700
In-Reply-To: <CAGZ79kY=j-sgrAFwAhP-_9EKBsa6FXARaVuCxM6gPHV7M+1OAA@mail.gmail.com>
        (Stefan Beller's message of "Mon, 17 Jul 2017 16:22:36 -0700")
Message-ID: <xmqq60eppnxk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D71A9DDA-6BEB-11E7-92A8-61520C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> Even if we limit ourselves to pointing at the index of the
>> superproject, there probably are a handful of interesting issues
>> that need to be clarified (not in the sense of "this and that issues
>> exist, so this won't be a useful feature", but in the sense of "we'd
>> be able to do these useful things using this feature, and we need to
>> fill in more details"), such as:
>>
>>  - Making new commits in the submodule available to the upstream.
>>    Just like a detached HEAD in the submodule, this is not tied to
>>    any concrete branch, and it is unclear how a recursive "push"
>>    from the superproject should propagate the changes to the
>>    upstream of the submodule;
>
> In Gerrit land people are trained to use
>   git push HEAD:refs/for/master
> which would work fine when propagated to the submodule as-is.

What I was alluding to is how you find 'master' in 'for/master',
given the submodule HEAD which only says "I point at the index of
the superproject".  Note that 'master' here refers to a branch
in the submodule.  If we further limit ourselves and declare that
a submodule that uses this external-reference as HEAD must always
be on the same branch as the superproject is on, then we can find
what branch the superproject is on, and use that.
