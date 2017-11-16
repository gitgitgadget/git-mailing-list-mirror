Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CE48201C8
	for <e@80x24.org>; Thu, 16 Nov 2017 00:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932381AbdKPATw (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 19:19:52 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52755 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752932AbdKPATv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 19:19:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 86B5FB3391;
        Wed, 15 Nov 2017 19:19:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4B9PDq7AUcXoWezY41QWBn2sHRA=; b=ws+iTp
        mJpEjGmB2MGbxkyEHUxbs8wZAMXXXcnepP1g9VyUGjvkvTe8spBTmENquJhWyB6F
        QOmwcifOe6n/iJE/ReykU0vv7+wgslJfWRLNUXQlbR74plhExvOdYwr7/Lq4vndw
        5j943a/U31vBDOeDvinIMp2zPeW+v/d7fW9co=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uU0GBO1aM84EfTkoC0zSou6TGIVSrtJZ
        sNI3fMl4QL3dZFzORnhxr3fNRtp7VlvQRxE25FdM+QCTZZg9czIHjkKUH5HWBzgo
        9AnQDGVVcc8ocN5yETeXolQVD7ObfXyVPGbWq21fbTycSIqiaSRrdj8NGubS3kB0
        K1/qbm3o9sc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7EDB8B3390;
        Wed, 15 Nov 2017 19:19:48 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EE3AEB338D;
        Wed, 15 Nov 2017 19:19:47 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ninivaggi Mattia <mattia.ninivaggi@helsana.ch>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [Feature- Request] Option to commit after checking out branch command is made
References: <670f44c0ac554f2faec5a6112376b015@MSSMAILP06.ads.hel.kko.ch>
Date:   Thu, 16 Nov 2017 09:19:46 +0900
In-Reply-To: <670f44c0ac554f2faec5a6112376b015@MSSMAILP06.ads.hel.kko.ch>
        (Ninivaggi Mattia's message of "Wed, 15 Nov 2017 15:27:18 +0000")
Message-ID: <xmqqtvxvxefx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DAD33154-CA63-11E7-8F92-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ninivaggi Mattia <mattia.ninivaggi@helsana.ch> writes:

> 1. I checkout a branch, without having commited first
>     > git checkout dev
> 2. I get this error message:
>     > error: Your local changes to the following files would be overwritten by checkout:
>     > // List of files
>     > // ..
>     > //
>     > Please commit your changes or stash them before you switch branches.
>
> But I would rather prefer a scenario like this:
> ...
> 1. I checkout a branch, without having commited first
>     > git checkout dev
> 2. I get a message like this:
>     > Your local changes to the following files would be overwritten by checkout:
>     > // List of files
>     > // ..
>     > //
>     > Would you want to commit first? (y/n))
>
> IF y --> prompt for commit message and commit automatically

I do not think you want to do this for a few reasons.

 * The "please commit or stash" is merely a suggestion whose primary
   purpose is to silence clueless newbies who would have complained
   "Git said 'error: ... overwritten by checkout' and I do not know
   what to do next; the error message is so unhelpful" otherwise.
   Majority of the time when I see this message, it is because I
   forgot that I was in the middle of doing something (meaning: I am
   far from finished with the changes I was working on), and I would
   not be ready to commit.  I'd rather keep working to get the work
   into a more reasonable shape before committing, or stash the
   changes first if the task I wanted to do on that "dev" branch is
   more urgent and what I was in the middle of doing is lower
   priority.  

   Because of this, I would expect many users (including the ones
   who are right now newbies but will have gained experience to
   become experts in the future) to appreciate "stash before switch"
   a lot more than "commit first before switch".

 * People write scripts that use "git checkout" to switch branches,
   and they rely on the command to fail in this situation, instead
   of going interactive and gets stuck waiting for an input (which
   may never come).  Because of this, the updated behaviour you
   propose must never be the default, and at least must be protected
   behind a flag, something like "git checkout --autostash dev" (or
   "--autocommit", if you insist).  With that, you could do

	[alias]
		co = checkout --autostash

   and train your fingers to say "git co dev".

Of course, you can have a "git-co" script on your $PATH, which runs
"git checkout $1", lets it fail just like it does now, and then does
"git commit", if you really want the behaviour.  Again, you can then
use "git co dev" and you do not have to worry about breaking
people's scripts that depends on "git checkout" to fail without
going interactive.
