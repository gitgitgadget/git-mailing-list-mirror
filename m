Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975B5C38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 08:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73DC6208CA
	for <git@archiver.kernel.org>; Fri,  8 May 2020 08:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYlXuBBP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgEHIdn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 04:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbgEHIdn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 May 2020 04:33:43 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E09AC05BD43
        for <git@vger.kernel.org>; Fri,  8 May 2020 01:33:43 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id js4so1908643pjb.5
        for <git@vger.kernel.org>; Fri, 08 May 2020 01:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5FVLS5k0x+vL75K7xLAZWoRnvNeal1sdhuxel+JOjd4=;
        b=UYlXuBBP+sC69ivZks+Y8Z2LwXueNtgj5H4ImrE55igFuo6M6RdnT/jx/iYcQ3tfe2
         OkuOIbF4Ak71pBkjUyBt+OVLfx4gZOZb/YDriHwLK3gkpVz3S8Mun70IObuiQzSYUYss
         22nueRZ7AUAbEHHXAl3wUVKPsh2RqJZ8wiMjbT48Jr2/viADVT9wQ4ng/Z3F+PkT20Xm
         kXnNszkwqYiuV2sWayYV33MUo6EyxCfXM2ckaX4455ryi+jlTjj7TSoR0SDTSK3xjpbL
         EEQl9Kf0hWTpzSkudn/xbo5QDRWWO4rF9csPnx0x3Kb3xcYKaIIRXjWxA3Uau7miYMDs
         uTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5FVLS5k0x+vL75K7xLAZWoRnvNeal1sdhuxel+JOjd4=;
        b=txtCeR/pHAkvZGQ2+Ah/rLESvMQHuT1ulofTDRwCJVOO+KDW+0ouiQIWs7A99veFmC
         Zmtlfdy/eBAUrsQByCgpGXy2sAoBjSBGJpHNtfhwPFnyKHua7VGbleDaZZ1Bji280oUK
         RyLHxYTjvOQyK2+xJQvGfVXWTddgSZOB+rq4Bd5uudY/TjZguccFfkrBpkSqI1vIG/n2
         HqYthDXStstBGdJtI1KEM3zaY+Fdc3PY3SxHmoTqThA5gie9iG3XJM33In7fRUhQHivq
         852+WHKMp0r+cMnNmj7a+s/m1+UIce83+CaFj8QE8b0zGE7ZmQSW3lGxcASvQE4uVilv
         GrrQ==
X-Gm-Message-State: AGi0PubOG+RMWCSK7uhEfCP2sjRrlRdEfPmS4nQezgtxy8hEr8AUV91Q
        M2jsR9yhIkfQSIRPNEBn5gw=
X-Google-Smtp-Source: APiQypKOM1NnmmVgQCVHY2hEkNyd1+br40J/Ifut3ZKJza4OKGXl3IDiy1SbrLzjacXcq5mY6TVVyA==
X-Received: by 2002:a17:90a:fe07:: with SMTP id ck7mr5137682pjb.216.1588926822503;
        Fri, 08 May 2020 01:33:42 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id gz14sm1840061pjb.42.2020.05.08.01.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 01:33:42 -0700 (PDT)
Date:   Fri, 8 May 2020 01:33:40 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Force Charlie via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Force Charlie <charlieio@outlook.com>
Subject: Re: [PATCH] Correctly initialize 'installed_handlers'
Message-ID: <20200508083340.GA36538@Carlos-MBP>
References: <pull.630.git.1588921514146.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.630.git.1588921514146.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 08, 2020 at 07:05:13AM +0000, Force Charlie via GitGitGadget wrote:
> From: Force Charlie <charlieio@outlook.com>
> 
> Because static variables are not initialized properly,

what do you mean by "properly"?, all static variables are set to 0;
that is a warranty of the language (all the way to K&R) and any C compiler
should enforce that as part of the standard.

> temporary files may not be deleted when receive-pack receives a signal.

the way this is handled would seem to indicate otherwise

if (!installed_handlers) {
                atexit(remove_tmp_objdir);
                sigchain_push_common(remove_tmp_objdir_on_signal);
                installed_handlers++;
}

there is no explicit locking and so there might be a thread race
condition, but the code below wouldn't make a difference in that
case.

could you elaborate more on how to reproduce the problem?, I suspect
that if there was a problem then suppressing whatever signal that
was triggered before sigchain_push_common might help, but the window
is too short to be a likely issue.

Carlo
