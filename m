Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F6982018A
	for <e@80x24.org>; Mon, 27 Jun 2016 13:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbcF0NR6 (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 09:17:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60212 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751706AbcF0NR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 09:17:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DB6C8262DD;
	Mon, 27 Jun 2016 09:17:54 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ei8LEw0LFysPOAH8FruexAu1c+4=; b=l6M23F
	WtaK4sqy+ibyK4JXnN/tOjNjYWalKgwn5O6t4fzCUTvNWezhYaw1l+svh/kCl8HG
	G00cE8JBOSAdTra+Fezs2gp3Qu5EPxBWUqO90+QcFNPyXVWtpc6uRC25G0KA4iyv
	Kz9gdxIk8QQWh8mv+5iipobUN9cqD8afMuhg0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fhlr5W34tq5IW6ypSKiWgLf5CEFGwyZb
	zU9m/losSBiBl1cjgfcpSs6sEli9i7dtQ1AHECYo8vKMbL9tSDkz19KKMihVLUFz
	jho0XJ8XxmKbT6NFo4zBqmIzKIgoJRnI+qat7ejWqmUX10ojWFAUVgKJ6AY9Ubsi
	sO8UkNNCJLE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D3B6F262DC;
	Mon, 27 Jun 2016 09:17:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5AB13262D3;
	Mon, 27 Jun 2016 09:17:54 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Barret Rennie <barret@brennie.ca>
Cc:	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Michael Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH] builtin/worktree.c: add option for setting worktree name
References: <20160625051548.95564-1-barret@brennie.ca>
	<576E2FA9.7070008@kdbg.org>
	<1FEF5F90-6534-4D91-B27C-16FE6D16EC3F@brennie.ca>
	<xmqq1t3ldpdl.fsf@gitster.mtv.corp.google.com>
	<xmqqshvzddet.fsf@gitster.mtv.corp.google.com>
	<036C19B4-5941-43E4-AE2A-8782797D9523@brennie.ca>
Date:	Mon, 27 Jun 2016 06:17:52 -0700
In-Reply-To: <036C19B4-5941-43E4-AE2A-8782797D9523@brennie.ca> (Barret
	Rennie's message of "Sun, 26 Jun 2016 23:40:15 -0600")
Message-ID: <xmqqk2hadb3z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8EAF74E2-3C69-11E6-A401-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Barret Rennie <barret@brennie.ca> writes:

>> For example, the "frotz" and "nitfol" repositories (i.e. where their
>> worktrees borrow their refs and object stores from) could have a
>> single configuration variable each, i.e.
>> 
>> 	(in $HOME/xyzzy/frotz/.git/config)
>>        [worktree] location = "~/*/frotz"
>> 
>> 	(in $HOME/xyzzy/libs/nitfol/.git/config)
>>        [worktree] location = "~/*/libs/nitfol"
>> 
>> and then the user could do in each of these two repositories
>> 
>> 	$ git -C ~/xyzzy/frotz worktree add --by-name xyzzy-1 topic-1
>> 	$ git -C ~/xyzzy/lib/nitfol worktree add --by-name xyzzy-1 topic-1
>> 
>> to get the desired layout instead.
>> 
>> The traditional way may be "create one HERE", and your patch tries
>> to tweak it to "create one at HERE with this NAME".  The above
>> attempts to remove the need for specifying the exact location every
>> time a new worktree is created, and instead let you specify the
>> systematic way in which you lay out your worktrees based on their
>> names.
>
> Are you proposing that `--by-name` creates a worktree in the current working
> directory or that the default behaviour of `git worktree add` is changed to
> to create the worktree in the current working directory when executed with
> only one argument (the branch)?

It is not a proposal but an illustration of what I meant by "hint".

What I am envisioning is that we may enhance the "worktree add"
subcommand to take two forms.  In addition to traditional

    $ git worktree add [opts] <path> [<branch>]

when worktree.location configuration is present, you could say

    $ git worktree add [opts] --by-name <name> [<branch>]

omitting <path> and instead giving <name>.  Use the <name> to
substitute the wildcard in the pattern given by worktree.location,
i.e. with the above example for "frotz",

    $ git worktree add --by-name xyzzy-1 topic-1

because the worktree.location configuration is set to "~/*/frotz",
that would act as if <path> was given as ~/xyzzy-1/frotz.  Name is
set to xyzzy-1, and the newly created worktree would initially check
out topic-1 branch.
