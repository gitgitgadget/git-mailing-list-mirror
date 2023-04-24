Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C322CC77B61
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 10:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjDXK1u (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 06:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbjDXK1X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 06:27:23 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BDE40D9
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 03:25:36 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-504ecbfddd5so6122868a12.0
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 03:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682331878; x=1684923878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kuMFUPuZoLoozXaz3FkVSSsisV3y+5JdEP1zM90Ao0=;
        b=eoIOoPwO+ibaaR3J7b+Tkp8mHfg3z14McCa/m/dAeKxAO1h36mrR4hA8c3yTjD0ReQ
         g3656Nk1HFXF19JQYowdrMN/2Re4l59aNP6DuOU7UV+vSk1ap8KN3qTvCoziHSQkBpnt
         M7f489z01Wl8OePRGJk7S9D3kHp2Erh8nFHV6d2UMlcSi1PNuFXU1F7x3mSWkwGVKZnF
         5AXBi/WZgaqvIVQSH0uRixMV3EpzkrPfB5PgQ2jdCDKx2GK3NN+lTJslcTSyJu4pXP7g
         fixP6R28rDVtj+mXyw7g8wCud2nhIMV3/sID+s/qr9i1nfOC0NM8QoCeae4jksYiTVHT
         uGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682331878; x=1684923878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kuMFUPuZoLoozXaz3FkVSSsisV3y+5JdEP1zM90Ao0=;
        b=Qshgl0u63YoFnvOl30WdQWNJwHeMcruju/DZU3cA/8nagP59drxbB6w1LFILSauriG
         Oh+YfDagWNaS5bRzsTXWHQ66SLj+8ZuSqxOGLCZCMkoIcfGogORYrCnmvaALBbUuHbc4
         dD/xs+j1wJQjuBwqHB4hZa5YsZxKNjKh82/ZRgD8nWJzEoYTflfFDNaEiiAO9ZIkvwPy
         3Pag14B5AzJRTiYmP67+kKJjBiGRBDRPfTTwZ/8/uze31z/J3GFIQmgxyr4diEqIp1BT
         u/tFkWaRuJq4KoD+6myx+VUYc/xXHG2AmPXTh838daUpr05R/F8iliXW5IWRAH6C30Xm
         +uBw==
X-Gm-Message-State: AAQBX9eb9XNdGYoTzjEYTG+ZR66FWjpa25SGQy8ny878l5H6v4weeUXQ
        umGxtR/OLFAuOj9+I90ReUSeBk6GMsyNI8gbMwiNE+KtxPM=
X-Google-Smtp-Source: AKy350aBpBBwKw/q6DsdgEDNaXDo6YABAR6pYrcJ9N+2OZeyoELI7fUNo6dxyHc29NsX9KXjWJlZc7J02ZNsfgRCXKY=
X-Received: by 2002:a05:6402:2c7:b0:4fd:23c9:11ed with SMTP id
 b7-20020a05640202c700b004fd23c911edmr11272670edx.17.1682331878357; Mon, 24
 Apr 2023 03:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <8fe188a9-c01f-9fb5-5877-8ff508094b22@game-point.net>
 <CAPx1Gvdc6bqzt2PpqD1Z4e5w+b=8gZhUSyfUQC1n8QazdBacEw@mail.gmail.com> <74a361fd-4ee6-f362-8d49-92417f0e2dac@game-point.net>
In-Reply-To: <74a361fd-4ee6-f362-8d49-92417f0e2dac@game-point.net>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Mon, 24 Apr 2023 03:24:27 -0700
Message-ID: <CAPx1GvfszM00DzW9JxxoNZfnM3-eUJCxPArUzwFV7E+t==cJ4g@mail.gmail.com>
Subject: Re: Proposal: tell git a file has been renamed
To:     Jeremy Morton <admin@game-point.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 24, 2023 at 3:15=E2=80=AFAM Jeremy Morton <admin@game-point.net=
> wrote:
> On 24/04/2023 02:43, Chris Torek wrote:
> > ... Alternatively, we could have a
> > command -- similar to `git commit --only` in effect

> I'm not sure what the utility of the --only thing would be - to detect
> renames that didn't have changed content so that all renames could be
> done in one pre-commit?

I mentioned `git commit --only` here just to point out that `git
commit` already has the ability to make a commit without using the
current index as the new commit's source.  A "just do renames"
commit operation (in spite of other changes already made in the
current index) would need similar functionality.

Exactly how this might work, I haven't defined.

> Huh, I just read the docs on [hg mv]... does that mean hg already has
> this functionality of being able to store a "this was renamed" marker
> in its index?

Mercurial does not have an index in the first place.  The internal
structure of the Mercurial database is an append-only series of
changelongs, with files stored as deltas from the previous version
of that file (with some exceptions).  Files are listed in a manifest,
and renaming a file preserves the file's identity despite the
change of name.

(This internal format is very different from Git's.  Git is a
content-addressable file system, rather than an append-only
changelog.)

Chris
