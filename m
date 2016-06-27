Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8C0120179
	for <e@80x24.org>; Mon, 27 Jun 2016 05:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629AbcF0FkU (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 01:40:20 -0400
Received: from [104.236.5.163] ([104.236.5.163]:44769 "EHLO brennie.ca"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750894AbcF0FkT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 01:40:19 -0400
Received: from [192.168.1.38] (142-165-34-81.sktn.hsdb.sasknet.sk.ca [142.165.34.81])
	by brennie.ca (Postfix) with ESMTPSA id 5524B401CD;
	Sun, 26 Jun 2016 23:40:17 -0600 (CST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] builtin/worktree.c: add option for setting worktree name
From:	Barret Rennie <barret@brennie.ca>
In-Reply-To: <xmqqshvzddet.fsf@gitster.mtv.corp.google.com>
Date:	Sun, 26 Jun 2016 23:40:15 -0600
Cc:	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>, Michael Rappazzo <rappazzo@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <036C19B4-5941-43E4-AE2A-8782797D9523@brennie.ca>
References: <20160625051548.95564-1-barret@brennie.ca> <576E2FA9.7070008@kdbg.org> <1FEF5F90-6534-4D91-B27C-16FE6D16EC3F@brennie.ca> <xmqq1t3ldpdl.fsf@gitster.mtv.corp.google.com> <xmqqshvzddet.fsf@gitster.mtv.corp.google.com>
To:	Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On Jun 26, 2016, at 12:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Now, if you do the worktree, you may still want the relative
>> structure between these two, i.e. if you want to work on two
>> different branch combinations of the whole thing, you would want to
>> do this:
>> 
>>    $HOME/xyzzy-1/frotz       - borrow from $HOME/xyzzy/frotz
>>    $HOME/xyzzy-1/libs/nitfol - likewise for nitfol
>> 
>>    $HOME/xyzzy-2/frotz       - borrow from $HOME/xyzzy/frotz
>>    $HOME/xyzzy-2/libs/nitfol - likewise for nitfol
>> 
>> where xyzzy-$n may be for topic-$n branch both in frotz and nitfol.
>> 
>> And explained that way, it becomes clearer that you would want to
>> name $HOME/xyzzy-1/frotz worktree after "topic-1", not the default
>> name you would get "frotz" (because the default gives you the leaf
>> level name of the newly created worktree).
>> 
>> After the discussion above (which may or may not match what you
>> raised this topic for), I think a feature to let you override the
>> default name makes sense.
>> 
>> It just needs to be explained better to help the users when the
>> feature eventually becomes part of Git.  Also, others (especially
>> Duy) may have even better ideas (e.g. instead of having to always
>> use --name to give custom name for all worktrees, set a "hint" just
>> once to help the logic that comes up with the default name give a
>> better name), so while the feature may be desirable, your exact
>> implementation may or may not be what we eventually want to adopt.
> 
> For example, the "frotz" and "nitfol" repositories (i.e. where their
> worktrees borrow their refs and object stores from) could have a
> single configuration variable each, i.e.
> 
> 	(in $HOME/xyzzy/frotz/.git/config)
>        [worktree] location = "~/*/frotz"
> 
> 	(in $HOME/xyzzy/libs/nitfol/.git/config)
>        [worktree] location = "~/*/libs/nitfol"
> 
> and then the user could do in each of these two repositories
> 
> 	$ git -C ~/xyzzy/frotz worktree add --by-name xyzzy-1 topic-1
> 	$ git -C ~/xyzzy/lib/nitfol worktree add --by-name xyzzy-1 topic-1
> 
> to get the desired layout instead.
> 
> The traditional way may be "create one HERE", and your patch tries
> to tweak it to "create one at HERE with this NAME".  The above
> attempts to remove the need for specifying the exact location every
> time a new worktree is created, and instead let you specify the
> systematic way in which you lay out your worktrees based on their
> names.

Are you proposing that `--by-name` creates a worktree in the current working
directory or that the default behaviour of `git worktree add` is changed to
to create the worktree in the current working directory when executed with
only one argument (the branch)?

In either case, I'm not sure what `worktree.location` does here, since we're
creating the worktree in the working directory, unless I'm misunderstanding
your example.
