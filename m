Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1717C433ED
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 06:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A008961464
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 06:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbhDOGGc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 02:06:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51866 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhDOGGa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 02:06:30 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 16D06BB5C6;
        Thu, 15 Apr 2021 02:06:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l3Llsob9oarAMX5+mwTaYOoMfvo=; b=iFTkEg
        q0FcCvb9oBmmktgSHwk25q5AswPsLrQU/uv6T+UrGm95uCwQsHzK4qipxr72oh5j
        aDmckaJNerYf9SR9MWldZ1CWoA66o0y3TpFJeavu/zp7okvN2TG43TFHXFOZ2aWL
        rNVWNVkJg0p96qQSlGBtA443h6FocDkmSTsgU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xCIJRuHfs33zvhe5MGns1zLlK/JQY53W
        +wj30KBWLAkUDKplrE78gJ7h0WtyHlgAOe51s33BkEj2+OFy8m5Jp6tnymaGWPmV
        dTB4hOXp2jLwdZidYgAR/jjkZi87B2cA/4uaM3s+83yx9peEWNPeY1n6QS7xWZy8
        yqaTRs+GSys=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0EAB5BB5C5;
        Thu, 15 Apr 2021 02:06:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 41848BB5C4;
        Thu, 15 Apr 2021 02:06:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Raxel Gutierrez <raxelgutierrez09@gmail.com>,
        mricon@kernel.org, patchwork@lists.ozlabs.org,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: Pain points in Git's patch flow
References: <YHaIBvl6Mf7ztJB3@google.com>
Date:   Wed, 14 Apr 2021 23:06:06 -0700
In-Reply-To: <YHaIBvl6Mf7ztJB3@google.com> (Jonathan Nieder's message of "Tue,
        13 Apr 2021 23:13:26 -0700")
Message-ID: <xmqqv98orsj5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AAF6300C-9DB0-11EB-BEBB-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> That reminded me that it would be useful preparation to collect
> descriptions of pain points we are having with our existing patch
> flow.

As the maintainer, I want to ensure that what I queue on 'seen' is
kept reasonably up to date.  Not picking up the latest every time a
topic is rerolled is OK, but before declaring the topic will hit
'next' in a few days, it must be (1) the latest and (2) the greatest
(meaning: what reviewers are happy with).

This requires a few features from any tracking system.  It must be
able to:

 - tell which round of patches are in 'seen'.

 - tell which e-mail messages are the newer round than what is
   queued, and which ones are the latest round.

 - tell which patch have been commented on, and been updated in
   response.

 - tell which patch have been positively accepted with an Ack or a
   Reviewed-by, and if a patch in a newer round is identical to an
   already accepted one (in which case, reviewers would not bother
   to send "this step still looks good to me").

The system I use for the first two points is to rely on the list
archive and the mapping from each individual commit made out of a
patch on the list (implemented as git notes, that records a blob
with the Message-Id for each commit [*1*]).  So

   $ git log --notes=amlog --no-merges --oneline master..$topic

would give a list of commits with the original Message-ID, and I can
see which piece of e-mail each commit came from.

The third and fourth are maintained mostly manual, with me keeping
notes in the draft of "What's cooking" report (which I send out from
time to time).  Having to notice, pick up and squeeze in Acked-by's
and Reviewed-by's is quite painful and cumbersome, especially for a
long series, and the buggy "git rebase -x" does not help, either
[*2*].

If we run a patchwork instance for our project, the first two could
be largely automated.  Automation built around Patchwork should be
able to, or at least should be able to help me to:

 - notice when a new round of an existing topic is posted.

 - fetch the "amlog" notes, together with a copy of daily 'seen', to
   see if a topic that is queued has an update, and notify me and
   others when the topic queued is stale [*3*].

 - tie a step in the latest round with a corresponding step in the
   previous round, and show Ack's and Reviewed-By's that are still
   valid [*4*].


[Footnotes]

*1* "git fetch https://github.com/gitster/git +refs/notes/amlog:refs/notes/amlog"
    should give you a copy of this database.  Then, for example you
    can ask where a commit came from:

    $ git show -s --notes=amlog format="%N%s" 61a7660516
    Message-Id: <pull.1001.git.git.1618254757074.gitgitgadget@gmail.com>
    reftable: document an alternate cleanup method on Windows

    Note that this is not a one-to-one mapping.  I may initially
    apply patches to an inappropriate base and push the integration
    result out that has it in 'seen', but I may realize that the
    series needs to be queued on a different commit and rebase the
    topic the next day.  Both commits before and after such a
    rebasing have come from the single piece of e-mail, so you can
    say "this commit came from this message", but it is impossible
    to expect a single answer to "which commit is the result of this
    message"---there will be multiple.

    Strictly speaking, when two rounds of the same topic had patches
    that were unchanged between the iterations in their earliest
    parts, two pieces of e-mail may convey the same patch, so in the
    ideal world, it might be more useful to record "this commit came
    from this and that messges, both of which record an identical
    patch".  I currently do not do so, though.

*2* It would be ideal if "rebase -i -x 'add-trailer -r peff@'" can
    be used to stop at each commit, run the 'add-trailer -r peff@'
    script that amends HEAD to add "Reviewed-by: peff@", and
    continue, while honoring the "notes.rewriteref" configuration
    variable (in my repository, set to "refs/notes/amlog").  That
    way, I can queue with "git am", at which time "amlog" gets
    populated to map each commit to the original message, find
    Reviewed-by: and do the above rebase, while carrying the message
    IDs to resulting commits.  Alas, "rebase -i -x" is buggy and
    loses the notes during this process (doing s/pick/reword/ and
    manually squeezing Reviewed-by: into the log message is a poor
    but workable workaround).
    cf. https://lore.kernel.org/git/xmqq8s6tcuxc.fsf@gitster.g/

*3* It is perfectly normal if a topic is left stale, if the newer
    iteration breaks integration.  So the stale notification going
    directly to a contributor from an automated system would not
    help very much, but it needs to come with the reason why it is
    kept out of 'seen', which must be supplied by human, not by an
    automation.

    If an automation around Patchwork can send, instead of "hey,
    here is an updated series available" notification, a mbox
    readily usable by "git am -s3c" to me, with Acked-by's and
    Reviewed-by's already incorporated, that might be ideal (these
    trailers may have to be filtered/curated to avoid spams,
    though).
 

*4* Judging a step in the latest round and the corresponding step in
    the previous round has not substantially changed may not be
    easily automatable, and carrying Ack's and Reviewed-by's forward
    would require human curator of the "patchwork" database.
