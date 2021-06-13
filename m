Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6AAC48BDF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 11:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D954A610CD
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 11:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbhFMLmL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 07:42:11 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52608 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbhFMLmK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 07:42:10 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7E1111FD29;
        Sun, 13 Jun 2021 11:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623584408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5L3iSIuJ144IbNdX5fkqbKE7ztaNehPWuaXa3B/I3bU=;
        b=RKcMyRL7xiZv1jtSX956LgEW+hbwgTvwckhs2rtJbewUQAh9zz4cGZAJYBLKzGep9REwqz
        fRLVDf9iSB72BpQmFvokSWS/MEkmOv/rEXwhlPbWVRpSP+njjZpD28hXSB9P9/NKweYwpe
        HjeZPYY+uGU/Ac2/l0SxkNW+oSLJr5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623584408;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5L3iSIuJ144IbNdX5fkqbKE7ztaNehPWuaXa3B/I3bU=;
        b=CRyiDnzu2IvBQ6FUdVV7Jx/QklSWNEM/0kfxVwfBdYM8In3n5C6QlmnqADVRxX3BqPOrC3
        Ojd0Ihwd5A0mokCg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 58B2B118DD;
        Sun, 13 Jun 2021 11:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623584408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5L3iSIuJ144IbNdX5fkqbKE7ztaNehPWuaXa3B/I3bU=;
        b=RKcMyRL7xiZv1jtSX956LgEW+hbwgTvwckhs2rtJbewUQAh9zz4cGZAJYBLKzGep9REwqz
        fRLVDf9iSB72BpQmFvokSWS/MEkmOv/rEXwhlPbWVRpSP+njjZpD28hXSB9P9/NKweYwpe
        HjeZPYY+uGU/Ac2/l0SxkNW+oSLJr5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623584408;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5L3iSIuJ144IbNdX5fkqbKE7ztaNehPWuaXa3B/I3bU=;
        b=CRyiDnzu2IvBQ6FUdVV7Jx/QklSWNEM/0kfxVwfBdYM8In3n5C6QlmnqADVRxX3BqPOrC3
        Ojd0Ihwd5A0mokCg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id LZ5xFJjuxWC8ewAALh3uQQ
        (envelope-from <msuchanek@suse.de>); Sun, 13 Jun 2021 11:40:08 +0000
Date:   Sun, 13 Jun 2021 13:40:07 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Varun Varada <varuncvarada@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Coup <robert.coup@koordinates.com>, git@vger.kernel.org
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
Message-ID: <20210613114007.GF8544@kitsune.suse.cz>
References: <20210512180418.GF8544@kitsune.suse.cz>
 <609c2f98932f3_71bd120840@natae.notmuch>
 <20210513074622.GG8544@kitsune.suse.cz>
 <CAFLLRpJeU3BFKmsGgFoKQRLCw-uGRRH1Ob7PZBHUEQu_Pqshgw@mail.gmail.com>
 <20210513094818.GH8544@kitsune.suse.cz>
 <CAD2i4DDY1z1ZNigRfVog1205hKBk+U5KfinzXCk-2mkaYy4cjQ@mail.gmail.com>
 <20210527114629.GD8544@kitsune.suse.cz>
 <60afa7d9d4ca_2056d208d9@natae.notmuch>
 <20210527143541.GH8544@kitsune.suse.cz>
 <CAD2i4DC0zH8WQvfZiHJA7f+DXubZjG6fKSuMbXdaztDC_PU4ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD2i4DC0zH8WQvfZiHJA7f+DXubZjG6fKSuMbXdaztDC_PU4ZA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 12, 2021 at 06:13:02PM -0500, Varun Varada wrote:
> On Thu, 27 May 2021 at 09:35, Michal Suchánek <msuchanek@suse.de> wrote:
> >
> > > > Not all evidence. There are people who think the use is fine.
> > >
> > > What people think is not evidence.
> > >
> > > There's people who think the Earth is flat.
> >
> > And there's people who think it's not ok to use 'impact' as synonym for
> > effect/affect, too.
> 
> This is not because they *think* this, but because it's demonstrably
> true. The words are not synonyms according to any reputable
> dictionaries, as shown already.
> 
> >
> > Indeed, but what the dictionaries provide is a definition.
> >
> > Based on the definition some people think it's not OK, and some people
> > think it's OK.
> >
> > That's only opinion, not evidence.
> 
> Hence, the dictionary definitions, which are evidence. If people are

The dictionaries provide definition, not usage guidelines.

Fabricating usage guildelines from sources that do not provide them is
opinion, not evidence.

> confused as to what the words within the definition mean, they can

Two people. That's called 'anecdotal evidence'. You will find anecdotal
evidence in favor of pretty much anything possible, that does not mean
it's in any way common.

> 
> > >
> > > > > that "per se" being used to mean "necessarily" is not a style issue,
> > > > > using "impact" to mean "an effect" or "to affect" is not a style
> > > > > issue.
> > > > >
> > > > > As has been stated already, the clear and substantial argument for
> > > > > this change is that it reduces the confusion that arises from
> > > > > improperly using the word "impact" in the instances without any loss
> > > >
> > > > There is no final authority on 'correct' word use in English.
> 
> Yes, there essentially is. It's called a dictionary. If you don't
> respect the value of dictionaries, you're tacitly claiming that anyone

I don't consider opinions tangentially related to dictionary content a
proof of anything.

Also it has been pointed out that dictionaries don't agree on the
precise definition - hence no final authority. The laguage use varies,
and dictionaries also reflect that. Even the use of word 'impact'.

> 
> >
> > This will bring in reviews that focus on hairsplitting when the
> > formulation with 'impact' reads better than 'effect' and where the
> > change does not make it read any better so it should not be changed.
> >
> > It also brings in reviews of the sort that simply say that use of
> > 'impact' is OK, and there is no need to change.
> 
> That's an "if". This, however, is a situation where multiple people

We already received such reviews as response to your patch. It's not
what-if.

Best regards

Michal
