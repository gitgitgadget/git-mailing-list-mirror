Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87649C433E0
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 04:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48FF564E12
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 04:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbhA3EVU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 23:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbhA3EF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 23:05:59 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC84C06121C
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 20:04:32 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id t18so12554366ybb.22
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 20:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=6mPMURn5W9d0R1GToF6VY73bMPYXK0Dm2pvb+4P6cBE=;
        b=BrnlJmiBGicydt6EqcmJYbgIeeVHn7VYn3Z36Tm+kLnmtijQqA7NAHn3WTcSpmPc+f
         htydfPd4uF0awZlpxfqy3LjSIKgKIB48OqeYv1G7UVOQrgcJXREfvJau5WwbA2L66nd7
         WiD/oi0yrR975TUTf82iKZGG94J+f5jySxouFk23ET9uukC8lmdn7z0BRlVHpyH+oXg8
         wN3/OUmAhZV9Bc9T+gGkGNCcT/OVHf7mLCPhb8D6gdMS7nA9JoFTKrO70KGaHVh8UBN2
         dpkE6j/VZ2scGUxbviVazoGzN26xzrH3kfTCvKwiBx6uc3V3GRNnbMcc11306HkxWESc
         q/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6mPMURn5W9d0R1GToF6VY73bMPYXK0Dm2pvb+4P6cBE=;
        b=RZBuwzm/QHDm9iiL8dN3nDIKiF46eAbzDZhR8kaEXwH7uqcfprPWtTSfgsKanTwSAO
         vJ2x/I+itAIquLVnJPDs1ZrzTt08xDw2y5SEbEZqR0eRWnk45pdXlYekTqLC4nCkCOwr
         tVzb+rfzPKu6GKD9c1zsBIbOn5YRzvjaGYELTBO1AVpFRs9cOKOEveWHg+xPIoWb2rnu
         gignoJHAz6SZIj/pFQ/QNYosBm/sjKEa5CRK17a6g7m9TJN2fYvrrL1yerxkJGgQ/yhb
         cxXQ5+AseTog0nuRzCrvd6OxUVRZTahlGr3rBFYdzPs5BK/0KHLnZoV743HCsz2Dba4x
         IlQA==
X-Gm-Message-State: AOAM533F4/ZvCcoigDuvt3advacVvyNM2yQeWZ+hvBqPrTXO6G0KF9Vs
        hEmgcTPTb44xnfO1HO7wBDpAZhPgTWEgBC6jEVb2
X-Google-Smtp-Source: ABdhPJyTR91iV/GFtmNyt1gGtV4iToGZ6nKpu7mnBOUEBbz3ZM/arFoyV9mYlQzG+7+V3Vsx7USmsBoynOOo16JVJuYm
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:ea4f:: with SMTP id
 o15mr10673600ybe.44.1611979471971; Fri, 29 Jan 2021 20:04:31 -0800 (PST)
Date:   Fri, 29 Jan 2021 20:04:29 -0800
In-Reply-To: <87k0rzp3qx.fsf@evledraar.gmail.com>
Message-Id: <20210130040429.798839-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <87k0rzp3qx.fsf@evledraar.gmail.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: Re: [PATCH v5 1/3] ls-refs: report unborn targets of symrefs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> 
> On Tue, Jan 26 2021, Jonathan Tan wrote:
> 
> > +If the 'unborn' feature is advertised the following argument can be
> > +included in the client's request.
> > +
> > +    unborn
> > +	The server may send symrefs pointing to unborn branches in the form
> > +	"unborn <refname> symref-target:<target>".
> > +
> 
> "branches" as in things under refs/heads/*? What should happen if you
> send this for a refs/tags/* or refs/xyz/*? Maybe overly pedantic, but it
> seems we have no other explicit mention of refs/{heads,tags}/ in
> protocol-v2.txt before this[1].
> 
> 1. Although as I've learned from another recent thread include-tag is
>    magical for refs/tags/* only.

Thanks for spotting this. Right now the server sends anything, but the
client only uses the information if it is a branch. I think this is the
most flexible approach so I'll keep it this way and document it
explicitly.
