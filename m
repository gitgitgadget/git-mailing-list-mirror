Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5734D20455
	for <e@80x24.org>; Mon, 16 Oct 2017 06:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751768AbdJPGoN (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 02:44:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54578 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751734AbdJPGoL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 02:44:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C69D9A4D4F;
        Mon, 16 Oct 2017 02:44:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oZk1u39QkVjm3H3vnFZVDCwnVkk=; b=Fgcnue
        uJLbdeQGRFneQurAv7Mqb0JsQONwhEi5+FgF+a/yx2byvosu1iqzngBLnFs1oefq
        YINXFvKzPfcjL4Ky4114DM1geSvPDe7hgD9PuK8bWNMMk7OVCeQv0C5PioQXmYij
        bHaLDVhf0YK0YildOUFu+9d9OssROuqcpwocU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Dv939JMpNjstnL83dIpm3gK0qiJncPTO
        QB/rle+wlm+zrAJZ+lX615pD370fVOL9qMc1Fza2Jq/GhbK4pHAxIlkvTYB8+Izf
        tSUjhAvlE9FAiAHDtv84ODFDmBeQvWsc/BhjrjnLqtZYffMFpc7PdvGwVuZnzNLI
        p8KvVk6tSbY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BD959A4D4E;
        Mon, 16 Oct 2017 02:44:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2D8ADA4D4B;
        Mon, 16 Oct 2017 02:44:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Cc:     Marko Kungla <marko.kungla@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] check-ref-format: require a repository for --branch
References: <CAKY_R-uk9hpR2hbkPsw2cqoMo6bQKoyp6cWTO20L3fOWfLW2-Q@mail.gmail.com>
        <20170714180313.apsnbnw7no2nvtf5@sigill.intra.peff.net>
        <20170714181831.fvi2coppzhm747mk@sigill.intra.peff.net>
        <20170717172709.GL93855@aiede.mtv.corp.google.com>
        <20170817102217.3yw7uxnkupdy3lh5@sigill.intra.peff.net>
Date:   Mon, 16 Oct 2017 15:44:08 +0900
In-Reply-To: <20170817102217.3yw7uxnkupdy3lh5@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 17 Aug 2017 06:22:17 -0400")
Message-ID: <xmqqinffsibr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A2ADEB8-B23D-11E7-9341-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Jul 17, 2017 at 10:27:09AM -0700, Jonathan Nieder wrote:
>>  ...
>> I don't think it's right.  Today I can do
>> 
>> 	$ cd /tmp
>> 	$ git check-ref-format --branch master
>> 	master
>> 
>> You might wonder why I'd ever do such a thing.  But that's what "git
>> check-ref-format --branch" is for --- it is for taking a <branch>
>> argument and turning it into a branch name.  For example, if you have
>> a script with an $opt_branch variable that defaults to "master", it
>> may do
>> 
>> 	resolved_branch=$(git check-ref-format --branch "$opt_branch")
>> 
>> even though it is in a mode that not going to have to use
>> $resolved_branch and it is not running from a repository.
>
> I'm not sure I buy that. What does "turning it into a branch name" even
> mean when you are not in a repository? Clearly @{-1} must fail. And
> everything else is just going to output the exact input you provided.
> So any script calling "check-ref-format --branch" outside of a repo
> would be better off not calling it at all.

I threw this topic in stalled category, hoping that one or the other
opinion eventually turns out to be more prevalent, but it didn't
seem to have happened X-<.

Things like @{-1} would not make any sense when the command is run
outside a repository, and the documentation is quite clear that it
is the primary reason why we added "--branch" option to the command,
i.e.

    With the `--branch` option, it expands the ``previous branch syntax''
    `@{-n}`.  For example, `@{-1}` is a way to refer the last branch you
    were on.  This option should be used by porcelains to accept this
    syntax anywhere a branch name is expected, so they can act as if you
    typed the branch name.

So I am tempted to take this patch to make sure that we won't gain
more people who abuse the command outside a repository.

Having said that, there may still be a use case where a Porcelain
script wants a way to see if a $name it has is appropriate as a
branch name before it has a repository (e.g. a wrapper to "git
clone" that wants to verify the name it is going to give to the "-b"
option), and a check desired in such a context is different from
(and is stricter than) feeding refs/heads/$name to the same command
without the "--branch" option.

So I think the right endgame in the longer term is:

 - Find (or add if it doesn't exist) a way to recommend to Porcelain
   scripts to use to expand an end-user generated string, and to map
   it to a branch name (it may be "rev-parse --symbolic-full-name
   $name"; I dunno).

 - Keep check-ref-format as (or revert it to be) a tool to "check".
   This would involve split strbuf_check_branch_ref() into two:

   - one that does not do the @{-1} thing and is used ONLY for
     format validity check (including rejecting a name that begins
     with a dash, which is OK for a random ref but not acceptable as
     a branch name);

   - the other that does @{-1} thing before doing the above.
   
   and then making the code call the former, not the latter.

The end result would be that check-ref-format becomes textual check
only, and can be usable (agian) outside repository, with or without
"--branch".  As the current code does not allow us do that yet, I
think it is safer to forbid use of --branch outside the repository
for now, purely as a bugfix.


[Footnote]

*1* In a sense, @{-1} is not something the scripts need to check its
    validity of---it is the branch you came from, so by definition
    it must be with a good name.  What the scripts want is instead
    see what the branch actually is, which is not what
    "check-ref-format" is about.

    a31dca03 ("check-ref-format --branch: give Porcelain a way to
    grok branch shorthand", 2009-03-21) says:

    The command may not be the best place to add this new feature, but
    
        $ git check-ref-format --branch "@{-1}"
    
    allows Porcelains to figure out what branch you were on before the last
    branch switching.
