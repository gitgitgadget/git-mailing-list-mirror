Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF8FCA0EC3
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 21:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349306AbjIKVdI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236288AbjIKKLe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 06:11:34 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5290DE5F
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 03:11:29 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-271d9823cacso3397396a91.1
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 03:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694427089; x=1695031889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZlehtkYchqff54qu9lUjxgveDdraBvfk0cjENp75AjM=;
        b=Hl8a+l7SzZlWZQ/N59Iat4rZ30vtFPSjSvVc51MRvOVAAqPIvLZH8FZch8DZkKh1ws
         tmP0AVbPU3uHPF15S7R5FW8jEQAONDMwTApbwVBHbj9k/qL84/FOCnA8MVcx+J3i2qrj
         b8ia2bcSjjzNwzVn8iNlKlUJ+jQHTvYRAqvJp4ROZFqa1Zdq2kj8akC//DAFQmTEBJhy
         TQogCVeAixVzPf+7eiqsH30PmcW78ykuBLtlFajGJqrxLHDLoPkymGqL5BYcDd6IWmOL
         iY7YHq1NGjHVV2Z1on64Q10VT0goLxdGHT0qM7LeHnAa1jLWRXmuvTgBCLX8PYfvLDcp
         eKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694427089; x=1695031889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZlehtkYchqff54qu9lUjxgveDdraBvfk0cjENp75AjM=;
        b=RTybWZUhO6qLTX2ENz8ZmH8tnciGqoAqLyM1omocmk81HpEjZBOLsNcK/00tdOXesE
         tX3TQm3Q4QzyrXHCYz2HVh7+gFsZzThgvJ2T5sXxGuDaHm209t41aKqvmzsSheXwKPFj
         egBPvg2G5saDwgtKTcc6PSJxAayBuVbRO8uqz/susvVndaTXxtSHzE0N7lsiVS/drPCf
         77CuNdsa6Uumv1+cmaWkEkTlZ6Y5kr0nmlJtIz2bgfAFfttHBMuwfIwxbQ0sOoLYlxVk
         JjeDn1HUDtq1Vcul6PmSEjH6v5ZvJnYG45r6px5VZ3Q5o2aAlfCXFTYH9HLwsmueCQN+
         GXoA==
X-Gm-Message-State: AOJu0YwKBbdOOOvEnAffA1JnNXL42YU7wXs7B2tU+MWb3J5XYuK7fwCJ
        KePgPNu4L0cHXuey8hyx/PxCY4iXimujlqNLaCk=
X-Google-Smtp-Source: AGHT+IGW+y3SkKlxTGCf/6jqX99YZMbIuEc2iGuMmXoCbw29G1oNAY8T5hvaGk6MAn3mHwr1LJdneLABidzAhaUNI/k=
X-Received: by 2002:a17:90a:2cc5:b0:26d:1e2d:51a7 with SMTP id
 n63-20020a17090a2cc500b0026d1e2d51a7mr8431848pjd.37.1694427088759; Mon, 11
 Sep 2023 03:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAN47KsV0E+XC2F+TVKXnnJnkATRp7eM7=-ZJFyZcoTz9SJmcHQ@mail.gmail.com>
 <ZP2DaQMA_aFvjQiR@debian.me> <CAN47KsUe=qicr4wZWd33EV+cciUr8ztP2veoOkcw0JBtvsBGjw@mail.gmail.com>
 <ZP4PO+HkbsbuKact@nand.local>
In-Reply-To: <ZP4PO+HkbsbuKact@nand.local>
From:   Max Amelchenko <maxamel2002@gmail.com>
Date:   Mon, 11 Sep 2023 13:11:15 +0300
Message-ID: <CAN47KsX5cpo5oD7PAwAQzjR4oocST6uSkJe2SzAYPxxqy7dGtg@mail.gmail.com>
Subject: Re: [bug] git clone command leaves orphaned ssh process
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
        Hideaki Yoshifuji <hideaki.yoshifuji@miraclelinux.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Maybe it's connected also to the underlying infrastructure? We are
getting this in AWS lambda jobs and we're hitting a system limit of
max processes because of it.
Can you try running this inside this image public.ecr.aws/lambda/python ?

On Sun, Sep 10, 2023 at 9:47=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Sun, Sep 10, 2023 at 12:47:14PM +0300, Max Amelchenko wrote:
> > Output of second ps aux command (after running git clone):
> >
> > bash-4.2# ps aux
> >
> > USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAN=
D
> >
> > root         1  0.0  0.0 715708  5144 pts/0    Ssl+ 09:43   0:00
> > /usr/local/bin/aws-lambda-rie /var/runtime/bootstrap
> >
> > root        14  0.0  0.0 114096  3088 pts/1    Ss   09:43   0:00 bash
> >
> > root       167  0.5  0.0      0     0 pts/1    Z    09:46   0:00 [ssh] =
<defunct>
> >
> > root       168  0.0  0.0 118296  3408 pts/1    R+   09:46   0:00 ps aux
> >
> > See the added ssh defunct process.
>
> Hmm... I wasn't quite able to reproduce this locally. Below
> `git.compile` points to a Git executable built from the v2.40.1 tag
> corresponding to your bug report:
>
>     $ host=3D'ssh://*****@*****lab-prod.server.sim.cloud/terraform/module=
s/aws-eks'
>     $ git.compile clone "$host" /tmp/x
>     Cloning into '/tmp/x'...
>     ssh: Could not resolve hostname *****lab-prod.server.sim.cloud: Name =
or service not known
>     fatal: Could not read from remote repository.
>
>     Please make sure you have the correct access rights
>     and the repository exists.
>
> and then:
>
>     $ ps aux | grep defunct
>     ttaylorr 3688844  0.0  0.0   6340  2180 pts/1    S+   14:45   0:00 gr=
ep --color defunct
>
> Thanks,
> Taylor
