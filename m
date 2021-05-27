Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0671AC47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 19:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBE536124B
	for <git@archiver.kernel.org>; Thu, 27 May 2021 19:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235560AbhE0TxW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 15:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234847AbhE0TxW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 15:53:22 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97A1C061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 12:51:48 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id o66-20020a4a44450000b029020d44dea886so391769ooa.5
        for <git@vger.kernel.org>; Thu, 27 May 2021 12:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=h/D2rfPtBpMX4hXshxAGtH6+bx0w68yNUyipfNUlNvg=;
        b=q/d7Y2jKk9gNnU0KGAX1v5v0J9GiPP8vVwlLLE75EzC0ZZPkSWky2FyMcj9p4piold
         pPmpS32uchOPPvAh+HXVOb2GZxgaCf3jUPX6AuEJPl6//CL5iuHRwVHEQWVhX2ZWTNXj
         bTMsz5dvM2nOPlL3qOvduEzxDVSeGh+H4SQQcSFsu+v6d8exlm1NdZaU0bV44YXeMfn5
         KG/f3nt04qgjGNMD6mu43thqHap4CCYKyYVHc8Jby/mHQOuOQ6g0NAoXCyMlnXw08rq5
         alGY0CEdNLHozrdI675srKo9vxH7Ye1Dy05OKkMNXgmvMx9dwH3WbjHpDs1XIdIJt5sF
         8YXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=h/D2rfPtBpMX4hXshxAGtH6+bx0w68yNUyipfNUlNvg=;
        b=fLU329YCt8BFeabBGYEkiI6AmCXyja+W39LSZxUOGzXEmVxJSKKScG9uWikmQ3hUhj
         dcU7hUR/g9plUTcYuXWhB3vsUz5J4syTyGP/4VxVdyk4P5DDc+pmLBM1u0sbKvqZsrQa
         wa1kx24ayZMWzkY8UCQHTOXuV8af7d6uP/L2Dh7yg3GhzJrqn5Mt20lvCTMQv3Ktzhcm
         /JKHFZjS2emsFsjNNz5xmztbdX9DoN/okzyRlc99gCrgDqRZkT3RKF3H6eroR//PsgFL
         7258UDVOyA3UoUk//uX09q7hMNCcBRU4Ouass5D7gUkkVnqpeuqWhw83b9RX6UyUbtSW
         J3vg==
X-Gm-Message-State: AOAM530f35tgc5WmMhb0q8JCH6QyWq28SHEElTRGnmzIm3kiCLbvx0M7
        UJhPIkYfLgKHda1mlSC1jmBocwo3aNPzcg==
X-Google-Smtp-Source: ABdhPJxIm6Uyv6QXvyWD95CiB/7GH95rG3YN13tPZeCnAl2goztMEaOv+k4YVTafwTBtR5WfQVzr6A==
X-Received: by 2002:a4a:d052:: with SMTP id x18mr4058835oor.21.1622145108023;
        Thu, 27 May 2021 12:51:48 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id x63sm664006oix.47.2021.05.27.12.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 12:51:47 -0700 (PDT)
Date:   Thu, 27 May 2021 14:51:46 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Mathias Kunter <mathiaskunter@gmail.com>, git@vger.kernel.org
Message-ID: <60aff85261fcf_26530208a@natae.notmuch>
In-Reply-To: <065528bf-b496-83d3-767d-2a78e50a9edf@gmail.com>
References: <065528bf-b496-83d3-767d-2a78e50a9edf@gmail.com>
Subject: RE: git push doesn't use local branch name as default
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mathias Kunter wrote:
> Hi all,
> 
> at https://git-scm.com/docs/git-push#_description it says:
> 
> > When neither the command-line nor the configuration specify what to
> > push, the default behavior is used, which corresponds to the simple
> > value for push.default: the current branch is pushed to the
> > corresponding upstream branch, but as a safety measure, the push is
> > aborted if the upstream branch does not have the same name as the local
> > one.
> 
> However, on a branch which does *not* have an upstream branch 
> configured, the command
> 
> > git push <remote_name>
> 
> doesn't use the local branch name as default,

Yes it does, but only on the src side of the refspec. Something like:

  git push <remote_name> <branch_name>:

(invalid refspec)

Note the remote side is missing, so git doesn't know where to push to.

> Note that it *does* work if the remote branch name is explicitly specified:
> 
> > git push <remote_name> <branch_name>

In that case git assumes you mean <branch_name>:<branch_name>.

Sounds like you want to change the default to `push.default=current`.

Cheers.

-- 
Felipe Contreras
