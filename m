Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90A0C43457
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 13:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E6E522203
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 13:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEswbyQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgJNN3W (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 09:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgJNN3W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 09:29:22 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8F2C061755
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 06:29:22 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id w17so5045236ilg.8
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 06:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WxNiBAGuSWC20tVNSVWZFKmZ0NgozO+GvZ9fkPjP+ec=;
        b=gEswbyQyq3xJTSXZTZ1OAZygPTJEu6lPDWdQH5Mgaudda0BFSCVStngxNPgDQ85Bk7
         vyaoPCRaN0minyARpd1cCwG5hPrgvYv4rbM7xCqgZTJpYqzIzfRaT2Hd1oIfZJsRhKvn
         4bC/N9mMeKMo4TUp9TcCA1VFcr6MdQGEoWayiNEUcrT3hmgBdWQlS/ciMANmT36tDaMv
         AxkzufwAnQNescmL6B0uIGXtZNBiqjh08zlZmjzrqcRp2q1r9H+I/f0mmGlda0gp+D+4
         HRH/geVn7+iqCNGIgqppa97v0aOZVLTVANzC52xCUKwipSEbBU1AInvuyb6SNPZEv+RR
         t0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WxNiBAGuSWC20tVNSVWZFKmZ0NgozO+GvZ9fkPjP+ec=;
        b=L7ouEXyfpwQtN7JH95ROndIZMnBMqQC35DsiCWw+TH3ZpB60f7hZ02TvBSN/eZMwDj
         f5EWVnCmJqB46CL+NpNcwkdlv2Zh5LaiBCqI+q98iTRhW0xVTsBtINzSaLsKoBoFWP2v
         4iHOGC221C9L7QlO6MZg6yGxdNjnqVKGwZs2l5Jz/rBEZAbsSHtMq5W/XtG7LcYYrzse
         uOsPxeNroAqSmVWlVFJ+GrlQAhRZjciAgV0tIEK830KCFIksoxbXO70LT3TeXitTPymO
         CNBucDU2mAIV5wLiU+BZ0ryLyHMX4Hp7eoMUtVvmeHyY9/izFMfIAtTrEPGa+A24TStD
         YCmw==
X-Gm-Message-State: AOAM5328+HDc0jW2mCzHelvbJ4/K8VGStZoju/RpshGAL6vrbW91AIwU
        T30jw0uanLVGlck88DDKxxQKd/LRhivTgQ==
X-Google-Smtp-Source: ABdhPJx9qGvFkwAO9I2q92tH0fA8cmoU8BPAXAPzZzL0nWkBNbiPvD+DGqsLKHjyfo/N+Q5y9b0G6w==
X-Received: by 2002:a05:6e02:ee8:: with SMTP id j8mr3790289ilk.296.1602682161161;
        Wed, 14 Oct 2020 06:29:21 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id p17sm2860747ilh.34.2020.10.14.06.29.20
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 14 Oct 2020 06:29:20 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: git diff --submodule=diff and --stat/--dirstat/--name-only
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <CA+3n-TrVncSq6kY8sTTw=LiOvLKe=6k1yBE8cmmR3i40CaXR6w@mail.gmail.com>
Date:   Wed, 14 Oct 2020 09:29:18 -0400
Cc:     Git mailing list <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E3D98950-2EA1-4BFE-8A2D-CE8AEAF5AD39@gmail.com>
References: <CA+3n-TrVncSq6kY8sTTw=LiOvLKe=6k1yBE8cmmR3i40CaXR6w@mail.gmail.com>
To:     Marc Sune <marcdevel@gmail.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Marc,

> Le 14 oct. 2020 =C3=A0 06:14, Marc Sune <marcdevel@gmail.com> a =C3=A9cr=
it :
>=20
> Hello all,
>=20
> First, thank you to the community for the great work. Worth saying it
> from time to time, I think.
>=20
> I am dealing with a couple of big repositories that use git
> submodules. They have nested submodules, and some of them are pretty
> huge. I came across:
>=20
> git diff --submodule=3Ddiff
>=20
> Which is very handy for creating some tooling, but it's obviously slow
> - in the order of tens of minutes in my case - for big diffs. I was
> only interested in the list files that changed, in this particular
> case, but:
>=20
> git diff --stat --submodule=3Ddiff
>=20
> doesn't seem to honour `--submodule=3Ddiff` and it doesn't go into the
> submodule(s) nor recurses, of course. Other options like `--dirstat`
> or `--name-only` seem to behave the same way.
>=20
> I've tried this v2.20.1 and the HEAD of master (d4a392452e) with the
> same results. Is this a missing feature, a bug or is it just the
> intended behaviour?
>=20
> Regards
> marc

This would indeed be useful. It's a missing feature, and so intended =
behaviour
for the moment, I would say. It was discussed recently on the list [1] :


[1] =
https://lore.kernel.org/git/20200924063829.GA1851751@coredump.intra.peff.n=
et/t/#u

Cheers,

Philippe.

