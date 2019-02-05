Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8581F1F453
	for <e@80x24.org>; Tue,  5 Feb 2019 10:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbfBEKOZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 05:14:25 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:36250 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfBEKOY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 05:14:24 -0500
Received: by mail-wm1-f44.google.com with SMTP id p6so2963511wmc.1
        for <git@vger.kernel.org>; Tue, 05 Feb 2019 02:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PY2WGNx5Ue3soppFOAtORlfRd+M0RGMxkxX7BZQazC0=;
        b=g07Q7U37wPP3bSXUdVepLv3M9LgFSjljomFOLJpyWnm+3lpdYxMfJ1pDJcq+TQt0t8
         alUSuzi2i2gU+Clb3ERkbPWwBiPuU9oIOlHTX5o+Rc/+FlsmYUXGh8j8NXdohuHbobst
         e5fVx4V+nASjaen+0LVM7+tH6j5hQP9EGtiXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PY2WGNx5Ue3soppFOAtORlfRd+M0RGMxkxX7BZQazC0=;
        b=e8DqCo2p/kcl+XdMi5aI22jHaUT+bEFlGGtPyk4w+ly82dmXcXnsA64oN+9u/vcyqW
         XQUXbcvQMQ6mk3dg87IT6BfJqtVBVS71Zg4NOmWElL4rpyZ0hxB//E6yXRGAEVxJzMFp
         WxiPehWN2OC2xRbaLexr6xmuEV6g25izhjqkk5/UCnsMlrd5udwXnc5bO36OD2ByUVsQ
         vn2eTooHuKajQecc4kr4apVTjpgP/pKlBRypeYmqF6mD19Wi8RGMXxntX0VabRbwy/Oe
         hcxkd5G/QtNgpDL6/En0oMf8dYI1ktAnytk5N0ae8rnhdegSGmjL0g5YiQ7DPULUjda0
         X5mA==
X-Gm-Message-State: AHQUAuYpAfg5uU5SV9NBp1ujfmjwgrzxjlFXsbXydhj+7VVHFXcFYKe5
        tHiyxmKSr+fLuSX+bDwhCuN81LnM71QcneGK3MDaqpiC/yM=
X-Google-Smtp-Source: AHgI3IZ2li4w8E74lt5KKisnjFtBvQaEWQg2A4NMZD/p39BCpmLqvDQp0J9bVBBSzfVrJCxr5Q+RE0+ZzFx3giZi2Z0=
X-Received: by 2002:a1c:bb04:: with SMTP id l4mr3076944wmf.142.1549361663126;
 Tue, 05 Feb 2019 02:14:23 -0800 (PST)
MIME-Version: 1.0
References: <CAE5ih7-Gi6i8ZRDjsVELLesTORRDxvrLYf00DYTBRFUWUmAAdw@mail.gmail.com>
 <20190204232844.GA2366@sigill.intra.peff.net>
In-Reply-To: <20190204232844.GA2366@sigill.intra.peff.net>
From:   Luke Diamand <luke@diamand.org>
Date:   Tue, 5 Feb 2019 10:14:12 +0000
Message-ID: <CAE5ih7-8Z6r1yrRMZN24wEoOqz_S=63HGg9RkNyYXhbXFgh1Fg@mail.gmail.com>
Subject: Re: Partial clone - bad pack header?
To:     Jeff King <peff@peff.net>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 4 Feb 2019 at 23:28, Jeff King <peff@peff.net> wrote:
>
> On Mon, Feb 04, 2019 at 01:45:35PM +0000, Luke Diamand wrote:
>
> > I tried to do a partial clone, but it gave me a "bad pack header". Is
> > there anything I can do to debug this?
> >
> > I did "git config uploadpack.allowfilter true" in my repo.
> > Then I went to a scratch directory and did:
> > $ git clone --filter=blob:limit=10M ssh://localhost/~/git/my_big_repo
> > remote: Enumerating objects: 1619425, done.
> > remote: Counting objects: 100% (1619425/1619425), done.
> > remote: Compressing objects: 100% (362435/362435), done.
> > remote: Total 1619425 (delta 1225623), reused 1604277 (delta 1211975)
> > Receiving objects: 100% (1619425/1619425), 10.34 GiB | 35.61 MiB/s, done.
> > Resolving deltas: 100% (1225623/1225623), done.
> > Note: checking out 'a943f529b4781f34602f1ad5aab99a8699975c29'.
> > [...]
> > fatal: the remote end hung up unexpectedly
> > fatal: protocol error: bad pack header
> > warning: Clone succeeded, but checkout failed.
>
> Just a guess, but does setting uploadpack.allowAnySHA1InWant to "true"
> in the source repo help?

That's a very good guess - it works a treat with that!

>
> By default, upload-pack will not allow the client to request those
> arbitrary blob sha1s. I thought it was _supposed_ to notice this and
> complain with a nice error message, but I know I have run into cases in
> the past where it does not (but never tracked it down -- this may well
> be one of them).
>
> -Peff
