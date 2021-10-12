Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631E1C433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 22:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48D7760234
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 22:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbhJLWmf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 18:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhJLWmf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 18:42:35 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2671C061570
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 15:40:32 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id q5so450032pgr.7
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 15:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=bX//4eqvFQOEWi/RY9D+pDr9Qy6jfi9poO4RyhoaNRY=;
        b=iNf/Xl8BV5zhabB/GPWwYQ4OAYg/ohc6y8O95oYMFLbXAil/oXmxPAAfg6D5FHnZrF
         SM3b9/V0DWZvc7AS1ooabx57bg5ahtucmi6mGI5sh4sk8kTQXQCZ4wQpYWLTLhhyrji3
         FApld0emHAOG+JsDbrGlnIX+3obOz/mBVx2e9+srVuIa8IGvOkQi17wepQ18uLM0/gsy
         gZUH+6T1Q5c/PAgxjDZhduQMjg/UQji0khtmw5/MAEoyU59sTR/cqPW5tWNZK/oiZj03
         2QdjMm4EfLGoqQDFuTNDQd4W2iwwFuuSb2VD2CpZ/iASOVsbHD2HZ0+G9FZlqPCkRWQR
         XBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=bX//4eqvFQOEWi/RY9D+pDr9Qy6jfi9poO4RyhoaNRY=;
        b=qN105IzgV+pZn3vUzwFsNH0IJIDoCTAlp/TMAopANEd4gn4LpnxPb+6XoC0avcGt9Z
         PtL12kg4fFWpGZYS3+TDCxXrKR4JDihIv3TTLT2WxIGmNQfWy/DFb3UfnKiPIUcLsvdl
         hMXoq0NlMSl0X8fRw0Ef5ufKOi2ANuCppSKyrcNhAGbUKBcrJC+UAbLZNYkwRx0gMIzy
         epFpiwheVA/cSssRO6lLm4Gey7IjxfDMcCb1LbZmJrWyqDozLO1/qlkEYOJNb+RlyNuv
         bydyenQYscvi58GSKkpc5uyb7onX2L8r+9naxirUoqMzCQrgzI07siXeYJmvxycoe0ID
         PWCg==
X-Gm-Message-State: AOAM5316vskQYh4NgYgxNirGtY/VfIOzbkG4UwoUMpk8exfk4RnEiwOa
        UuQwGG4o+YdxpLwxoerxBcQniA==
X-Google-Smtp-Source: ABdhPJzfCK5ZaoKxTKrZodbZi8f9JfC3eyCQJekLBZz/LfcPzhgFT1EXrqKWUyYwZO11o924wBIx3g==
X-Received: by 2002:a63:b94b:: with SMTP id v11mr16469019pgo.145.1634078432237;
        Tue, 12 Oct 2021 15:40:32 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:d98e:8024:1d57:3752])
        by smtp.gmail.com with ESMTPSA id i2sm3812518pjg.48.2021.10.12.15.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 15:40:31 -0700 (PDT)
Date:   Tue, 12 Oct 2021 15:40:25 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, carenas@gmail.com, chooglen@google.com
Subject: Re: [PATCH v4 0/7] No more adding submodule ODB as alternate
Message-ID: <YWYO2TO5tg98oy5q@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        carenas@gmail.com, chooglen@google.com
References: <cover.1632242495.git.jonathantanmy@google.com>
 <cover.1633727270.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1633727270.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.10.08 14:08, Jonathan Tan wrote:
> Thanks everyone for your reviews. Here's an updated patch set, including
> Carlo's fixup squashed.
> 
> Jonathan Tan (7):
>   refs: plumb repo into ref stores
>   refs: teach arbitrary repo support to iterators
>   refs: peeling non-the_repository iterators is BUG
>   merge-{ort,recursive}: remove add_submodule_odb()
>   object-file: only register submodule ODB if needed
>   submodule: pass repo to check_has_commit()
>   submodule: trace adding submodule ODB as alternate

This looks good to me. All my concerns from v3 have been addressed, so:

Reviewed-by: Josh Steadmon <steadmon@google.com>
