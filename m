Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65296ECAAD3
	for <git@archiver.kernel.org>; Thu, 15 Sep 2022 07:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiIOHt7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Sep 2022 03:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiIOHt6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2022 03:49:58 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3172717585
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 00:49:57 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id h22so3705712uab.5
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 00:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=mlJg8gVPQv+FSe9+0ecS8xpbF9xrOmL8Rq87fCAi8F8=;
        b=ccSqjNngFR5DanSxfjyBHiz9/FsWCLyIijXXz/3mrjGJgwlYy30Ulmnwwh1qsF/qfm
         xTkZZXOjC2A1yQAZAACE0SASWE1UcbYc6L2A35KJfrNcoZzV6z48nSWb0d6fQtPlg0Dq
         p1k2rqycJ2XfCp3y/JL4fZhvgUm6WD1X6G2UNM/G1f7xcED0YkqPxD0nTRTvSG4AJuMY
         +OhO7FOlkXzVebEo/4WyWfNi9h0iwbrhbFSwWfJAf6qMon05IAagXNTM2a3mt/f2ltWz
         m8LNWC0xoiWpDz8SuFBfniB+HnMl0eFMhXVKSKpSxGFjN1UiyVUYZrS5Nc5AICZWuZW3
         exsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=mlJg8gVPQv+FSe9+0ecS8xpbF9xrOmL8Rq87fCAi8F8=;
        b=V+sP3uRIk7CQwHuly1BCApIISMhl17k+oGhDpH/qcAbv2wLbITDpBzNY7ZfHgIRD0b
         7yRHvI1v5tfOLew8BNX8iU0Gty1lOM4LKwQGAVhAI0G43bolCdtH8xwTqKwyT7WlgIHC
         sNmFmI3KNMBbbh4MWBnmXwr3TZk3emqosOvUr3+i8ZuFjF2oW7VRy5X47Ns+dC72dYqR
         h3GtkNC7/iggfkw6odHvGfz2DNokqLtZHGV+GAZHnfkzTc22jwO4I7dAxUnm2tf5YJ28
         ix7puL1TC47AfmAJUlp0/77sh3t2VqukfrV9fDGlfGMa6fL6rucIJYWj/uaCRdf9cp3Q
         e7gg==
X-Gm-Message-State: ACgBeo3XP3YR///54b1iitX8DOSrUAFZHhrweJRvJkJvu4U2xoGuHkZ4
        6r3IS95cdxx9WTQNIOrYNkj5OvJGW27zpxGZZpnq906h3W8=
X-Google-Smtp-Source: AA6agR5eCNey78pfKx4Nk6Uwreh1tCETsR3pLW3rfFgLi91PSYYtLlN2l/Iuaf82aZhTFEgvd8sLoOLpTV0W+wZfMc4=
X-Received: by 2002:ab0:5711:0:b0:3b5:13e0:23b4 with SMTP id
 s17-20020ab05711000000b003b513e023b4mr11467930uaa.101.1663228196212; Thu, 15
 Sep 2022 00:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <183353220fe.d7826593472673.3445243727369286065@elijahpepe.com>
 <xmqqbkrjb75g.fsf@gitster.g> <18337ea407a.10c144c52599576.4708941661785569426@elijahpepe.com>
 <CAFQ2z_OR8uLe3rs0r09a3fvSQUE2H4WQTquddUwEeahoiRWimA@mail.gmail.com> <18338058407.117ce7158612837.8515739237320978792@elijahpepe.com>
In-Reply-To: <18338058407.117ce7158612837.8515739237320978792@elijahpepe.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 15 Sep 2022 09:49:44 +0200
Message-ID: <CAFQ2z_P0k-VQ0mj4RQquA1SJX8RyY+63s2U2pkEr80+B8O4YXQ@mail.gmail.com>
Subject: Re: [PATCH] reftable: pass pq_entry by address
To:     Elijah Conners <business@elijahpepe.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 13, 2022 at 8:03 PM Elijah Conners <business@elijahpepe.com> wr=
ote:
>
> Han-Wen Nienhuys <hanwen@google.com> writes:
>  > it might be a bit slower, but "dangerous"? How so?
> In this context, dangerous is the wrong word, but in some cases large obj=
ects on the stack can cause stack overflows. In this case, slower is the ri=
ght word here.

I'll let you paint this bikeshed, but do note that the priority queue
isn't actually optimal here, in a much bigger way. In the typical
case, you'd have

1. large base reftable (created by GC)
2. small updates (created by individual ref updates)

When you're iterating, most of the iteration entries will come from
the large base reftable, and only occasionally, you have to get
entries from the small tables.
In this scenario, the current code will insert entries from the large
table into the priority queue, have it filter up to the top at cost
log(number-of-tables), for each of the entries to be read.

With the current online compaction, number-of-tables =3D
log(number-of-refs), so at log(log(number-of-refs)) it's not a huge
cost, but certainly larger than the cost of copying the entry once in
the function.

JGit has an optimization here where it tries to get the next entry
from the table that previously provided the minimum entry. I didn't
implement it for simplicity's sake, but if you care about performance,
you might want to try your hand at that.


--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
