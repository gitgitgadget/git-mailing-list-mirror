Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B6EC433EF
	for <git@archiver.kernel.org>; Sat, 16 Jul 2022 19:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiGPTUj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jul 2022 15:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiGPTUi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jul 2022 15:20:38 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E9F17E37
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 12:20:34 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id g1so5197654qki.7
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 12:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KB99zNyM+q1wBBADq2dkyLUsjrbZcGAWG5oQMcnxWiM=;
        b=FZbwSp/Wd2+W6FtTqETorSWHjPLS7QaBM0BO4vCoJQGvUjFx6fp6gh1HPT7AsYdGNi
         Q7s2z8qnSlOBGbdsMzunVJCtZ2HeH32il+6ny2T5uo8aKrvlX9ng+5CW6Ldw6RvCf4AN
         J8GjUHRC02yh5Myh07QtTEpKGoBEiI/iwtE4QVmOwv/S/wf0yD8qqJgqkfHfF5dNjLBb
         5fnfJQWuMmpakRr9ILcUZAB0hefmNrsNx/YOafpokn4WCsL4nY1DgOwrfEul47sVgM/X
         XfOcRIlxhHwvMt++zUioyvAPuW+F/gYZuaOEwhaTX9R/bEQ7Pw2tAr3CFV0x8Yyqxmkq
         PKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KB99zNyM+q1wBBADq2dkyLUsjrbZcGAWG5oQMcnxWiM=;
        b=jV94Ct7oExECVGj4iG7Y2xZVj/8qLiZKCSTAT1h2ODO2crH//DMvVVao7cg0LhwjUW
         rusUKdV0+aN1j9NVeb4gFQYLzpkUmTQNPMBl3n8UyZq5VqCoeHr14pgMkBCoUjbLLlrd
         et29FqOFVvfi7q6wW6gQMsbYMkLejzztPb+zBjddEJXX2r+8jYjklHjf4/c8w3qIKB0F
         eBaE63SZZLSW8Zoqj+fhwKjXSiGur4AmWyBrSgp36tyAkWeX2vPEIkNpm7BhJj1WZ2TL
         h/Jx7dSPaVFIoNJKLh9J4xKYj7R8crZNyCRZpfT1LvDoh0LOx9iq9DiECTDYDMSyxtZS
         y8sA==
X-Gm-Message-State: AJIora872nA5LUuLHwABSoQPMiAc32EJlqn3m5zsuPgFAjJ4vqdHzkfq
        Q7DAyQpy2vtSbs0/ovFrxDctRQKtRaALQ/hPlAM=
X-Google-Smtp-Source: AGRyM1s1lw3DAnNp6alCZTS7jgRIWd1QjeK7542LpF7UDcuFaKICJtptQfexfqfICvRsGAlnhGD+C6NKy9LbIDUottU=
X-Received: by 2002:a05:620a:1786:b0:6af:6e0f:596c with SMTP id
 ay6-20020a05620a178600b006af6e0f596cmr13035448qkb.227.1657999233779; Sat, 16
 Jul 2022 12:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
 <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com> <29c7c76805abb9b8afd44a65cb39d8f9d3c95892.1657631226.git.gitgitgadget@gmail.com>
In-Reply-To: <29c7c76805abb9b8afd44a65cb39d8f9d3c95892.1657631226.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 16 Jul 2022 12:20:23 -0700
Message-ID: <CABPp-BF_F3X4ZMQpV7DRkt-ZzLS2erMKHJAbL6s2eQRxahEg=Q@mail.gmail.com>
Subject: Re: [PATCH v4 09/12] sequencer: rewrite update-refs as user edits
 todo list
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 12, 2022 at 6:07 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <derrickstolee@github.com>
>
> An interactive rebase provides opportunities for the user to edit the
> todo list. The --update-refs option initializes the list with some
> 'update-ref <ref>' steps, but the user could add these manually.
> Further, the user could add or remove these steps during pauses in the
> interactive rebase.
>
> Add a new method, todo_list_filter_update_refs(), that scans a todo_list
> and compares it to the stored update-refs file. There are two actions
> that can happen at this point:
>
> 1. If a '<ref>/<before>/<after>' triple in the update-refs file does not
>    have a matching 'update-ref <ref>' command in the todo-list _and_ the
>    <after> value is the null OID, then remove that triple. Here, the
>    user removed the 'update-ref <ref>' command before it was executed,
>    since if it was executed then the <after> value would store the
>    commit at that position.
>
> 2. If a 'update-ref <ref>' command in the todo-list does not have a
>    matching '<ref>/<before>/<after>' triple in the update-refs file,
>    then insert a new one. Store the <before> value to be the current
>    OID pointed at by <ref>. This is handled inside of the
>    init_update_ref_record() helper method.
>
> We can test that this works by rewriting the todo-list several times in
> the course of a rebase. Check that each ref is locked or unlocked for
> updates after each todo-list update. We an also verify that the ref

s/an/can/ ?
