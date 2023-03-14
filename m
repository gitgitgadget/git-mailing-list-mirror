Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0F6C05027
	for <git@archiver.kernel.org>; Tue, 14 Mar 2023 19:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjCNTSj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Mar 2023 15:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCNTSh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2023 15:18:37 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C17CC39
        for <git@vger.kernel.org>; Tue, 14 Mar 2023 12:18:36 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id t13so6023688qvn.2
        for <git@vger.kernel.org>; Tue, 14 Mar 2023 12:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678821515; x=1681413515;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0rXnRi78kVA55eog+QVx6gFdZnD65YyBBNk3+Mo3SYs=;
        b=W83e7p3mLRu1HqVEB1O31kOOiZq0Q1VAOMQdtym++YZheI89Ov69I+5lAOmUBRVb+W
         rCIF1bRllj9uKwVmL0Si22ZatceaCK11J/wTd03+TU9ZLTLgVvMbRADQLfhVjlQ9eYy1
         yNyhDBACofGUsU5nENV2I6bk5v87ulbR5o4mYSpetq4TkRuMHSCStq3qSnKl8TtjslzV
         WVNf6GhmdgcnY96k8S4C6BD5jC4NUI748ROCw5S0H+hK7clTncHmEtqRpKOME9qEvxXN
         IOrWkD1xB9Zr6aTNdvMKCRqMgB5qSmhMmcxUDWZxT6G1+xJ5oPcLWvibXE23/Uz41eXk
         CvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678821515; x=1681413515;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0rXnRi78kVA55eog+QVx6gFdZnD65YyBBNk3+Mo3SYs=;
        b=twi7qKcy33hR2+7Lctnhl8Ebl0Mb/6a3TlnvVi5VMmAtr/bFGejeeKlz0m2/9p6Enz
         E/L4xgd8EX7Qs806rH+CKY85wHaA0+Oko6RhSTK8wtLjPLYm2Cug+NYG6OcxY94p3NJJ
         Vu2atYzJyLKywIJ6RKvbaat0I5pBOLUvqDBOaiBjGHYffY3oiRPlur59+gmz0ROXd8Yn
         JPNUFmYHuUU0W3xjHNmimlJEflVXf3IkRCt/KzxsoiwotgAGBfhUcp5Gv0laLnCjUva7
         y1A6NigAXnQwJoZQ8vepgrBFJ+GT8Xyc0Ykgd13py4ZrP18EsJf4b+y4SoPIwmGjOYQt
         1+uQ==
X-Gm-Message-State: AO0yUKW4gZR6j/onjGFSZWPmxp45sNbJFEwhGk5X13lJF9OmTa6LcCcx
        WfzkQ9kZtDH10IkgQ9l4F//umuEfohhipw==
X-Google-Smtp-Source: AK7set/INY+w56u12/U536UZcycpXjh9q8seOgjp4DSUoWXMsgN2d8IUlrAHs3MR/affn4JnYq5xOA==
X-Received: by 2002:a05:6214:2401:b0:56e:f7dd:47ad with SMTP id fv1-20020a056214240100b0056ef7dd47admr1370722qvb.5.1678821515040;
        Tue, 14 Mar 2023 12:18:35 -0700 (PDT)
Received: from localhost (pool-74-105-67-34.nwrknj.fios.verizon.net. [74.105.67.34])
        by smtp.gmail.com with ESMTPSA id 201-20020a3705d2000000b00745a78b0b3asm2237586qkf.130.2023.03.14.12.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 12:18:34 -0700 (PDT)
Date:   Tue, 14 Mar 2023 15:18:33 -0400
From:   John Cai <johncai86@gmail.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] diff: support bare repositories when reading
 gitattributes for diff algorithm
Message-ID: <20230314191833.qmiisyvsu2ppu4sh@pop-os>
References: <pull.1459.git.git.1678758818.gitgitgadget@gmail.com>
 <ddd7cbb6-4f4d-ba0e-857e-5981779326d0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ddd7cbb6-4f4d-ba0e-857e-5981779326d0@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/03/14 01:21PM, Philippe Blain wrote:
> Hi John,

Hi Philippe,

> 
> Le 2023-03-13 à 21:53, John Cai via GitGitGadget a écrit :
> > This patch series adds support for bare repositories for the feature added
> > in [1]. When using a bare repository, by default we will look for
> > gitattributes from HEAD. When the --attr-source option is passed, we will
> > try to read gitattributes from the commit.
> 
> When I read that I immediately thought of the config settings 'mailmap.file', 
> 'mailmap.blob' which allow the same sort of thing, but for the mailmap.
> 
> For the sake of consistency of the whole system, maybe we would want to support
> 'attr.file' and 'attr.blob' ? In that case, maybe we don't need a new command
> line option at all...

I wasn't aware of those config options. Indeed that's a good option! My only
concern with that is that there is already some precedence for passing a
<tree-ish> as a source for attributes in [1], so I thought adding a command line
option would be somewhat consistent.

But I can also see the benefit of using a config value since there is also
precedence because of mailmap.file and mailmap.blob. Not sure what others think,
but this may be the less invasive way to go.

1. https://git-scm.com/docs/git-check-attr#Documentation/git-check-attr.txt---sourcelttree-ishgt

> 
> Cheers,
> 
> Philippe.
