Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89A3820966
	for <e@80x24.org>; Thu, 30 Mar 2017 21:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934218AbdC3VzC (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 17:55:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59057 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755096AbdC3VzB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 17:55:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 23AF06F261;
        Thu, 30 Mar 2017 17:54:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=p2mOkum3TFljEVY7LGt+UKavVuU=; b=RSmyAt
        ux60tlAXM7WsP92CQPJuqEmBAJh52S7bB2acGPF6EQBhR2kHZqh1JsREfqReS4AI
        9CXqzahOVJmoWsVLlc6poAT2ad33Oo+KWt0N9ndXhHqxtcsVBBnQzoJU7fUfX/j8
        oy5J09C45AEi2XkSCdDkhw3qfz1syIoPCsaa0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KJVIh9x2nNWYPQvcIdTrPC6L86T5E1TX
        QbOgLI15Oc8RhVr/m84xZzS3cu7PLsZuIlh9XmK/YBbnHrm4oQcLfdEX1OEJTxRM
        IKBor9N4hVjNv/ibtRHn2uBZHxNtca+g5G0fQcgSHEBF8jvsixyO7+IvscLKtSCO
        I+RbavUzJDs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C9436F260;
        Thu, 30 Mar 2017 17:54:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 645B26F25F;
        Thu, 30 Mar 2017 17:54:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Thomas Rast <tr@thomasrast.ch>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] log: if --decorate is not given, default to --decorate=auto
References: <20170324054631.21622-1-alexhenrie24@gmail.com>
        <20170324183825.GD31294@aiede.mtv.corp.google.com>
        <xmqqa88263qw.fsf@gitster.mtv.corp.google.com>
        <20170330213358.qjsobjcbons66skf@sigill.intra.peff.net>
Date:   Thu, 30 Mar 2017 14:54:57 -0700
In-Reply-To: <20170330213358.qjsobjcbons66skf@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 30 Mar 2017 17:33:58 -0400")
Message-ID: <xmqq1ste2zwu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 846D7674-1593-11E7-B991-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Mar 30, 2017 at 11:03:51AM -0700, Junio C Hamano wrote:
>
>> With the "--decorate=auto" option becoming the default for "git
>> log", "git tbdiff" will be broken.
>> ...
> I'm confused. I thought "auto" would kick in only when we are outputting
> to a terminal. Or is the problem that the "is it a terminal" check is
> fooled by $GIT_PAGER_IN_USE, because you are running "git -p tbdiff"?

Interesting.  Yes, I do use 

    [pager]
	tbdiff

in my ~/.gitconfig file.

    $ git tbdiff ..@{-1} @{-1}..

is one of the most frequently used commands in my ~/.bash_history
these days [*1*].  I by accident has been running the 'master'
version (not my private edition 'jch' that is a bit ahead of 'next')
for the past few weeks, and I just switched back to using the 'jch'
version so that I can say

    $ git tbdiff ..- -..

instead, and that is when I noticed we broke "tbdiff".

> If so, this is the symptom of a more general problem, which is that
> a script outputting to a pager will have confused sub-processes, who do
> not know if their pipe is the pager one or not. Perhaps it is time to
> resurrect my patch from:
>
>   http://public-inbox.org/git/20150810052353.GB15441@sigill.intra.peff.net/
>
> I think it would need a Windows-specific variant, but the general idea
> is sound.

Yes, that might be necessary.


[Footnote]

*1* The general flow to accept a reroll of a topic "au/topic" goes
    like this:

    $ git checkout au/topic
    $ git log master.. ;# to remind me what it was about
    $ git checkout master... ;# to go back to the original base
    $ Meta/CP ./+au-topic.mbox ;# run checkpatch
    $ git am -s3c
    $ git tbdiff ..@{-1} @{-1}..

    Then if the initial N patches are identical, e.g. when the
    output of tbdiff begins like this:

     1: f6d8dfd8b6 =  1: d681cf5ada do not check odb_mkstemp return value for errors
     2: 52dcad2c2e =  2: abf30edce4 odb_mkstemp: write filename into strbuf
     3: 033d6ae6cb =  3: 38fceca547 odb_mkstemp: use git_path_buf
     4: 55e3179076 !  4: 344267b632 diff: avoid fixed-size buffer for patch-ids
        @@ ... @@

    $ git rebase --onto 033d6ae6cb 38fceca547
    $ git tbdiff ..@{-1} @{-1}..

    That way, I can preserve the author and committer timestamps of
    the earlier part that did not change.
