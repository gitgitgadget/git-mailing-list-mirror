Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 404F72047F
	for <e@80x24.org>; Wed, 26 Jul 2017 18:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750964AbdGZSV2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 14:21:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64758 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750952AbdGZSV1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 14:21:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 743CE8F9DB;
        Wed, 26 Jul 2017 14:21:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=05VkYw7rBuxDxdlpSzXg9aB9ZwA=; b=gpNM5U
        ib4Q+X6/gW1L/LA4J6l//G9r7CCH/fSYG2NNnlke+IDd/ev8b7AEXTzFNfTAxbEl
        J4i3Kpy7CjMuIJLdODclD66EknC6zf9KvT1cMEvk7NRl+Oy7r8g9rSkq8KwYJCkE
        r60rcRF1DGDr6miHdtJkQHFzxIT7TA4Mv4kYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cctE+QhWCqbrqzNAvM69q5VCm22p9kWX
        GDYS4KyqeQKvbHrvh/pZnDQfhVIrNdBWheFoqu+AQxdF/TRl6p81lir2Q46xhstW
        r1T6kU0FHxMrv14Y1u1zigkPJJM7WnlBv4CRR9xIdDxcr7t85rCF1VyBkrGrXL/Z
        J4iszYcngK4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B5BE8F9DA;
        Wed, 26 Jul 2017 14:21:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D357C8F9D8;
        Wed, 26 Jul 2017 14:21:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC PATCH 0/5] Add option to autostage changes when continuing a rebase
References: <20170726102720.15274-1-phillip.wood@talktalk.net>
Date:   Wed, 26 Jul 2017 11:21:17 -0700
In-Reply-To: <20170726102720.15274-1-phillip.wood@talktalk.net> (Phillip
        Wood's message of "Wed, 26 Jul 2017 11:27:15 +0100")
Message-ID: <xmqqa83rrrdu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3820B0A8-722F-11E7-BD3D-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> These patches add an '--autostage' option (and corresponding config
> variable) to 'rebase --continue' that will stage any unstaged changes
> before continuing. This saves the user having to type 'git add' before
> running 'git rebase --continue'.

I wonder if this interacts with existing rerere.autoupdate
configuration variable and if so how (i.e. would they conflict and
fight with each other?  would they work well together?  would one of
them make the other unnecessary?).  In any case, they look closely
related and perhaps should be named similarly.

I even have a suspicion that they may be essentially doing the same
thing.

For a previous discussion, you start from here:

  https://public-inbox.org/git/7vej6xb4lr.fsf@gitster.siamese.dyndns.org/#t

and for the context, look at the original post by Ingo, to which the
above message is a response to.

Thanks.

>
> Phillip Wood (5):
>   rebase --continue: add --autostage to stage unstaged changes
>   rebase -i: improve --continue --autostage
>   Unify rebase amend message when HEAD has changed
>   Add tests for rebase --continue --autostage
>   Add rebase.continue.autostage config setting
>
>  git-rebase--am.sh             |   1 +
>  git-rebase--interactive.sh    | 111 ++++++++++++++++++++++++++++++++----------
>  git-rebase--merge.sh          |   1 +
>  git-rebase.sh                 |  76 ++++++++++++++++++++++++++---
>  sequencer.c                   |  22 +++++++--
>  t/t3404-rebase-interactive.sh |   2 +-
>  t/t3418-rebase-continue.sh    |  50 ++++++++++++++++++-
>  7 files changed, 222 insertions(+), 41 deletions(-)
