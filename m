Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ECE2202DD
	for <e@80x24.org>; Fri, 20 Oct 2017 02:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751707AbdJTCTs (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 22:19:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52675 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751616AbdJTCTr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 22:19:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 809C0A12B8;
        Thu, 19 Oct 2017 22:19:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fcrlvgVnmrMTgo0kD8bGNN0nIFE=; b=x4ZXMm
        HC79wDGeLMqJgOEMbllEJxzHXuZ9OfTmVi9Sa+YApa3ZiRP4+d50ZzB66MtH7zQI
        fFzAo5uRZeH5AZM9cPz1MJCRpze7+NXY9MHENs/fSwugTr7jDmRbM26YCU9M9BWG
        3G8jeyH9H91Vz21D3gP+gYjwTZ3UNEMMF45Eg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vIEUOBRXX+AybI8aayEBuJa6uTWyorlh
        nJpDOZiadRPLCqUD2aCvFZZRkgXAI8STyDCZfSziKo26Zm9Ecvv4nlJMpesAmhod
        hwy/p4nZ0FUkt1BghG05h5ToCZI5jrX7PzD5/ZbYOXXcbolsaFbKF8QOXutRj62t
        u6HVyjfvWTo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 775B7A12B7;
        Thu, 19 Oct 2017 22:19:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CE48BA12B6;
        Thu, 19 Oct 2017 22:19:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Marius Paliga <marius.paliga@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, thais.dinizbraz@gmail.com
Subject: Re: [PATCH] builtin/push.c: add push.pushOption config
References: <xmqqmv4pl117.fsf@gitster.mtv.corp.google.com>
        <20171019174715.6577-1-marius.paliga@gmail.com>
        <CAGZ79kaSU+w0=zb61=5pEzhtd4U5Hzae4C2bUgpchNHAL_mzMA@mail.gmail.com>
Date:   Fri, 20 Oct 2017 11:19:44 +0900
In-Reply-To: <CAGZ79kaSU+w0=zb61=5pEzhtd4U5Hzae4C2bUgpchNHAL_mzMA@mail.gmail.com>
        (Stefan Beller's message of "Thu, 19 Oct 2017 12:46:08 -0700")
Message-ID: <xmqqbml2imrj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 23F90D86-B53D-11E7-B9CC-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> @@ -161,6 +161,9 @@ already exists on the remote side.
>>         Transmit the given string to the server, which passes them to
>>         the pre-receive as well as the post-receive hook. The given string
>>         must not contain a NUL or LF character.
>> +       When no `--push-option <option>` is given from the command
>> +       line, the values of configuration variable `push.pushOption`
>> +       are used instead.
>
> We'd also want to document how push.pushOption works in
> Documentation/config.txt (that contains all the configs)

Perhaps.

> So in the config, we have to explicitly give an empty option to
> clear the previous options, but on the command line we do not need
> that, but instead we'd have to repeat any push options that we desire
> that were configured?

It is not wrong per-se to phrase it like so, but I think that is
making it unnecessarily confusing by conflating two things.  (1)
configured values are overridden from the command line, just like
any other --option/config.variable pair and (2) unlike usual single
value variables where "last one wins" rule is simple enough to
explain,, multi-value variables need a way to "forget everything we
said so far and start from scratch" syntax, especially when multiple
input files are involved.

> Example:
>
>   /etc/gitconfig
>   push.pushoption = a
>   push.pushoption = b
>
>   ~/.gitconfig
>   push.pushoption = c
>
>   repo/.git/config
>   push.pushoption =
>   push.pushoption = b
>
> will result in only b as a and c are
> cleared.

The above is correct, and it might be worth giving it as an example
in the doc, because not just "give an empty entry to clear what has
been accumulated so far" but a multi-valued option in general is a
rather rare thing.

> If I were to run
>   git -c push.pushOption=d push ... (in repo)
> it would be b and d, but
>   git push --push-option=d
> would be d only?

>> @@ -584,12 +599,13 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>>                 set_refspecs(argv + 1, argc - 1, repo);
>>         }
>>
>> -       for_each_string_list_item(item, &push_options)
>> +       for_each_string_list_item(item, push_options)
>
> We have to do the same for _cmdline here, too?

I do not think so.  The point of these lines that appear before this
loop:

 	git_config(git_push_config, &flags);
 	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
+	push_options = (push_options_cmdline.nr
+		? &push_options_cmdline
+		: &push_options_config);

is that the command line overrides configured values, just like any
other configuration.  Adding _cmdline variant here is doubly wrong
when command line options are given in that it (1) duplicates what
was obtained from the command line, and (2) does not clear the
configured values.
