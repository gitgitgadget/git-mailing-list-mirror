Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8E1F1F4F8
	for <e@80x24.org>; Sun, 25 Sep 2016 18:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760834AbcIYSiO (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 14:38:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50932 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1760650AbcIYSiK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 14:38:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 34C993DCF5;
        Sun, 25 Sep 2016 14:38:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wZNMMFkBeLxekLzh0wJfkrGQfTA=; b=qKnaZf
        XLoB4+72qjVhRDQxLWWUrHFeKbRJnfoc7Ez58k3FXu5nC3/mXBPCI4/MaSey7N6u
        4Y2O0gF4zABvuGijmyHzh0r3AR23wRZmlgsKvqe7fU7pl2grUU34nGLOK1F9/5Mr
        v1J3ziy8DVg3eOVdBTW2zaWBA64LGERr692N8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jn6OkbodwA/1eIwibb/5p5oCK8OeK9Pp
        TA/VtIekPpyk1uxqLpAYGMtzcMENTCVTCiR0YizZbj+lJkiIel+QScgOFuRwRsrV
        +yuGolzEG0sbLlEkHNeigRFgrIsQBK+QfsqomhANYZJ0mVnjczjYuXHoot6vuMDO
        Kk5reCQFmdg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2D1FF3DCF4;
        Sun, 25 Sep 2016 14:38:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 581393DCF1;
        Sun, 25 Sep 2016 14:38:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 0/3] recursive support for ls-files
References: <1474676014-134568-1-git-send-email-bmwill@google.com>
        <20160925071744.2qcz7cntc7xxpjqv@sigill.intra.peff.net>
        <20160925163244.GB66080@google.com>
Date:   Sun, 25 Sep 2016 11:38:06 -0700
In-Reply-To: <20160925163244.GB66080@google.com> (Brandon Williams's message
        of "Sun, 25 Sep 2016 09:32:44 -0700")
Message-ID: <xmqqzimvygdt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3441E652-834F-11E6-BB8C-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> On 09/25, Jeff King wrote:
>> On Fri, Sep 23, 2016 at 05:13:31PM -0700, Brandon Williams wrote:
>> 
>> > After looking at the feedback I rerolled a few things, in particular the
>> > --submodule_prefix option that existed to give a submodule context about where
>> > it had been invoked from.  People didn't seem to like the idea of exposing this
>> > to the users (yet anyways) so I removed it as an option and instead have it
>> > being passed to a child process via an environment variable
>> > GIT_INTERNAL_SUBMODULE_PREFIX.  This way we don't have to support anything to
>> > external users at the moment.
>> 
>> I think we can still have it as a command-line argument and declare it
>> internal. It's not like environment variables cannot also be set by our
>> callers. :)
>> 
>> I don't mind it as an environment variable, though. In some ways it
>> makes things easier. I just think "internal versus external" and the
>> exact implementation are orthogonal.
>
> We may still want it to be an option at some point in the future.  This
> way we can revisit making it an option once we know more about the other
> uses it could have (aside from just being for submodules as someone
> suggested).

I do not think it makes too much of a difference between environment
and command line option.  We need an update to the "git" potty to
say "you told me to use the submodule-prefix feature, but this
subcommand is not prepared to accept it (yet)" and cause it to error
out either way, which would mean that a series that introduces the
feature needs to touch "git.c" anyway, so I would have expected us
to add command line option first, simply because "git.c" is where it
happens, optionally with the support for the environment variable,
not the other way around.

>> > Also fixed a bug (and added a test) for the -z options as pointed out by Jeff
>> > King.
>> 
>> Hmm. It is broken after patch 2, and then fixed in patch 3. Usually we'd
>> try not to have a broken state in the history. It's less important in
>> this case, because the breakage is not a regression
>> (--recurse-submodules is a new feature, so you could consider it "not
>> working" until the 3rd patch). But I think it's still a good rule to
>> follow, because it makes the commits easier to review, look at later,
>> etc.
>> 
>> For that matter, I do not understand why options like "-s" get enabled
>> in patch 3. I do not mind them starting as disabled in patch 2, but it
>> seems like "pass along some known-safe options" should be its own patch
>> somewhere between patches 2 and 3.

Yes, exactly.

An obvious lazy way out to avoid breakage-in-the-middle and make
incremental progress would be to squash everything into one patch,
but we should and we should be able to do better.

I'd imagine this three-patch series would be more pleasant for
future readers if it were structured like:

 [1/3] introduces the submodule-prefix as a global feature; at the
       least it needs a way to invoke (either an environment, or an
       option to "git" potty, or both) and prevent mistakes by
       erroring out when it is attempted to call a subcommand that
       does not support the feature (yet).

 [2/3] adds the --recurse-submodule feature in a limited form to
       "ls-files".  I'd suggest for this step to pass through all
       options and arguments that are safe and reasonably useful
       to pass through without needing anything more than "ah, this
       option was given, so let's stuff it to the argv-array". An
       attempt to give things that are not yet passed through until
       3/3 to lead to an error that says it is not allowed (yet).

 [3-N] each of the remaining steps after 3/N adds support for one
       more thing to be passed that 2/3 refrained from doing, by
       doing more than just "pass it in argv-array", and then remove
       the "not yet supported" error that added by 2/3 for that one
       thing.  The first of these "more things" would be to support
       pathspecs as the receiving side would need code changes for
       the matching logic.  There may be more, or there may be
       nothing else that requires 4/N, 5/N, etc.

>> There are some other options that are ignored (neither disabled nor
>> passed along to children). Most of them are related to exclusions, which
>> I _think_ are safe to ignore (they do not do anything interesting unless
>> you specify "-o", which is explicitly disabled).

Sure. I agree that some options fall outside of "safe and reasonably
useful to pass through" criteria and it is OK not to support passing
them through.  I however think we should detect mistakes in the
caller, though.

I wonder if this will be common enough in the future that we are
better off adding a bit or two to the parse-options infrastructure.
Thinking out loud, would an enhancement like this be sufficient for
this particular series, and still useful in more general cases?

 - allow the caller of parse_options() to mark each entry with a
   handful of bits with no meaning to parse-options API.  "ls-files"
   may use this mechanism to mark options that to be passed through
   and options that must be rejected when --recurse-submodules is
   asked.

 - parse_options() will mark each entry as "this option was given"
   while doing its work.  Note that "--no-foo" counts as "option
   'foo' was given".

With these, after your call to parse_options() returns, you could
notice that recurse-submodules was asked for by inspecting your own
"static int recurse_submodules" global variable, and then iterate
over builtin_ls_files_options[] array yourself to see if an option
that you marked with "must be rejected while recursing" bit using
mechanism #1 was seen by parse_options() by relying on mechanism #2.

You could also add a new helper macro to parse-options API that
iterates over the options[] array, i.e.

	for_each_parse_options_array(opt) {
		if (!opt_was_used(opt))
                	continue;
		if (opt_custom_bit(opt) & NOT_IN_RECURSIVE)
                	die("'%s' cannot be used with --recurse-submodules",
			    parse_options_name(opt))
	}

or something like that, but we'd need to gain experience with the
mechanism #1 and #2 first before deciding if such a helper is useful
(iow, I do not think we need it from day one, if we go this route).

