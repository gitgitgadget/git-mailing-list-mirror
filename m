Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B994DC7EE26
	for <git@archiver.kernel.org>; Tue, 23 May 2023 16:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237677AbjEWQBp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 May 2023 12:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237670AbjEWQBj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2023 12:01:39 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A7E91
        for <git@vger.kernel.org>; Tue, 23 May 2023 09:01:37 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-96f7bf3cf9eso916076666b.0
        for <git@vger.kernel.org>; Tue, 23 May 2023 09:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google; t=1684857696; x=1687449696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXSV6H9ZA3vCC4P9y9PFZX7/1roABB4ofFw5tv9vrnU=;
        b=eepHzaAMSWjOPg4AuoKhQJ6VY8gtU1WdtxcEzxaad+UeOTnmY5qb3ENbYQnX02EP4n
         8tiFrrhHRcyxlRSAJETOR5GAhHWH+MzfUUshzaPAmOAFh6Izlyu/M11tLXDE3wMAn1CO
         mkShKX3RahBtJQwA0PVCpQMYxcAi6qx7HUws4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684857696; x=1687449696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXSV6H9ZA3vCC4P9y9PFZX7/1roABB4ofFw5tv9vrnU=;
        b=RJNlhtoqMsfmcQYEy22q/IchOjVDeS9ci3jIQKgIsaLY/JlFXRN6Yz+Qg9Lqz3zMZJ
         UfuV3vjBU4U/D7G1WBVwAVvJrOJ0IAUZvMQHYQoyKKY6JJsp+WDAXfR8LCLyUJ/73xnh
         YCQRt1Hvqi9mT8hfg1KT2XOH1V71gm6snIN7uKz9Ap7rzc81qdYZ57Kwt88s/dkwomvR
         fgXmMQz8gXeqhoz0oMQppaUpd1z7e6Y8KLxsVooNg8U/cszG8zHyVFFA53im8mt/TzHg
         5b6a0wtq2+y3a7bnx6B6/F7z+jKvEBzvohLflDYcwxnqm7bk1sjBE8Zvge1uA4GB9+LM
         Z7iw==
X-Gm-Message-State: AC+VfDzHC3eYSeuzSXGXfiEExpsCPeh62LSdwGVpALJgSXnyBygAl9W2
        sYdK2wBH/BbychpTSYDjqWVCdfK2ggs4tGGBNbDC65wGqbcrzUDNK6c=
X-Google-Smtp-Source: ACHHUZ6b7RI+1jagjiLyb+XQIz0YiBUorVUhpGh57lTjOa1aGVeoKv63YX7dhHufkKgsx74aRRX2qCVYCrPWnV3Bnro=
X-Received: by 2002:a17:906:9b84:b0:94f:5b91:7952 with SMTP id
 dd4-20020a1709069b8400b0094f5b917952mr15995961ejc.21.1684857696260; Tue, 23
 May 2023 09:01:36 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1535.git.1684830767336.gitgitgadget@gmail.com>
In-Reply-To: <pull.1535.git.1684830767336.gitgitgadget@gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 23 May 2023 18:01:25 +0200
Message-ID: <CAPMMpojV1Ts=OKM0FbBHU6=EB5RKNxHucX-8VQmYoQBNefKpqQ@mail.gmail.com>
Subject: Re: [PATCH] cherry-pick: refuse cherry-pick sequence if index is dirty
To:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 23, 2023 at 10:32=E2=80=AFAM Tao Klerks via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Tao Klerks <tao@klerks.biz>
>
> Cherry-pick, like merge or rebase, refuses to run when there are changes
> in the index. However, if a cherry-pick sequence is requested, this
> refusal happens "too late": when the cherry-pick sequence has already
> started, and an "--abort" or "--quit" is needed to resume normal
> operation.
>
> Normally, when an operation is "in-progress" and you want to go back to
> where you were before, "--abort" is the right thing to run. If you run
> "git cherry-pick --abort" in this specific situation, however, your
> staged changes are destroyed as part of the abort! Generally speaking,
> the abort process assumes any changes in the index are part of the
> operation to be aborted.
>
> Add an earlier check in the cherry-pick sequence process to ensure that
> the index is clean, reusing the already-generalized method used for
> rebase. Also add a test.
>
> Signed-off-by: Tao Klerks <tao@klerks.biz>
> ---

My apologies for the premature submission: I've now realized I used
the wrong existing check. "git rebase" checks for a clean *worktree*
(ignoring untracked files), and that is what I reused here. What git
merge and git cherry-pick check for, and what I should have added a
check for here, is a clean *index*.

The current implementation of this patch is far too restrictive. It
doesn't break any tests (and maybe I should add one now that I know),
but it's doing the wrong thing.

Tao
