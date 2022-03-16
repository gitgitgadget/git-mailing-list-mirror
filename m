Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CFDC433F5
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 10:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237140AbiCPKqo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 06:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355199AbiCPKqn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 06:46:43 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F136353A
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 03:45:29 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id j3-20020a9d7683000000b005aeed94f4e9so1150215otl.6
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 03:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iyPy4z3cAo2bmRiS1sFnBtpiitoY5EuHvsgMifA8gAY=;
        b=ZPjZ1atfnA1tf//HgzI0S0h5zaZ2aHS2WsRiFYVYK4CdfkSsd98PgU9zS+B0WVb4kG
         xwoA2nMkxt6AlK5+5eqcjuYioaGvIV5oIB+6yMfVzZFBKnhoYyBOXsNr5atlpdxePZ6v
         1PzNbHhtN4v0DfVnGFG/FmEVb9RL9GSp6JHAKZzQ6SMeb7RuwYXFEZjHkt4tgxO986jN
         ZzBVGZ/btiaDITpphvDbP6D+1872VX/IREeO3ALosugKZOslU/Nb7y4gGoQYPY46W3FK
         uLtBNue0zOwtcPMG+abIj0/g66Y0+uOctD31ysgIMUwBx5+WPfqlpIzZuy+v+laJIxsv
         aifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iyPy4z3cAo2bmRiS1sFnBtpiitoY5EuHvsgMifA8gAY=;
        b=5T/E7lA9tQDNmBcwhLoDOCKn2SP6fuNWSOMqLq040K2+7W3pqOzMq7PKnYsPGMuO13
         2cjx3GsUXXojeO459RONH/4fSIR48Nl6qiHa/hy4D3Tm07bZgrauk6HrhkrjgjcMmYab
         yZUgkI8Lb5zkAqvgxXEpCz+jVqcVXg1MSKtCL0s6BNJB71zXb5u2o3UA4S+xsJDnhroo
         CjemMn60S0OcOHcunqFGc2weUDSidZjycOK6/9H+tRQbHLXWnsBNaAQuqG9RZxW7cx2x
         U7MUXth5RZj4UcNvOY5pUSUgLJwG8Npf7ij7qkxMdliXFHntEUtxgSZCAMj/Jc9/Qk7g
         yoYA==
X-Gm-Message-State: AOAM5306OdQHkShkG5HZb95aBiqM9hKLDzLoaJrmHe1jzJ3dC5QkXx7S
        jJ6ArByj0YqiUibcDxbhC2TJgN618hLWlaFXSY/e3YNuMMI=
X-Google-Smtp-Source: ABdhPJyWd0Cs2ltPPP7VHFtSTQkFscujd83gXMf6GEB98FsuywCd3XqM629BUsOuYFBTcfdwb8ATx1EO9CIN58qLfms=
X-Received: by 2002:a9d:6b89:0:b0:5c9:7b17:7cfc with SMTP id
 b9-20020a9d6b89000000b005c97b177cfcmr1772919otq.359.1647427528724; Wed, 16
 Mar 2022 03:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220315100145.214054-1-shaoxuan.yuan02@gmail.com>
 <20220315100145.214054-2-shaoxuan.yuan02@gmail.com> <1ab24e4b-1feb-e1bc-4ae4-c28a69f77e05@github.com>
In-Reply-To: <1ab24e4b-1feb-e1bc-4ae4-c28a69f77e05@github.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Wed, 16 Mar 2022 18:45:16 +0800
Message-ID: <CAJyCBORDOJUwTzOC+hYwGGPUBCXST0_mBdwRLh2N+cA=5k0d4A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] mv: integrate with sparse-index
To:     Victoria Dye <vdye@github.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victoria,

Just found an interesting (probably) behavior.

In the `sparse-checkout` directory created in `init_repos()` in t1092, if I
say:

$ mkdir folder3
$ touch folder3/a
$ git mv folder3/a deep

and git will prompt:

"fatal: not under version control, source=folder3/a, destination=deep/a"

And if I say:

$ git mv folder3 deep

git will prompt:

"fatal: source directory is empty, source=folder3, destination=deep/folder3"

What I am wondering is that file `folder3/a` is outside of sparse-checkout cone,
should `git mv` instead prompts with `advise_on_updating_sparse_paths()` or this
"not under version control" alarm is acceptable?

-- 
Thanks & Regards,
Shaoxuan
