Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF14C77B72
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 05:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjDPF2r (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Apr 2023 01:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjDPF2p (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2023 01:28:45 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A76D1BF
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 22:28:44 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4ec8143400aso746790e87.0
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 22:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681622922; x=1684214922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4Wp/aFXzqzjXYG4uiLNGS+Q9se/nDEjx7apcU1Wr8M=;
        b=bijUd2QBv/I+jBZ/ltcgut00lZRVV+4J+9hPECvxrLTu5C3XMq+vnZQRoTwvVpoZaQ
         SG07CfWz7podClhMD1ljswlyHcwyrcUerzyB5t5Ld+HNt6PIm+G476Zg+awuP3QmqHhT
         MDMKYgwreTfs49QOFpJojoJH69kZQeU7p8o/fYey+OgqmtDA2TmWJEXWAHoUAdno3gTg
         2dAMdv62VpWibTPIHWDhhfkuQALB3iZ1xZc+XlPazl2604EKCI8LdO6FGzdW3kgS9aF6
         cus/Smq81mOpbEB6/YhAbXEE0B0vY1QI63Rwac5f2ljI9IGB/ETd1mxwXn0qR7ZWdRtL
         9bhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681622922; x=1684214922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4Wp/aFXzqzjXYG4uiLNGS+Q9se/nDEjx7apcU1Wr8M=;
        b=ha8IR3v7cAbTM/icVgmiRfqHNCxWmHd5RLgrNBqXBn+af8/3is+kU09Nr7BY2fyyZk
         9cXyq4zk+LQrHj28MJofsTR44Pqf5awA3UzfIXmwd8TGKlrgsnwQCfzEY0na7ffUGVot
         zMLaahodA4tAfhffZfQeoJsacvyjh977kvRISeZhsZ5qC0R8N/C+9Ue0Pm+NV4FNlaWV
         HWz91tsyNngz3Kob8CDXmReMQHOUoj344c+pEMDE/3V3L+3AUEiEpIqO5JKnnp+S6SaN
         4cJVfRlXXY6xTWwMAbJxAceIGbFYAPUYxNk7+W9qqXky3rZpBodj3nod96ylAxfN7POW
         v7gQ==
X-Gm-Message-State: AAQBX9fKlwY0844YPbShER34tow9A5ZWYpvYCa0qRu/kkNzouxOT8cl7
        q6JGZm3d3N9SEbaFUWJmpA8oJqI8Thy/jLEd1eA=
X-Google-Smtp-Source: AKy350YyhrLWDjNjmUvO5egYYU0QnSgFgWYxCbUCPHuzKgxyxqG/qn93PgpXAQ6cdS66YzEeZw0m/7+REmCIEySgbig=
X-Received: by 2002:a19:f80a:0:b0:4ea:fa15:5bce with SMTP id
 a10-20020a19f80a000000b004eafa155bcemr1101062lff.7.1681622922217; Sat, 15 Apr
 2023 22:28:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230407072415.1360068-1-christian.couder@gmail.com>
 <20230407072415.1360068-12-christian.couder@gmail.com> <8daf2603-2818-9c9d-7a06-6af2872a045a@github.com>
 <89c78da5-388a-e52b-b20b-e376ac90de14@github.com> <CABPp-BGfG3VeY1gOugzig8PLan1AS66BMWnyFSOsLOy-zqLdXw@mail.gmail.com>
In-Reply-To: <CABPp-BGfG3VeY1gOugzig8PLan1AS66BMWnyFSOsLOy-zqLdXw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 15 Apr 2023 22:28:29 -0700
Message-ID: <CABPp-BHeQpOwit742hVn5eMdeX3WUPCBg7JNhOKjdJsFQbZOdQ@mail.gmail.com>
Subject: Re: [PATCH 11/14] replay: use standard revision ranges
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 15, 2023 at 12:07=E2=80=AFPM Elijah Newren <newren@gmail.com> w=
rote:
<snip>
> > What happens if they add an --author filter?
>
> git fast-export accepts full revision ranges, including ones that make
> no sense like this.  We could add patches to exclude such options, to
> both replay and fast-export.  Or just document that they make no
> sense.
>
> To answer the question as asked, though, let me first provide a little
> background: for a commit A with parent B, git-replay checks whether
> the parent of the current commit (i.e. for A that'd be B) has been
> replayed (as B').  If so, it will make the parent of A' be B'.  If
> there is no B' (e.g. because B was part of "upstream" and thus wasn't
> replayed), it makes the parent of A' be whatever is passed to --onto.
> This allows git-replay to not only rebase/replay a linear set of
> patches, but a partially or even fully divergent set of branches.

A small clarification, which only matters to future work and not this
particular series: the above description where ONTO is the fallback
for a lack of B', is for first parent only.  For a second (or later)
parent of A, which we'll refer to as C, if C has not been replayed as
part of this operation, then we simply use the unmodified C as the
second (or later) parent of A'.
