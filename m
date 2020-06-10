Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84157C433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 01:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 482582078D
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 01:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NzxFYuey"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgFJBOP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 21:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgFJBON (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jun 2020 21:14:13 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F410C05BD1E
        for <git@vger.kernel.org>; Tue,  9 Jun 2020 18:14:12 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id h124so379511yba.12
        for <git@vger.kernel.org>; Tue, 09 Jun 2020 18:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jaHNs8nOofZJLfWiJyQmlvMnxxj7iOumdRL0psAWRwY=;
        b=NzxFYueyPnH0+hdeOu8zO4/tHDAk28sWf74EEIgXVqv1QFsYFJZhxZP4+G6siq8fok
         Pk0AggHf7G6frkfwlV2QCj7Oqkj8YMJ7twFd7vrjjUDxzJ1FTRRzOPhEbTg8r3XRCr83
         LeP5BNuLVuVWtgagkj9f6x/JrXKnEOM/ZAewJOXSLz8HnQ7tGf0shvCjE0Gyl7+PjqhS
         A+UYcn1k5nw/GK4N0WOdT+NQ67rFZ7UOxkWEhmf2PJ/6hi0DkrviQMD80XZt14q0MwSM
         hKRvc4Q9xOtcO9w//LXx0adDJP10pya0pOS7PzzXH/F7asjlvR1FoRxxwutFx7mIl6fN
         6/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jaHNs8nOofZJLfWiJyQmlvMnxxj7iOumdRL0psAWRwY=;
        b=Xg79+fJMHnwc5rzkOLDDCXNeZ1CSKDSGV//Pc1TAyT+2odq4bWDr0A/Rqs4hVc6qUY
         Vatn4yNmZ/NCurn6ILdRErQ9qEJKFpl8pIpwUBn/+N3SkcUDP7/AM4OcG4M2Qu0CdBxU
         rh1Q2qrSSa9mmeE+YPKJKJntgKwYr/t7/b5BNVWaCP4AVmhk+w0PKJbCElX7ADDdk28W
         irTUuWA6ZYPArxCgGJmA9rpqzQxsOgrdq2psniMh74AtluudgCpIiUGW9M8yD/2cNKYr
         h5dNpMcxn9ilWZC1FIrpqNKBxaBjOjrK4+PYAwUxOGOIR9Fdi8Ikfsjdrsm4eeMH9R3l
         ttvg==
X-Gm-Message-State: AOAM533V8yMCrVrLiRxwIpAAhVJpJUaKVceHEYuXVxSs2zzQl1C1z9A3
        aoY9uz2QugZ9WVJqzuXYckcG0S7pyulOtHpTyuf6
X-Google-Smtp-Source: ABdhPJzpFr7cl/TSbb5KofOTQhKL48a+tc4BXvAJDJSwVWY7v2c5fdCKIlMK41464rYfkWpJqH7AADDLCzQtYKDJZ56i
X-Received: by 2002:a25:820e:: with SMTP id q14mr1507454ybk.196.1591751650850;
 Tue, 09 Jun 2020 18:14:10 -0700 (PDT)
Date:   Tue,  9 Jun 2020 18:14:06 -0700
In-Reply-To: <xmqq5zcexoqi.fsf@gitster.c.googlers.com>
Message-Id: <20200610011406.178334-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq5zcexoqi.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: Re: [PATCH 5/8] Documentation: add Packfile URIs design doc
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > @@ -349,6 +362,9 @@ header. Most sections are sent only when the packfile is sent.
> >  		  *PKT-LINE(wanted-ref LF)
> >      wanted-ref = obj-id SP refname
> >  
> > +    packfile-uris = PKT-LINE("packfile-uris" LF) *packfile-uri
> > +    packfile-uri = PKT-LINE(40*(HEXDIGIT) SP *%x20-ff LF)
> 
> 40* 

I'm almost ready to send out an updated version, but have one question:
what do you mean by this? If you mean that I should use "obj-id"
instead, I didn't want to because it's not the hash of an object, but
the hash of a packfile.
