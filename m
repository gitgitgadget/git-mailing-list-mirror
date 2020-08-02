Return-Path: <SRS0=XjWc=BM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20863C433DF
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 14:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F30512075A
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 14:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fl3q0vQS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgHBOfX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Aug 2020 10:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgHBOfW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Aug 2020 10:35:22 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2C4C06174A
        for <git@vger.kernel.org>; Sun,  2 Aug 2020 07:35:22 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id y8so11722013vsq.8
        for <git@vger.kernel.org>; Sun, 02 Aug 2020 07:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6eWYMH/lO/kuPguiwkkvjmuIvPCSntqKKCq14694EgA=;
        b=Fl3q0vQSNv5YmBhK8tPjfRaCVwMHf9qo6R7cHWm1+ry9pdaSNsYd4opClo3j8/NUH9
         eAupp0VMJ9aYqLFi42BWZeeFdjcxcmu4OKgE7yzyaggReFcOf73c+lrBmQoqHGq4NJgA
         BwPm4A41MN5Khwnejxudp4iPdpJkJuOTwO1D127yv0R2LdpyWVe8gi8HBkWUkDaDetrR
         BSOg1oPQdTXL3Uz0J1Hv1OLr2fD8Zo25ls2u0j7WQKnShKJFOJ5lRUYE5SMcXSnwYW7r
         wx0FKd4I60Vf4Oyo4NuILtJ9G3su+ZBDzjdkKkEYLT3D7mD4pOEsNvAZfAni5Rqz01os
         Ym4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6eWYMH/lO/kuPguiwkkvjmuIvPCSntqKKCq14694EgA=;
        b=m9sG9gJdfk1E7gDTrluNMdCAJ5xeQApF9BIsMFFz3ROZgfodhePW2LjJ0qFj+bJiyy
         3uu0GpSYPBExYtcWm8dhoX2Ra5BxUWT7tBjXIasMwH1pmefqRDb3DEHt7Jbchz3p3sa+
         9kVs5g+IHfg5U3YXO09Xmy4tvB+QfsMYcHAw4kdprIWPhNNaveHLSDnN2HJqSoyFYul7
         b3Yd4rh/a7fAGuTFE3qmpNBYpJvcQgT5/adtvY4NftzzJl3XdVn9ZIlZlxnR+wt7UBNJ
         xtgOj9HwfCto0CZb23P9/9NuBCsPrzpPxkyqzkvWC1PFEasHQTqyWZMQAk9nGgFJzwMc
         Gsyg==
X-Gm-Message-State: AOAM531ZEp0KWOr5MmeaA//fLbN/QKb1z/BmUCoObY+RVckywnxHn51E
        E4CDUCJ1Iqd6hVasSU3clCbNlXttPhcL7HCvj8k=
X-Google-Smtp-Source: ABdhPJxPVsdR+issWhgqihMClTjhzEBCBQadjKG/cEvaS5BVekkoMWWDFsG3T9tNJJbgojUCGo4YpW0b19iOauCs6DE=
X-Received: by 2002:a67:bb06:: with SMTP id m6mr9084901vsn.54.1596378921698;
 Sun, 02 Aug 2020 07:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200801220611.10453-1-martin.agren@gmail.com>
 <CAPx1GvcZFVfmP8aTdXu_epdSn1EDy_cP6-=hi65c_5DbNEq+FQ@mail.gmail.com> <CAPx1GvcD80MfjZLiKBrH8BgsvVToZ90C057gk7b4BUzbLMNu2A@mail.gmail.com>
In-Reply-To: <CAPx1GvcD80MfjZLiKBrH8BgsvVToZ90C057gk7b4BUzbLMNu2A@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 2 Aug 2020 16:35:10 +0200
Message-ID: <CAN0heSoYAJkZVG7_TPTo3Osz+FuR__AY5Ykc8OSwzARTotfwcQ@mail.gmail.com>
Subject: Re: [PATCH] t1450: fix quoting of NUL byte when corrupting pack
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 2 Aug 2020 at 03:02, Chris Torek <chris.torek@gmail.com> wrote:
>
> Oh, wait, I am indeed missing something -- the script itself is
> all in single quotes, so the single quotes on the line in question
> are wrong.  Never mind!

No worries! Thanks for having a look at the patch. Is there anything
that could be done to make this clearer in the commit message? (I find it
quite awkward to discuss quoting: will the reader understand which
quoting is part of my own formatting of the message vs which is part of
the quoting issue I want to get across!?)

Martin
