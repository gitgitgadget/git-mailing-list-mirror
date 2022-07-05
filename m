Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01149C43334
	for <git@archiver.kernel.org>; Tue,  5 Jul 2022 13:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbiGENp3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jul 2022 09:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbiGENpG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jul 2022 09:45:06 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB642CDDF
        for <git@vger.kernel.org>; Tue,  5 Jul 2022 06:08:59 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id r9so14434864ljp.9
        for <git@vger.kernel.org>; Tue, 05 Jul 2022 06:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z7mGEYy3aR/XDXfhCr3rdzo4Ni7gbxZjspUjiux+cLk=;
        b=qTMBFmd+/IFSYZ0KtzHP0xIv5vCGQe56F1i6mOdxLHmHqEghI8vy21ro3z7WvIxYUJ
         W7t+qKY2eJjWip7WKBcmp8jDIFkkoysWVAXrcpJ52mleR/MGFqTvXtySyqGbBfoq5hNq
         QVNNycdcpLK6csryYDmUJd2xN2hbfvYUx+tcamYqcF+aisEf+HV9Wdd+rznCtZOIllNU
         ODIDhBSIUNp4k9DPasRjL8tObVvEL4w6VRjiS5oPw1d+LdMvdXQrgxK2vx7tA7Rhtq9C
         NO5zIqz6XCZv8CYJWGlnHnhY2YT+d044oRDMHYCTk+PHyhZYCpS0KMemvCKEMOSk+D3t
         HA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z7mGEYy3aR/XDXfhCr3rdzo4Ni7gbxZjspUjiux+cLk=;
        b=FdNB5JlXSLiayOD2i5DjyzDmQsiqx1wTEl2OS9AzZzanqsKDk/8CbO6/8qAU/ivM9L
         o1yy26hzgwMLMVqNRBv1bJU608rAX7rGAEQI3/4yZ/4pDP8cS50jKXs3/pX22WSA94/U
         z68GXgX1ICt7tq2mrIWnHqPH59Kq01IRXxfJOEmI83eIQamgbzYZRPnKqEUHubtCaC4P
         RL3j0XV35Viz2kmAoxGnQV3woiwQgTbfn9X2bdje7uGrsErpAVCgQ1QIGgbzXQS1Nj4m
         AYlt4j6npApi0tW8AGfaTTYdvjNhVAlHQUSk2yg6YGSGG6iQ9dD2fzIDM3m2n1T9yAtu
         E3Jw==
X-Gm-Message-State: AJIora8/Z923C8MJKwlfHSaGy/5nS6ynu3ByFxTzJEh8aEISmHjgt7Ht
        qovmevJU4Vvke3+B3XiDi8BwxhgMO2vTxk+KY5Y=
X-Google-Smtp-Source: AGRyM1swknLmqM/qzNY190+ez0O70p8oDLSaTo6Imd3+msSlByuS7xsdk/NLWYWmQPMZnXQw56wSY7NQ4k0c/BFx0YY=
X-Received: by 2002:a2e:8558:0:b0:25a:a2f3:b69b with SMTP id
 u24-20020a2e8558000000b0025aa2f3b69bmr18921308ljj.24.1657026537695; Tue, 05
 Jul 2022 06:08:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAKSRnEzMaQEv=3mkNWRpy6+-c0rz=R191iqheCQ2ptXFs1CQgw@mail.gmail.com>
 <96034b3f-9811-38c1-7afe-c1c9dd243f0e@github.com> <CABPp-BHv3TSJhnWSF8AjF_nr72vMnOFXZJKoG0juGwjz13TZ=w@mail.gmail.com>
 <c5662c60-4a21-be94-8fe0-13c6730292dd@github.com> <CABPp-BFRHjF7+9T8dGG=ixsezksZUNU7pm29MG2kcLEYwE06Og@mail.gmail.com>
 <CAKSRnEx2seC41QCe8sQOPf0=VNqHB6GkZ3M_CpGmOZRS0FS1gA@mail.gmail.com>
 <CABPp-BHgwaWNEJnSer0-jw8+53NDuRWLvtXp4U_JJ8T_t-bTpQ@mail.gmail.com> <CAMwyc-Q7dEwo7AzFTYXrX-0i+b80ikzv_MCzTr7ZKaCPKwcERw@mail.gmail.com>
In-Reply-To: <CAMwyc-Q7dEwo7AzFTYXrX-0i+b80ikzv_MCzTr7ZKaCPKwcERw@mail.gmail.com>
From:   Dian Xu <dianxudev@gmail.com>
Date:   Tue, 5 Jul 2022 09:08:46 -0400
Message-ID: <CAKSRnEwda+WomBQbvjZ+hry+k2vGO4ukR42f66tHqxO7LdU_sA@mail.gmail.com>
Subject: Re: git bug report: 'git add' hangs in a large repo which has
 sparse-checkout file with large number of patterns in it
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Elijah Newren <newren@gmail.com>, Victoria Dye <vdye@github.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

Please see answers below:

1.  H: 2.27m; S: 7.7k; Total: 2.28m

2.  Sure I will run 'reapply' after the sparse-checkout file has
changed. Just curious, do I have to run 'reapply' if 'checkout' is the
next immediate cmd? I thought 'checkout' does the updating index as
well

3.  I simply added one file only, 'git add' and 'git add --sparse'
still hang. Let me know if you need me to send you any debug info from
pathspec.c/dir.c

4.  Good to know and we are investigating if we have a way out from --no-co=
ne

5.  I should've been clearer: The experiment done here uses 2.37.0

Thanks,

Dian Xu
Mathworks, Inc
1 Lakeside Campus Drive, Natick, MA 01760
508-647-3583

On Mon, Jul 4, 2022 at 3:12 PM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> On Fri, 1 Jul 2022 at 17:53, Elijah Newren <newren@gmail.com> wrote:
> > > (Btw our company=E2=80=99s email mathworks.com is blocked by
> > > mailto:git@vger.kernel.org, hope someone can help take a look)
> >
> > Konstantin: Is this something you know how to look into?  (Or do you
> > know who to ask?)
>
> Unfortunately, I'm not in charge of vger -- it's historically managed
> by volunteers outside of LF.
> You should reach out to postmaster@vger.kernel.org.
>
> Best regards,
> -Konstantin
