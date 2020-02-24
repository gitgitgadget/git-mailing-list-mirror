Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738C7C38BFA
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 21:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E3320838
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 21:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="x0PaLYLe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgBXVgH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:36:07 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61668 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbgBXVgH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 16:36:07 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D4EE5522E3;
        Mon, 24 Feb 2020 16:36:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MtfWLHaB5+L+3z6sNWcbBKRa1fM=; b=x0PaLY
        Le7G98s9aUDwymeeKUiWY/dDARYgc6sczDMeCnBBAhLMUUnChebtQigYpbnpvx7w
        XaMfwqb6fkrkFrenrefWl0r4DNHDMnmJuIbOX0KN3Ymvc6o+E7EmUoCGmaEI3/jL
        LG7TC2QtEY7WWIQOXZ6eK0y/OpFFTYtuecykE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DZdJKl9/IkAZqp2NokO/S6n/omR8/mqT
        3YbTRIeTlnIRA1ybacnp/sp4JHQLx9JW1Ny3Jp2VPHaveLRMiMlSGJLxS8Ihsgk3
        rKjLJzxr8e2MEshC/kULRsaZpUIKr/RCdAgYO9AAi+pR+0/M4ykYCh1purs5MA0K
        beO57ZcFxPk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 98255522E2;
        Mon, 24 Feb 2020 16:36:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 61590522DE;
        Mon, 24 Feb 2020 16:36:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Daudt <me@ikke.info>
Cc:     Robin Moussu <moussu.robin@pm.me>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Inconsistancy with `git rebase --preserve-merges`
References: <v9k9hyJjfgQYYIczd9NqrjSdyOyxwqEB0iWyQ_TZCnobCZZoZ8_v6WB4KcWyW5xxRPdDUyEqEYfXylOnGI57CtK9KegMgp_0bz_5RrIIhHY=@pm.me>
        <tmm3ViXf1QO5dCCNgDCHCHSZeUKUfiYvNoI9RMvdLlnOLk0oUt_w2SKgYu3LPh6no-wHhq1gXbVlBKgLcnGCR5HaTgWMx5se9KmJOKITUHk=@pm.me>
        <20200224183648.GF1247035@alpha>
Date:   Mon, 24 Feb 2020 13:35:59 -0800
In-Reply-To: <20200224183648.GF1247035@alpha> (Kevin Daudt's message of "Mon,
        24 Feb 2020 19:36:48 +0100")
Message-ID: <xmqqlforoegw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A6689DC2-574D-11EA-8237-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Daudt <me@ikke.info> writes:

>> $ git rebase --preserve-merges -i 412f07a~
>
> Can you try `--rebase-merges` instead? Since v2.22.0 `--preseve-merges`
> is officially deprecated, but even before that it was already known to
> have flaws.

The options to "rebase" command seem to follow the usual "last one
wins" pattern.  There is a single opts->type field, and upon seeing
--preserve-merges, the field gets assigned REBASE_PRESERVE_MERGES,
and then when the command line option parser sees "-i", the field
gets overwritten by assigning REBASE_INTERACTIVE.  So

    git rebase --preserve-merges -i 412f07a~
    git rebase -i 412f07a~

both should do the same thing.

I suspect that "--rebase-merges -i" may hide the real issue (which
is "the command line option parsing of rebase is messy"), but it may
deserve to be cleaned up, now that the result of "rewrite it in C"
efforts seems to have sufficiently stablized.

What to clean-up?  There could be two-and-half ways to view it:

 * The options should follow the usual "last one wins" pattern; if
   we take this stance, what happens with "--rebase-merges -i" is
   buggy and "--preserve-merges -i" that behaves as a mere "-i" is
   doing the right thing.  The part of the command line parser that
   implements "--rebase-merges" should be fixed so that its effect
   gets reverted when "-i" is seen later.

 * The options "--rebase-merges" and "--perserve-merges" (there may
   be others) and "--interactive" should be mutually exclusive; if
   we take this stance, we should error out when we see two or more
   of them on the command line.

 * The options "--rebase-merges" and "--preserve-merges" (there may
   be others) should be mutually exclusive or "last one wins", but
   "--interactive" can be combined with them to make them
   interactive.

I am not sure which one is the best.  The impression I got from the
current state of the code is that it started from "last one wins",
and the code wanted to transition to "--interactive makes other
options go interactive" but hasn't done a good job by leaving loose
ends (like what we saw with "--preserve-merges"), so perhaps the
last one is what we want to aim as a long term solution?  I dunno.

