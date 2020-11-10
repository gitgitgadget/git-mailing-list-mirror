Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD5EC388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AB2D20825
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KgIAc1tb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731587AbgKJVjD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 16:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731981AbgKJVhk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 16:37:40 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721B6C0613D1
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:37:40 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id x13so48123pfa.9
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=s/+N1DQ8GVzUisJ6bFoh7DKgRIy7q573ckt3BaFxiyA=;
        b=KgIAc1tb9c/bjo/fB6QYzP9/mXmyyYuYEifFdGmCAssr7gf+n3OuWltd8sCjVvfBpP
         51kfnkJ7FcsHFmI6jsvRakDUWmJ7TFk2NeAt4WE0/wP+tJbDx/MovydMklfUtdfa2fa0
         daSEm5WMjrhqQyFD0lfERcD7DF+sVfy8wAhU+cD4yQHQZVUcEYH8h1dRmBMVfGsNJDwz
         oD5bRpHUbedVDRW4W2MvRBDkDqsziraMq4Zd/5q4Ok4CW3dInfj/k5CIuBUPKi9+4zPo
         0AYEq81zbrC+xbL3N47y0SJwW63RxNRfuiAvzWgMQh7GeG9RP+KvM15YTC3fnao5cOk2
         QRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=s/+N1DQ8GVzUisJ6bFoh7DKgRIy7q573ckt3BaFxiyA=;
        b=f+U8cU1meSxlX8u12V1aEwRYH0YTdgF2EzvrX3hZRqR4gacaChNiu3fedhgzg7km8v
         HxkhoSPY6IWjTzc9GnPtWWz30m37XPNhQh7Phuj8mZ+SPcdvteIJhP7ZwRQk54jl2WI6
         zjNzN0mhCqwzkUaQArTDLzY/J3mujXrbKNpVCms45tppuTs/GZhKlMqacpJwVtUGNcCC
         1dDgTwnsbljz/Ii93nVoOJuLXDH4hKzwQ6d/qO3r263g0MSJYyhW2YRvF52MNCQgyB6m
         dvBWWLATpw9pOzGHQC6OCmxGFME8zNYCcaPFbhJrWA+GrK5mLEBcqHhAFTMTrSInQfaC
         GlWg==
X-Gm-Message-State: AOAM5326hg88q1ZsWWjuakz3+eLNbGFC4mZZidTKpbtYqgAOsj9zT7Xx
        tj27tSIAQdIBtB6RYbz0NRonOML/FEzhRQ==
X-Google-Smtp-Source: ABdhPJx7Dbt2uURp76Rrrr2OQ6OjR4zDQ3+rju+Xy8iVdSkvbsUHLMBmKGbI8lOuBNXEgNVvVHNoFw==
X-Received: by 2002:a63:f748:: with SMTP id f8mr18577098pgk.420.1605044259878;
        Tue, 10 Nov 2020 13:37:39 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
        by smtp.gmail.com with ESMTPSA id mt2sm4552900pjb.7.2020.11.10.13.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 13:37:38 -0800 (PST)
Date:   Tue, 10 Nov 2020 13:37:32 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 00/10] Advertise trace2 SID in protocol capabilities
Message-ID: <20201110213732.GE36751@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <cover.1604006121.git.steadmon@google.com>
 <4f1a1bab-7ac7-b8dd-acb2-6aeb04be3171@jeffhostetler.com>
 <20201102222020.GA1904687@google.com>
 <xmqqa6vyqgoc.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa6vyqgoc.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020.11.03 13:22, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> >> So the value being passed between client and server over the
> >> protocol may look like `<sid1>/<sid2>/<sid3>` rather than just a
> >> single `<sid_x>` term.  For your purposes, do you want or care if
> >> you get the single term or the full SID ?
> >
> > I'm not sure we care too much one way or the other. A single component
> > of the SID should be enough to join client & server logs, but it's
> > easier to just send the whole thing.
> 
> It may be worth documenting this design decision in the protocol
> doc; even though protocol doc may say this should be treated as an
> opaque token, people may assume certain structure.

Done in V3.
