Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBFAC71153
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 20:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240505AbjH2UjF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 16:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240546AbjH2UjB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 16:39:01 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D4EFD
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 13:38:59 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52a3aa99bcdso6735633a12.0
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 13:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693341538; x=1693946338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGg3Cj3dNS6BI2nE1a4i2IdIgtc8GPVCNHJOwXXZsH4=;
        b=LCJjnVNvlGVVvjKiE9sAqGOmPAnbwnYWXkmLs7l544ZqwHXwlX5SVtAU2O771Fdj+e
         Driv5UJYtSgtrjr8fRdrmy+htt7JUGVyuxsRFpR1wqHWPj7j3DDaJqhMdi5EqNit+jCP
         w8rqMUWOBVcOliXUe0JTohVZ+LY1mOM8jim7uojDfioIz4v4moAzTimn7PqZieOUfsi+
         HpQTaxXA0GiXDh0SfIIF4tcJFbpHS8phYEd6FDI6geDAmOSdjSEe9Idn+btOjnJ0JTx0
         OjRB64o22aW3IrWd0Fyan3wKm52M8mxNCTFuVNmmvsKBB5Nxmr+o5PsGjMiBICjUFRTo
         rmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693341538; x=1693946338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGg3Cj3dNS6BI2nE1a4i2IdIgtc8GPVCNHJOwXXZsH4=;
        b=X8qYYjZfJR4zNn7PS6lEaFkstcrcmVxYYcpiUZryqkhLsRZE74kCAnxTti3P016J3y
         eun4UWDcPr1kB/tXL2e82j3C1WqbsAsIx1DREhFfAgKJktRQ5SCxg54zFo6CsPHyia5g
         E3mPipNsVKsiN8CdPIHtT4wYa73iYLJjgjBCkeD23jM3xcirmFjsRQpNA9iLx+meDyPC
         7ZY2eCoZFhyJnz+dQLNo540zPOvLaWiv12+0v7sCHUzZ4baKBKL7PjdMf25rF3RSNP8G
         JMtihQcNYHfzRnggAEPApn5iaS6Pg8gpepu7OOx3P+9lJ15i+Bu3XAEoAGZlobKFyVts
         kfDQ==
X-Gm-Message-State: AOJu0YykyWpvSUu8rqoToTklLEc0JOCFXA/TdQtshmqh969lI0ecuWYN
        AqpuyjHbrA/+jJ74g7ashJ7kfnzKoAzuzo1vv2E=
X-Google-Smtp-Source: AGHT+IFA5ahDhVpq6CVA8FRXYOQh/bOnVc8X7yXBvn2CBy9U7raVEdNB1pt82iWWJMXEdAiMLh/cbS1EmrsDVVbY6XM=
X-Received: by 2002:a05:6402:1a59:b0:51e:5322:a642 with SMTP id
 bf25-20020a0564021a5900b0051e5322a642mr272061edb.27.1693341537611; Tue, 29
 Aug 2023 13:38:57 -0700 (PDT)
MIME-Version: 1.0
References: <ZNwhVOggObU7aVTr@nand.local> <CAP8UFD2Yw1XazomxEj0QB20FoaxkO16t_xgRurtnqCCOuhX-eQ@mail.gmail.com>
 <2c31a3d4-59f7-d036-0c6b-5fd62cc7a2fa@gmail.com> <ZOZSo7vJztHcvb4W@nand.local>
 <435a2aa3-59f8-d2bc-f653-4f93d86b9c31@gmail.com> <ZO4wxU1ilpa6/3EW@nand.local>
In-Reply-To: <ZO4wxU1ilpa6/3EW@nand.local>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 29 Aug 2023 22:38:45 +0200
Message-ID: <CAP8UFD2CGf8efBHquS=LJP8uQ5ivuDryqGz96PZ81oDtrNgNXw@mail.gmail.com>
Subject: Re: Git in Outreachy? (December, 2023)
To:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     git@vger.kernel.org, Hariom verma <hariom18599@gmail.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 29, 2023 at 7:54=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Tue, Aug 29, 2023 at 11:14:38PM +0530, Kaartic Sivaraam wrote:
> > BTW, I think the deadline to sign up for Outreachy is approaching soon =
I
> > believe. The community page [1] seems to indicate that we haven't signe=
d up
> > yet. Given that there was an interest in us participating in Outreachy,=
 I
> > just wanted to check whether we've signed up our community ?
>
> Indeed. I was waiting to see if interested parties had the resources to
> sponsor an Outreachy student, since we have to pay Outreachy for each
> student we accept.

It will take some time before I can confirm whether or not GitLab is
willing to sponsor one Outreachy intern.

> If you (or others) are interested in mentoring but don't have a way to
> pay Outreachy, we could certainly discuss allocating some of the
> project's funds to support one or two students.

I clicked on the "Community will participate" button, but this leads
to a page saying "Outreachy internship funding is required" and where
we have to list the sponsors we have, the amount of funds they are
willing to sponsor, if the funding is secured and the funding decision
date. I think I will fill this out saying that we have 3 (potential)
sponsors: the Git project, GitHub and GitLab. I will not check the
"funding is secured" checkbox and say that the decision date is
October 5 (so just one day before the deadline for "Project list
finalized"). This will leave time to find out if we can indeed sponsor
at least one intern.

Let me know if that works for both of you.

By the way, Kaartic, do you still want to be an org admin? And Taylor
are you Ok with Kaartic being an org admin?

It seems that I received an email asking me to confirm Kaartic as an
org admin, but I couldn't confirm then and later when clicked to the
link to confirm it looked like it wasn't possible anymore to confirm
that. So not sure what happened, but maybe we could try again to
register you as an org admin.

Best,
Christian.
