Return-Path: <SRS0=m/64=4N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DD3C4BA00
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 22:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA5C20838
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 22:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="adlbwTTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgBYWIq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 17:08:46 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34784 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgBYWIq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Feb 2020 17:08:46 -0500
Received: by mail-pf1-f196.google.com with SMTP id i6so311498pfc.1
        for <git@vger.kernel.org>; Tue, 25 Feb 2020 14:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tXeo/hJrXBAONWIuSHKSoyGZTy9knTgkOI3VojJEgvU=;
        b=adlbwTTp3On0DALow0g+9XhMTq3ojXHEu8Dfub73WND6CZqKQFt8kE67KhQi+ipmq2
         W/s+ubiZ/o1tk0w/sRbJOonIfSHIQqIRUWxcVlfW7A4YKokq/3rue6JfgYBR7+xBh2y0
         kDe8HJQuLcE3ZJeyvuOdQKRI+b3Krn/JqxvRnVt8Xcqb8b3rzevMRxPdE5kz+nmoBR5s
         SYNdI2P1DxPYPmzbjoSV5UmAVoN1I8lFbVLe6O0+rYwHZw/NWTM8iOSd2BqffFWDP7sG
         bOIMMFt2nySgAwjMyw1RX6EkaUniJyLdXor58itK/oncsGST3Ok7k7E3PfD3n6wFUp7f
         dyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tXeo/hJrXBAONWIuSHKSoyGZTy9knTgkOI3VojJEgvU=;
        b=hYj3poiFVnCU1WijSvFLqDqe8J6tqwFWW0YxMZRAp2LvKn7spRy3kbu/f8YCcgESmv
         JP8LfWWy3lzMYq1OzHbni5IsInR3JO3yuYGx8oUdYWRPLB5pygVUxuJBmCcBn28zD44/
         pSoAx45Q9peH3rqQDU9rnK3LwOpQmPblXUmSYy1v2O7eLxmCs8Dk8xF8aONrUXyxhZUM
         qq+fo8dWVBp8KWur4tJOSHCAIJcRUIOW6Ngfl0jYurEFAf5k9xkTv4i0Pj66NJ+MYJru
         g1zKYO+ecX62pNPRSBIYpgWvwOVxMUedYAk2QLBegM2G73jR/KwAeqbgXpgcgKty2JN7
         Y9Sw==
X-Gm-Message-State: APjAAAWAkpNNLOvZfIyQrkSM6kX1QFz0FDk23t9fhttBDyqYXZojRGV5
        PHBCEO9moxQmSIGolMO6XiUffg==
X-Google-Smtp-Source: APXvYqxkMmRV41DzWMoZSCfYl/t7HcYqr2sLitR/RSNYGqQ1btSfFWMW0YYy2pDcfJFhPTnc2Gz3tA==
X-Received: by 2002:a63:33c4:: with SMTP id z187mr635850pgz.114.1582668523691;
        Tue, 25 Feb 2020 14:08:43 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id x12sm74535pfr.47.2020.02.25.14.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 14:08:43 -0800 (PST)
Date:   Tue, 25 Feb 2020 14:08:38 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 07/15] bugreport: add git-remote-https version
Message-ID: <20200225220838.GB212281@google.com>
References: <20200220015858.181086-1-emilyshaffer@google.com>
 <20200220015858.181086-8-emilyshaffer@google.com>
 <xmqqr1yp9eue.fsf@gitster-ct.c.googlers.com>
 <20200220232812.GH2447@google.com>
 <xmqqo8ts7gf5.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo8ts7gf5.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 20, 2020 at 07:44:30PM -0800, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > ... Unfortunately I agree that we wouldn't be equipped to handle
> > reports in other languages.
> 
> I actually was anticipating a far better world ;-) 
> 
> There is no reason to limit the recipient of reports only to *us*.
> Use of Git and population proficient in Git would become wide enough
> that we should be able to expect that users who speak language X can
> be helped by experts who speak the same language X with their
> issues.

Hm. I guess I got the opposite impression from you way back in v1. I do
wish it had been communicated a little more clearly; it's frustrating to
perceive a reversal after seven months of review. But that's probably on
my own reading comprehension :)

Well, I certainly don't mind - but I did have a pretty long conversation
with Jonathan Nieder last week about whether it's feasible to make the
bugreport extremely stable while also being locale aware. As I
understood it, he worried about someone having a misconfigured locale
causing the bugreport tool to crash when it tries to set the locale.

But I'm having trouble figuring out how that can happen. It looks like
we use libintl.h to do almost all of our string localization, which I
have to assume is pretty robust. Or to put it another way, if the user's
environment has broken libintl.h, then it seems like they also have
bigger problems outside of Git which they would notice already.

(Side note: I went down a rabbit hole of trying to break my locale, and
did manage to generate some garbage by setting 'LANG' to a non-UTF-8
character set and setting 'LANGUAGE' to a character set which does
require UTF-8, that is, 'LANG=es_MX LANGUAGE=ko git status'.)

How about if I localize the bugreport template, headers, and formatted
comments (e.g. "3745 local loose objects"), and include a tip in 'git
help bugreport' suggesting that if it doesn't look right, maybe the user
wants to run it with 'LANG= LANGUAGE= git bugreport' to ensure it
actually gets generated?


I had another thought, actually, that this is maybe semantically similar
problem to the malformed config we discussed earlier in the review. Does
it make sense to include some kind of --safemode flag to 'git' which
asks it to not perform localization and not read configs? I would
propose adding it just to git-bugreport, and I could work around some
locale weirdness that way, but with a broken config the attempt dies
before git-bugreport binary is invoked at all.

 - Emily
