Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACE1C433DF
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 879172311A
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=3v1n0.net header.i=@3v1n0.net header.b="C9SsBUfO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbgHFRXB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729962AbgHFRFS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 13:05:18 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C38C061A2D
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 05:29:16 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id a14so18044034edx.7
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 05:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=3v1n0.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p7T5YxGNW7W6rGfJxpX81PBJsKeVHGG18OV2oUr9UTs=;
        b=C9SsBUfOGE133l4g6XIAptERdDNwtzGemf9nlqJuG3DO0jqCg+cA6dhSCWGRkFqVbp
         KBbdq+vXrBdKEfbqQokK9nzRh4N0CslJk9MmsFj6Mv5BZNNyt6sLuNWqD2vr22fztTNb
         9Qz6d8PpQa8TfBsnoWRw4e1U/O9/p/wyqH9U4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p7T5YxGNW7W6rGfJxpX81PBJsKeVHGG18OV2oUr9UTs=;
        b=Z8SlnQh2RDwFvJ2tlaOOuHIbCSYB8uaUz9OhhnOWeVIFtlcoH6S+3XCBltphfhqfj+
         2288dvVqGa9gF8Ur8EJGnILgwjW8b5a/CN+x8Iq7jdOobbT81+k+HpWlYWtWg+OP4B5d
         rKdX0ZWJJK5aqOZKEv0dXNhDkBZnxMHT2MOUPrq5lpfpBULQix5G2FaW2m9sTI3D2msk
         u+pEg0hpCMvcfpxOnpuzRzpM4nU+OCCeLdsPcj5KJx15hir2RkCa/EbneybKs56+taOj
         6wP/bbTTYRacxuywqkmngqOSpYWcf4UWQOTIDbLKo8YnmurgMTHCTTrZ9YgrvKGdATit
         s3iw==
X-Gm-Message-State: AOAM533GPtkREUp7RpbbcxCl5PJbIKkbdyrxEpbnsKvit6rgxQs2nDOh
        yHmIc/B6aSmyFaETtlbmMU7UViFVWECTyg==
X-Google-Smtp-Source: ABdhPJzZrzhdr27Xctff8m7aiFarGZtaXLiC46amVRli/L8FdKa6LjGFyxl/bR1k8Pmq0QviS4teuQ==
X-Received: by 2002:a05:6402:12c4:: with SMTP id k4mr3795236edx.358.1596716954340;
        Thu, 06 Aug 2020 05:29:14 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id g5sm3633595ejk.52.2020.08.06.05.29.13
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 05:29:13 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id m20so25522839eds.2
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 05:29:13 -0700 (PDT)
X-Received: by 2002:aa7:d1cc:: with SMTP id g12mr3910515edp.385.1596716952812;
 Thu, 06 Aug 2020 05:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <pull.693.git.1596634463.gitgitgadget@gmail.com>
 <fc0d2b103ec080fa38e5d51bf2205b7360c1b601.1596634463.git.gitgitgadget@gmail.com>
 <CAPig+cRX3_ArTYQwc1jWHznBxLf+j0McYSo=nPq4C319J=DBvg@mail.gmail.com>
In-Reply-To: <CAPig+cRX3_ArTYQwc1jWHznBxLf+j0McYSo=nPq4C319J=DBvg@mail.gmail.com>
From:   =?UTF-8?Q?Marco_Trevisan_=28Trevi=C3=B1o=29?= <mail@3v1n0.net>
Date:   Thu, 6 Aug 2020 14:28:45 +0200
X-Gmail-Original-Message-ID: <CAALaScmKT44snh-5zTqe=Y2gjXjpo3fxRrbzotsXnr=+3Ap9ew@mail.gmail.com>
Message-ID: <CAALaScmKT44snh-5zTqe=Y2gjXjpo3fxRrbzotsXnr=+3Ap9ew@mail.gmail.com>
Subject: Re: [PATCH 2/3] mergetool-lib: keep a list of cross desktop merge tools
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?UTF-8?Q?Marco_Trevisan_=28Trevi=C3=B1o=29_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Il giorno mer 5 ago 2020 alle ore 23:08 Eric Sunshine
<sunshine@sunshineco.com> ha scritto:
>
> On Wed, Aug 5, 2020 at 3:53 PM Marco Trevisan (Trevi=C3=B1o) via
> GitGitGadget <gitgitgadget@gmail.com> wrote:
> > Instead of repeating the same tools multiple times, let's just keep the=
m
> > in another variable and list them depending the current desktop
> >
> > Signed-off-by: Marco Trevisan (Trevi=C3=B1o) <mail@3v1n0.net>
> > ---
> > diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> > @@ -288,11 +288,12 @@ list_merge_tool_candidates () {
> >         if test -n "$DISPLAY"
> >         then
> > +               cross_desktop_tools=3D"opendiff kdiff3 tkdiff xxdiff"
> >                 if is_desktop "GNOME"
> >                 then
> > -                       tools=3D"meld opendiff kdiff3 tkdiff xxdiff $to=
ols"
> > +                       tools=3D"meld $cross_desktop_tools $tools"
> >                 else
> > -                       tools=3D"opendiff kdiff3 tkdiff xxdiff meld $to=
ols"
> > +                       tools=3D"$cross_desktop_tools meld $tools"
> >                 fi
>
> I have mixed feelings about this change. On the one hand, I see the
> reason for doing it if the list of tools remains substantially the
> same in each case, but it also seems like it could become a burden,
> possibly requiring factoring the list into more pieces, as new
> platforms or tools are added.

I kind of agree on that, so it was mostly a proposal but I can withdraw it.

> What I might find more compelling is creation of a table of tools and
> the platforms for which they are suitable. It doesn't seem like it
> would be too difficult to express such a table in shell and to extract
> the desired rows (but that might be overkill). At any rate, I'm rather
> "meh" on this change, though I don't oppose it strongly.

Yeah, I was thinking the same, but also could be a bit complicated to
maintain especially when it comes using something that needs to be
supported by pure sh.

--=20
Trevi=C3=B1o's World - Life and Linux
http://www.3v1n0.net
