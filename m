Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072CAC77B61
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 23:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjDJXQ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 19:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjDJXQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 19:16:28 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549319D
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 16:16:27 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id a13so6310068ybl.11
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 16:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1681168586; x=1683760586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gOZqbe1QMmdQD8rtGtqRYMaTM5PWo63f61elFrp80Qk=;
        b=cCcO4sJQ+r92ohORbsx7+HlqyVgGcVz6czqkLMWo9kXpEklV6Bq5sEjHO+6A0VIZUL
         NMk3MeJzS/yfolQwX4ipXQzSXU7iPKy1J7V8n1oSwpcL5tnHa1586HWep7IVhaYWYGHM
         Lkd7ZTbADsyrlaLbK0mM2HWVv5G4v4Xmu1yHIs7gOl7UW015LiHp/fGtoHFIm8zhgWkE
         R+HALH5EiPwy2Mq7D39nwrY/rLr5EzjbhGcrrWejnHoBPwJT0lpCdR2g7axq1owxfXJt
         FfLTNs4y6KOMcDx3Y1F0eIg1T9QRYLMKUsHmFl/T08n+G8cTttJv5GuV5WkAguJsrYbI
         0evw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681168586; x=1683760586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOZqbe1QMmdQD8rtGtqRYMaTM5PWo63f61elFrp80Qk=;
        b=BOSVN/NnPLgcY4/I5hKCZ3fITzUUxnqDacNTC82dlEgAriz0zYIeTqnvVEv48oP1p6
         CZ2vZsrFVNfQaDosjwnaO228R+yg5NqxBsH0vxpQ9M91yhKn1JD2a6z7xwlbtNwQXI0a
         Km0jiw1NyNkQSCCkZWl3yMytANvbSt9jWOThlyGy6EVp4tlX9UznDqrYhaR+nsIQyXxS
         N5K4e3OyjY3h+BudKhmvkwVn9iyhURndf9OkERO0FLrlMBTmGF5M4myIfT9fLE6kTXio
         0/rYT7eZBIXbU3mF4orPMhceKmUcKofqr724tnYjkWRjem9j0FPAsblnDClzep9zvW+w
         WuZg==
X-Gm-Message-State: AAQBX9cewkSq64snG4NFUIfkJC82yOdpBROjK3065Fn7lkUS97u0jGeq
        /TtN0uZEZj5d95Ro/pvlEsUvW3O1Rfx3Pm+Y7opE4g==
X-Google-Smtp-Source: AKy350YnAgF7yjJ+TaMY3WRO9sqDtH0Zss8XN7nHnZkjhCU/1YbQktbXL6bD7L67TEULmejvKTa/Vg==
X-Received: by 2002:a25:28c3:0:b0:b8e:fdf6:8fce with SMTP id o186-20020a2528c3000000b00b8efdf68fcemr369643ybo.1.1681168586403;
        Mon, 10 Apr 2023 16:16:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q12-20020a81c64c000000b00545a0818495sm3128663ywj.37.2023.04.10.16.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 16:16:25 -0700 (PDT)
Date:   Mon, 10 Apr 2023 19:16:24 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v2] clone: error specifically with --local and symlinked
 objects
Message-ID: <ZDSYyDjJ4ks4ECNv@nand.local>
References: <pull.1488.git.git.1680652122547.gitgitgadget@gmail.com>
 <pull.1488.v2.git.git.1681165130765.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1488.v2.git.git.1681165130765.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 10, 2023 at 10:18:50PM +0000, Glen Choo via GitGitGadget wrote:
>     I tried teaching dir_iterator_begin() to return an exit code to indicate
>     that we found a symlink, but it ended up looking quite ugly when I
>     started to consider plain files as well as generic lstat failures. I
>     think the extra lstat() is fine as a one-off, but if we need another
>     instance of this, we'd be better off doing the refactor.

;-). Heh, I was wondering what happened since your [1] made it sound
like you would investigate making dir_iterator_begin() return an error
code.

[1]: https://lore.kernel.org/git/kl6lmt3k3ccc.fsf@chooglen-macbookpro.roam.corp.google.com/

>  Documentation/git-clone.txt |  5 +++++
>  builtin/clone.c             | 11 ++++++++++-
>  t/t5604-clone-reference.sh  |  2 +-
>  3 files changed, 16 insertions(+), 2 deletions(-)

But if it turned out ugly, I don't mind; this version looks great to me.

Thanks,
Taylor
