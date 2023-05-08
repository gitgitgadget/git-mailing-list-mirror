Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82F3C77B75
	for <git@archiver.kernel.org>; Mon,  8 May 2023 16:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbjEHQyT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 12:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbjEHQyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 12:54:16 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9555E55B8
        for <git@vger.kernel.org>; Mon,  8 May 2023 09:54:06 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-643aad3bc41so3527675b3a.0
        for <git@vger.kernel.org>; Mon, 08 May 2023 09:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683564846; x=1686156846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pwBaoSBkQtF/HJ0x7fimOBuuFmgcOyFRVy3Z9hhcNw=;
        b=dgyL6JlLcflSFkDK7IF7myacMl55YThux4WqgZEctArOV9Ph1Oh/jlGsq4nDoiEXYn
         XtQ6DUNQwCX6DKufZ9zac0so11otnJIanHdwEjAYHAKmpSGdAdNmBleNB88tF20nRfBL
         8PmIzQ3tSNSP7Hv7a+Prjl6ANTjP2wZbZqRc2LtGJLvY7U7I1qUp+wFjiNV+eP9yaGPF
         ZUW3mAPkbfNLQe0caPlV80idLFQKVrPZYySvb28iCasyOIoFNOyRfjEb6avgsQiE1Gwd
         SFw4iph7XmKlLWoxbDwGAG/EAAkCNxOgob/44m6MPxIbMyp3N64dZ4FYzSIQTwqc0z4c
         4uLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683564846; x=1686156846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4pwBaoSBkQtF/HJ0x7fimOBuuFmgcOyFRVy3Z9hhcNw=;
        b=NoOZhWGQLAoQp9SSOAJFZzlV2O5g/DewEKpfYBbpeQbIXCJ+HKYzA997SZizkWt44s
         /rZOaXwpYHK1xw0V8ZGJzsodYv7kO2w8SPTn3J9LxQ5amIVoYWiKJeJzbod5RITNf8zT
         D9Q1PujCj1sBy2SUFI3NRQvA71NxB8UzG6aBoe/h4DGLtLZUiYMonRJEydwcVACydAbf
         BlfWdJAorUcpgC9wpwZO0X9Gpr663B34UlppqV9rE6mqkl2uostpkBsa16jSWc1a5oSQ
         RRqtnH/qKuGv23ipgnyr4R24hrn1OAuhQqNLNyKU9WAL5p5CV3eFFtHM6MqdOuVVUhzI
         9AqQ==
X-Gm-Message-State: AC+VfDyXqsmaEVTtPcpN6/d3+6Gqrjp6H5x+bzmNNyEUqIuxDfjY7e0y
        c4gMdZtPa69lkiGAjGr0JdBK+5Q36oHzZ/KppP5GD5/1ymw=
X-Google-Smtp-Source: ACHHUZ5z0eMCGrGfK4XDUdibM1JBc4BQFvb1aMt9/zydudnr71Ysu5gi4EjsEqA3EjF0/1K0hvUiz9lPh+dlTQLMAn8=
X-Received: by 2002:a05:6a00:1a09:b0:63b:7119:64a9 with SMTP id
 g9-20020a056a001a0900b0063b711964a9mr14909653pfv.16.1683564845652; Mon, 08
 May 2023 09:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAOvKW55oWs+atYyy-cTb=H0VhJx-V+M7_7FsqjdJ_jU9bR+8LA@mail.gmail.com>
 <a611877f-c515-033c-e015-f3952b520c08@gmail.com> <CAMP44s23Qsw3behbm57BNKeT9w_u1OunV04A9uzz85rDcD_Uug@mail.gmail.com>
 <CAOvKW55MbXF8sDaGTTk9XJxw6Ln9E9G8qOF4wbXzEKY=GH=Zag@mail.gmail.com> <64590f5430b36_79d229439@chronos.notmuch>
In-Reply-To: <64590f5430b36_79d229439@chronos.notmuch>
From:   Dan Stromberg <strombrg@gmail.com>
Date:   Mon, 8 May 2023 09:53:54 -0700
Message-ID: <CAOvKW57WdwNoYXJyebMf-V4mQBz5CjvD=qhGxtht_2YKuygL1g@mail.gmail.com>
Subject: Re: Weird merge records
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Thomas Guyot <tguyot@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 8, 2023 at 8:03=E2=80=AFAM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> > You seem to be implying that I shouldn't use 'git pull --rebase
> > upstream "$branch"'.
>
> If you know what you are doing, then do whatever you want. `git pull --re=
base
> upstream $branch` is fine, if you know what that does.

I consider myself a git neophyte.  It's a large topic.

> I would just keep in mind that `git pull` wasn't meant to merge your chan=
ges to
> upstream, it was meant to merge $branch to your integration branch.

I see.

> > If that's the case, what would you recommend?
>
> I would recommend `git fetch` + `git rebase` (or merge). If you are expli=
cit
> about what you want to do, surprises are minimized.

Might that look like:
        git checkout "$branch"
        git fetch upstream
        git rebase "$branch"
        git push origin "$branch"
?

Thanks!
