Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6E6C433EF
	for <git@archiver.kernel.org>; Mon,  4 Jul 2022 19:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbiGDTML (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jul 2022 15:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234597AbiGDTMK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jul 2022 15:12:10 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B931E4
        for <git@vger.kernel.org>; Mon,  4 Jul 2022 12:12:09 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id b125so7297526qkg.11
        for <git@vger.kernel.org>; Mon, 04 Jul 2022 12:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IZ6XZI/tq21o3DBPDcJMBPOHrNHJgA+z1TGfVn04eF8=;
        b=Wa98/uKHy+MxFe+jq0QUu0HRsL58M6p2Pnn7+VndIdo0utoEfmK2iCUqpzqztF4I1D
         4EoYsVyz4Vct/byjHW2ubl+GUnbOAWf0AuaRn/86UibodiFzdUEEfBvSEu1nvIrzrP6b
         UtQKqLfVdqlLb6VPkT09b8p8og3SRwrUPVqag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IZ6XZI/tq21o3DBPDcJMBPOHrNHJgA+z1TGfVn04eF8=;
        b=QOs3Wt3GEsDyHOVhaQ9Y7MNYyQlKE33Dis5PG5FuFgPC+OqyuGa5T5QnNHfnaC6lLL
         F7n+lNQtH5eG5YONcYPRBsR9Eg3YFg72ew3GeYCl52KG3rp2MfcJoddi7TKylHEexI9D
         QyRkMo39JMmWJhstT1O8DKxAT/SR/nrwY8tL/bU33grr02cuzHMLCOsq9BmzIVql4jtI
         tI6x2ZC42e4KnQiCXq5WAlKFPgfAzD472fpqN0J32kzov7npeE/05xJAiijoVppnZZbL
         A606c9FpvSki4Q3d+9z6/LMIUy1NBnbWNusoy9i83B8M8cXv8mUlXZCSHIeDYMjyn4ZM
         9R6w==
X-Gm-Message-State: AJIora9ZqxMOOZnmvIJzcOmDZk+FIEUyQukL3hzM24hYMLyVNquvKY0F
        EijTmoRAi8VlDtYEeGtbRkOou1oxmDtNz2wIQRfhxA==
X-Google-Smtp-Source: AGRyM1vbVwdD54AafgXmag5bkwMs8m+RA88PZEJLrGC26zyXPFwwZFb0a/Xn24+B8fKUwb3XYgm3N+0y+jg0Tz86P4M=
X-Received: by 2002:a05:620a:248b:b0:6af:504d:c1e0 with SMTP id
 i11-20020a05620a248b00b006af504dc1e0mr21253568qkn.750.1656961928461; Mon, 04
 Jul 2022 12:12:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAKSRnEzMaQEv=3mkNWRpy6+-c0rz=R191iqheCQ2ptXFs1CQgw@mail.gmail.com>
 <96034b3f-9811-38c1-7afe-c1c9dd243f0e@github.com> <CABPp-BHv3TSJhnWSF8AjF_nr72vMnOFXZJKoG0juGwjz13TZ=w@mail.gmail.com>
 <c5662c60-4a21-be94-8fe0-13c6730292dd@github.com> <CABPp-BFRHjF7+9T8dGG=ixsezksZUNU7pm29MG2kcLEYwE06Og@mail.gmail.com>
 <CAKSRnEx2seC41QCe8sQOPf0=VNqHB6GkZ3M_CpGmOZRS0FS1gA@mail.gmail.com> <CABPp-BHgwaWNEJnSer0-jw8+53NDuRWLvtXp4U_JJ8T_t-bTpQ@mail.gmail.com>
In-Reply-To: <CABPp-BHgwaWNEJnSer0-jw8+53NDuRWLvtXp4U_JJ8T_t-bTpQ@mail.gmail.com>
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Date:   Mon, 4 Jul 2022 15:11:57 -0400
Message-ID: <CAMwyc-Q7dEwo7AzFTYXrX-0i+b80ikzv_MCzTr7ZKaCPKwcERw@mail.gmail.com>
Subject: Re: git bug report: 'git add' hangs in a large repo which has
 sparse-checkout file with large number of patterns in it
To:     Elijah Newren <newren@gmail.com>
Cc:     Dian Xu <dianxudev@gmail.com>, Victoria Dye <vdye@github.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 1 Jul 2022 at 17:53, Elijah Newren <newren@gmail.com> wrote:
> > (Btw our company=E2=80=99s email mathworks.com is blocked by
> > mailto:git@vger.kernel.org, hope someone can help take a look)
>
> Konstantin: Is this something you know how to look into?  (Or do you
> know who to ask?)

Unfortunately, I'm not in charge of vger -- it's historically managed
by volunteers outside of LF.
You should reach out to postmaster@vger.kernel.org.

Best regards,
-Konstantin
