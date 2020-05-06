Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70E3C28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 04:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3C9C20752
	for <git@archiver.kernel.org>; Wed,  6 May 2020 04:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLzslkFE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725782AbgEFEAz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 00:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgEFEAz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 00:00:55 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7FDC061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 21:00:55 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id f15so2400plr.3
        for <git@vger.kernel.org>; Tue, 05 May 2020 21:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=W8c5S2APGHsgTjD7g/x0c2izOs5KmUBm3VOpo5F57XU=;
        b=NLzslkFEeNZOQsu7uhV7RK2xePoV+xx0Dia6OWXp2hKJwtaf/6lnOa2uH5Bhkn7y4C
         LS9pVbUprBo9UjXYiBlWr7EIubAdC+0r5cDELqmv0waW7sb2kRv4OjsZov5DZEbWPeqs
         Fh6dpXeSx7iQ4t/TQl8e+Uyzq3jYMVNKTDVZG+Ph/D8XAw+58PTbvHeiGrQyOPd8fot/
         eBdmPgxvS4jnSc4orn2qA78O8FovNkzsogw6zZQgiVLr5QAVTl/rQ0SbdE+NVu3SNc5H
         jI0rQ7MLg58CODZJW1IbsaJQHW8hGfQQeYxAXocf4EtfOM1YEBmff+7kiqTA+PFw1NTH
         7VlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=W8c5S2APGHsgTjD7g/x0c2izOs5KmUBm3VOpo5F57XU=;
        b=MKz6qL8TXtJCVtwCo7KKQJHu5BkOLilg3BA68sfwn0Pz4rfw+YVDVd+HUV1mZiOUZF
         Ofpeuo4uGy9vVes+8gsY2wKUpmzVhd/J1C1To9lxSz1H0cggAalIoc+sp4O5fx5/bSyG
         TMYFxWn2JT1J6P0m9WWkkDwH7YU558pDfEEzQ7ezPueznq7TTYk4IbkQd/T8JSzb+PPq
         w7IFjo6AxFCjsxeS27vAwOtwu3xEy0Kf/pM01+zpjUii/PM/ZHAMF6LrUyGuUGY38Uot
         4WlCS4/Ao58y9OlBSJd5y+Jwysuab1/ATxcJ0fsNKOUNMkguvDy+N5s82vYMoQQaiyr4
         1GsA==
X-Gm-Message-State: AGi0PubPOE3/MZJm1fuyKayFKFDcwCuufl+dwrikmj49uS8GK2QNTXQu
        NCfgkyfZPnUG/j8JHooJN/mUThC3A1w=
X-Google-Smtp-Source: APiQypJxX2bLHHhaFPtS3TV7YMXLOVUQ4NXyeYsJVRB+zUVsowkag+6l9uzoN6GdhUyBWb3tOG1Rjw==
X-Received: by 2002:a17:90a:252f:: with SMTP id j44mr6673581pje.9.1588737654328;
        Tue, 05 May 2020 21:00:54 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:a8c:9ade:2a5b:e2af:27ac:f0ce])
        by smtp.gmail.com with ESMTPSA id z1sm3323079pjn.43.2020.05.05.21.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 21:00:53 -0700 (PDT)
Date:   Wed, 6 May 2020 09:29:28 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Anthony Byrnes <byrnes.anthony@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: newbie question - how to upgrade older existing git version
 2.9.3.windows.1 to latest release
Message-ID: <20200506035928.GA5115@Abhishek-Arch>
Reply-To: CAAULzeKqsx=ajDQ3y7F=UXUok1ep9PFkEeh0ZL34+765WQ9xvg@mail.gmail.com
References: <CAAULzeKqsx=ajDQ3y7F=UXUok1ep9PFkEeh0ZL34+765WQ9xvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAULzeKqsx=ajDQ3y7F=UXUok1ep9PFkEeh0ZL34+765WQ9xvg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello!

On Wed, May 06, 2020 at 02:51:06PM +1200, Anthony Byrnes wrote:

> hi,
> 
> I have a working git version 2.9.3.windows.1 on a build server.
> 
> What is the correct/recommended way to upgrade to latest release
> without breaking any git settings?
> I am very scared of breaking any settings ....
> 

From the Git for Windows FAQ [1]:
---
How do I update Git for Windows upon new releases?

This depends on how you installed Git for Windows. The bundle
installation requires you to download and install the new version. Any
customizations you made will be kept as long as you did so in the
appropriate configuration folders.

For advanced users working with the Git for Windows SDK pacman is
available as a package manager. See Package management
---

In principle, you could uninstall Git for Windows and re-install it
with the bundler [2] and your git settings should be safe.

[1]: https://github.com/git-for-windows/git/wiki/FAQ#how-do-i-update-git-for-windows-upon-new-releases
[2]: https://git-scm.com/download/win

> Git downloads page implies this might work, but I am unsure as to what
> this does....
> 
> 
> Git via Git
> If you already have Git installed, you can get the latest development
> version via Git itself:
> git clone https://github.com/git/git
> 

This installs the *development* version of Git. It's primarily intended
for developers who want to contribute to Git (either through writing
code, documentation, testing, packaging, etc).

As you use Git as an end user, I would recommend installing through the
bundler.

> 
> -- 
> Hello World

Regards
Abhishek
