Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440B2C43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 22:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1149B20774
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 22:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uwO7gRqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgCZW10 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 18:27:26 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:56185 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgCZW10 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 18:27:26 -0400
Received: by mail-wm1-f46.google.com with SMTP id z5so9189201wml.5
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 15:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iTdlJOByW9ZVhbVaJkUfIP8J7n4g5iP4a56EUJv8F5w=;
        b=uwO7gRqm1Aw8pQDkzGaR+VNkOW8qdJGQ7oRmr0SFhshL4Sv/ZFVvmNbD/EuWygz6SM
         r1BvOJXBZ6dhooFb8XwxRf+I2ftYly6JaPsHNrlJ8i7Jjph7SC2EGL2z4u3lGnFrIxKL
         WCE0YlyZ0LnX+BPMgaXBSNDDbfAEx/VxQrgIhNs6soH9xalsXdY2Kh8ifmBQHxvlzgAc
         eOWiGy600rQ7TzT5uhXYVNfMk+1FG4T0Cs3DYA/wn4V6cUaD4QftrHKiSoeeF0/44IXM
         /6AojU86VBAbtnMHUNhbUgbgYby2nJrLxc2KtWXu1eJdfb5Mb+RNbb8hiPRbZQjm+VPq
         QGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iTdlJOByW9ZVhbVaJkUfIP8J7n4g5iP4a56EUJv8F5w=;
        b=pcR6KP77SVlMMAOeOrc1nNcOVSlcn8TclnH/tdaUr2agc//dy/o5IwE9hQzI7tWXCa
         LdmuvaculH0WDrl1l/Ncvb5a8DL4g2cSIo5a/Cyv4RqHPLHh2/hPq2t+44Iq+FGE2DjY
         zGZjg38HyEKdkoTZy7Y45iWZQyCun7QYseL48//OKMEge6hMdxfAVuoSb4DX9qBIFVOk
         kY8ODEtvJC9jFUWyHVLP7wnpiAEaAJewOU0gtYL7aYYAs35PLfB0mscXp+Ye/bm4WyOH
         WkjDxbmDM+hhd7TALrJYuMgeOLNwmj/8GS7xs9KL6WYKfKIuItzsnxDJH58pAAY5cL/2
         QxSQ==
X-Gm-Message-State: ANhLgQ3lDeS7COoQPRFnbCCGFBdiVIynxfS4zchcncpWj3z8dJmz7s2F
        DDvGIe1yVm+tSPjkVLir8Ak=
X-Google-Smtp-Source: ADFU+vvi78AHQXFkJ3otbAvjmhtcOWV/mIATj79O84qbFzDKxaO1BCd/OtzxdC7FvC1RF8QLiYdZ1A==
X-Received: by 2002:a5d:66c3:: with SMTP id k3mr646321wrw.407.1585261643909;
        Thu, 26 Mar 2020 15:27:23 -0700 (PDT)
Received: from doriath (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id f187sm120192wme.9.2020.03.26.15.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 15:27:23 -0700 (PDT)
Date:   Thu, 26 Mar 2020 23:27:20 +0100
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     Konstantin Tokarev <annulen@yandex.ru>
Cc:     James Ramsay <james@jramsay.com.au>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [TOPIC 3/17] Obliterate
Message-ID: <20200326222720.bkqkhalof6s2srfq@doriath>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Thu, 26 Mar 2020 22:55:13 +0100
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
 <5B2FEA46-A12F-4DE7-A184-E8856EF66248@jramsay.com.au>
 <20200315221940.bdgi5mluxuetq2lz@doriath>
 <3839451584363302@sas2-a098efd00d24.qloud-c.yandex.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3839451584363302@sas2-a098efd00d24.qloud-c.yandex.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From Konstantin Tokarev, Mon 16 Mar 2020 at 15:55:39 (+0300) :
> > My situation: coworkers push big files by mistake, I don't want to rewrite
> > history because they are not too well versed with git, but I want to keep
> > *my* repo clean.

> Wouldn't it be better to prevent *them* from such mistakes, e.g. by using
> pre-push review system like Gerrit?

So my coworkers are mathematicians, and not all of them are comfortable
with dvcs, and I already have a hard time convincing them to use git rather
than dropbox. I take it upon myself to make it as easy as possible to use
git (by telling them to push to a different branch when there is a conflict
so that I can handle the conflict myself).

I don't think Gerrit is a solution there...
