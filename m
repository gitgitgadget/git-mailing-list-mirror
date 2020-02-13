Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5258BC2BA83
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 18:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C7BC217F4
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 18:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="eaWjuYhi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgBMSAe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:00:34 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37180 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbgBMSAe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 13:00:34 -0500
Received: by mail-pf1-f193.google.com with SMTP id p14so3452795pfn.4
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 10:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YKl2RoK1asWZuUju2GMmcoF30COtl8q+5VHIIljIRck=;
        b=eaWjuYhiZWvZSynOlg01Y7sTh8a7fsVLiVSPsgloJMifOp1Fc/Bwz/ekonkl6pFOLI
         ebwkoSoJGm9C1O8qeLoNAkwcBKZ6jO22JwCsNsuFBq+7ptxA4finSMAxL27cmhFEGlOT
         /v/eYZFvqDANiTTevgmNucUixFzTNAgYxWOfurKuk8ptXntNPtGRurrnUFYFWlMDq0Pd
         yQjMj3AqSMJSPXe56mFCHzE34SRxyTTCErgQE9mq9y0Y+Q5VwDJHiVeAELRelaT2EYX3
         WCpBe1hx7skQF8A7lp1xOqsKiHB4i4vCaACtKz9caNtFdOEePiLFx+Ht4kCYAHpH9F/H
         izSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YKl2RoK1asWZuUju2GMmcoF30COtl8q+5VHIIljIRck=;
        b=Y7RwL7XSd/fAToHbLauP/HasJiY+/EoVcugnQgoDLiw/LSo2g3A8x2LNo2Mpusiod9
         XRsnBwUVIasGMqmfQnYZXv+xjHfrib5EPMuE4d/cZx5NI+senOxwaFVHAXoWyfF83Ftu
         WAB4PfCaDtGbIkD2cjHES+FfIheQ04fdE69vTkU7ZUUBgHEgsk4YJ67tANsbqkjhNKXC
         xAU1K2K7k3GpMJ1GLzpCnzWPjtSPjn6p04SHTn6KV9KXmqfon3mzIPmq6b3awukdxNCz
         i0qFuybEH21JK+c5uAVzeUhlfZIX3p9TQvHbG2A4xqf7xkDOwt4Hykjhe7yiezi+sdE6
         KKFA==
X-Gm-Message-State: APjAAAVCUXB2+CJm/PInM9LUivwxoJofrmIQS1MiFOV4Sd/mCgHpGu0M
        OQ/SmLfQitLmFm8AQUUDfdehXg==
X-Google-Smtp-Source: APXvYqx+YKpKKvVk1XOYe1Xmd6s5mZH/Emt5yBlmYUDzyJTGqGfqtQWAqpl41uVSPlNin2feVIykEA==
X-Received: by 2002:a63:4f0c:: with SMTP id d12mr20050814pgb.322.1581616832106;
        Thu, 13 Feb 2020 10:00:32 -0800 (PST)
Received: from localhost ([205.175.106.72])
        by smtp.gmail.com with ESMTPSA id q11sm3809612pff.111.2020.02.13.10.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 10:00:31 -0800 (PST)
Date:   Thu, 13 Feb 2020 10:00:30 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Parth Gala via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Parth Gala <parthpgala@gmail.com>
Subject: Re: [PATCH 2/5] object.c: lookup_unknown_object() accept 'r' as
 parameter
Message-ID: <20200213180030.GF45518@syl.local>
References: <pull.545.git.1581535151.gitgitgadget@gmail.com>
 <16dd64618ab6a086727685e9eca3850fabc46437.1581535151.git.gitgitgadget@gmail.com>
 <20200212202540.GD4364@syl.local>
 <xmqqtv3vtst5.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtv3vtst5.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 12, 2020 at 01:11:02PM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > ... same question about why assigning:
> >
> >   struct repository *r = the_repository;
> >
> > and passing 'r' everywhere is preferable to simply passing
> > 'the_repository' in directly.
> > ...
> >>  static void mark_object_for_connectivity(const struct object_id *oid)
> >>  {
> >> -	struct object *obj = lookup_unknown_object(oid);
> >> +	struct repository *r = the_repository;
> >> +	struct object *obj = lookup_unknown_object(r, oid);
> >>  	obj->flags |= HAS_OBJ;
> >>  }
>
> I do not claim that it applies to this particular function, and the
> function is too small for it to matter, but when a function is large
> enough and it always works on one single repository, it would make
> it easier to later update the function further to set up 'r'
> upfront, making it point at the_repository for now, and to use 'r'
> throughout the function.  That way, when the time comes to update
> the function to work on an arbitrary repository, the only change
> required will be to turn the local variable 'r' to an incoming
> parameter the caller can supply.

Right, but my suggestion was that this advice doesn't apply to this
particular instance since I don't expect that we'd ever passing
something other than 'the_repository'.

Specifically, I was worried that we'd get bitten by re-assigning 'r' in
the middle of the function and then end up in some odd broken state.

Maybe I'm worrying too much.


Thanks,
Taylor
