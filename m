Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD014C433E0
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 22:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D56623104
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 22:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbhASWuR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 17:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbhASWti (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 17:49:38 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF32C061573
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 14:48:57 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id et9so10009872qvb.10
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 14:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IGPM3kIQ3cH8DVRktTqCQ+pgb722U7zLxU+yB5IFwMU=;
        b=fmbnCJGlLR8GL2JdCyC0MIuzOfa7ov6RrpmJYGZw6GdzrofVo9kcYVw+hMwLF9aOgt
         7lSGg/BG9JMAT4zk2sQ6uIrz3FYB3t4EncjNiuFZoVEqBQhpFFyeTOp89yoQy/qNXO/K
         6bsmmiN8juaUoXGC4daezXXLG0cqPlNevp2QdhTrOqQejCNfKkw5td6sI2LnwVEOBJa2
         8Yoh48ridkUx1qoZ+zAzi6M8JGopn0zW/DRabwiM/qECk6MLaYXnjdLB59TGLHYEUhDk
         POmJEJDMubEW7OCMTFDFsgvDStMQu81KlQlCK7yZVNeky3STq24I/GM158pByhi3xDFV
         zRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IGPM3kIQ3cH8DVRktTqCQ+pgb722U7zLxU+yB5IFwMU=;
        b=Qlxl8xmKUnRK73+sui6dYUxKjkVHWtaPBHHiURezkZ5HfYF8K0N3yHFPxrNj1XxQT8
         VTVkmb/3YkFZJyNgKcRprVcEoEa3OOUrW+g51xU4XTEWWkZUurerDcc9Ed0C24teD0pI
         XuYARcbxR59rrrBJokcYoP2VUg69Wh3OlWVOm4EXPm1fXxf6/Bd3O9A84HxwKpfbZwRA
         o7kn2qOPqWWTbsrQL3ea6fwjscqJCkq56vmU4ZDjPtRIxONzidnkRE2xP7d4zyj7lMda
         LdCZI9R9uesT10rftfVoB2TKHr6C30GUj0j/XNYSBG40h+pALT4f74kZCB1YbSqeYoe+
         PVkw==
X-Gm-Message-State: AOAM531HLkq377vU8vlRvw2hY91dlJldaGYQVHoszF1ugE+KEjU6DUru
        5J+E4Ub6Ppzgv4O82o/k+wIRbA==
X-Google-Smtp-Source: ABdhPJy7O1QslkLDvH22wHCYExA/34tftyEk46TXIYfdwDnUE7UkiPisWvzVr1G0W1F9F3hDLzuzPA==
X-Received: by 2002:ad4:5b8f:: with SMTP id 15mr6591264qvp.1.1611096536729;
        Tue, 19 Jan 2021 14:48:56 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:ed38:94a5:e78e:2d58])
        by smtp.gmail.com with ESMTPSA id s30sm57284qte.44.2021.01.19.14.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 14:48:56 -0800 (PST)
Date:   Tue, 19 Jan 2021 17:48:53 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 00/17] Add directory rename detection to merge-ort
Message-ID: <YAdh1XTvDhRzGTiC@nand.local>
References: <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
 <pull.835.v3.git.1611086033.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.835.v3.git.1611086033.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 19, 2021 at 07:53:36PM +0000, Elijah Newren via GitGitGadget wrote:
> Changes since v2:

Thanks, all of these look good to me. I appreciate you addressing all of
my nits :-).

I couldn't find anything to write about in the last clump of patches, so
with these recent cleanups this series LGTM.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
