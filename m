Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796B8C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 05:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 563EC20721
	for <git@archiver.kernel.org>; Mon,  4 May 2020 05:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fpu4GvSG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgEDFzi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 01:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgEDFzh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 01:55:37 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E16C061A0E
        for <git@vger.kernel.org>; Sun,  3 May 2020 22:55:37 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t40so3245930pjb.3
        for <git@vger.kernel.org>; Sun, 03 May 2020 22:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=xlE0xlBdPOXRZGSwS7OBpA78Ddv0z9aXm1KXuxqesKU=;
        b=Fpu4GvSGkGKCZDnyH3CQS6a9eXNhbTOtDYcY9VunZeLNxd3ruHFKk1ZCgHCEsAB7oq
         srHeBmCsPquOEb03GmpqsazzAZqrO4N7tU8RV+S99eMSaekqgUbBUoxz0I9PmywUkFpB
         cOD4hlaE2SDZFjxIYPqMTfu7YnPOU30ntVgipLjDxaZCsuvya/c1UpMCVkWVekqhRO9d
         Td9OC9girKGnXTFm0/xHXYc8wSfMSycP5074qlW2zXv4FqwCyNMw78wmmW2QgoYjndNL
         dPCMuFk/rs4d0N6eUCnyL29w7c8cerk3MxsF6pva0gFzsBcJXEdTTRmnawCKagGQ2lof
         tmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xlE0xlBdPOXRZGSwS7OBpA78Ddv0z9aXm1KXuxqesKU=;
        b=rVgPVZLhuyp6YHtDYV22Xdd7RPvcSlgo6dgB7+8I3mUxXImZgqYqDqQNpjt9lbuQja
         h9cUVOkA2Kc7leqIWr5rvXo9AT0rismwhD1N5RzD80yKLtlzSUPYaQ8Col+lVyjt87PD
         HD60N1db/X0T/TZSifOGcrmG4AxyK87q6Kmi4uSByts6a1gXNJdedwgJOchaj42FYu2b
         pCOrZ6SbKhANFw8Oy108PfsUYLK+yOMcrDmRMbKCQJ7pqRrRh7Q4nrarB6BVyzqv4LSr
         n5cUw7WdOMt2/zL7AB1ba+Zj/YjaSgS9NaR7AaKlzIXN69VAD16lcVZizV+2Sr3fvgGS
         6Mfw==
X-Gm-Message-State: AGi0PuagVmlX95DEy9AseqYtnBhmJ4Wl4MbGRetGA/LXjxYHOXMZ91L1
        Rf1bX/6+Lz0VgfqOpBQhMiGFDPqXHvg=
X-Google-Smtp-Source: APiQypIp1fVOmBdTmJV2kcIchAHT82vq+c/pVY8ikfDoD3u1msqgPXKfWwd5dXcWJGLg29/6xL90Tw==
X-Received: by 2002:a17:90a:9311:: with SMTP id p17mr15218330pjo.145.1588571736926;
        Sun, 03 May 2020 22:55:36 -0700 (PDT)
Received: from konoha ([103.37.201.176])
        by smtp.gmail.com with ESMTPSA id y24sm7796540pfn.211.2020.05.03.22.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 22:55:36 -0700 (PDT)
Date:   Mon, 4 May 2020 11:25:30 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     kreska07@gmail.com
Cc:     git@vger.kernel.org
Subject: Re: file is showing as modified even that it was never commited
Message-ID: <20200504055530.GA13290@konoha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEoQP9iY-0+=ETA0vrHL0HngccwtNA_3KX4WSSokJpOgJDGUeA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Ewa!

This might be the fix for you:

A `gitignore` file ensures that certain file(s) which are not
tracked by Git remain untracked.  However, sometimes particular
file(s) may have been tracked before adding them into the
`.gitignore`, hence they still remain tracked.  To untrack and
ignore files/patterns, use `git rm --cached <file/pattern>`
and add a pattern to `.gitignore` that matches the <file>.

Most probably the '.idea' folder might have been tracked before adding
it to the '.gitignore' and hence it shows up in the staging area (i.e.,
when you run a `git status`, it shows up as modified).

If there is a doubt still, feel free to drop a message here :)

Regards,
Shourya Shukla

