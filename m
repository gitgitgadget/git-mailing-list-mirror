Return-Path: <SRS0=oqjl=22=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68240C33C8C
	for <git@archiver.kernel.org>; Sun,  5 Jan 2020 15:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F3720866
	for <git@archiver.kernel.org>; Sun,  5 Jan 2020 15:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdA+Z2AO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgAEPcU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Jan 2020 10:32:20 -0500
Received: from mail-lf1-f42.google.com ([209.85.167.42]:46958 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgAEPcT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Jan 2020 10:32:19 -0500
Received: by mail-lf1-f42.google.com with SMTP id f15so34783508lfl.13
        for <git@vger.kernel.org>; Sun, 05 Jan 2020 07:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+XEK/xtJrmY/3rU31bfYKMTQ683+S/nCFkn6cNaBR7w=;
        b=FdA+Z2AOFNRO+XV7ZZA1zLy/em9+fXcBfV1FPzIDRj1oXTsNbRhI7vnftjUgpRo1NX
         gHMhKPpq2TZbPwh4xnqYKqsBViXb/Hbw6WujefPacrANITbCRpbPPZuSzfY8ue08C8Rc
         Oenfr6jVgzIZnWDEfxo1icbg+FDguwRkrSYthfUDyghWiOj2bXoZJHFlw1JXUtrwAB6e
         Wn8T926b3QlSpfJMNHF8/GkwnEE85+bfh2jc8Conz4ILqIi7Ytb7V3PR6wlnRXwYtXrl
         AxmfFdI2rQg39K5h5sM6ZP/m91l/7Q5TFoOtOnkWx4+fmB3obY5QP/te+JIG3bfBgwbY
         r4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+XEK/xtJrmY/3rU31bfYKMTQ683+S/nCFkn6cNaBR7w=;
        b=l+rzG4EfCfVgqM4bd2ok2CkD+h6F5wif6DPixvPOZ0ZgE/N3WLtiZShK5P07KPw9zV
         rCtIf1LHlDoOMa2h4rbAbgh/Lts4o2B503fvsxf8Z7ZoF9s7NM/qGIeTqFRwMDlr6lSJ
         oV6FB+B+xO8YtLkO9rXkSBpflE2OEoZdpMbp3gVuAJLpgwBnOvjTtD6pURjqSEt+/60F
         0LhlHbB66dThsTlpEmKeGQcyTHMUZAxieA420tKAlbbMmluRjnyNVWawtxPp7zZW55hI
         jDpNkmKjLh11gmW756rotbj7+/1jyaY2Wrzv69knR247/lrDQCOxahGhXNwZawmjSOln
         eRYQ==
X-Gm-Message-State: APjAAAUogqWs6JwC0f1nctMX17xM/Z+KcWiH3Vzww8srJsTZ0wNBE8tH
        CKAHQWT0lrMhZc0VbHj67rBteb7L8p8GV50PxXxOvFn8TwY=
X-Google-Smtp-Source: APXvYqxW8h4Cf/5pi7PO4F7AolRDZ2GzNsohiKCSTs3wyVVrcm5NOYuj2MyVUtw3X/08sXGccj/imHCgu4mRloRSjxw=
X-Received: by 2002:a19:7d04:: with SMTP id y4mr52043254lfc.111.1578238337657;
 Sun, 05 Jan 2020 07:32:17 -0800 (PST)
MIME-Version: 1.0
References: <CAOAGZwEfMQ6F8t3a+jVDNrPd6ZWFfiHDU9z1srSHp575DmqcVQ@mail.gmail.com>
 <CAOjrSZv-D6qsyd7mjAEAJ=6YVUTUupYLNdUkDTjbGkA_9eOfUA@mail.gmail.com>
In-Reply-To: <CAOjrSZv-D6qsyd7mjAEAJ=6YVUTUupYLNdUkDTjbGkA_9eOfUA@mail.gmail.com>
From:   Wes Hurd <13hurdw@gmail.com>
Date:   Sun, 5 Jan 2020 10:32:06 -0500
Message-ID: <CAOAGZwEEYe=1+jh2PNaT9w7-Ggti+N6YY0605bWvgbMuWrf78A@mail.gmail.com>
Subject: Re: push --follow-tags not pushing tags ?
To:     Matt Rogers <mattr94@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ah ok, that's it

thanks Matt

I'll update the stack overflow to clarify


On Sat, Jan 4, 2020 at 11:24 PM Matt Rogers <mattr94@gmail.com> wrote:
>
> I believe --follow-tags only pushes annotated tags.  Does the issue
> still persist when you use something like:
>
> `git tag -a -m "I'm an annotation"`
