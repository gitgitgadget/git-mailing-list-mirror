Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E682AC2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 13:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0EB420705
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 13:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toptal.com header.i=@toptal.com header.b="dtGApZ0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgAaNnB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 08:43:01 -0500
Received: from mail-vk1-f174.google.com ([209.85.221.174]:40386 "EHLO
        mail-vk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728500AbgAaNnB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 08:43:01 -0500
Received: by mail-vk1-f174.google.com with SMTP id c129so2066563vkh.7
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 05:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toptal.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Lk+AcyDW4grtCC4eRgU+AfIV7Ns46YoDKxJ50oDID0Q=;
        b=dtGApZ0NaRV0MGWPhAETZc+sqV6Hm+BYhqR/mKMmrlueiiScnzTLgYsFfM4eV4z5dg
         yK5kLnbJIF4umXhmtu10ou0OQzwIe2EP9CIqOpyx5l951wwmmqzJtggCQpKjXfYaris+
         UiBI4uazlN3Qo7J8vssFXykabQ0vJbjh+GVvts0Go3aOgxgmieJeFYejSkquIEtsGaYb
         77+G9+Ji787p3K5FuIpmBydrkxbICjUsBYjr6qEBPdO074RRFqaQWlxWCfDgEXf/xmJF
         UfSF8E0GXCH5CXqBfFZlEBt7vHUy02wIuTvzzM4ND0V1rW1H9ZKjbRdrRqJQ4w+vzftK
         BxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Lk+AcyDW4grtCC4eRgU+AfIV7Ns46YoDKxJ50oDID0Q=;
        b=lr94+ZDmDhgaUy4e/mSB3pMMqOY1RPKE/eJYH88KOVFyuwn7Fau6cKaC8GfEPuav4f
         yHZ29gGE9NaKYYiDLIGJtI7VNhe1zetLG56Bb6ngXxx4lOfCNk4fgtbP4nXTsgMzsASp
         PdAz4aW5/BD5/tU0rcWgPCf7yVGXyNCjaQ6B7KY3p9nDqar1lClr2RSvih7budEbz54h
         71jXqidnla+di0Kep6AZ0/e0EsOa5zPKmWW1/wZRy4lVqi/8Dp2visgtjGd9D+7/syRK
         Z1Bfz0m7n9LcVkwHPHV/UeDi0tAeT0xJlCOQ8KeHM/K3izO9R4Op8S8UFC8seeppmrWX
         O4rg==
X-Gm-Message-State: APjAAAU7cgXxaFOORObpVGTvnMxnyV6e2NGyZcllT5i02kovu12anRlB
        Oy40yklK588EUageS+e1WAnxN2Ook8TJkP6DBsZuqUs8
X-Google-Smtp-Source: APXvYqwPqqAraWz//Sj6+4C/UxDoHy9NRKlvWZOXIawT9In0pqiwi1FUQ3G5TVzLQ6jp561gkb4NaiVB3cXTfBPXTdQ=
X-Received: by 2002:a1f:f283:: with SMTP id q125mr6245697vkh.69.1580478180541;
 Fri, 31 Jan 2020 05:43:00 -0800 (PST)
MIME-Version: 1.0
References: <CAPgZwKbZ0g+VXjnD03hGkRXfwU2DpygLhLBFG3xv1W9c8oQ1fQ@mail.gmail.com>
 <CAE5ih79j+o87yEPbj+nFR6b4rx_NU2eLJite69=+qMdpXdEidw@mail.gmail.com>
In-Reply-To: <CAE5ih79j+o87yEPbj+nFR6b4rx_NU2eLJite69=+qMdpXdEidw@mail.gmail.com>
From:   Ivan Selin <ivan.selin@toptal.com>
Date:   Fri, 31 Jan 2020 16:42:49 +0300
Message-ID: <CAPgZwKbYKPbZeEY2O22DJBvDpjHRR2XVW9hQ7-tML-UE2bkXYA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_git=2Dp4_cannot_use_perforce_client_created_by_p4j?=
        =?UTF-8?Q?ava_=E2=80=94_=22Expected_view_key_View1_missing=22?=
To:     Luke Diamand <luke@diamand.org>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yes, that's exactly the way that I've tried it and it worked for me.
Can we have that integrated into git-p4? What can I do to make it
happen?

On Wed, Jan 29, 2020 at 1:35 PM Luke Diamand <luke@diamand.org> wrote:
>
> On Tue, 7 Jan 2020 at 15:53, Ivan Selin <ivan.selin@toptal.com> wrote:
> >
> > Hello!
> >
> > If I create a perforce client from java using p4java, it gets created
> > with an extra key "ViewDepotType" in client definition. When I try to
> > do `git p4 sync --use-client-spec`, git-p4 dies with message like
> > "Expected view key View1 missing" =E2=80=94 because it assumes that all=
 keys
> > starting with "View" are "View0", "View1" and so on.
> >
> > How to reproduce:
> > 1) Create perforce repository;
> > 2) Create a perforce client (let's name it "my-client") in said
> > perforce repository using p4java; add one view mapping to the client
> > on creation;
> > 3) Run `P4CLIENT=3Dmy-client git p4 sync --use-client-spec`;
> > 4) git p4 finishes with error "Expected view key View1 missing".
> >
> > Attaching hexdumped/unmarshalled examples of "regular" client
> > definition and client created with p4java. Note that p4java's version
> > has "ViewDepotType" key and regular client does not. Also,
> > "ViewDepotType" key is not showing up in text output of `p4 client
> > -o`, only in binary format (`p4 -G client -o`). And I'm attaching a
> > patch that solved the issue for me.
> >
> > Is that information enough or should I add anything else? I'm new to
> > git community, but willing to help.
>
> I suspect the problem lies at around line 4220 of git-p4, where it does t=
his:
>
>      view_keys =3D [ k for k in entry.keys() if k.startswith("View") ]
>
> I think changing that startswith to a regex match would fix this,
> although I have not tried it.
> Something like:
>
> is_view =3D re.compile(r'^View\d+$')
> view_keys =3D [ k for k in entry.keys() if is_view.match(k) ]
>
>
> >
> > Regards,
> > Ivan.
