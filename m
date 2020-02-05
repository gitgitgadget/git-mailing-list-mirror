Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0D2C35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 02:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 065C621741
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 02:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YOasa9Yd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgBECtF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 21:49:05 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40089 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbgBECtF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 21:49:05 -0500
Received: by mail-pj1-f68.google.com with SMTP id 12so303071pjb.5
        for <git@vger.kernel.org>; Tue, 04 Feb 2020 18:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vhVK3bcUnKMaVBo4WNFkVZtpOi6Tm9rLQTn7uiscRe8=;
        b=YOasa9YdpeyAoOoPUkmglbiC54CKexZJQAfbPJJ1q47t8ovIKiuIE4PoV20h8ccZYY
         wEtxyXbdlunRcj1ofHMwZIk6nTvtZwskVSthYPGhznNqZTt9htbCILFIwHNX6bY4l/pB
         GF48WOresY/8nA5d4ixDHYGBlSAZh574TnD/DmhyrKWOZygnHIzD4Tw0cee6SjqFoSYC
         DcKXaEVogOMK8G/WKUFWau4IhHF7dwDKUPBpSjXJBdtTQ/dTaEh17yxsntQu1dhlWFu3
         9fRU1fjoCR8cbaI7/ef0xxoQ9J6wxlO18VedWOCoTVHTJdRgau5YnOV4BFeKl+Sr/12r
         ZFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vhVK3bcUnKMaVBo4WNFkVZtpOi6Tm9rLQTn7uiscRe8=;
        b=AGtxLiT6tyaUvLcZby22n/aSu/mpZQC4+8bwuQa+DtO85lcfcWzZynhMy1Yw/rPUgu
         UBGuZpM6IT7JO0rr67mV8FdQmYy4nVKnhhpFx+nMLKgY/LKAdHSQs/t+QOY9f0ATxbte
         vR7CxoLMGRkWWPCQFGU6K0rUhXIuE5uLfU4XbbRRxwO375ISH8h6w+loR9PIDFQrwn82
         DF7F79W+AlF0texw6kMQ33WYPd0m5I1qXQJD03qWsgctKXbzr7yviTEHZ9ETFw8ejvAJ
         XVSX7jqwlmFdsEhzGy9mtrD6wtrJufo9yBC0rI5dgCAmi/nktkZpC7pKlRn3DajDFOJc
         G7MQ==
X-Gm-Message-State: APjAAAVNM41GugEvqNga57zx20k1isMY1D/6E4IvYBfR7HNbJLpb020H
        Ja1rbvM/KAwEuxlmQ8MMI5yCMo1gbMI=
X-Google-Smtp-Source: APXvYqwmpr1mX3MOxQl6CuCAt0HNQNS5vWIccqXtGedxnLVyWHR6spMUFSc+MKKQz5XP1fxVB69I2Q==
X-Received: by 2002:a17:902:d898:: with SMTP id b24mr32921545plz.133.1580870944565;
        Tue, 04 Feb 2020 18:49:04 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id g18sm25574812pfi.80.2020.02.04.18.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 18:49:03 -0800 (PST)
Date:   Tue, 4 Feb 2020 18:48:59 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v5 11/15] bugreport: collect list of populated hooks
Message-ID: <20200205024859.GM87163@google.com>
References: <20200124033436.81097-1-emilyshaffer@google.com>
 <20200124033436.81097-12-emilyshaffer@google.com>
 <xmqqh8068a5k.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh8068a5k.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 04, 2020 at 10:44:39AM -0800, Junio C Hamano wrote:
> emilyshaffer@google.com writes:
> 
> > +	/*
> > +	 * Doesn't look like there is a list of all possible hooks; so below is
> > +	 * a transcription of `git help hook`.
> 
> That's "git help hooks", if I tried my reproduction correctly.

Yep. I'll fix it.

> A straight-forward (in the sense of "what we want in the outcome is
> quite clear" and not in the sense of "anybody can design and implement
> it with a single 30-line patch") follow-up we can make after this
> series lands is to rethink how Documentation/githooks.txt is
> maintained and the list we have here is synchronized with it.
> 
> The design could me just the matter of running "grep" of some sort,
> with appropriate markups that are no-op to AsciiDoctor/AsciiDoc
> added to the documentation source, to produce this list.

Well, with Martin's suggestion[1] to use annotate:bugreport[include]
instead of bugreport:include[x], this kind of change becomes a matter of
course to just use "annotate:hook[x]" and write a script nearly
identical to generate-bugreport-config-safelist.sh, and add it to the
Makefile.

Like I said up-thread, I don't like the idea just because it's awfully
temporary (pending work that's right below this on my list for the
coming weeks).

It sounds like you're saying you don't mind any work of this nature
being done as a follow-up - and that's fine with me, too. I'd just
rather do the follow-up with enums and a library than with grep and
sh. :)

> >  static const char * const bugreport_usage[] = {
> >  	N_("git bugreport [-o|--output <file>]"),
> >  	NULL
> > @@ -193,6 +243,9 @@ int cmd_main(int argc, const char **argv)
> >  	get_header(&buffer, "Safelisted Config Info");
> >  	get_safelisted_config(&buffer);
> >  
> > +	get_header(&buffer, "Configured Hooks");
> 
> Phrase nit.  There may be many people who just enabled hooks without
> configuring, so "Enabled Hooks" may be more appropriate.  We do not
> have to inspect what is in the hook to determine if it is enabled,
> but we do need to if we want to tell if a hook is "configured".

Ah, that's a good point. OK, I'll change the wording as you suggested.

 - Emily
