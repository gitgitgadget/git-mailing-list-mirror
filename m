Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC4BC433F5
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 18:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346227AbiDKSUj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Apr 2022 14:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiDKSUh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 14:20:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7E91DA53
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 11:18:22 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 345B41F38D;
        Mon, 11 Apr 2022 18:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649701101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I49lhvIOeqxV282QBWnpGg6hKJSrJuF1g1A9TGsArZo=;
        b=woM8YWIi2tgd9KzLYbcWaIBbWBaEt2NovYpdy6Eap2Q+42e75nhrZnMON4LpWmQFYrmjqM
        y6sq5gt17UKoslOJCQ7UeYvraMVrJHb5sTAjYkQ6rFoqZBmcm0xwWW8gnF8gQa78MpKd8T
        5ZuxjOdqRiiQ3hMk8uHKfWhzWHZ6pDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649701101;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I49lhvIOeqxV282QBWnpGg6hKJSrJuF1g1A9TGsArZo=;
        b=05VrL5LEXo5x3mWKDX7vYwCtQjZ1gvzXZDIYjrlXqRRp9iWXJzutd6Ugc8O+Kc5JVYejqB
        Nlo6+xfC8UuFAeAg==
Received: from kunlun.suse.cz (unknown [10.100.128.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 11E58A3B88;
        Mon, 11 Apr 2022 18:18:21 +0000 (UTC)
Date:   Mon, 11 Apr 2022 20:18:19 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Erik Cervin Edin <erik@cervined.in>,
        Christian Couder <christian.couder@gmail.com>,
        jurgen_gjoncari@icloud.com, git <git@vger.kernel.org>
Subject: Re: Make commit messages optional
Message-ID: <20220411181819.GF163591@kunlun.suse.cz>
References: <7ED89912-2E10-4356-9C61-14B90EC0719C@icloud.com>
 <CAP8UFD2Tk-FuGcFN0DEKK6g3O8G=SGuU99FPRRqPM_-39i9t0A@mail.gmail.com>
 <220408.86r167bxra.gmgdl@evledraar.gmail.com>
 <CA+JQ7M-uSatD4=HHxaqe4yVAJ5WGuWC_BprX4hnfKSrt6-1GEg@mail.gmail.com>
 <220411.865ynfkj7r.gmgdl@evledraar.gmail.com>
 <xmqq4k2zjyb0.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq4k2zjyb0.fsf@gitster.g>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 11, 2022 at 10:59:47AM -0700, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
> > On Fri, Apr 08 2022, Erik Cervin Edin wrote:
> >
> >> At the risk of bikeshedding.
> >>
> >> The case in favor of not allowing empty commit messages by default is
> >> that most of the time, empty commit messages are useless.
> >>
> >> I've written my fair share of poor commit messages (-,..., wip, foo).
> >> Sometimes I've fixed that retroactively, sometimes not. The advantage
> >> I see with empty commit messages is that it's more ubiquitous to
> >> "write something better" or "whatever". The downside is I can't git
> >> log --grep '^$' to find them.
> >
> > You can:
> >
> >     git log --invert-grep --grep '.'
> 
> Wow, that's nasty.
> 
> In any case, "--allow-empty-messages" exists, and that is where we
> draw the line.  We will not bend over backwards beyond it.

Isn't special-casing the empty message bending over backwards to some
other influence instead?

Thanks

Michal
