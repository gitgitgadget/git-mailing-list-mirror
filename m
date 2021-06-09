Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AF7C47095
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 04:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF9DC60234
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 04:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbhFIEqj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 00:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbhFIEqi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 00:46:38 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63D7C061574
        for <git@vger.kernel.org>; Tue,  8 Jun 2021 21:44:44 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id q8-20020ad45ca80000b02902329fd23199so5099156qvh.7
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 21:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MZbeHxK3oghVB6gzTQNMKIKgqGhGb32k0k5M13XDkeg=;
        b=DPDcy3lo/dBlbUofvmj8p7Q71eoTKxTOIqMrDyaMiXkLKmuCectaKqqHGEqVL8fNIz
         Q8j3x04dJNcbdoMObDs0ZWffwHuxXERcyQNfSKaxAKbng1KXAPMMhCKuTq1OAEjXDcq7
         a2YlkDzdbfJCDfqVB5YixmOjN9DvczPgsjeRYnsU9in3yHjZmII5+WwOoDPOaUSuFZBi
         yuQbTebNlMa5zuS4lHkVqy3rbhwjnmGz1lgkcy7fB2lQFInUBRxlG2SN/7WgkCKdFVwz
         XLzynJXqGzjr7bxP6OLmxcbOnsqpF4nYIwUbQGusSZvPWRbj+zx8rT3ENTURiJKdQWOR
         6BSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MZbeHxK3oghVB6gzTQNMKIKgqGhGb32k0k5M13XDkeg=;
        b=l4JMhXDNuQ6g4hIxzHdbMf6DyrQ6XHTIPLIpu5goFpd0wE9zA5TmsM4V4u60HlvvJv
         CDtVhcbwiJ2/poo1t03hGpDITzQAIs64t7q6rivag3gR5EQ7+jIqOYBWbtfRxB2jQRVa
         fcBv5jVavvUHeXT+Sgw5LTk+gsuONEfLRlgKR4D6W0cLvuMD+bJLO/xZnB5rxeZkETM7
         wWqfrROE54RQMqG6iRKaIxjrrAK4nmUQTuWG0qYJS/0iQLQzR0kyo2GABzHxdYGHya3m
         7C2uEx+CuxAQq4aNBEI9U7YJwdXT+nLFT2ANwxMHzNWfMaBK13ISQdA7pNfv1WMs/HIX
         uTZg==
X-Gm-Message-State: AOAM5300Vu9fvIIsCAvP9nIZ22MyO1WtP1tJP5UeW5BDwPe+F4HrW6eB
        U4TsfEGiHKRv3eHrZVzV/cZAfT9MI7MkkZl1/5Cv
X-Google-Smtp-Source: ABdhPJzX9gkkCfPj4/y0JhWiV8N91Xt52ZkaY2vCqkiCtyPiaYUHKm3CbRJ5ZVxE+ItM0GJ56BlL8P8oJ6D7Mw9YlNGx
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:ad4:4b71:: with SMTP id
 m17mr3630287qvx.45.1623213883400; Tue, 08 Jun 2021 21:44:43 -0700 (PDT)
Date:   Tue,  8 Jun 2021 21:44:41 -0700
In-Reply-To: <CABPp-BEn+yksK1KhncL8jWAya+ikGPUtsWpoZhrJrgRH2ORajw@mail.gmail.com>
Message-Id: <20210609044441.2326555-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CABPp-BEn+yksK1KhncL8jWAya+ikGPUtsWpoZhrJrgRH2ORajw@mail.gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: Re: [PATCH v2 1/4] promisor-remote: read partialClone config here
From:   Jonathan Tan <jonathantanmy@google.com>
To:     newren@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, me@ttaylorr.com,
        emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > @@ -99,6 +94,15 @@ static int promisor_remote_config(const char *var, const char *value, void *data
> >         size_t namelen;
> >         const char *subkey;
> >
> > +       if (!strcmp(var, "extensions.partialclone")) {
> > +               /*
> > +                * NULL value is handled in handle_extension_v0 in setup.c.
> > +                */
> > +               if (value)
> > +                       repository_format_partial_clone = xstrdup(value);
> > +               return 0;
> > +       }
> 
> This is actually slightly hard to parse out.  I was trying to figure
> out where repository_format_partial_clone was initialized, and it's
> not handled when value is NULL in handle_extension_v0; it's the fact
> that repository_format_partial_clone is declared a static global
> variable.
> 
> But in the next patch you make it a member of struct
> promisor_remote_config, and instead rely on the xcalloc call in
> promisor_remote_init().
> 
> That means everything is properly initialized and you haven't made any
> mistakes here, but the logic is a bit hard to follow.  Perhaps it'd be
> nicer to just write this as
> 
> +       if (!strcmp(var, "extensions.partialclone")) {
> +               repository_format_partial_clone = xstrdup_or_null(value);
> +               return 0;
> +       }
> 
> which makes the code shorter and easier to follow, at least for me.

Hmm...is your concern about the case in which
repository_format_partial_clone is uninitialized, or about ignoring a
potential NULL value? If the former, I don't see how your suggestion
fixes things, since extensions.partialclone may never have been in the
config in the first place (and would thus leave
repository_format_partial_clone uninitialized, if it weren't for the
fact that it is in static storage and thus initialized to 0). If the
latter, I guess I should be more detailed about how it's being handled
in setup.c (or maybe just leave out the comment altogether - the code
here can handle a NULL repository_format_partial_clone for some reason).
