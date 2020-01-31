Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545F5C2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 15:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C9B2082E
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 15:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="J+/Epbpp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbgAaPwW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 10:52:22 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:40663 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729030AbgAaPwV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 10:52:21 -0500
Received: by mail-wm1-f45.google.com with SMTP id t14so9211891wmi.5
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 07:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f95LSI90e169v4CPYTQADIrINRbOHQ9H7hhLGf8VqAQ=;
        b=J+/EpbppCcu1Q9rYyuhbZ3/qHNclsz85/h7a3/Vb55/lZO9fzRdHM62jgeQECAgb/Y
         zt0WnE8crxBlvfL2CZ6CTaPwkbYCtB6kOkF8ckzpxVl6TUGhJbHfmDsuDzu6QOp0Ewa3
         tSYzcsx0aqotalkl3XUKdW1DEETSoyQ2BuhCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f95LSI90e169v4CPYTQADIrINRbOHQ9H7hhLGf8VqAQ=;
        b=dN4geHo4DQxIYeDRcfh97xHeNggc3Qqkt3G4sUrbpJSbHfywYLCkYGN9odklk6jkA/
         318lmk0qooh+dT0gtzuojIolTaMA91El0bNTv5RZa+SH7m4s5JiK1o8yLzkpDBsioNwT
         XpIbyJvsVQypWIYqBhjuAr0pHNEIrD/LeZrDr2qv48bhQytVbSrr4io6nG6tcNWPAuII
         YPDYJ9yHN9ERx3W3I/3JjpAobRUj+5+FGHYPwE+j+aTprD+ZcRl+nhg+LeOjEQZkuhKL
         0zS/65gruWjfkK4Tz4GNKx0Lh0dSVxZuxoiQOH9GGgzRV6ZzYfYr4I4981AqctlfUs2G
         TpxQ==
X-Gm-Message-State: APjAAAWNoR5w1nrqsCeDKCSdDOaZqe/34ko6pogLKhYKK+uhFfnSXJNH
        vAIrpLz4Lf5TtzOR37+i6TD/iOPMN37F8Z8YGX4JdA==
X-Google-Smtp-Source: APXvYqweTfDEkDfZ0LcxPKt6WgSZE0lTjNqUZo9vC6Gy0mIg+y+f2uMfyh6Rb+iuI9MF9D5nytl7sNB4TWRIeqcC7jw=
X-Received: by 2002:a1c:e3c2:: with SMTP id a185mr12653894wmh.27.1580485939542;
 Fri, 31 Jan 2020 07:52:19 -0800 (PST)
MIME-Version: 1.0
References: <CAPgZwKbZ0g+VXjnD03hGkRXfwU2DpygLhLBFG3xv1W9c8oQ1fQ@mail.gmail.com>
 <CAE5ih79j+o87yEPbj+nFR6b4rx_NU2eLJite69=+qMdpXdEidw@mail.gmail.com> <CAPgZwKbYKPbZeEY2O22DJBvDpjHRR2XVW9hQ7-tML-UE2bkXYA@mail.gmail.com>
In-Reply-To: <CAPgZwKbYKPbZeEY2O22DJBvDpjHRR2XVW9hQ7-tML-UE2bkXYA@mail.gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Fri, 31 Jan 2020 15:52:08 +0000
Message-ID: <CAE5ih79xWfjLC48y=mSLhdG2zVR5d-XeAbJJFV2SPTew5FGf+Q@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_git=2Dp4_cannot_use_perforce_client_created_by_p4j?=
        =?UTF-8?Q?ava_=E2=80=94_=22Expected_view_key_View1_missing=22?=
To:     Ivan Selin <ivan.selin@toptal.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 31 Jan 2020 at 13:43, Ivan Selin <ivan.selin@toptal.com> wrote:
>
> Yes, that's exactly the way that I've tried it and it worked for me.
> Can we have that integrated into git-p4? What can I do to make it
> happen?

A patch would be very welcome!

See Documentation/SubmittingPatches for details, but it's likely
enough to just make the change, and then use git format-patch and git
send-email.

Please ensure you add a "Signed-off-by" (git commit -s).

Thanks!
Luke


>
> On Wed, Jan 29, 2020 at 1:35 PM Luke Diamand <luke@diamand.org> wrote:
> >
> > On Tue, 7 Jan 2020 at 15:53, Ivan Selin <ivan.selin@toptal.com> wrote:
> > >
> > > Hello!
> > >
> > > If I create a perforce client from java using p4java, it gets created
> > > with an extra key "ViewDepotType" in client definition. When I try to
> > > do `git p4 sync --use-client-spec`, git-p4 dies with message like
> > > "Expected view key View1 missing" =E2=80=94 because it assumes that a=
ll keys
> > > starting with "View" are "View0", "View1" and so on.
> > >
> > > How to reproduce:
> > > 1) Create perforce repository;
> > > 2) Create a perforce client (let's name it "my-client") in said
> > > perforce repository using p4java; add one view mapping to the client
> > > on creation;
> > > 3) Run `P4CLIENT=3Dmy-client git p4 sync --use-client-spec`;
> > > 4) git p4 finishes with error "Expected view key View1 missing".
> > >
> > > Attaching hexdumped/unmarshalled examples of "regular" client
> > > definition and client created with p4java. Note that p4java's version
> > > has "ViewDepotType" key and regular client does not. Also,
> > > "ViewDepotType" key is not showing up in text output of `p4 client
> > > -o`, only in binary format (`p4 -G client -o`). And I'm attaching a
> > > patch that solved the issue for me.
> > >
> > > Is that information enough or should I add anything else? I'm new to
> > > git community, but willing to help.
> >
> > I suspect the problem lies at around line 4220 of git-p4, where it does=
 this:
> >
> >      view_keys =3D [ k for k in entry.keys() if k.startswith("View") ]
> >
> > I think changing that startswith to a regex match would fix this,
> > although I have not tried it.
> > Something like:
> >
> > is_view =3D re.compile(r'^View\d+$')
> > view_keys =3D [ k for k in entry.keys() if is_view.match(k) ]
> >
> >
> > >
> > > Regards,
> > > Ivan.
