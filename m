Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33F8A20281
	for <e@80x24.org>; Fri, 22 Sep 2017 09:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751919AbdIVJOr (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 05:14:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61194 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751808AbdIVJOq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 05:14:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 46FD3AADAD;
        Fri, 22 Sep 2017 05:14:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fXGW0XKNXml3JiEn5OCALEdbW7c=; b=pIy5u4
        78yWTi5s/1bvg6cslZpJedM9IUdlgPhI+YOuZXVk9F229Z4QMbywdakqZmjGtbr6
        908OFibNaK39QpbWznBG3wrOBqYfrYT3tYOzpomidvXDE3yfhTHRdFiJ4vM3FJWq
        uD9C7Y5O5JJiRCcKr1HyqnVZ0SKGcZDhlvipI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=euInrmTBSxTWtyiRRZGNATV0BRIYcxik
        ObG0wt+IPuXZRlNjHlZf0BGXQ3NcPY/8C9C523d4sSIBWOaRosh6uVElJNQLU5wE
        HfCtfRiMl3zkHsFaThjle08fBXSu7ypMB8Vto1XLcd6P3Ftpz1ZqwxMIuRGuWLfK
        o+n53Z7MSuU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E3BCAADAC;
        Fri, 22 Sep 2017 05:14:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 943ADAADAB;
        Fri, 22 Sep 2017 05:14:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org, Ekelhart Jakob <jakob.ekelhart@fsw.at>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/3] merge-base: return fork-point outside reflog
References: <68633b20-9e2b-ae23-2ede-8728283250f0@grubix.eu>
        <cover.1505394278.git.git@grubix.eu>
        <5513a1415d11517c28158d9b4212d383a233182f.1505394278.git.git@grubix.eu>
        <xmqq60ckzng7.fsf@gitster.mtv.corp.google.com>
        <cd97bb1b-13f3-0856-a250-8f4921b9f6d8@grubix.eu>
        <xmqqshfnx1kl.fsf@gitster.mtv.corp.google.com>
        <xmqqshfgk1mr.fsf@gitster.mtv.corp.google.com>
        <5a2fca1d-4edf-965f-4840-58c924c91051@grubix.eu>
        <xmqqzi9nlcyw.fsf@gitster.mtv.corp.google.com>
        <4a14c35c-88b0-7bc3-0a6e-c69ed9ec7ee7@grubix.eu>
Date:   Fri, 22 Sep 2017 18:14:39 +0900
In-Reply-To: <4a14c35c-88b0-7bc3-0a6e-c69ed9ec7ee7@grubix.eu> (Michael
        J. Gruber's message of "Fri, 22 Sep 2017 10:34:52 +0200")
Message-ID: <xmqqa81njds0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 76D71C3C-9F76-11E7-B121-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@grubix.eu> writes:

> I'm still trying to understand what the original intent was: If we
> abstract from the implementation (as we should, as you rightly
> emphasize) and talk about historical tips then we have to ask ourselves:
> - What is "historical"?
> - What is tip?
> - Tip of what, i.e. what is a "branch"?

The feature was meant to be a solution for "upstream rebased the
branch I based my work on."

Suppose you did

	git clone $URL
	git checkout -b mytopic origin/topic
	work work work and commit commit commit

and then the next "git fetch" found that remote/origin/topic did not
fast-forward, i.e. your upstream rewound and rebuilt the topic.

Now, running

	git rebase origin/topic mytopic

would be a disaster, as it would try to replay all the commits
reachable from mytopic on top of the updated origin/topic, but the
set of commits reachable from mytopic includes those the upstream
used to have, on top of which you based your work, and you are not
interested in replaying them at all.

If you remember where you forked your topic from (you should be able
to tell from "git log mytopic"), then

	git rebase --onto origin/topic $fork_point mytopic

would be the way to replay "your" work on mytopic on top of the
updated upstream.

The reason why "--fork-point" exists is because people wanted to
automate the "remember where you forked your topic from" part.

Your upstream might have rewound the tip of topic many times while
your repository did not fetch from it (iow, the reflog for
origin/topic may not have _all_ the tips of other people observed to
be historicallly at the tip of the remote), but that is immaterial
for our purpose.  As long as you built on top of origin/topic, the
fork point must be one of the commits _you_ saw at the tip and it
does not matter that you did not constantly fetch to observe all the
changes at the remote.

So the answers of these three questions are:

 - "historical": _you_ saw in your repository;

 - "tip": _you_ saw it pointed by the branch you forked your work
   from; and

 - "branch": whatever you consider you based your work on top of,
   typically a remote tracking branch.

Of course, if you are employing a more advanced workflow, you might
not have started your mytopic branch at any of the tip.  E.g.  if
you wanted to extend Ben's fsmonitor topic, you would have forked
your own topic like

	git checkout -b my-fsmonitor origin/pu^2

after fetching from me, and --fork-point would not be of much help
obviously for such a workflow.  But such users will use --onto and
explicitly specify the fork point so it is outside the scope of the
feature.

