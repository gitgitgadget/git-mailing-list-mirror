Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8C4F1F43C
	for <e@80x24.org>; Tue, 14 Nov 2017 13:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755139AbdKNNFf (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 08:05:35 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61946 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753976AbdKNNFe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 08:05:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C3CAB2583;
        Tue, 14 Nov 2017 08:05:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vwB8fmcunvIqk3q9oiV5Du4V19M=; b=W27Cml
        ki5VjeZCCiK/NEPGMvDFmiNT9yYX2vCXt0MH/5ptyzl7vtDjw4ZYMT2yEJljbu0s
        WQI7RAV4RthR2Efc8WDcmUrs3iMwRjyua6C2oKAiAjEUcFcd4ch6HUPR/BaxQuA1
        hFKH76CbBV3A4kQYkpdF8HaeGwpNa6UMq+Zuk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZA4HiIvlRfQICgBCkutlDQ6JgL046Zos
        aPwqJ5KU0fJqX4mm96x3uxrrVPpCLDjf+fDZfYwVr8R26Bz7MzbBu2RRmFE+GxoL
        7VHPt44dxYKZ5uj4OBzq5qbRHyl4pcXFhZj5VQdyAZzYZ+3K3hU1by+KqpXvCiMF
        OAD5+FJy+4Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 019CFB2582;
        Tue, 14 Nov 2017 08:05:33 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6D92FB2581;
        Tue, 14 Nov 2017 08:05:32 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
Cc:     git@vger.kernel.org
Subject: Re: [RFC 3/3] log: add an option to generate cover letter from a branch tip
References: <xmqqbmk68o9d.fsf@gitster.mtv.corp.google.com>
        <936c2b33-3432-f113-d84b-0623246ec673@suse.de>
        <xmqq7eut4cae.fsf@gitster.mtv.corp.google.com>
        <92c426bc-5ce9-da7c-5f10-66b5fc46825b@suse.de>
Date:   Tue, 14 Nov 2017 22:05:31 +0900
In-Reply-To: <92c426bc-5ce9-da7c-5f10-66b5fc46825b@suse.de> (Nicolas
        Morey-Chaisemartin's message of "Tue, 14 Nov 2017 10:28:21 +0100")
Message-ID: <xmqqo9o52ep0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F092270-C93C-11E7-8791-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de> writes:

> The triple dash is so that the diffstat/shortlog as not seen as
> part of the cover letter.  As said in the cover letter for this
> series, it kinda breaks legacy behaviour right now.  It should
> either be printed only for cover-at-tip, or a new separator should
> be added.

This reminds me of a couple of random thoughts I had, so before I
disconnect from my terminal and forget about them...

[1] format-patch and am must round-trip.

I mentioned four uses cases around the "cover letter at the
tip" in my earlier message

    https://public-inbox.org/git/xmqqbmk68o9d.fsf@gitster.mtv.corp.google.com/

Specifically, (2) we should be able to run "format-patch" and record
the log message of the empty commit at the tip to the cover letter,
and (4) we should be able to accept such output with "am" and end up
with the same sequence of commits as the original (modulo committer
identity and timestamps).  So from the output we produce with this
step, "am" should be able to split the material that came from the
original empty commit from the surrounding cruft like shortlog and
diffstat.  The output format of this step needs to be designed with
that in mind.

[2] reusing cover letter material in merge may not be ideal.

When people write a cover letter, they write different things in it.
What they wanted to achieve, why they chose the approach they took,
how the series is organized, which part of the series they find iffy
and/orneeds special attention from the reviewers, where to find the
previous iteration, what changed since the previous iterations, etc.

All of them are to help the reviewers, many of who have already
looked at the previous rounds, to understand and judge this round of
the submission.

The message in a merge commit as a part of the final history,
however, cannot refer to anything from "previous rounds", as the
previous attempts are not part of the final history readers of "git
log" can refer to whey they are trying to understand the merge.
What exactly goes in a merge commit and how the messages are phrased
may be different from project to project, but for this project, I've
been trying to write them in an end-user facing terms, i.e. they are
designed in such a way that "git log --first-parent --merges" can be
read as if they were entries in the release notes, summarizing fixes
and features by describing their user-visible effects.  This is only
one part of what people write in their cover letters (i.e. "what
they wanted to achive").

So there probably needs a convention meant to be followed by human
users when writing cover letters, so a mechanical process can tell
which part of the text is to be made into the merge commit without
understanding human languages.
