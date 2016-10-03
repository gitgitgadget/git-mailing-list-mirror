Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5461E207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 19:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752439AbcJCTAv (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 15:00:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55282 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751099AbcJCTAt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 15:00:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 25AC84223B;
        Mon,  3 Oct 2016 15:00:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=e7TAuqBih6ozU+uMrdRymfPP7FQ=; b=L6n6zO
        IG7FGV6wbs5pSZclY9fArIhYSENZZrrMIxZnVJKC1kAazm8XrFIk3uCuvUF3+zoA
        5J1J2eaUWGkvbqYg5oqOtlyLZE65o6orAJSuXk8qAwiCEcQtunks1SAOPOp0UeYT
        yGzVqHT/pWoMvxyzmbrS8yDaFMDiVon0hYavU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gCuOUIGsufZK2SpC+eLOfurpqNK/azap
        1b7LeLn0dK8o/XPXzLGWPtNmRYyQ7TDQbnHOecSzfeSXAEERYzVkIIB/frsmPOdJ
        X3kQ1quSgxLo2bRtVLIUoZoWyA42sik3Yt0OZCOZeNIO4rkkqAe6jbjatTz1IzBu
        2Tc7SL3cVGw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1C6534223A;
        Mon,  3 Oct 2016 15:00:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 76BD542239;
        Mon,  3 Oct 2016 15:00:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeremy Morton <admin@game-point.net>
Cc:     git@vger.kernel.org
Subject: Re: Reference a submodule branch instead of a commit
References: <57F29FEF.30700@game-point.net>
Date:   Mon, 03 Oct 2016 12:00:45 -0700
In-Reply-To: <57F29FEF.30700@game-point.net> (Jeremy Morton's message of "Mon,
        03 Oct 2016 19:14:07 +0100")
Message-ID: <xmqqfuod6yw2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B1A9A628-899B-11E6-9A8E-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeremy Morton <admin@game-point.net> writes:

> At the moment, supermodules must reference a given commit in each of
> its submodules.  If one is in control of a submodule and it changes on
> a regular basis, this can cause a lot of overhead with "submodule
> updated" commits in the supermodule.  It would be useful of git allows
> the option of referencing a submodule's branch instead of a given
> submodule commit.  How about adding this functionality?

When somebody downstream fetches from your superproject and grabs
the set of submodules, how would s/he know what _exact_ state you
meant to record?  When s/he says "I have your superproject commit X,
which binds submodule's branch Y at path sub/, and it simply does
not work.  Your project is broken", how do you go about reproducing
the exact state s/he had trouble with to help her/him?

The only thing s/he knows is that the commit used from the submodule
must be one of the commits that was on branch Y at some point in
time, hopefully close to the timestamp recorded in the commit in the
superproject.  And your record in the history of the superproject
does not tell you more than that, so you wouldn't have any idea
better than what s/he already has to help.

Hence, such a "functionality" will never happen, at least in the
exact form you are describing.

It is conceivable to add some feature that allows you to squelch the
report that the submodule recorded in your superproject is not up to
date from "git status" etc. to help those who thinks it is OK to not
bind the latest submodule commit to the superproject all the time,
though.
