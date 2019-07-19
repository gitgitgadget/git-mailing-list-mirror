Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D54E1F461
	for <e@80x24.org>; Fri, 19 Jul 2019 15:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbfGSPg5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jul 2019 11:36:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61779 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfGSPg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jul 2019 11:36:57 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2EC8E15FF23;
        Fri, 19 Jul 2019 11:36:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UKFmu2gKHP4rJBNpJambLQdk/Rk=; b=YzM/h6
        ojNl/gwmQdj1AYb0ay55L6fdPpdAMcPt3ORi0r79FW680y2KR2ymlus4vrs47HpL
        sWtKMpmHFv2RNO8gV38hFPmPIG4WHytluru3nzYNLr21HQ4LXFz7YqGBAOqUzGm8
        oXf1jXrB4Q18S2eipnJ0wE114JFMT0tM2Xq00=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=j+sAOl+6/oLEA034If5/1ReWyQOc9hUC
        WQCKT9s5kThQDVYZgiXgL2gZAy1q5x8H3UwnraGhzR950Q54YbDDpO14whqxDjrh
        rdzAdTXOkvpTt325PYLDPnYT4LIsr7I4aUfK0yUkvQEB4AD+0OOVTpELLrmqQW4N
        korciLzaaEs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2584515FF22;
        Fri, 19 Jul 2019 11:36:52 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6FC6815FF21;
        Fri, 19 Jul 2019 11:36:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 23/24] t5505,t5516: create .git/branches/ when needed
References: <pull.287.git.gitgitgadget@gmail.com>
        <db69b33ff4a583f75e07f15d10dba70bd99fcaf7.1563455939.git.gitgitgadget@gmail.com>
        <xmqqftn3xet7.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1907191555180.47@tvgsbejvaqbjf.bet>
Date:   Fri, 19 Jul 2019 08:36:50 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1907191555180.47@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 19 Jul 2019 16:52:00 +0200 (CEST)")
Message-ID: <xmqqd0i6vxwt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 075BBF76-AA3B-11E9-BEE5-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> You probably forgot that I already proposed that, long time ago:
> https://public-inbox.org/git/cover.1494509599.git.johannes.schindelin@gmx.de/

No, I haven't.  It was actually meant as an invitation to you to
help us come up with a reasonable deprecation path.

I'd be super happy if we did not have to support 3 sources and
instead just 2 sources of the remote information, but as I said
number of times in the previous attempts' discussion, I think it is
trickier than any of our past migration (like "push.default") to
remove support for .git/branches, as I see no reasonably convenient
alternative/workaround for those who do take advantage of the fact
that .git/branches/ is "one liner, single file per remote source",
which would make it convenient when you need to interact with dozens
of sublevel integrators and the population of them changes
regularly.  "Run 'git remote add' with these options to limit its
scope to a single branch" is easy to say but cumbersome to execute.

The best case scenario I came up with is to start giving a message
when we read *and* *use* information from .git/branches/ hierarchy
(i.e. when we know we found a potential user who will get affected
by removal of .git/branches support), asking to tell us not to go
forward with the removal if and only if an alternative we leave for
them gives them unacceptably high cost (i.e. "we cannot afford to
migrate our workflow not to use .git/branches/ because ..."), and
after a few releases we do not hear anything from anybody.  The
second best would be to see responses that can serve as concrete
examples to build our easy-to-use alternative after removing the
support for .git/branches/.  The alternative might end up not
removing the support, but that is OK---we are in far better position
than we currently are either way.  The reason why we still have the
support is mainly because we know there were users who took active
advantage of that facility (again, not Cogito) several years ago,
and we do not know if they moved on to update their workflows to use
the config-based settings.  After the above (or something similar)
happens, we will know that nobody needs it and we can remove it with
confidence.
