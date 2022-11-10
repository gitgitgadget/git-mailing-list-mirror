Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CB2C43217
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 20:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiKJUgj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 15:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiKJUg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 15:36:27 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEE754B23
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 12:36:26 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id w26-20020a056830061a00b0066c320f5b49so1779742oti.5
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 12:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KfS65aY/ELmmlX6ZE+8uEGFK3U4gtAXrrjsvjo4tLDY=;
        b=T6KW8N+/96vcr0QwsymTpNUfKmCdOLI553K2FLslpCHTCvEMZcTQBRRM2wKPbysR5d
         C1mlJngruKHlQ9nzkygbwp0SOuA7aL8fIdaLVk16rSvMNePb/8Y2oGo5opcjXIUxN+Y2
         fWeY9CrTnERHywK6mHsMERNvVPzCwR78nw/Ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KfS65aY/ELmmlX6ZE+8uEGFK3U4gtAXrrjsvjo4tLDY=;
        b=R1UoMXsHf1zhOCuM03TiEdS9fV/aOSVGzczXeRKDnrgNBbzzALSSyPEnn3llCYKUVp
         RMCWkzMITuwxcUNanZkKRsW8rYX57PU9MnNMw5kGvT5FhhLdCeJwGm/nlaNKIwZV4P1t
         RLV5/Y2igvdNsTBrWA61OQTIdMjXWBnNlm3b+e/SYX34gUG3MWFAoigtEJL6UsaZIYj7
         k2yEhB4NjMQmwin8XKJj32O3WlWYSfHnXVfxGV63dNkNikrHPNTL9XkCeNDO+J/u3rtK
         REj9nC20U/YAJaAJsTyDzeuB+3+i7ayYLjDZlq5+Js0S06efNHqTXEdat2d/Fs1hzOKA
         z8tA==
X-Gm-Message-State: ACrzQf1z2Rd6oNjcwqWRJtNpe4yIklEmahymluIL/rlYXlDW+2Fs66OB
        ziibm8SqDrhdxs1gQOOdWmPUnYwB7L2HyjeuLxUQxDhEplg=
X-Google-Smtp-Source: AMsMyM7mH6Og2oxDbhQ7lubBMjEEPFGJzWl9PtXdjiWiX5mTP9gIod7YHSujpnfpwwwWoa6hW0oeR5pQZXhT6FJiHzk=
X-Received: by 2002:a05:6830:18d2:b0:66c:8d62:5a1e with SMTP id
 v18-20020a05683018d200b0066c8d625a1emr1896610ote.112.1668112585523; Thu, 10
 Nov 2022 12:36:25 -0800 (PST)
MIME-Version: 1.0
References: <0dec6e1e-207c-be13-ae95-294d9b1e8831@ramsayjones.plus.com>
In-Reply-To: <0dec6e1e-207c-be13-ae95-294d9b1e8831@ramsayjones.plus.com>
From:   Adam Dinwoodie <adam@dinwoodie.org>
Date:   Thu, 10 Nov 2022 20:35:56 +0000
Message-ID: <CA+kUOan=Dj4T7J57yJSg2Qh4+SQuCV0MOLKxQrZC6s1=ciOdNw@mail.gmail.com>
Subject: Re: [PATCH] Makefile: fix cygwin build failure
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 9 Nov 2022 at 22:46, Ramsay Jones wrote:
> <snip>
> [1] After a cygwin update, '/usr/bin/msgfmt.exe' refused to run, saying
> that it could not locate the 'cygunistring-5.dll' file. Using cygcheck,
> I found that this dll is provided by the 'libunistring5 1.1-1' package.
> After installing this package, everything works just fine.
>
> I don't know how package dependencies are specified/updated, but it
> would seem the 'gettext-devel' package has a direct or indirect
> dependency on the 'libunistring5' package. Looking at my setup.log file
> I would guess one-or-more of the following packages needs an update to
> note this dependency: 'gettext-devel 0.21.1-1', 'gettext 0.21.1-1',
> 'libgettextpo0 0.21.1-1', 'libintl-devel 0.21.1-1', 'libintl8 0.21.1-1',
> or 'libasprintf0 0.21.1-1'.
>
> Unfortunately, I am not subscribed to the cygwin mailinglist :(

It looks like this was broken by an update to some of these packages a
couple of weeks ago[0]; I've reproduced the problem and reported it to
the mailing list[1], so the package maintainer should be able to
update the dependency information :)

[0]: https://cygwin.com/pipermail/cygwin-announce/2022-October/010764.html
[1]: https://cygwin.com/pipermail/cygwin/2022-November/252445.html
