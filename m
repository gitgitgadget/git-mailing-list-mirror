Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D21C77B75
	for <git@archiver.kernel.org>; Wed,  3 May 2023 17:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjECRHU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 13:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjECRHG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 13:07:06 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C10744B1
        for <git@vger.kernel.org>; Wed,  3 May 2023 10:06:34 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1aaf70676b6so29446095ad.3
        for <git@vger.kernel.org>; Wed, 03 May 2023 10:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683133584; x=1685725584;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HzT+aPtnfqMnLBEyeOR4Pb0kEABs8nNQCSidTQpRo0E=;
        b=q5kDuW6KLN+r4ewfCkhrUknDfjbJkSw5qAxIUFwJ6eHFX9eitG35ii/EMsVXxb+PQg
         U8CCLVjraCEYAjvxVKQFnqFS468v10eeO1nLqTamFw4I3mAiaXiXKwm8LFU1Bsn0kQGC
         XoiSVDobEeMJ9JBWAfiUXUpghTCfFAC2+ZB/a05BkZX6wATEQhg6dqh4naDOLwIveUFA
         5GjQ4AU7rTgrqJlfh03Yl2eq+/qCJQV6utpP+Nkg+Bdp98dH05rO4TH8GGk475XKSprd
         w0loWN9P+BW6GmaQ45APpjrgjg+bE0PO6Mny66AmZmf0ep7ySQtn+YFj5Q4lxk6zSIUQ
         QnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683133584; x=1685725584;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HzT+aPtnfqMnLBEyeOR4Pb0kEABs8nNQCSidTQpRo0E=;
        b=DwNdWs+9tRLUOyLhNA/Ply6C3eoCZoI3ISjWTk41HNIM3n4jTlO3NwpJSkBUkM+7HB
         C6KDOBRpUI/mKGaq/KlvjEAfi7MACPg0MHTNWn1JBpZOKrZ8l6hKg5uenVNBeGtJaHDW
         bN+aKqBcxq5P3O9csFry8dzeSfMRCS8STCx2f1DNEfz8WkyDIo7kH/dKhwCfzhpXYECR
         LNNDnPXvBV/MY/JFOZE4elk1cCI0ECkm3RwHyC8wrGOaKMYc8ym9WbIgn4QmajHcjmwa
         qxAipjP5XhZrw8PK3H67fFLiLtTi6TeUKt6tF4ysdrKGFs3zhFt7vfNDb+WQDQFLKBcb
         0ivA==
X-Gm-Message-State: AC+VfDwOdXBqFIajF+YUJBa1J/9JsqBymV+bhTktEUvGIAIK2P6vZR8H
        ffmwiTlmq4MKi6t3pmQDJJGtqwUI/2I=
X-Google-Smtp-Source: ACHHUZ6BspUTXEk8rdQKA67l32oVtHvuTHcudBtnrp/071YXqAQHf9S7mC/EFy4Rxa3lNX8oycrhUQ==
X-Received: by 2002:a17:902:ef94:b0:1a1:ee8c:eef5 with SMTP id iz20-20020a170902ef9400b001a1ee8ceef5mr714807plb.7.1683133583660;
        Wed, 03 May 2023 10:06:23 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id k11-20020a170902694b00b0019309be03e7sm21831570plt.66.2023.05.03.10.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 10:06:23 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Sohom Datta via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        Sohom <sohom.datta@learner.manipal.edu>
Subject: Re: [PATCH v2] docs: clarify git rm --cached function in gitignore
 note
References: <pull.862.git.git.1601888338644.gitgitgadget@gmail.com>
        <pull.862.v2.git.git.1683127916363.gitgitgadget@gmail.com>
Date:   Wed, 03 May 2023 10:06:22 -0700
In-Reply-To: <pull.862.v2.git.git.1683127916363.gitgitgadget@gmail.com> (Sohom
        Datta via GitGitGadget's message of "Wed, 03 May 2023 15:31:56 +0000")
Message-ID: <xmqqild9tkdt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Sohom Datta via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Sohom <sohom.datta@learner.manipal.edu>

Please make sure this line matches what you sign-off the patch as,
i.e. the above line should read more like

    From: Sohom Datta <sohom.datta@learner.manipal.edu>

> Explain to users that the step to untrack a file will not also keep it
> untracked in the future.

"also keep it untracked" -> "prevent them from getting added"?

After all, it is not "git" that makes the path tracked.  It is the
user who says "git add" that file that is not supposed to be
tracked.

> Signed-off-by: Sohom Datta <sohom.datta@learner.manipal.edu>
> ---
> ...
> diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
> index f2738b10db6..8b78e1b3e08 100644
> --- a/Documentation/gitignore.txt
> +++ b/Documentation/gitignore.txt
> @@ -146,7 +146,9 @@ The purpose of gitignore files is to ensure that certain files
>  not tracked by Git remain untracked.
>  
>  To stop tracking a file that is currently tracked, use
> -'git rm --cached'.
> +'git rm --cached' to remove the file from the index. The filename
> +can then be added to the `gitignore` file to stop the file from
> +being reintroduced in later commits.

Should that be `.gitignore`, I have to wonder.  If the file in
question is in a directory `deep/hierarchy`, the user may choose to
add it in `deep/hierarchy/.gitignore`, and in that sense, you may
have chosen to say "tell the ignore/exclude mechanism" in general
without specifying the exact file path, in which case I am OK with
that strategy, too.  But then, `literal` mark-up is not appropriate
as it is no longer something the user types literally.

I'd vote for just saying `.gitignore`; it's simpler and users who
want to be creative can improvise at their own risk ;-)

Other than that, looking good.

Thanks.

>  Git does not follow symbolic links when accessing a `.gitignore` file in
>  the working tree. This keeps behavior consistent when the file is
>
> base-commit: 69c786637d7a7fe3b2b8f7d989af095f5f49c3a8
