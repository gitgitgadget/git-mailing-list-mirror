Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32884C433E6
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 18:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 105D964F6A
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 18:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236914AbhBBSiJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 13:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238603AbhBBSf4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 13:35:56 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B222DC06178A
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 10:34:57 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id c186so14078756pfa.23
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 10:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=K3znd53XxW/wZJ46EP2jTXBDICz0G6Zt4XRv7Of/0lE=;
        b=I6Yh9X/q5tpgX9PxiPu3JZyRWPfhWB0ud5YL3iB3PuHBaViDivNUhNCuiTjTnjKP2b
         MgHi49ar9Y1YfRGgDSVckSKsPvYahClmI6J2ZKhrjcvr/UNmWP1gBlNWz2y6vAMLXWsc
         ZtqAz3NVi/DQelAwXaSq1ahRrstdWbyQOF/i67h67S1Yuayr/xROJwnj1K+HNpp50vTj
         FR+acZFrrHhLcQCu+puSk0zZ1sTLauQwWU6tkuEO/9Pr73XjA+hiqMJhhjEsfHnCtSto
         2fqK73XRBU/dwjZSnsn4N4dCO5aeXHgNVH2S2zZViF+gtDHBk2t1d05SdzvajwTe8wUr
         Y44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=K3znd53XxW/wZJ46EP2jTXBDICz0G6Zt4XRv7Of/0lE=;
        b=bLyK0Pozq2yRGAohuoNFcM1iETMpZZzq0GC6IIWZVSU3pvs0DUpoeZy2glqMI9TpLO
         bDbMYzkW5qoTMnpiWmdmJLuk51ongbViAou+Ftxh4p3l21dXZEqV8Uff0BL93hFtZfn0
         9kZCDyEkGA4BnTqWstLWQ+xoZvttX1k+sXYh7dQ68/gJUuDM9kZFwuwY5hPDiKfshQJy
         GVXoW94o2btTqSyyGajrUMyFGyCCPfTuliHCqNee0DTAg762+PG9VdeFpqagRSis0qfz
         Zl86TnXNXG7LFEMPXSrAHvYfemVX8LyZIZUK08+vCIhL2CnoZoSC0xy4Vuh8jGg3Wsrz
         uA4g==
X-Gm-Message-State: AOAM532+1EViaRWmm2JWgg6rwjdGwrYWy7fqiqichrTQMi5Tpw4Hu5Sd
        KU1DU5BIWiV5Frro7jMQajVjJKgRqzv/LCOtDUVO
X-Google-Smtp-Source: ABdhPJzdges75e9qtAYzDaJ5kDkG+ivh47BEB/EOIxk6dlZl0DicWbhgIrnEsOgUIYInCzNAPW29m22zjfSCjQZhL4H1
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:e7cd:: with SMTP id
 kb13mr5642750pjb.10.1612290897224; Tue, 02 Feb 2021 10:34:57 -0800 (PST)
Date:   Tue,  2 Feb 2021 10:34:53 -0800
In-Reply-To: <xmqq4kiuif4d.fsf@gitster.c.googlers.com>
Message-Id: <20210202183453.1907985-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq4kiuif4d.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: Re: [PATCH v6 1/3] ls-refs: report unborn targets of symrefs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
> > index 85daeb5d9e..4707511c10 100644
> > --- a/Documentation/technical/protocol-v2.txt
> > +++ b/Documentation/technical/protocol-v2.txt
> > @@ -192,11 +192,19 @@ ls-refs takes in the following arguments:
> >  	When specified, only references having a prefix matching one of
> >  	the provided prefixes are displayed.
> >  
> > +If the 'unborn' feature is advertised the following argument can be
> > +included in the client's request.
> > +
> > +    unborn
> > +	The server may send symrefs pointing to unborn branches in the form
> > +	"unborn <refname> symref-target:<target>".
> > +
> 
> I somehow had an impression that this is done only for HEAD and no
> other symrefs.

Right now, that's true.

> If this describes the ideal endgame state and the implementation at
> the moment only covers what is practically the most useful (i.e.
> HEAD), that is fine.
> 
> If we do not plan to support symrefs other than HEAD that are
> dangling, that is fine as well, but then the description needs
> updating, no?

I'm not sure what the ideal endgame state is, but I could see how
sending all symlinks would be useful (e.g. if a client wanted to mirror
another repo with more fidelity). Right now I don't plan on adding
support for dangling symrefs other than HEAD, though. Maybe I'll update
it to something like:

  If HEAD is a symref pointing to an unborn branch, the server may send
  it in the form "unborn HEAD symref-target:<target>". In the future,
  this may be extended to other symrefs as well.

I think that there is a discussion point to be decided
(advertise/allow/ignore vs allow/ignore), so I'll wait for that before
sending v7.
