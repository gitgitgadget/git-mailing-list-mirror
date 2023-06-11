Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2314FC7EE37
	for <git@archiver.kernel.org>; Sun, 11 Jun 2023 08:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjFKIMD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jun 2023 04:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjFKIMC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jun 2023 04:12:02 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AC1ED
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 01:12:00 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f6e13940daso33817655e9.0
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 01:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686471118; x=1689063118;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YN0l4rcBehy+nrmA4u3plNVdOAaxTbHGIskomkTE53E=;
        b=q5VvKu8ptWvc5uNgIOs3zSGeRu5bg9S7zzCl1kKrLEErc3SCXGtIzi2+IB6fOMzcSd
         DTvqaWSUyQuKQHruI/t/dQ+pv/5R3QOfC15D9d5SwQniK7RW1rpHPs/DID3pan3e2evF
         jhQycpI4Qh1BH+HqDXcVof39M5ELYZrrSFDiKHaSi6X7eRJknYmYapZ6LXJ6c2JprVgY
         GayjCPu+khAUvzYqpBJwhFdOj8A8k86NQuRkJrsYyRT9s2S3Lf9vkhenaEBGFuuBSMwp
         f9g0XyBFXFIBxnqHdYP5nxJKV/JWQwvqiXXgxF/Y7wK6qr/AJLa3MymnFP0vzxK6ADqt
         lQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686471118; x=1689063118;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YN0l4rcBehy+nrmA4u3plNVdOAaxTbHGIskomkTE53E=;
        b=LpbTcoxzzQs0z6nFjT0opIh19NVEmOZX8TtRMKexMdNoMQSVZBBy462bYvfqzatzCA
         JwNZ76dUYgnAeipNGP0QxrTGlNdbBnIFY3KsfcuogSncje+pJ12idg0EOz2onpX5ybRU
         ZJ/Vgo9gIzGLVUZsc6uPPllwpK+XgUOHEpFhv/wJvnfuleORDIynJYZjLQXzepoA+9L7
         V2A+u564oOb4ocH1cpV6hCOIMY8RKLI9tP29KLyAWjK8hRJ1u4cryx5Em0BogZK4fVGR
         cuKc0vw8eMjKdvYwyjLbLOTcydTNehRmMJs1R9F0wYvht8gPr2qOIOFy22TDzJ1QDRw8
         wz5w==
X-Gm-Message-State: AC+VfDwc8r2PCpVpPHwc4jBGiUNWt4TB7L74/U2SpmWqI0r4NzanpINZ
        ll0KvbplQIrDT0pkUyfpyeJQTnsDmbW1sWQlDOVvcvkB
X-Google-Smtp-Source: ACHHUZ6iaUyR2Aicz39mNWROYpO51wqWoHd50dRLT7oMgOk0uojVpDOvK2deT+CwIMcAxft1rdpW+YN9qMPHXFEbiXE=
X-Received: by 2002:a05:600c:287:b0:3f6:f2b2:15c9 with SMTP id
 7-20020a05600c028700b003f6f2b215c9mr5348116wmk.37.1686471118224; Sun, 11 Jun
 2023 01:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <CADdMKP8y3TjeCyJaxazYFY9zN2QpnMVZyRWnpoTLMcZ0ZPNMzg@mail.gmail.com>
 <CADdMKP_J7BSBeEpc6oQTh=BMf4geZJ6PwNM5yqzRQmDyT=1oXw@mail.gmail.com>
In-Reply-To: <CADdMKP_J7BSBeEpc6oQTh=BMf4geZJ6PwNM5yqzRQmDyT=1oXw@mail.gmail.com>
From:   Douglas Leonard <dleonard.dev@gmail.com>
Date:   Sun, 11 Jun 2023 17:11:43 +0900
Message-ID: <CADdMKP87DU_Vdj7Se0aRoMrkN6XUX7m1dREqbYifZDF-4MeUAA@mail.gmail.com>
Subject: Re: git-alltrees: root trees and subtrees without duplicate commits.
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just an update, this has been cleaned up with a python implementation,
with a decent bit of added functionality, particularly tag-renaming,
and it's been working well.  It's already pip installable.  Maybe I'll
get around to adding it to pypl.. maybe.

Cheers,
Doug

On Thu, Jun 24, 2021 at 8:55=E2=80=AFAM Douglas Leonard <dleonard.dev@gmail=
.com> wrote:
>
> For what it's worth, a demonstration script is included which makes
> parallel changes on various local and remote repos and does origin and
> subtree push/pull..
> In future plans... it's possible to fully reintegrate the subtree
> commits into the full branch point file tree locally so that they are
> cherry-pickable too, as if all changes were made on complete local
> branches.
>
> Regards,
> Doug
>
> On Wed, Jun 23, 2021 at 10:27 AM Douglas Leonard <dleonard.dev@gmail.com>=
 wrote:
> >
> >
> > Hi all,
> >
> > For a very quick introduction, I'm a career physicist. I just thought I=
'd share a detailed method and implementation I developed to improve on sho=
rtcomings of subtrees.
> >
> > This says it all
> > https://gitlab.com/douglas.s.leonard/alltrees/-/wikis/home
> >
> > But to repeat a little...
> >
> > First, it allows a container "sub" tree, ie syncing only the non "sub" =
parts of the tree to a repo.  But maybe more importantly, when it pulls fro=
m the trees it's able to "remap" or reconstruct old commits back to their o=
riginals to avoid the duplicate commit issue of subtrees.  This is round-tr=
ip reproducible so consistency is kept both ways. It avoids the need for sq=
uash with subtrees. Compare the two images in the wiki to see the differenc=
e between subtree without squash and alltrees. Non-FF changes made in a tre=
e repo show as branched and merged. Traditional advantages of subtrees are =
kept, primarily that users/developers of any one repo don't need any awaren=
ess of how to use the subtrees or the other repos.
> >
> > I have used this some, but not extensively yet.  In my use it has worke=
d.  I think it's pretty quick, but I haven't tested on large projects.
> >
> > Cheers,
> > Doug Leonard
> >
