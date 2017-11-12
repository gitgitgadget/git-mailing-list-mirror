Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49E721F43C
	for <e@80x24.org>; Sun, 12 Nov 2017 01:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752505AbdKLBnv (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Nov 2017 20:43:51 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60936 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752443AbdKLBnu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Nov 2017 20:43:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 97FFBB4B4D;
        Sat, 11 Nov 2017 20:43:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3Dkf1xqamvN84QMjnY2hbQVPYSw=; b=vaoTjd
        9pt2SPs+Hm5Ye/lVt0PGmWb5BnyIdumFxN4Ncj/N1RmnHzgHdbNTv5F0sexyLo32
        W1suD2AkJDnSLu5VEowOV83jPfkUelCFM2RAJnGtTN9qKo798tJ+mfTLs+Ut1t8t
        emWGdJp8JHPcunE9aaPwBuM1K62cGEDRVsAuk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DhH8Mg51gHsu95NZHSPl+HwTiWfyC1S5
        2VFQtOPtkvyIu8IUlfqtGkhDjF7uUjiHsrqC9l9BJgJr4igmioBynyHZeA5oqrpG
        b4sv3oLHeu+lf9g9GyJv5UhmXzOaeQI/qMDZP7xTlZ4BsqeFHOgW1+xkUeajqxfm
        gAuKSOxblPc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7B990B4B4B;
        Sat, 11 Nov 2017 20:43:49 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C782FB4B4A;
        Sat, 11 Nov 2017 20:43:48 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Christian Couder <christian.couder@gmail.com>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>,
        Stephan Beyer <s-beyer@gmx.net>
Subject: Re: should "git bisect" support "git bisect next?"
References: <alpine.LFD.2.21.1711110639120.5632@localhost.localdomain>
        <CAP8UFD3az17BpB0nA+35p3BP95sBuOY0Yvce3cgbh0L3YH7+rQ@mail.gmail.com>
        <xmqq4lq0ev8g.fsf@gitster.mtv.corp.google.com>
        <20171111194616.a2hl4dwz5cycuzdh@thunk.org>
Date:   Sun, 12 Nov 2017 10:43:47 +0900
In-Reply-To: <20171111194616.a2hl4dwz5cycuzdh@thunk.org> (Theodore Ts'o's
        message of "Sat, 11 Nov 2017 14:46:16 -0500")
Message-ID: <xmqqvaigclv0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EDBF77BC-C74A-11E7-91C4-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Theodore Ts'o <tytso@mit.edu> writes:

> On Sat, Nov 11, 2017 at 11:38:23PM +0900, Junio C Hamano wrote:
>> 
>> Thanks for saving me time to explain why 'next' is still a very
>> important command but the end users do not actually need to be
>> strongly aware of it, because most commands automatically invokes it
>> as their final step due to the importance of what it does ;-)
>
> This reminds me; is there a way to suppress it because I'm about to
> give a large set of good and bit commits (perhaps because I'm
> replaying part of a git biset log, minus one or two lines that are
> suspected of being bogus thanks to flaky reproduction), and so there's
> no point having git bisect figure the "next" commit to try until I'm
> done giving it a list of good/bad commits?

It is surprising that I've never heard of this idea, but I think
that it is an excellent one.

When the user knows what bad and good commits in what sequence will
be fed to the command (i.e. replaying a saved output of "git bisect
log"), ideally we would want to "plug" the auto-next processing, and
just mark good and bad in refs/bisect/* without doing anything other
than creating these refs, and then run a "next" before giving the
control back to present the final working tree to be tested by the
user.  That would save the cost of intermediate checkouts but also
the cost of extra merge-base computation that is done to catch the
case where the user gave a good commit that is an ancestor of a bad
commit by mistake.

I think that the output of "git bisect log" was designed to be just
an executable shell script that the user can edit (the edit is
mostly designed to make it possible: "I know I screwed up in this
step, so I change its 'bad' to 'good' and remove the remaining
lines") and just execute it.  Which makes the simplest approach that
would first come to my mind not work very well, unfortunately.

	The "simplest approach" would teach the "--no-autonext"
	option to "git bisect good" and "git bisect bad" and skip
	the call to bisect_auto_next in bisect_state when it is
	given.  Then update the output from "git bisect log" to add
	that option to all good/bad commands, and then add an
	explicit "git bisect next" at the end.  This won't work well
	because it is likely that with the "remove the remaining
	lines" step, it is likely that the user would remove the
	final "bisect next".

A workable alternative approach is to teach "git bisect replay" to
be more intelligent.  Right now, I do not think it does anything
more than what happens by an execution of the input file with a
shell, but "replay" should be able to read a single step ahead in
the command sequence while doing its step-by-step execution, and
when it notices that it is about to run "bisect good" or "bisect
bad", and if the command to be run after that is also one of these
two, it can decide to skip the auto-next processing in the current
step.  It shouldn't need any new "--no-auto-next" option (I am not
saying that adding the option is bad--in fact, I think it is a good
addition for expert users; I am just saying that the approach to
make "replay" smarter does not require it).

Christian, what do you think?  Am I missing something?
