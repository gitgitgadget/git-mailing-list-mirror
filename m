Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D11C77B75
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 00:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjDSAGh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 20:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjDSAGf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 20:06:35 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDD47AAB
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 17:06:32 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6a5fe1ebc42so513889a34.1
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 17:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681862790; x=1684454790;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/PML56j4HSfmpDZxLVGWwtxBJod9WL6msf5erJezY48=;
        b=BjN7hA9nxIq5ALaJOAsIoxGhRyM5QRsIKUmrBOqCoEt8XEOuWy9q77nCP4h8iACJYp
         q1v82rUfkjQpWP4JCnuOJ8343pNnJAayJoW9WdzylaP/rXkqW+VkNe1Uy7/Z8hJSZAE/
         XqNcnRRuLUwZvzsyQxFV4zIkZwN9BFJ5NOZgGhYuZ2Ce45C1y64r0Gb+V9fBGpHqdMsT
         toNKWgEvC49lUI77lRiN9EhNWD2UlhfTuUq+lqJzhiQoe1CbEXRNZJaCFCghQSSif0MS
         FPehe6lXrMrPuUMpTX/E3NYaNT07/I2yhjUCYkCbRvzlW9j+eGwPChSbKpKF0sJ/RZns
         3OMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681862790; x=1684454790;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/PML56j4HSfmpDZxLVGWwtxBJod9WL6msf5erJezY48=;
        b=WYNkoE1xEobXbd9+Pe4P+2Piyf7YXyKA3PdJvyjnM1jIhyVUWZ+PjuI6c3zIEwXBRG
         H08MMRyz8XzhrVlb8aRmCgkcacc3FewJSMZkZhKHwLUjWhcif32fI+KtmguXmYiiX3jV
         c78W1JSl1nGhvHU1MQUguYGoQWr1EfGWFvtyb0mcQMWTrrKXVqUtadyqsBjkJIRvQivj
         RI7k+Q8HHO32Gc1fN3zYTKp2CJKZ84XmtxcpRIu2zdUAQd/OnrCIKkXjjjG14udwGXdR
         fIdAAZaqWddcVHSGiEYpqhpmJkl9WNfH+eNgljsEO7/clL5zDvEZVfXdT9/DiXsqU4js
         lKHA==
X-Gm-Message-State: AAQBX9drt8/QweXAksljZFEDGx2Yqd7wbWCFJattPOKCvr4iLiES8fYl
        bY0sUmQX5YBRiikJfq7NpXgnq2Pu2gs=
X-Google-Smtp-Source: AKy350ZA3jnWmHmvIIlgTXL7x9ySoxcwJHtWp85QpvhvXkl6yvsu9wvJ9ntDJB/m3vixglmUav3nbg==
X-Received: by 2002:a05:6870:e2cb:b0:177:b64e:517f with SMTP id w11-20020a056870e2cb00b00177b64e517fmr2518638oad.20.1681862790632;
        Tue, 18 Apr 2023 17:06:30 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id j41-20020a4a88ac000000b0053b88b03e24sm6465927ooa.18.2023.04.18.17.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 17:06:29 -0700 (PDT)
Date:   Tue, 18 Apr 2023 18:06:29 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Erik Cervin Edin <erik@cervined.in>,
        Git Mailing List <git@vger.kernel.org>
Message-ID: <643f30851cd53_2217c42948e@chronos.notmuch>
In-Reply-To: <CA+JQ7M_KuDXBaVTzVwLTx+R4-6-3TOuUOpcchkS26iiosc85Hg@mail.gmail.com>
References: <CA+JQ7M_KuDXBaVTzVwLTx+R4-6-3TOuUOpcchkS26iiosc85Hg@mail.gmail.com>
Subject: Re: Git rebase no longer defaults to upstream after force push
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Erik Cervin Edin wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
> 
> What did you do before the bug happened? (Steps to reproduce your issue)
> 
>   git init --bare foo.git && git clone foo.git/ foo && cd foo
>   touch bar && git add bar && git commit -m init
>   git push -u
>   git switch -c a
>   seq 1 3 > bar && git add bar && git commit -m 1
>   git push

For me it fails at this point.

  fatal: The upstream branch of your current branch does not match
  the name of your current branch.  To push to the upstream branch
  on the remote, use

      git push . HEAD:master

  To push to the branch of the same name on the remote, use

      git push . HEAD

  To choose either option permanently, see push.default in 'git help config'.

  To avoid automatically configuring an upstream branch when its name
  won't match the local branch, see option 'simple' of branch.autoSetupMerge
  in 'git help config'.

What's your configured push.default?

>   seq 11 13 > bar && git add bar && git commit -m 2
>   git rebase -ir # Works like git rebase -ir @{upstream}
>   git push --force origin main:a
>   git rebase -ir # No longer works like git rebase -ir @{upstream}

This works fine here.

-- 
Felipe Contreras
