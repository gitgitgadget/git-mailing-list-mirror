Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5E0C433FE
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 16:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237198AbiAaQ3k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 11:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380445AbiAaQ14 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 11:27:56 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719BFC061755
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 08:27:19 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id j14so20180810lja.3
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 08:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=f8o7DBprPl4Ye+XKNGSM6gOTFaYS+xG+fViBz2TrIO4=;
        b=KaplyP3SX6qJJUBMJ/PzONe2WZDIE5CA53k5iFT00CH/Ic6XMsm5JCEiv82sG5OHXv
         4mSHyaBQdZ+PmxNkULQGaHOZ5F8Z8/69ttQ8OuoU4ToCKOWbDSOv+GxNb6CFOUlOMOwO
         3tAk8T4BCWPwvUbJpN9OXszWBhc3wP14DkM3gIW8SIfFn4BfQ7kVNkdS7zyqhipZB5kQ
         h1d0xefsAc1ONu47HNU5rXk2MaseF8nebT+S0gVjidx3tCntuJBE620c9PTByselavtv
         vHMNkgUkLxCZxgfsu3CKlmlCgam1T9Ci8BgGEbc89Gp/Wd+EopeQpidbUb4oI10UlrNc
         7kwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=f8o7DBprPl4Ye+XKNGSM6gOTFaYS+xG+fViBz2TrIO4=;
        b=v8jo9XisEoVT6CHzAI/gGG1LIiwCfNL/dWsIFjWlvjLcr4weagXAuLJ1Fmdb5Pd/IE
         5bSNkpdqAo0DgCI15aOt3XlKzBbv1K4/Ljz0yKH87sHMNffuH8BSrhC+udjwFT/g0A/j
         3EDVEMVoO2vrswzLcNsRF9WkgBKjY0LHqCbU0TqEZn8ZPv3iYny7TepW3+g+XkXE+h5l
         yyhJ8efEWx7HFTKbAxFcKJNJWy+/sjma6go4ya1prigloEGQLDs4kKq/UDlFuUQw21Y6
         wqHI5InJATxRXHkA5zVvhNenn5GMx4KVsTUqmKos5kMeieMA/2XYs6Q0cysIdzFcJ6fD
         aj4A==
X-Gm-Message-State: AOAM531kt1R94i2pCTFHnDhvKENuKkj1TyEnG8jUaU8f4vQ7lIutDrQb
        rqoCLwtVNLjsxyjnqbcPKT7vLP6T8v8=
X-Google-Smtp-Source: ABdhPJw+NOqG5bx7q3APLlyyzPGTTLlVjIYU1bKxw9JVMZwcZwRJFrhssvWd0BEcYCLeZl4pCoML+A==
X-Received: by 2002:a2e:9953:: with SMTP id r19mr11527970ljj.37.1643646437403;
        Mon, 31 Jan 2022 08:27:17 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id a3sm3699958lfs.303.2022.01.31.08.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 08:27:16 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     =?utf-8?Q?G=C3=A9ry?= Ogam <gery.ogam@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Stage, test, and commit only some changes, then repeat
References: <37128901-233F-4428-8A52-470773A18AB0@gmail.com>
Date:   Mon, 31 Jan 2022 19:27:16 +0300
In-Reply-To: <37128901-233F-4428-8A52-470773A18AB0@gmail.com>
 (=?utf-8?Q?=22G=C3=A9ry?= Ogam"'s
        message of "Sun, 30 Jan 2022 21:17:33 +0100")
Message-ID: <87bkzrvpjv.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Géry Ogam <gery.ogam@gmail.com> writes:

> Hello,
>
> I would like to stage, test, and commit only *some* changes of the
> working tree, and then repeat this process with the remaining changes.
>
> My current solution (published at
> https://stackoverflow.com/a/70914962/2326961):
>
> 1. Stage some changes:
>    ```
>    git add -p file
>    ```
> 2. Save away the remaining changes:
>    ```
>    git diff >patch
>    git stash push -k
>    ```
> 3. Test the staged changes.
> 4. Commit the staged changes:
>    ```
>    git commit
>    ```
> 5. Restore the remaining changes:
>    ```
>    git apply patch
>    ```
> 6. Go to step 1.
>
> It is not ideal because a) it uses a patch file for saving the
> remaining changes; b) it uses the stash only for setting the working
> tree to the index state.
>
> It would be ideal if I could save *only* the remaining changes in the
> stash instead of resorting to a patch file. How to do it?

It looks like you don't need patch file for this workflow. What's wrong with:

git add...
git stash push --keep-index
... check, git add fixes
git commit
git stash apply

???

-- Sergey Organov
