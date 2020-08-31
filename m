Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A047C433E2
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 17:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73769206EB
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 17:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nJYKMILS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbgHaRAy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 13:00:54 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62701 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgHaRAy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 13:00:54 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 995B2E74F0;
        Mon, 31 Aug 2020 13:00:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EKzhwYLTZDrpVKqAQjCzfmLxV/w=; b=nJYKMI
        LSI4BZstc0+a3ZeuPPzc3RNVe8HKdGQS5n+KZs8qebF6po/n4R5Hopm7jFnXRb8Z
        yAGPT1CRlIRlF0Qanb+TMAR75fX3RDPPxuJ+kZ7vZY+xmOhcg41n2WamI+V8+n/h
        uLyREccaujDXVBsv/2qvl61bH0G69folPnwpg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gltH5atxZ9npM4dE3QpBTkuz5xeWEvAf
        vciKRFOj02yyQC8/bD8TPDMx5MqCxQ7pCV+CKaqtcGXpArpaYcnGqm1i/UsEvrH7
        xly/x4UH7GM1rjOtlyUR7+CC4pKOXmDJm7w0ULrb3UPNqrl7PzgS3dgps4Ijcsoq
        8kBl88Q9Tnc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 92FFBE74EF;
        Mon, 31 Aug 2020 13:00:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C5AFAE74EB;
        Mon, 31 Aug 2020 13:00:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v2] revision: add separate field for "-m" of "diff-index -m"
References: <20200829194634.23306-1-sorganov@gmail.com>
        <20200829201140.23425-1-sorganov@gmail.com>
        <xmqqo8mrh12b.fsf@gitster.c.googlers.com> <87a6ybugpe.fsf@osv.gnss.ru>
Date:   Mon, 31 Aug 2020 10:00:45 -0700
In-Reply-To: <87a6ybugpe.fsf@osv.gnss.ru> (Sergey Organov's message of "Mon,
        31 Aug 2020 15:45:33 +0300")
Message-ID: <xmqqd036hhs2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8435186E-EBAB-11EA-BD77-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> $ git diff-index -m --no-diff-merges HEAD
> :100644 000000 4aec621a6d1a9a5892f0b4b6feb2ed329fd04bf2 0000000000000000000000000000000000000000 D	main/main.cc

At the first glance, this looked like a good justification for this
patch.

> If you say "compatibility wart" is not a trouble by itself, -- I'm fine
> with it, -- then "more" in my commit message is misplaced indeed.

Yeah, when I wrote the "compatibility wart" comment originally, I
was describing "this needs a tricky code because two independent
options happen to share the command line parser" and nothing more.

I was not reacting to "more", by the way.  I was reacting the lack
of concrete problem description.  "A '-m' option given to the
'diff-index' command can be defeated by giving '--no-diff-merges'
later" you showed above can be a good replacement for "causes more
troubles".

But in the ideal world, "--[no-]diff-merges" should be rejected as
an irrelevant/unrecognised option to the "diff" family of commands
(as I said in the message you are responding to, it is only relevant
to the "log" family of commands where the diff machinery is solely
to compare between (some of) its parents and in that context, what,
if anything, kind of special treatment is made for merge commits
makes sense as an optional instruction to the command).  Splitting
the field into two fields, setting both fields upon "-m" but
toggling only one with longhand "--[no-]diff-merges" would allow the
code to notice and make the above command line silently turn the
"--[no-]diff-merges" into a no-op, so in that sense it would be a
good first step, but an ideal solution would probably need to know
if we are parsing for the "log" family or for the "diff" family and
error out upon seeing a "log"-only option like "--[no-]diff-merges"
when checking the command line option for "diff".

> This change has nothing to do with defaults. It rather about correct and
> clear code.

OK, I misread your intention.  Sorry about that.

Thanks.

