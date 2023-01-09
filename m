Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE87C677F1
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 17:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbjAIRFC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 12:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237231AbjAIREX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 12:04:23 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630443E841
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 09:03:21 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id t15so9149270ybq.4
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 09:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7ux+KTQg88blzwtYlYP8q9eUAIKnMIEhwrOaqbV/0CM=;
        b=XhAYDb8kmOq29BiZxd1kmRjd6eXJRpo7sUfQE5h8M30kZANvRW14kTAujzSZY9x58P
         xzbAHGCh/Fp1g5nuMBjNcuRc/lzaHZLd2ZcGYxgXxbig3QMBKoFGZBuHup0ySNhXMfGF
         gVPCMMUuku5Wlo1VvNdIjvzU1RCuKrhWOjoCvQmfp+DqIdst/QM6+gbKeShVoZK3WPO1
         rgiraFXaIzTb7X28pSdIrtLflNbxr9m2o1prM5Vv09exg9mcNQ07PU2MRFqDuiN+gkE7
         dVDFbLrUkNNl1vRvamQuAEOO8bjTo21FgKzxO819EH89YMbY3Pv5HgFNecDuzG5ABcB7
         xmEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ux+KTQg88blzwtYlYP8q9eUAIKnMIEhwrOaqbV/0CM=;
        b=rG7Ig02ppvn0M94r+jVao1uPvOQsfAiZr23jJTrSc4kqhGs2YXl6BowQpoUA4NKXmN
         NEOctj9zMrU9fheDo31EXSm4Fop2VI3kmVk5li5TYUDqjrxStv1tEuuoh/6GOpT4rzQH
         rma+sYalxS+z1xdlAzt+H+6uqLmsSrz7zlhTR5KTCzWv/v4i5Iv7CyhWg37HQlG7yudc
         7Pk11twQq/D90v64Pr8xIVtnV8CXeescehcC0tDzeWwKBTmZwUteflgjKaXZ/P9RajxF
         W7WerHTCH7QSpwECQA5s1Ys7txMoX1SrRSFNV90GuaOUyRpGfofGJOMXbFqGk5ygScE+
         MnwA==
X-Gm-Message-State: AFqh2kr7OmhpXMyVutKVucJCSUAHpslk/hOnj/HOoVleAaGS6g4ozriY
        gmpgKWd503OcCuW0J748JAZOgNVZdio9S33EtNnslzU7cE+pvw==
X-Google-Smtp-Source: AMrXdXs5jFWQq8rTr9RtXIz6gI6cbjSdpaiRovUJ8SwtsjqWkIuZ+M0EgT52D+UeZszQ2yylbfbfb9FYnU7gVsmysIE=
X-Received: by 2002:a25:4dc4:0:b0:7b9:663d:f68f with SMTP id
 a187-20020a254dc4000000b007b9663df68fmr492991ybb.389.1673283800184; Mon, 09
 Jan 2023 09:03:20 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos@gmail.com>
Date:   Mon, 9 Jan 2023 19:02:43 +0200
Message-ID: <CAHMHMxWta9Q3O9enn_ntAMdQnE2n_2RPA_Tg0psM+4BEE8dpeA@mail.gmail.com>
Subject: Ambiguity on .gitignore vs pathspec ... pathspec
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello there,

I believe I have found a behavior that I cannot explain via the
manpages https://git-scm.com/docs/gitignore#_pattern_format and
https://git-scm.com/docs/gitglossary#Documentation/gitglossary.txt-aiddefpa=
thspecapathspec:

For the repo:

```
$ git-ls-files$ (master +) tree
.
=E2=94=9C=E2=94=80=E2=94=80 a
=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 schemas
=E2=94=82       =E2=94=9C=E2=94=80=E2=94=80 a_schema.json
=E2=94=82       =E2=94=9C=E2=94=80=E2=94=80 a_schema.yaml
=E2=94=82       =E2=94=9C=E2=94=80=E2=94=80 fema.json
=E2=94=82       =E2=94=94=E2=94=80=E2=94=80 fema.yaml
=E2=94=9C=E2=94=80=E2=94=80 b
=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 schemas
=E2=94=82       =E2=94=9C=E2=94=80=E2=94=80 a_schema.json
=E2=94=82       =E2=94=9C=E2=94=80=E2=94=80 a_schema.yaml
=E2=94=82       =E2=94=9C=E2=94=80=E2=94=80 fema.json
=E2=94=82       =E2=94=94=E2=94=80=E2=94=80 fema.yaml
=E2=94=94=E2=94=80=E2=94=80 schemas
    =E2=94=9C=E2=94=80=E2=94=80 a_schema.json
    =E2=94=9C=E2=94=80=E2=94=80 a_schema.yaml
    =E2=94=9C=E2=94=80=E2=94=80 fema.json
    =E2=94=94=E2=94=80=E2=94=80 fema.yaml

5 directories, 12 files
```

and all YAML files committed, I get:

```
git-ls-files$ (master +) git status
On branch master
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
new file:   .gitignore

Untracked files:
  (use "git add <file>..." to include in what will be committed)
a/schemas/a_schema.json
a/schemas/fema.json
b/schemas/a_schema.json
b/schemas/fema.json

git-ls-files$ (master +) cat .gitignore
**schemas/*.json
git-ls-files$ (master +) git ls-files '**schemas/*.yaml'
a/schemas/a_schema.yaml
a/schemas/fema.yaml
b/schemas/a_schema.yaml
b/schemas/fema.yaml
schemas/a_schema.yaml
schemas/fema.yaml
git-ls-files$ (master +) git ls-files '**/schemas/*.yaml'
a/schemas/a_schema.yaml
a/schemas/fema.yaml
b/schemas/a_schema.yaml
b/schemas/fema.yaml
```

It seems to me that I have to use different pathspec definition in the
`.gitignore` file, and different on the commands (and they are
"exactly opposite" :/)

With regards,
Ntentos Stavros
