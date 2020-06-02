Return-Path: <SRS0=E3tc=7P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC63C433E0
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 16:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0E79206E2
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 16:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zy2yBmh9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgFBQzM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 12:55:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54035 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgFBQzM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 12:55:12 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D474674666;
        Tue,  2 Jun 2020 12:55:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vgTg36KWSitcnubu8Yo9rsfVhGU=; b=Zy2yBm
        h9KrLBVhIM7461Aau9d8woJsk3G/AqKt0qiixlV7F3o2Jy/z9nO6jHhrPbon6Rvv
        iI9HaZ7dVSm8bfkluuSjEGsqVEzOkurP0F++X8IxaXbnXHoF9EjGo55Ia+AAz+6r
        X5mpxLmH6bHdrn6fdyXTe/QKkQ0yhz930PkOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CMQBRjoqyZz+S+pXMcaHA4I8dJKnWnC3
        bgQ2IMtTj6YEDcLNRa0Hni0FTIfDynZbgNmzxvdNaZVsYOqHXiSqUHyaBgau3tSk
        UaGW1/nXZ1BPPR17NgMtZRhVSG7LQORMyNq3wyCqEAdWLFIfGnON/T9H6XVF6E4X
        RvQZVmH7Yoo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BF84074665;
        Tue,  2 Jun 2020 12:55:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 21FF874664;
        Tue,  2 Jun 2020 12:55:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] clone/fetch: anonymize URLs in the reflog
References: <pull.797.git.git.1591039202561.gitgitgadget@gmail.com>
        <20200601214715.GB3309882@coredump.intra.peff.net>
Date:   Tue, 02 Jun 2020 09:55:07 -0700
In-Reply-To: <20200601214715.GB3309882@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 1 Jun 2020 17:47:15 -0400")
Message-ID: <xmqqimg9tnkk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D092C356-A4F1-11EA-928D-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Jun 01, 2020 at 07:20:02PM +0000, Johannes Schindelin via GitGitGadget wrote:
>
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> 
>> Even if we strongly discourage putting credentials into the URLs passed
>> via the command-line, there _is_ support for that, and users _do_ do
>> that.
>> 
>> Let's scrub them before writing them to the reflog.
>
> Good idea.
>
>>     This came up in an internal audit, but we do not consider this to be a
>>     big deal: the reflog is local and not really shared with anybody.
>
> Agreed.

Nice.

>>  builtin/clone.c            | 10 ++++++----
>>  builtin/fetch.c            |  9 +++++++--
>>  t/t5541-http-push-smart.sh | 15 +++++++++++++++
>
> The patch itself looks very neatly done.
>
>> @@ -993,11 +993,13 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>>  
>>  	path = get_repo_path(repo_name, &is_bundle);
>>  	if (path)
>> -		repo = absolute_pathdup(repo_name);
>> +		display_repo = repo = absolute_pathdup(repo_name);
>>  	else if (!strchr(repo_name, ':'))
>>  		die(_("repository '%s' does not exist"), repo_name);
>> -	else
>> +	else {
>>  		repo = repo_name;
>> +		display_repo = transport_anonymize_url(repo);
>> +	}
>
> Not introduced by your patch, but I had to read this a few times to make
> sure we always end up with repo and display_repo set. IMHO it would be
> easier to read as:
>
>   if (this) {
>      repo = ...;
>      display_repo = ...;
>   } else if (that) {
>      repo = ...;
>      display_repo = ...;
>   } else {
>      die(...);
>   }
>
> instead of sticking the die() in the middle.  Maybe just personal
> preference, though. :)

For a if/elseif cascade of few-liner blocks each, I do not think it
would matter, but if a block were larger, having the die() case at
the beginning or at the end would indeed make it easier to spot any
anomalies.

>> +	# should have been scrubbed down to vanilla URL
>> +	git log -g master >reflog &&
>> +	grep "$HTTPD_URL" reflog &&
>> +	! grep "$HTTPD_URL_USER_PASS" reflog
>> +'
>
> And you make sure we retain the username. Nice.
