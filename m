Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45DAC433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 06:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6E5661C14
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 06:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237915AbhKPGJk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 01:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238637AbhKPGJi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 01:09:38 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AF7C061714
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 22:06:40 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id i12so15013220wmq.4
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 22:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d/VgoClh4VDJ4MmiWhiV6SR/ac2nIByzY56ax469Xrk=;
        b=bGokjxo3DKB3Rd4QOX30aQ2Zxw/bV4Xwx7aXn5OGJblhv0rkeeVDiwHIAPpGPSh3R3
         hUUx8Hv4qr0Fve7i0/aA4jkXHlG9DTQadMUiUJ3wLDmwz5tqcEYa9gI2Zp7tc7plkAeC
         4AujhKKDA/izozNv1bX4a3P9VUAdHTqox0V+jXuLuqgg/ecFytfleqqo6FUkdo086D3L
         +z4xjwBlLY65fnTHA2X0KZWqZ6fFDoL5izdIvIBvou2AqwTVoLWli28pqIsPVUwhnNVX
         i7ZEBnMIWzpl/V0hDp1wqH2C4YcSDuW4wTYrLf8GkLnmY3VFgc5kVpmdqMjRPDyawjFa
         PchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d/VgoClh4VDJ4MmiWhiV6SR/ac2nIByzY56ax469Xrk=;
        b=j4qsEWT3qoR4HyVD4aTZDghcmQEuDcd8BJNHysLelseH8UkxJVyB+UDsCGJmRouZcd
         H2Y0MRJ+CrCdC7rzEdXBf/GLCTMqoxvbK4lhhRehhC71Wx03/cIXwDzDu3kd9dmdajbI
         EjriQeyoGTX03AlJN53U+yURQZShZsbaA27giJU/IOYrjdevBeYKjvWIDqfHDzhJqSuI
         BrUO9kA9q+Vz3zNOopfSr3p/0nbyTISFgkUuA+Tc9E2z3d2nZR09YS9GE8xf9Zq1snJn
         JpwFB89xxbSM3+7Ct1F2l55aVN513YMVuAt7AVCli/4DjqiJ194FJtQ/e8zwDwuVmzcJ
         2csw==
X-Gm-Message-State: AOAM532t9THnjhiW+uTkUiKfjDOUvGKClUnkFK2F1c7VohrQhxMfm5Yw
        lVE3AyavmYnKqh6zAoE+r9riANAdxG2pSw==
X-Google-Smtp-Source: ABdhPJzhjNlfQXWUxa+NUwXMhyVVeKsUtuSzvx2l6/HMkUkt360EhZQHkdRhs3H3ycm+dbWlJPBqEQ==
X-Received: by 2002:a7b:cc07:: with SMTP id f7mr66624024wmh.106.1637042798957;
        Mon, 15 Nov 2021 22:06:38 -0800 (PST)
Received: from gmail.com (194-166-84-189.adsl.highway.telekom.at. [194.166.84.189])
        by smtp.gmail.com with ESMTPSA id y12sm16192800wrn.73.2021.11.15.22.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 22:06:38 -0800 (PST)
Date:   Tue, 16 Nov 2021 07:06:35 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2] sequencer: do not export GIT_DIR and GIT_WORK_TREE
 for 'exec'
Message-ID: <20211116060635.uy5ry5huwxo2hsxy@gmail.com>
References: <pull.1134.git.git.1636738973089.gitgitgadget@gmail.com>
 <pull.1134.v2.git.git.1637041986945.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1134.v2.git.git.1637041986945.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 16, 2021 at 05:53:06AM +0000, Elijah Newren via GitGitGadget wrote:
>     sequencer: fix environment that 'exec' commands run under
>     
>     Changes since v1:
>     
>      * Fix wording in multiple locations pointed out by Johannes
>        Altmanninger
>     
>     Note that Johaness Altmanninger also suggested some additional
>     GIT_DIR/GIT_WORK_TREE and --git-dir/--work-tree testcases, but since
>     those change the current working directory to the work tree so that
>     GIT_WORK_TREE ends up being '.' in every case, I think it's straying a
>     bit from the point of the test. If other feel strongly, I can add them
>     in.

Yeah I also think it's better to leave them out for now. For one, the
GIT_DIR/GIT_WORK_TREE test is not really interesting. Next, things are not so
obivous: I'm not sure if --git-dir/--work-tree should export those variables
to exec but that can be investigated later.

This patch looks great.
