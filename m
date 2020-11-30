Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0D8C5519F
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 08:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F19C720643
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 08:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gpb/1KKu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgK3Ir0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 03:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbgK3IrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 03:47:25 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB62CC0613CF
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 00:46:39 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id g14so14880178wrm.13
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 00:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=OKPW0r5viTsLzQuoQqH3f/yImB3LcAG9IemXovi3re4=;
        b=Gpb/1KKuYhsAc5SsAJCf4uzzbSD2/lMhK3PtaPfImcsV2Erbimdvnr8w8+TAle5ykX
         KW1o2zPhXzduKHP0spU/9mGT9Qyps4ahX/jJywU2G3kGUKyvcwseyqvhh+2imO6p+6f8
         zZwun4N4qJkoIIzXxl1A4dw9eyLP6CHTpM7O7JeTAjHLbYbuIIlY38qI7vQUOxg1BAUf
         qM84DpVxQkR1wtv98XY4TmaTLlnKnMqiOdMoEBFBwMTEh6zxs8PR6fwOyT7rlc90A9So
         ztqKFV8z7l9wnH05eREK+LfPt2qq43GXQLBs937TuW5M8qQRrtZhcqaiX05j0GDrgp+L
         Wmwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=OKPW0r5viTsLzQuoQqH3f/yImB3LcAG9IemXovi3re4=;
        b=ehTlkkWSSNWmB3/ZIT5bbXhSY3m3Xjh5NGthgFy6E1d5+oEQpVj2PYuzNlQhYboQ9f
         NRwGkn5b0UapZJqIuCSLLN/2UiQDToElybWCbOuHZ4nsQxw6Qhfs7tpOHshbU1EdtWDL
         kD2UDMfZloBJEnZEzMj0o+fRhVxZRZH5L31kDMX0BEKXZf4srEiD//p2KBCXSln08ccU
         1SL+BHkoUD7Ec29eVzoRyXUMiiBH9EmSEdBWuipOhT/LBdy9PBPf2/KvxykxyHLd/as1
         /zxrU03Njru75VlYtRTL4Z2PPwFJaPGmJYZW1sXnKEr1O8HBWPtiD/hLJHjiDYbepldh
         BVag==
X-Gm-Message-State: AOAM530mtEz2BHJm4pBcChBFTKgA4jT0nZD36EknayhqVeXGEHW8DtLB
        Vjzvjv4SQT6HVKtu1+TLm68oUFYv4uBClkOjW96NgApXnw5Y6Q==
X-Google-Smtp-Source: ABdhPJwPX4oxMB4edt4gznN0kmHrLiFJB6FbNznwywAT4fLeVE7sjZgo19iwP5ZGvFQr+Wy8kaAf02TrbQeu/KhujI0=
X-Received: by 2002:a5d:52c1:: with SMTP id r1mr27543425wrv.255.1606725998007;
 Mon, 30 Nov 2020 00:46:38 -0800 (PST)
MIME-Version: 1.0
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 30 Nov 2020 02:46:27 -0600
Message-ID: <CAMP44s08MH36SYqG1QE8tf5VdxJ-Cb8kpwD3eHeBQH+WSyBnLw@mail.gmail.com>
Subject: git-smartlist 1.0 released
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

For a while I've been using some shortcuts to visualize my specific
changes in comparison to some upstream/official/master changes.

For example, if I just do "gitk @" it takes a while to load the 61K
commits that are part of the "current branch", when in fact I'm
interested in only 10 or so.

I can simply do "gitk master..@", and that does the trick, but it gets
to be a bit tedious to type that every single time.

Moreover, maybe I'm interested in two branches: "fc/feature-a", and
"fc/feature-b". I can find the specific commits with "fc/feature-a
fc/feature-b ^master".

But what if they are not based on "master", but "next". Or worse; what
if one is based on "next", and the other on "stable"?

Easy, you just do "fc/feature-a fc/feature-b --not $(git merge-base
fc/feature-a fc/feature-b)".

At this point it should be clear that perhaps a helper would help.

This is the primary problem git-smartlist is trying to solve.

In its essence git-smartlist tries to generate the revision list you
most likely want.

The whole point is to avoid typing as much as possible, and generate
minimal, yet useful, revlist.

In its main mode without any arguments git-smartlist simply generates
"@{upstream}..@". If you specify a branch, it will generate
"branch@{upstream}..branch". In both cases if no upstream branch is
configured, "master" will be used.

Then, if more than two branches are specified (e.g. fc/feature-a,
fc/feature-b), git-smartlist will find the merge base of both and do
"fc/feature-a fc/feature-b --not $merge_base".

To configure an alias for this mode:

  ls = smartlist log specific

Then, typing "git ls" will trigger this mode, and you can do "git ls",
"git ls fc/feature-a", or "git ls fc/feature-a fc/feature-b".

You can replace "log" with your favorite command. In my case it's `lg`
(log --oneline --decorate --boundary --graph).

A second very useful mode is "branches". If you specify more than one
branch it's the same as the "specific" mode, however, if you don't
specify any argument it will be the same as "--branches --not
$merge_base", and if you specify a namespace like "fc/" it will be
"--branches=fc/ --not $merge_base", or you can specify a prefix as
well "fc-*" -> "--branches=fc-* --not $merge_base".

I use this a lot when I want to see a bunch of branches with a certain
prefix, for example: "git lb fc/completion/".

If on the other hand you use gitk a lot--like me--you might want to
consider this alias:

  v = "!f() { gitk \"$@\" & }; f

Then you can have shortcuts for both text (lg) and visual (gitk)
exploration of the commits.

  ls = smartlist lg specific
  lb = smartlist lg branches
  vs = smartlist v specific
  vb = smartlist v branches

For more information check the repository in GitHub.

https://github.com/felipec/git-smartlist

Cheers.

--
Felipe Contreras
