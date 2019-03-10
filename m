Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8374220248
	for <e@80x24.org>; Sun, 10 Mar 2019 07:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbfCJH7F convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 10 Mar 2019 03:59:05 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50497 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfCJH7F (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 03:59:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id x7so1416237wmj.0
        for <git@vger.kernel.org>; Sat, 09 Mar 2019 23:59:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=THLGca5rsPmG05hz/z/jr/vjN20bZMb91wnjhBe/prI=;
        b=U6HrPPWPKGIixKqxpZThDkYCdneViZnMa5a7kV6BdOplgszn2isWLUSadUBDVGWjNj
         d+iL36mOnGbs32QuywX/oxCpzlUgbfFZ4fu21jjbCfxeEeX8mIk5f6vKKUYUl5uf66r0
         uJ3Bsp6gpwyRtvoDCxCMJ/fi/Ec3Q5J5KZ3lTO+LDhbijeQZQ+bJVScjUlS1k3eDc10B
         j64OtoAVd/gICU4Qq3CPAcplcUbcWLpUAEcmm3DeHpfNqngcu5Lg+gAk5q/xJ6nNlbnP
         hF79PCXVPJ+zxmySWwWBXFbgJdXqRvYXRHS8dlwXUoLxdAIVOcC7r3dXgvpY0mmJ7ZSj
         uNDQ==
X-Gm-Message-State: APjAAAW8gAvVRmXGTywzRnWSLlCMJnQsSP7RWy87LGpvsxt/dfdflHSq
        HkeoE6Cf9JubPVngCh5LNnF7O4jh5fvQLqKGhVQ=
X-Google-Smtp-Source: APXvYqxXEXyVNGHVaODszE+tD78wNDXZv1jzWCrEECBl4OgJgsIbKrTjP2JoaH+vaba5uVtiRvcKej+iuACAhTy5ghM=
X-Received: by 2002:a1c:730d:: with SMTP id d13mr13670853wmb.37.1552204743409;
 Sat, 09 Mar 2019 23:59:03 -0800 (PST)
MIME-Version: 1.0
References: <20190308101655.9767-1-pclouds@gmail.com> <20190308101655.9767-3-pclouds@gmail.com>
In-Reply-To: <20190308101655.9767-3-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 10 Mar 2019 03:58:54 -0400
Message-ID: <CAPig+cTdE+mTtvExHm1Fm1SU=YkHai-d6BW6jJ9SGOWS3eZZPw@mail.gmail.com>
Subject: Re: [PATCH v1 02/11] restore: take tree-ish from --source option instead
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 8, 2019 at 5:17 AM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> This is another departure from 'git checkout' syntax, which uses -- to
> separate ref and pathspec. The observation is restore (or "git
> checkout ,, <pathspec>") is most often used to restore some files from

What is the ",," thing?

> the index. If this is correct, we can simplify it by taking a way the

s/a way/away/

> ref, so that we can write
>
>     git restore some-file
>
> without worrying about some-file being a ref and whether we need to do
>
>     git restore -- some-file
>
> for safety. If the source of the restore comes from a tree, it will be
> in the form of an option with value, e.g.
>
>     git restore --source=this-tree some-file
>
> This is of course longer to type than using "--". But hopefully it
> will not be used as often, and it is clearly easier to understand.
>
> dwim_new_local_branch is no longer set (or unset) in cmd_restore_files()
> because it's irrelevant because we don't really care about dwim-ing.
> With accept_ref being unset, dwim can't happen.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
