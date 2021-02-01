Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E58C433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 07:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFE8264E2F
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 07:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbhBAHaC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 02:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbhBAHaA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 02:30:00 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DACCC061573
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 23:29:20 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id d1so15325249otl.13
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 23:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ud2+hmDiVzfv7ErbfRqnma920SBcNqDdeWjl6fziBks=;
        b=VSULfXWOmNWFNjOY22Wj1yFpYfINHEmE3iCQyLeIBsBMc3ik2CBam4NzThLop/RQAd
         A81L4aU2zj/xe9oLOANjgmka4tz5V5sB8BNfm1G7bWFSx/j8TSPaf61n7N3oNbfd5+5V
         AwFenzxxaM5a45w3hy3LKfyS7X8oN+bs4JaOveJn8qfV6/JpEcxHiBSF82hxcLUAJi9h
         HvbM3sewHSqkjeE7MsKbf+ExLkxB+BMODL3aLU9DxrpqN0BbmSf8Mvs4rjZ5PPSHRzVV
         upz7hm81lS/RApvhLI5F+fCseynGZIQtZAn3fsMjj7K1vlAbogb3vum6IV2jWJ72/MCN
         YOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ud2+hmDiVzfv7ErbfRqnma920SBcNqDdeWjl6fziBks=;
        b=MgoaWaNFMFxLBwTAf/CPhvDrUPeI1sJ0DwTe/cJc7qkGH7rVHT+vUpaTHo3aTgjnxW
         6QShO/T3IoYnUxLU6R14fIJZQMIXCXJRbVYgCPE8xQppuIaLgXvAwbaBDWzndEDubeAg
         +Gg79WburDEL7Azx0K5iM0V+73bCUHbN5LF1gzrqSPDFIkkxLRL1UdTqgip72C8ckmd5
         CSNUXwL7YyodXmYU/8ubdpIz5MKyvjVo+WyQ+/cTNyM01mbDS05d9r7LkYEiqLyQp5qB
         hY9PJdBqQB70jPq7YfQVUSFe1WNOsq08HYKJgFJNJmNSbRkMC4J7CGLijJxzEfgyoywm
         L3pg==
X-Gm-Message-State: AOAM533zyjGU6kRq+UUaC5l5z49brq2LlmzN2zB2uMHt8CaO36db5NYf
        9QMowHY2pTAhJ80mDRDaMVo/kehp2mfXJ/Zmivs=
X-Google-Smtp-Source: ABdhPJy0TUHb5y6wbg6yoOJh5HWnuW9TP77IpD4SiFVD15UeX2w+HRwYEOqmz+9qv7fPG/kqox0jaevug1hOCby2grM=
X-Received: by 2002:a9d:21ca:: with SMTP id s68mr6649557otb.164.1612164559504;
 Sun, 31 Jan 2021 23:29:19 -0800 (PST)
MIME-Version: 1.0
References: <CAGP6POKSOaaq0A-L2RgQ+R+bJVo-KuZChEOcCuO8jP+Cm9QFPw@mail.gmail.com>
 <CAOLTT8SsmzNNvQHaP3+vQmuq0fdRbFNL8ukOvPW5Zw9+nPk32Q@mail.gmail.com> <CAGP6POKB1b=gCjd-rNCYrJKcp8bmRP_cpwAPi81udh61ZdZJzA@mail.gmail.com>
In-Reply-To: <CAGP6POKB1b=gCjd-rNCYrJKcp8bmRP_cpwAPi81udh61ZdZJzA@mail.gmail.com>
From:   =?UTF-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Date:   Mon, 1 Feb 2021 15:31:22 +0800
Message-ID: <CAOLTT8ScAgJFo8UxzXvVCX7ojk5fpc6eYxuUg-gJr=--LOzujw@mail.gmail.com>
Subject: Re: Recover a git repo after accidentally deleting some hash files
 located under .git/objects.
To:     Hongyi Zhao <hongyi.zhao@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

oh,I am using Konversation,it's a good irc client.
You can also use weechat in terminal.
And http://quhno.internetstrahlen.de/Vivaldi/freenode-help.html
may have many helpful usages for you to learn irc command.

=E8=AF=B4=E5=8F=A5=E4=B8=AD=E6=96=87=E6=B4=BB=E8=B7=83=E4=B8=8B=E6=B0=94=E6=
=B0=9B :=EF=BC=89

Hongyi Zhao <hongyi.zhao@gmail.com> =E4=BA=8E2021=E5=B9=B42=E6=9C=881=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=883:01=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Feb 1, 2021 at 1:54 PM =E8=83=A1=E5=93=B2=E5=AE=81 <adlternative@=
gmail.com> wrote:
> >
> > Hi=EF=BC=8CI don't think so unless you have the commit
> >  in github or gitlab which include this file=EF=BC=8C
> > maybe you can use git pull to get it.
> > By the way ,you can ask questions in irc chatroom #git or #git-devel.
> > There will be a good place to get help.
>
> Thanks a lot for your suggestion. BTW, what's IRC client and server
> used by you normally?
>
> > --
> > adlternative
> >
> > Hongyi Zhao <hongyi.zhao@gmail.com> =E4=BA=8E2021=E5=B9=B42=E6=9C=881=
=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=8810:16=E5=86=99=E9=81=93=EF=BC=
=9A
> > >
> > > Hi,
> > >
> > > I accidentally deleted some hash files located under the project's
> > > .git/objects subdirectory. In this case, can I resume the project?
> > >
> > > Regards
> > > --
> > > Assoc. Prof. Hongyi Zhao <hongyi.zhao@gmail.com>
> > > Theory and Simulation of Materials
> > > Hebei Polytechnic University of Science and Technology engineering
> > > NO. 552 North Gangtie Road, Xingtai, China
>
>
>
> --
> Assoc. Prof. Hongyi Zhao <hongyi.zhao@gmail.com>
> Theory and Simulation of Materials
> Hebei Polytechnic University of Science and Technology engineering
> NO. 552 North Gangtie Road, Xingtai, China
