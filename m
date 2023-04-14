Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED26C77B72
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 19:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjDNTcz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 15:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDNTcy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 15:32:54 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AF85265
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 12:32:45 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id ca22-20020a056830611600b006a3c1e2b6d2so11715466otb.13
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 12:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681500765; x=1684092765;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBEBpXhl9bUZ0U9R2Uon+cSLV5aoFQudI2bSJwNP8EA=;
        b=MyqM48hQPhFX6SkUVtx5v5Bhn/u1KbRbyLu4wViZTvkRYtjcPY5mKBLPb7XZOT+B2J
         vOqutjPk2AX9pJ2fQKSachGGv95reG50pp/CWbLrMg4iZG0OoBwLBCDNgMMXBYVzrymK
         L0kGeNTYzhWVHEtqMEsfEN0EYPKpFV9IQbfqeZTGpRBO0ElokN32eqMxVbtYLglJkbMW
         omlfxbX1/NIbl9idIyTiSis6TQ3kFIMzyf70Wv8e9RXW7z7Q22lKCZn8gxyVHV8GvLdc
         5qOBT8JIc0HHwFZkvdsgSXEZFQL+1HF4lZYDMIXQMoBP36fPXarZ/M0Va6N7OTdCsK3n
         D0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681500765; x=1684092765;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yBEBpXhl9bUZ0U9R2Uon+cSLV5aoFQudI2bSJwNP8EA=;
        b=C5gumg6F0CgrGF5+eyeWB1ifbxlEOzqNWB4wD/3fGhBVAVz6tPxgCReg+1raMtbUQM
         8m7N6nPmPLUnwpNwWd+lgoFj9xDTDqYCRa6b+kfgRT17/F+an/Eqk5i+L3Br0XwC3DcE
         oNzLuhWZwkwV/7Hv3eYEyffGEnlLXJANoZvNCNW1FEP8fUiBMm9GvxA5086aZpKipkx8
         oyYia1cWN9bNLv4zVQkpAxWlJc4NysC9jC06JLmyksnn+YQlmLhResktY/YHAWScaEtx
         0TIVkWgWNye78kIa/J5CEX39bZIIZz1yJ55ZaJN8jPiSIv6UDE2wUFtb6tdIPUsWXxZM
         PU5A==
X-Gm-Message-State: AAQBX9dtgWQI7QqMqBjviLxgMnEWN7SKadrpkm9WwJPIWPOv1pnbtpbD
        7EUYR+o/zyZiMDe55d2wAFs=
X-Google-Smtp-Source: AKy350aXl0fDAwerF/JMAv6WXEhUgiAC6rppWIeuaT5jH6EqrmRB8eIFjwwNOVFKrxQCHV7LMv+ROg==
X-Received: by 2002:a9d:7f95:0:b0:6a1:369f:c489 with SMTP id t21-20020a9d7f95000000b006a1369fc489mr3435712otp.33.1681500765235;
        Fri, 14 Apr 2023 12:32:45 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id f25-20020a9d6c19000000b006a32eb9e0dfsm1029644otq.67.2023.04.14.12.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 12:32:44 -0700 (PDT)
Date:   Fri, 14 Apr 2023 13:32:43 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Todd Zullinger <tmz@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <6439aa5b2c776_6058729489@chronos.notmuch>
In-Reply-To: <ZDmjIqNwVMESgHnn@pobox.com>
References: <20230414121841.373980-1-felipe.contreras@gmail.com>
 <20230414121841.373980-7-felipe.contreras@gmail.com>
 <ZDltLSTxBCWRoMjK@pobox.com>
 <643991c58aef_5ecfe29433@chronos.notmuch>
 <ZDmjIqNwVMESgHnn@pobox.com>
Subject: Re: [PATCH 06/18] version-gen: remove redundant check
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger wrote:
> Felipe Contreras wrote:
> > Todd Zullinger wrote:
> >> Felipe Contreras wrote:
> >>> If we are not in a git repository `git describe` will fail anyway.
> >> 
> >> The parent directory may be a git repository though.  The
> >> current code ensures that we're running `git describe` in
> >> the proper repository.
> > 
> > How exactly does it do that?
> > 
> > The current code expects the cwd to be the git repo, run it in any other
> > directory and it will generate GIT-VERSION-FILE in that directory, which is
> > clearly not intended.
> 
> Whether it's fool proof isn't really my point.  It did
> attempt to check that .git was a file or directory.  Not
> checking at all isn't necessarily an improvement, was my
> concern.
> 
> >> If we drop this, aren't we breaking things for someone
> >> building a git tarball which is in a subdirectory of a git
> >> repository?
> > 
> > How exactly would this hypothetical person build such a tarball?
> > 
> >   git init /tmp/foo
> >   mkdir -p /tmp/foo/bar
> >   cd /tmp/foo/bar
> >   make -C ~/dev/git dist
> 
> If I have a git repo, say ~/fedora/git which contains the
> fedora packaging (spec file, etc.) and extract a git archive
> in this directory, the describe will now pick up the data
> from the parent git directory, won't it?
> 
>     $ git -C ~/fedora clone https://src.fedoraproject.org/rpms/git.git
>     $ cd ~/fedora/git
>     $ git -C ~/upstream/git archive --format=tar --prefix=git/ HEAD | tar xf -
>     $ cd git
>     $ make GIT-VERSION-GEN
>     $ cat GIT-VERSION-FILE 
>     GIT_VERSION = 

I don't think this is a realistic use-case, but supposing it is, what would be
the desired outcome in this case?

 GIT_VERSION = 2.40.GIT

?

> The version file in the tarballs prevents this from
> happening in the most common case, but it still feels like
> this is loosening things a little more than it should.

If we care about this, the same behavior can be achieved with GIT_CEILING_DIRECTORIES:

 GIT_CEILING_DIRECTORIES=$(cd .. && pwd) git describe ...

-- 
Felipe Contreras
