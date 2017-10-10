Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD3622036B
	for <e@80x24.org>; Tue, 10 Oct 2017 12:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756134AbdJJMvm (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 08:51:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59483 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755888AbdJJMvl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 08:51:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A3FDA9741A;
        Tue, 10 Oct 2017 08:51:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/ElTFys0ls4aofmAG/1EakJvW8s=; b=PlDDa7
        /b82h+6yBetXstWC02H0BjDWNFR6tEL5moqeH3g/TtvXL6il4jvlyBL7cndoH6Un
        VeJSahOj+ZgYf7VF73DgiqKhyIi/Q82sHWHgg4Fah9ozh13J95M29h5X7b8wD6gv
        uFUFpYNLATLhVlx+GWL6bEIaODqpWZZQTUYBA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=woxc7MqJxNRt10k2F7eMbBLRyWB/bpAY
        nmktl63O/cTmfcdDD4+UZ7ltpF1dTnHGeWtd66iUkooCXkhsatYmDL5hM3XLne6Q
        a5nyxoq21Eh5WncPPOFUDROp/Kjpvst8NPgx4uBUUga234EgO/34LawGxOzPy59u
        MrP8xtwakqY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 99B6397419;
        Tue, 10 Oct 2017 08:51:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1469C97417;
        Tue, 10 Oct 2017 08:51:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Nazri Ramliy <ayiehere@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What happened to "git status --color=(always|auto|never)"?
References: <CAEY4ZpO2G-kTmuReE5gwKpftFqLfAqdpQwCK4R+qYbogCgGtUA@mail.gmail.com>
        <20171010001619.GL19555@aiede.mtv.corp.google.com>
        <CAEY4ZpPj3=+gL_wBW548qzAuS=aC=qswuPx-4H9DS=X10iJWVw@mail.gmail.com>
        <20171010005942.GO19555@aiede.mtv.corp.google.com>
        <CAEY4ZpMKE6yf2baaJt+x6c_esorFnyWvLZ=_KS1iRs6XbL42hw@mail.gmail.com>
        <20171010102509.e7ucbyon6ka6722l@sigill.intra.peff.net>
Date:   Tue, 10 Oct 2017 21:51:38 +0900
In-Reply-To: <20171010102509.e7ucbyon6ka6722l@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 10 Oct 2017 06:25:10 -0400")
Message-ID: <xmqqfuarp3mt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C273908E-ADB9-11E7-A476-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> :( I was worried that this might hit some third-party scripts.
> ...
> All that said, should we revisit the decision from 6be4595edb? The two
> code changes we could make are:
>
>   1. Adding a "--color" option to "git status". Commit 0c88bf5050
>      (provide --color option for all ref-filter users, 2017-10-03) from
>      that same series shows some prior art.
>
>      This is a clean solution, but it does mean that scripts have to
>      adapt (and would potentially need to care about which Git version
>      they're relying on).

If we view that "always" issue is a regression, then this is not a
"solution".  It is a part of an ideal world where we never allowed
"always" as a value for color.ui, which is not the world we live in.

>   2. Re-allow "color.always" config from the command-line. It's actually
>      on-disk config that we want to downgrade, but I wanted to avoid
>      making complicated rules about how the config would behave in
>      different scopes. The patch for this would look something like the
>      one below.

Yuck, ugly.  The code is simple (thanks to the "who ordered it?"
thing), but the behaviour is rather embarrassing to explain.

>   3. Revert the original series, and revisit the original "respect
>      color.ui via porcelain" commit which broke add--interactive in
>      v2.14.2 (136c8c8b8fa).

Which one do you mean is "the original series"?  The one that made
plumbing to pay attention to the color config?  I think it would be
the cleanest "solution" in the world we live in, but the series (and
the follow-on changes that started assuming that config_default
reads the color config) have a rather large footprint and it will be
quite painful to vet the result.

I think the right fix to the original problem (you cannot remove
auto-color from the plumbing) is to stop paying attention to color
configuration from the default config.  I wonder if something like
this would work?

 - Initialize color.c::git_use_color_default to GIT_COLOR_UNKNOWN;

 - When git_color_config() is called, and if git_use_color_default
   is still GIT_COLOR_UNKNOWN, set it to GIT_COLOR_AUTO (regardless
   of the variable git_color_config() is called for).

 - In color.c::want_color(), when git_use_color_default is used,
   notice if it is GIT_COLOR_UNKNOWN and behave as if it is
   GIT_COLOR_NEVER.

Then we make sure that git_color_config() is never called by any
plumbing command.  The fact it is (ever) called can be taken as a
clue that we are running a Porcelain (hence we transition from
UNKNOWN to AUTO), so we'd get the desirable "no default color for
plumbing, auto color for Porcelain", I would think.

