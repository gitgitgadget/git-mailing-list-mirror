Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75AFB207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 22:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S947619AbdDTWvF (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 18:51:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54381 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S947030AbdDTWvD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 18:51:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F15E79EE6;
        Thu, 20 Apr 2017 18:51:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9aZjmXP0giwZFosbDs9UECKKo4k=; b=L6IB5w
        /8z9cT7S0/vphgcjb9YevrvhItFOl2HH7TLf1U7Y8W7hnvm5Yr9U9KHUkP3E6r/c
        IDB4S0bJeJ+L54GnLhJSQduMGFHYB00Ta9YdQ/gNh6ck6pU1C1hQg/8X6GrBkbvE
        NWX5XaOjG0GpAhbdlx9YzkBHr+56gBb5WKmuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=D+VRTjogGGI2shZOmvMkHJ1Kcbt8Alth
        v2eVUE9wE728aA7VNHhK6YD0FzBgvgTZej7i+BEV1a74YCtmqvmcYVE+8FVmN0Ls
        mN9ZqGkmu8S48UxAugx44G8OtI24XPvEIKg2H2mRyYV+1DNPlgggX2XeZj64MuYM
        eK5Z7XmeOqo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3615A79EE5;
        Thu, 20 Apr 2017 18:51:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7992D79EE4;
        Thu, 20 Apr 2017 18:51:01 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2017, #04; Wed, 19)
References: <xmqq4lxjabce.fsf@gitster.mtv.corp.google.com>
        <20170420095921.GA23873@ash>
        <20170420153512.kc57z7cyxdzq74sg@sigill.intra.peff.net>
Date:   Thu, 20 Apr 2017 15:51:00 -0700
In-Reply-To: <20170420153512.kc57z7cyxdzq74sg@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 20 Apr 2017 11:35:13 -0400")
Message-ID: <xmqqo9vq8zhn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D3A9441E-261B-11E7-BAAB-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>>  	if (!ret && opts->keep_locked)
>> -		;
>> +		;	      /* --lock wants to keep "locked" file */
>>  	else
>>  		unlink_or_warn(sb.buf);
>
> I know this is just a drive-by comment, but given that the "else" is the
> only thing that does anything, would it be simpler to flip the
> conditional? The strbuf manipulation above also could go inside it.
> E.g.:
>
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 5ebdcce79..05ade547c 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -307,12 +307,11 @@ static int add_worktree(const char *path, const char *refname,
>  	junk_git_dir = NULL;
>  
>  done:
> -	strbuf_reset(&sb);
> -	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
> -	if (!ret && opts->keep_locked)
> -		;
> -	else
> +	if (ret || !opts->keep_locked) {
> +		strbuf_reset(&sb);
> +		strbuf_addf(&sb, "%s/locked", sb_repo.buf);
>  		unlink_or_warn(sb.buf);
> +	}
>  	argv_array_clear(&child_env);
>  	strbuf_release(&sb);
>  	strbuf_release(&symref);
>
> (Since it's in its own block I'd also consider just introducing a new
> variable for the path, but I guess reusing "sb" for each path is already
> a pattern in the function).

Yeah, when I looked at Duy's version and thought about changing to
lose the empty statement myself, I was afraid that the "if"
condition might become less transparent to grasp, but now I see what
you actually written down, I think "if we got an error, or the
caller didn't ask us to, remove that file" is easy enough to
understand.

Thanks.
