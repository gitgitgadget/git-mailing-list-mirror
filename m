Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3348C433DF
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 22:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C022B2075D
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 22:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sqIfMfcK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgGJWAK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 18:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgGJWAJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 18:00:09 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8437C08C5DC
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 15:00:09 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l63so3086081pge.12
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 15:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=opFDmmXeYjyLLFnrnku/8YOHpk3LQJSN+vt0wtwbz2M=;
        b=sqIfMfcKt3joDJjHFdIo1QUID56JEuHSX/H5p70ICG36j3mm6UfraWz2vT1pKPLx9i
         mEr7Q/F8Cun0nfo/LRT9999nKBSmtDm65Q5LWZCIcqjUFK68hb93k9EIuJTLZVpB+LPC
         8i+DPu44TLeuKUiO3vUxsBkG6SSgSlFt9LVPgLASR5tZg549OnUThCxKjQd1wlkrLXbO
         vBot8imdLxXMxVW8/xW64QjpgnKyPsM/BP2ZjsgsEvYkHubL0xCOuD58xDsFAnhGMQqH
         vuRSBKvdzFQfEabEAEaDCv4luabEXjnthUCEjRe9o0Hax6Y/WI1rNlaAcODgSGWC1YOJ
         aUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=opFDmmXeYjyLLFnrnku/8YOHpk3LQJSN+vt0wtwbz2M=;
        b=IKO5m83AphpTkWncSq+ELFCZcjYbHgcruZXhzBX17LU8QtIHHtEsREW0xs0JhP/Nh8
         UHW285rg7WnRB5TuRt9GaMduHohYvxSpDjmjaaZPSbFSnIzDF8s9Zd2/g+OfBcJGGP/h
         mE/28WMhNWZeFkG0CQo8bmSUggfJvMRegiDw5d+lgqp0R7eVzp68RTyXi9GGAkbwTG0y
         ebHz9f9tVU+osFDV9xt3uA0ySu+iCNHCu5CWrFbuLQ/O0Ue/eREILdd5E4+eeV8K3g2t
         3Grv3jM0+ija6kZMol3ZbtvDBv2ZRUuR+gW39NctiBME4LWBD60GS4uKoRGub9tgvL6x
         DjrQ==
X-Gm-Message-State: AOAM5338wpa0f3L2jp8Z2NJsW48imkf4iOja/TtS4SoZBlcAmmyThxKQ
        h8HBHEp6GEaPn2FfBhZDJEpp2mBvQ/A=
X-Google-Smtp-Source: ABdhPJyB8H8Gep444icyVm/9baxPxQxVjCiu/6x6ndu7ipr0sGrrSYQudoQbgM0pHHr1Z8sD5CCUww==
X-Received: by 2002:a63:571e:: with SMTP id l30mr61972644pgb.220.1594418408855;
        Fri, 10 Jul 2020 15:00:08 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id 22sm6918473pfh.157.2020.07.10.15.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 15:00:08 -0700 (PDT)
Date:   Fri, 10 Jul 2020 15:00:03 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] progress: create progress struct in 'verbose' mode
Message-ID: <20200710220003.GG3189386@google.com>
References: <20200710014242.1088216-1-emilyshaffer@google.com>
 <20200710014242.1088216-2-emilyshaffer@google.com>
 <20200710021451.GI9782@camp.crustytoothpaste.net>
 <xmqqpn93rsb3.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpn93rsb3.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 10, 2020 at 02:09:04PM -0700, Junio C Hamano wrote:
> 
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
> > So to make sure I understand this right, we'll collect traces regardless
> > if it's enabled, but we'll still honor the --quiet flag if the user
> > doesn't want to see them?  If so, I'm definitely in favor of this
> > change.
> 
> Hmph, if we know we won't be emitting, why spend cycles to collect
> traces in the first place?  Does it make the code simpler to follow
> or something?  As long as it is done when the user requests a trace
> to be taken, I do not care about the wasted cycles too much, I think ;-)

Maybe then I did misunderstand brian.

With this series, traces will always be emitted to location where
GIT_TRACE2_EVENT indicates, or default location. Like before, if the
user asks for --quiet or equivalent, the user will not see "Resolving
deltas... (4/30)" in their stderr.

Before this series, when a user indicated --quiet or equivalent, the
traces were not emitted to GIT_TRACE2_EVENT's location, because the
progress struct was not created.

I figured brian was saying "we'll still honor the --quiet flag if the
user doesn't want to see ["Resolving deltas...blah blah" in their
stderr]", and that is true. The traces will be logged but the
user-facing output on stderr will be suppressed.

> 
> > I was worried when I read the cover letter that we'd display
> > them to the user regardless, but from reading the patch and the commit
> > message, it seems I misunderstood.
> >
> > I think the making the verbose flag a parameter simplifies the code
> > nicely and puts the rendering decision in the right place.
> 
> OK.
