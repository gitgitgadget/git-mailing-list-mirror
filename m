Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96AEC48BCF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 16:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5EDA610FB
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 16:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhFMQaG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 12:30:06 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56900 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbhFMQaF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 12:30:05 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7A1421FD32;
        Sun, 13 Jun 2021 16:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623601683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4lJyibllKP3nYW35IpW3XRdj3O3OHQoZerRNJgpy2UU=;
        b=l7T55LiJGbMemSUd1VS46xQHc+EIPzES2VzmruaM1IHaLjrb9qjkBhM7Zx2rg+f46ud1AH
        2RlFCVeSgJSRS+p2+U80NAiO+hIJmAx3xl5yj6+36EaE2tNpKVKeBbU6ePVUw+o99nYLHo
        Zq3NQS30D8F9LvDtnc36cFX4plYnE0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623601683;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4lJyibllKP3nYW35IpW3XRdj3O3OHQoZerRNJgpy2UU=;
        b=niNiAUNpk4tQzHiZNNE+x89RCyBNlUCqn6T2bs+3P2vgej7FTe0Wm34CMYUHSKgSAgD64H
        sARd/JvOM2JjhTBg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 50185118DD;
        Sun, 13 Jun 2021 16:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623601683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4lJyibllKP3nYW35IpW3XRdj3O3OHQoZerRNJgpy2UU=;
        b=l7T55LiJGbMemSUd1VS46xQHc+EIPzES2VzmruaM1IHaLjrb9qjkBhM7Zx2rg+f46ud1AH
        2RlFCVeSgJSRS+p2+U80NAiO+hIJmAx3xl5yj6+36EaE2tNpKVKeBbU6ePVUw+o99nYLHo
        Zq3NQS30D8F9LvDtnc36cFX4plYnE0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623601683;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4lJyibllKP3nYW35IpW3XRdj3O3OHQoZerRNJgpy2UU=;
        b=niNiAUNpk4tQzHiZNNE+x89RCyBNlUCqn6T2bs+3P2vgej7FTe0Wm34CMYUHSKgSAgD64H
        sARd/JvOM2JjhTBg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id J+9XEhMyxmBWWQAALh3uQQ
        (envelope-from <msuchanek@suse.de>); Sun, 13 Jun 2021 16:28:03 +0000
Date:   Sun, 13 Jun 2021 18:28:02 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Varun Varada <varuncvarada@gmail.com>,
        Robert Coup <robert.coup@koordinates.com>, git@vger.kernel.org
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
Message-ID: <20210613162802.GG8544@kitsune.suse.cz>
References: <20210513074622.GG8544@kitsune.suse.cz>
 <CAFLLRpJeU3BFKmsGgFoKQRLCw-uGRRH1Ob7PZBHUEQu_Pqshgw@mail.gmail.com>
 <20210513094818.GH8544@kitsune.suse.cz>
 <CAD2i4DDY1z1ZNigRfVog1205hKBk+U5KfinzXCk-2mkaYy4cjQ@mail.gmail.com>
 <20210527114629.GD8544@kitsune.suse.cz>
 <60afa7d9d4ca_2056d208d9@natae.notmuch>
 <20210527143541.GH8544@kitsune.suse.cz>
 <CAD2i4DC0zH8WQvfZiHJA7f+DXubZjG6fKSuMbXdaztDC_PU4ZA@mail.gmail.com>
 <20210613114007.GF8544@kitsune.suse.cz>
 <60c610f04b288_41f2b208ce@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60c610f04b288_41f2b208ce@natae.notmuch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 13, 2021 at 09:06:40AM -0500, Felipe Contreras wrote:
> Michal Suchánek wrote:
> > On Sat, Jun 12, 2021 at 06:13:02PM -0500, Varun Varada wrote:

> 
> > > > This will bring in reviews that focus on hairsplitting when the
> > > > formulation with 'impact' reads better than 'effect' and where the
> > > > change does not make it read any better so it should not be changed.
> > > >
> > > > It also brings in reviews of the sort that simply say that use of
> > > > 'impact' is OK, and there is no need to change.
> > > 
> > > That's an "if". This, however, is a situation where multiple people
> > 
> > We already received such reviews as response to your patch. It's not
> > what-if.
> 
> In case you haven't been following this thread closely, you are the only
> person that says the use of "impact" is OK. One person said "impact" was

Apparently you have not followed this thread closely yourself.

> OK for him, but he didn't say anything of anybody else. Another person
> asked if they were synonyms. That's it.
> 
> I say Varun should resend the patch separate from all other patches,
> explain why they aren't synonyms and mention for the record that one
> person objects to the change.

No if he really wants the thing merged he should resend the patch with
proper reasoning how replacing the word 'impact' improves the
documentation and perhaps say for the record that two people find the
word confusing.

> 
> It's OK to merge patches where one person objects.

Apprantly you also missed that I am not opposed to the patch.

Best regards

Michal
> 
> -- 
> Felipe Contreras
