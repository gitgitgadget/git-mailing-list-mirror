Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23E6C433FE
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 17:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiJJRlb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 13:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiJJRla (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 13:41:30 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331DC6FA1F
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 10:41:29 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id z197so4070225iof.2
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 10:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GLRQMDlZwJFdgjql1SXfK3E0vObpHf/QYGqe/IS3o6c=;
        b=TO3EzAVEpg5gyJ4IPl+KGq1g+g/981hw8fKZg3EAgY0Q4iHNTDOkEhKeQMdVHFJB0U
         xUEcsZVMEg7LddMt0TrHq/jcnEj80lz+VlpjGeDnSaHDNM4JiIFaBmZWrfgGfv8CmEgP
         AhcxFT89LTL6hya7iBWqNMdpnIgmjARySkcuDwW5Xrw5kg7UXonE7lOwAhaa2Eu58ssn
         FCRz5dNRAz3M3gd5dzRZyN+3Q3UbX19XrZ1dpIUVCqe216QjerYFm99nOU8wcdkwcBwP
         OYX11rBW5y3vIpx0UIEnzDbTd+qofSFMA+/TF6daCchOeONLs+Tk5FJOMyYkdMneXi++
         291A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLRQMDlZwJFdgjql1SXfK3E0vObpHf/QYGqe/IS3o6c=;
        b=q/hENhRAOKRlBcRpOrvR+Hhg9Q0AL9YAmLObc18gevvUsyucmuWYaMGXbo6Zgd24a/
         OSPtxZslRAOTuw+9UPvypCAoYEFZLhs6uIE+tCjDBJ7siKjmsxdbzzl7L4ZukrjQc52y
         pK803tvzbhLsHoJGROzpq8g3MGhnKgBz5rM9AiiTwvLHnHA2Q6jIJgj1dMDgf3khJLBU
         scJFPEmWu2gzHYvcljC7PQtXjTvxzuo/iyv5KPwyMU48ndZD5C2b52Xl/1ZTgI/bJkrQ
         e6oonTW47tJ00dAZ/S5myUIPC3gGivcky6Ti0RwSq9ofrpta62K/JtW0UjXD/K5lMrZc
         IHmg==
X-Gm-Message-State: ACrzQf1vD3dZ4pTyGoIGATjYm2HKSN64PzmXiAeqS//I78fY1sDJvQJ1
        ae/++nxI9f4jdtoQxuMwE7wtA9VyYht7Jetp
X-Google-Smtp-Source: AMsMyM6B5jlVTqUNbP9wYEJLQytMiwKrYdsxrVK1nlLIWGtRtl72Y2H1PsDeuk8E+/cWFYcWpfCzUw==
X-Received: by 2002:a02:c853:0:b0:363:c5b0:b415 with SMTP id r19-20020a02c853000000b00363c5b0b415mr1443978jao.293.1665423688293;
        Mon, 10 Oct 2022 10:41:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o21-20020a0566022e1500b00688faad4741sm4490660iow.24.2022.10.10.10.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 10:41:28 -0700 (PDT)
Date:   Mon, 10 Oct 2022 13:41:27 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     orygaw@protonmail.com, rsbecker@nexbridge.com, gitster@pobox.com
Subject: [PATCH 0/2] grep: tolerate NULL argument to free_grep_expr()
Message-ID: <cover.1665423686.git.me@ttaylorr.com>
References: <o2ijhZAUIi7nPTwQmsJfpvPIEeLbhvn1AP8rhW2hCNbC380Z2ogDHzZigqJsHI6RwphsIZR3OSJSy-wYvyWv5un632tKynHKFLFPLPEDH2g=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <o2ijhZAUIi7nPTwQmsJfpvPIEeLbhvn1AP8rhW2hCNbC380Z2ogDHzZigqJsHI6RwphsIZR3OSJSy-wYvyWv5un632tKynHKFLFPLPEDH2g=@protonmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This short series demonstrates and fixes a bug whereby a NULL
`struct grep_expr*` argument (such as when running `git log
--invert-grep` without a `--grep` argument) could cause us to segfault
when trying to dereference that argument.

An alternative approach is to disallow `--invert-grep` without a
`--grep` argument. But a more user-friendly approach is to permit this
combination by pretending as if neither argument was given. This patch
series takes the latter approach by teaching free_grep_expr() that
passing a NULL argument should result in a noop, not a segfault.

Taylor Blau (2):
  t4202: demonstrate `git log --invert-grep` segfault
  grep.c: tolerate NULL grep_expr in free_pattern_expr()

 grep.c         | 5 +++--
 t/t4202-log.sh | 6 ++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.37.0.1.g1379af2e9d
