Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8300CC76196
	for <git@archiver.kernel.org>; Fri, 31 Mar 2023 20:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjCaUit (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 16:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbjCaUis (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 16:38:48 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DB31D86D
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 13:38:44 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id i6so28853380ybu.8
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 13:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680295124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYxdxbSuSv/eo7w2uj9GkU0lBTrS6VWQgCxqY+6sQ4w=;
        b=dQAc5SrPdkTNBJVPQcp+8QBQDa2SjE0SN2HwxXzlH7ccZcxpWcRiUZGjGrGfWiM4DU
         MGfSX4cPOKDEZpAxGHR7s4RNZ7yiwrKAMX0pKA4lvcjVn0R3csE653vVVsJUa1u7krtW
         SP2kZMF5/6qlHXOMb0kf2DkOyQBx7WIX0NgLs2v0mlJ+0E5YdQTI+Aog7vyd/8VDB5oD
         KVkwimtcLfdPf87ooJI5xRpZWNe+eohCvZ4is6xAjLnBmZsUdXrav5+G5chRhvnbeoOD
         Lt+cBMXgPoySc5hA1AZkqgaoSbnq1Xm0TFNiRThuhU72jX0PGtv3S8Z/4LQ9v1TwhTX/
         lOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680295124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYxdxbSuSv/eo7w2uj9GkU0lBTrS6VWQgCxqY+6sQ4w=;
        b=Px1nqfPRJyij4DXPjcqN3AqSGpAV2hHIuKYsG7mULAbAze9O5s+bjMor4Uk4ScKDZa
         B1qaFc2zLLq7eFjKPYCd/BU9Oe16547giCy2CoaFQlqAxIjCs0AyTPNwc7iFR0kax27y
         64TG3R2v1DQlsUZtfp0KngfKekF781oNXpDwwhV2AbnYz5tFpJnv2Z1u3MZ3JTbFFZO7
         59pvkScGXDlddt9lqmDMy9bbRlgKUqfoI6e+zWsiY3J/MKrNY5eldMRpyFP5aZhiDzHb
         Vd7KKBz2koeGXs/MIOlwFvyvhSXF8T1SDalKpD7/6R6nbvRdsYTLzw4gFNSL7/WDFOZw
         6/5Q==
X-Gm-Message-State: AAQBX9fubr9GZPDFIcL7710wU4iFK+z54OGRF81H3chVbdWJy0FZOqsm
        FOqsRoyyxcMkQPKD7Ei1kj03eHCwnMp4QJN73z162lAQ04BJrg==
X-Google-Smtp-Source: AKy350bHBxD9c99U7gBRgRj3JmK9xOxc9vdeSF1AEKTYCPH/DZdCSc4oDlLkjw2NXpzBJQ/LcyrsMqg+FCGZTfdxLNs=
X-Received: by 2002:a25:d0d0:0:b0:b6e:b924:b96f with SMTP id
 h199-20020a25d0d0000000b00b6eb924b96fmr6925769ybg.3.1680295123617; Fri, 31
 Mar 2023 13:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230330172052.10680-1-five231003@gmail.com>
In-Reply-To: <20230330172052.10680-1-five231003@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 31 Mar 2023 22:38:31 +0200
Message-ID: <CAP8UFD2Rq3Mh=X_g3_etHOje=G5hYgsFMO=6MuzgXUsysC+79A@mail.gmail.com>
Subject: Re: [GSoC][Proposal] Unify ref-filter formats with other --pretty formats
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     git@vger.kernel.org, hariom18599@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Mar 30, 2023 at 7:21=E2=80=AFPM Kousik Sanagavarapu
<five231003@gmail.com> wrote:
>
> This proposal can also be read at
> https://docs.google.com/document/d/1JBznA5n0WdWsbEskCeXxOnQuaa0urD89Vtprx=
stLPzo/edit?usp=3Dsharing

Thanks for your proposal!

[...]

> Pre GSoC
> =3D=3D=3D=3D=3D=3D=3D=3D
> I first got into Git=E2=80=99s source code around October, 2022 and have =
been
> going through code of topics that I found interesting whenever I had
> some time away from my college work. The following are the patches that
> I submitted, from earliest to the latest:

Thanks for these patches!

[...]

> Previous Work
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> There has been much work done in the past in this area. It majorly comes
> from previous Outreachy interns and GSoC students.
>
> Olga Telezhnaia <olyatelezhnaya@gmail.com> did work in this area in the
> fields of `cat-file` and `ref-filter` as a part of her Outreachy Internsh=
ip
> titled =E2=80=9CUnifying Git=E2=80=99s format languages=E2=80=9D. This wo=
rk and also the work done
> after that helped take ref-filter to a more general setting. She blogged
> about her work here
>
> https://medium.com/@olyatelezhnaya
>
>
> Hariom Verma <hariom18599@gmail.com> did work in this area as his GSoC
> project titled =E2=80=9CUnify ref-filter formats with other --pretty form=
ats=E2=80=9D.
> This is the major work done in this area and the final report can be
> read at
>
> https://harry-hov.github.io/blogs/posts/the-final-report
>
> This work is very useful as this serves as a kind of documentation
> and starting point to work towards the goal.
>
> ZheNing Hu <adlternative@gmail.com> has done major work under his GSoC
> project titled =E2=80=9CUse ref-filter formats in git cat-file=E2=80=9D i=
n the area of
> git cat-file, but more relevant to this project are the changes done to
> ref-filter. This work was a continuation of Olga=E2=80=99s work and made =
some
> changes to ref-filter logic. His final report can be read here
>
> https://github.com/adlternative/adlternative.github.io/blob/gh-pages/blog=
s/gsoc/GSOC-Git-Final-Blog.md
>
> Nsengiyumva Wilberforce <nsengiyumvawilberforce@gmail.com> did work in
> this area as a part of his Outreachy Internship titled =E2=80=9CUnify ref=
-filter
> formats with other --pretty formats=E2=80=9D.

Actually he has been working on this outside of Outreachy (and any
other program) as he didn't fulfill the requirements for being
accepted by Outreachy.

> He got rid of the duplicate
> implementation of the `signature` atom logic.

Even if the end goal is to get rid of duplicate implementations, for
now the ref-filter formats need to have equivalent atoms as what the
pretty formats have. Otherwise it will not be possible to fully
replace pretty formats using ref-filter formats. So for now the goal
of Wilberforce's patch is to add `signature` atoms to the ref-filter
formats.

> This work can be read here
>
> https://lore.kernel.org/git/20230311210607.64927-1-nsengiyumvawilberforce=
@gmail.com/
>
> Difficulties
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> A major difficulty is backward compatibility, so any changes made to
> remove the duplicated logic would need to be done so very carefully.
> Any new tests added must also be very precise so as to efficiently
> test the changes that are made.
>
> There are also minor difficulties, such as the older tests failing
> because of the changes made, so the work will have to be in such a way
> that those tests are successful and the duplicated logic is refactored.
>
> The Plan
> =3D=3D=3D=3D=3D=3D=3D=3D
> I think Hariom=E2=80=99s final report of his GSoC project is a good start=
ing
> point for working on the project. The report lists the work which is
> left in the =E2=80=9CWHATS LEFT?=E2=80=9D section, so I think the first i=
ssue to work
> on would be to look into why =E2=80=9CAround 30% of the log tests are fai=
ling=E2=80=9D
> and to work in the area of mbox/email formatting for commits. Work can
> also be done to make pretty handle unknown formatting options.

More details about these would be nice.

> From here, I can work on the remaining portion of the formats

Here too.

> and can
> remove the duplicated logic wherever possible, also writing tests to
> ensure that everything works.
>
> I can take the approach similar to what Hariom did before this.

Could you give more details about what Hariom did that you would also
like to do?

> Estimated Timeline
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Misc
> April 5 to May 3
> - Continue to work on git and get more familiar with the code.
>
> - Find and fix stuff.
>
> - Work on stuff that interests me.
>
> Community Bonding
> May 4 to May 28
> - Get myself familiar with the code of ref-filter.{c, h} and
>   pretty.{c, h}.
>
> - Communicate with my mentors about the approaches that can
>   be taken to get to the goal.
>
> - Working on Hariom=E2=80=99s branches (mentioned in his final report)
>   and making changes on top of them.

Can you give links to these branches and tell a bit about the changes
you would like to make on top of each one?

Best,
Christian.
