Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13802C48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 22:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D984B6109E
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 22:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbhFOWDJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 18:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhFOWDI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 18:03:08 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1D7C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 15:01:03 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id m2so224965pgk.7
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 15:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nh3Q3rw3DnXfwtvO36KAf0GLWtD757zWa6Jude30LK0=;
        b=SGlLYqesOhc59SrymcvLqZfyNbx3PM4C3oWQwPVgHagVNXSYYDZh/+3S/npx4uNCsT
         z9ObiF8S2pbIE92NcpPA7TiCuUso00gyaXp0EnZEkUPS3NMNdDL26+Zl5wqEgm3FcM93
         SO/QtUV3FVLcDZw5eSnvz1k80qOqHJjVBE5I+ZFSIl0h3oP8BAS/u/0dSJx+TydpWPIW
         BBDYD441Hl8C0QNncLMRp3dy3uYxD1d7zPZJbapvDy6tKcpS2FzHGLI3SpZJv5PIR3gX
         7nhy5ZNbI5V9FGU1x59HpxtZTQBUxLhbVAbPF4wS+eFqYesSO68F4Efi60NxNay31Eyr
         w2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nh3Q3rw3DnXfwtvO36KAf0GLWtD757zWa6Jude30LK0=;
        b=lziuENjEJaVCGSHFNM02Mqxv+oCxPZ4H5XsdP/GM2q5kHF5bBpMQlU3wciEnWDKyZY
         sU/jnHVHPaJywLVTkhgvWiJKjEAQIDh7VVOP5tKZ/gdgrK+sxm6qat8SSS2wlB9voD0V
         gQ1hQLkQSoQgbkizL8Y6y3/XpepJel6yPvlz0v2A0El9yz+wRry2y36VUk8BsFREOmJY
         phVNrz9UsjHgaxP0GUscikNtP0kTd/O/j4cgsnFCA6ub7pDPsdjxr7KvZ1QaYS7Y9EJz
         uoUZmYc66CiHmpKSzyVnf/qN+Ws7bz3vu3OtzQnEaLvv6TqtbnrWPXpS6smNI4hQRmDT
         6q8A==
X-Gm-Message-State: AOAM532jyxSaaLDdxoZOMuAAbWZvpBCad3HoAbM1ct4/9ru0Vf8mIbzT
        c7r/7HmqOSGujveLFLKNMI7DSw==
X-Google-Smtp-Source: ABdhPJwPV7woaBMeaK7CvcPEoiVTUm4GXBSFYBX+NglsQZ+jL7QllevkXXjRHrrhxRtzhYOQbOvLiw==
X-Received: by 2002:a63:4b5a:: with SMTP id k26mr1617246pgl.105.1623794462835;
        Tue, 15 Jun 2021 15:01:02 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:d4cc:f4a9:b043:ff6e])
        by smtp.gmail.com with ESMTPSA id z205sm119819pfc.165.2021.06.15.15.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 15:01:01 -0700 (PDT)
Date:   Tue, 15 Jun 2021 15:00:55 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] introduce submodule.superprojectGitDir cache
Message-ID: <YMkjF+TN05lM4IJV@google.com>
References: <20210611225428.1208973-1-emilyshaffer@google.com>
 <20210611225428.1208973-3-emilyshaffer@google.com>
 <xmqqzgvtxcas.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzgvtxcas.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 14, 2021 at 02:09:15PM +0900, Junio C Hamano wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > Teach submodules a reference to their superproject's gitdir. This allows
> > us to A) know that we're running from a submodule, and B) have a
> > shortcut to the superproject's vitals, for example, configs.
> >
> > By using a relative path instead of an absolute path, we can move the
> > superproject directory around on the filesystem without breaking the
> > submodule's cache.
> 
> As the function this new thing is added assumes the modern layout of
> having submodule "repository" in .git/modules/* of the repository of
> the superproject, it is rather easy to move the whole thing together,
> so recording it as relative path is all the more important.
> 
> Can a submodule repository be bound to two or more superproject at
> the same time?  "We assume no, and we will forbid such a layout, and
> that is why we can afford to make submodules aware of their
> superprojects" is a totally acceptable answer, but it would make it
> easier to follow the reasoning behind a design change like this
> series does if such an assumption is recorded somewhere.

Thanks for pointing out the use case - I can see this happening in some
case like adding a source code dependency from a few projects at once,
so it doesn't sound too far-fetched. But no, I don't think this method
of caching can support it; I think forbidding it and saying "if you want
this to work, use a worktree" is pretty reasonable.

Will find a nice place to write it down.

 - Emily
