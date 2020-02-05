Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F11C35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 20:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF3020720
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 20:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwDmuT9n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgBEUOT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 15:14:19 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36913 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbgBEUOT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 15:14:19 -0500
Received: by mail-pj1-f67.google.com with SMTP id m13so1479917pjb.2
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 12:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tZX9DaRiC0YXo0I4aFoD/zXoxoomKNXCkKixVkAzHJM=;
        b=UwDmuT9n75twK/jwBQ1Z3g2Um+Plmx+Bt0zSkfKeBBAXcdZLZmLUfOFpjzjkU+9Z0l
         f3pumQqeDvCYxRpuAhlJBvw4Eivdcdw2k7XWMhdxs2xugwkXusR6+r3RnixooY45hpdc
         tL4K6YS2cHYqd4sltjoJ3SJQ49RxaC1yYdu0cMIF8nH5Lqw7+HuLJ+amHbpCjQ8DEL8f
         bnatTdQJQvXcyGladH8a8ELwe0G9mtRBLGeOnE4Vr//qKeEZqb4ezSPlstGZdPZqskAl
         RjITU6s2/JNJjD0OOuxwEPctlCRbMJI7HZz1xqpg6YZbb93b9OTvintBIa48CqOjQ9oj
         Gm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tZX9DaRiC0YXo0I4aFoD/zXoxoomKNXCkKixVkAzHJM=;
        b=pjZC8o1PTXqgCr2FcdHmKiSoYj1ePLaoz3PXIBvSacZ/fCj4RRABoV4DfnYaaijL7o
         Gv7k6I5wmn+PQSLNvRgDRm7J1vvm2h7irtofn4WUVvvfhBW6hmmCALFJqDfb1OFbAzS3
         yMBgOAK00oecWb/hD2qJ+xwyAecxeQZzWN7yC9OFHFO1xUERaHhrZzxApaeEGAfY/K5/
         Rf5tYL8vpexExZfJuR29umPlTo38dN/Hd5Zy1ikdQ7p8lThNMDA8VVp1o7FAw3/Le+e4
         10fJb2qjBwWfygBFApZYqwIXXEw0oqMgIcc2vbdtRB8tNvULzdARt3iYCz9ourcOVIYc
         14DQ==
X-Gm-Message-State: APjAAAWZuiWYeZJtuclYJ5QWb9CnhagGU8Mz9GPp4VvPMszjLgYBfty/
        PcjmZZM6vvgeYjkoRWNs5b4qtBCbpnVnzSladbQ=
X-Google-Smtp-Source: APXvYqz1BxiRVRpbGkSK4hxEZ7VmAv4FXdPPYLlH+64sBIr5mvhZ2HhrvYFgKFPn6hBkm6gxdVHNbSyIWC8ib3cBGlM=
X-Received: by 2002:a17:902:8341:: with SMTP id z1mr35800766pln.178.1580933659082;
 Wed, 05 Feb 2020 12:14:19 -0800 (PST)
MIME-Version: 1.0
References: <20200124033436.81097-1-emilyshaffer@google.com>
 <20200124033436.81097-9-emilyshaffer@google.com> <CAN0heSq9AdF_WPmSkxDA3cPzOQBAbuw4oa+8azvLtjbP-jQfKw@mail.gmail.com>
 <xmqqmu9w6bop.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqmu9w6bop.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 5 Feb 2020 21:14:07 +0100
Message-ID: <CAN0heSpXcuBRjQvAwPpS6bM7gBs1LQQZggJBEgLOGCXM6GSrqQ@mail.gmail.com>
Subject: Re: [PATCH v5 08/15] bugreport: include user interactive shell
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 5 Feb 2020 at 21:06, Junio C Hamano <gitster@pobox.com> wrote:
>
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
> > On Fri, 24 Jan 2020 at 04:41, <emilyshaffer@google.com> wrote:
> >> +       char *shell =3D NULL;
> >
> > (Unnecessary initialization.)
> >
> >> +       shell =3D getenv("SHELL");
> >> +       strbuf_addf(sys_info, "$SHELL (typically, interactive shell): =
%s\n",
> >> +                   shell ? shell : "(NULL)");
> >
> > Thanks for avoiding a classic pitfall. :-)
> >
> > "<unused>" instead of "(NULL)"? "NULL" is mostly an implementation
> > detail.
>
> Isn't that <unset>?

Heh, yes, "SHELL: unused" sounds wrong. :-)

Martin
