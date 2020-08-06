Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195E4C433DF
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7488322DCC
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=3v1n0.net header.i=@3v1n0.net header.b="hzrdwKLK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730373AbgHFR3M (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729719AbgHFRAb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 13:00:31 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DBBC061A26
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 05:20:16 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id q4so31766418edv.13
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 05:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=3v1n0.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5RM1TOxqcKOTy7Kyq5T2yZbfiekQtyyQCg/SJ6KlwR8=;
        b=hzrdwKLK6elcrZY8j8uDjFXwjkz6K7PNNr5BQIbTMMTcL43e+xZsLzuvLeOgACk/sr
         Qh9HFQP0p4ye/lMhe3QY8fq+2TqilKaGNpEnKiyzgM+SnC5C8zeTRL00TSmeok5c/b+s
         a7OSUZG/0xmwsXTYjzgwRsl+fX+S1PzgPdQuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5RM1TOxqcKOTy7Kyq5T2yZbfiekQtyyQCg/SJ6KlwR8=;
        b=UXYl60Lzl+v+edJZZQXOXQS9HKfFQw6jhaEZu+dWNJT45ef/WTfQHOed1bojfupcJD
         9v5MFS46raRtJ/l4h9s2WNRrhvneGHBJntFI0QdMOCZvmZhYCMjRvmOm0ysKPSgQMAWI
         XqRlrVKGI/7MhYKNKc4lPenrKcN01L59qeluIWu0ViR/ds5cUuV0FpzR3F84w8dX1go1
         ckY0wwgPrx9ifqsgmIqqrJln4CcpxNVKYJW0Hn7d0I7gf5hcuNsEaU0RBkDU5Vu9Suus
         rilvmSIOEkcLLmdDkaolmzpBj/6RTk5lrE+1ulVWmP+cgT1fzi/imtD5hmGwRKu6oQaF
         cfMA==
X-Gm-Message-State: AOAM5332zBz0WGql3PsYL/nvnHwWjXyTjIqU2hT5KfeU5mN0S/MYw9V5
        0CuwCttBU0OkPIYGaRebMrLTv3T0AZ7EkA==
X-Google-Smtp-Source: ABdhPJz45dstpvgxvZvWVwa0sSt2IP8ohgPT13U4OcSQmNBmKUdvi0injaycyLLWTwLn4iO9eQQkvA==
X-Received: by 2002:a50:a6d2:: with SMTP id f18mr3700529edc.374.1596716407660;
        Thu, 06 Aug 2020 05:20:07 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id u8sm3592656ejm.65.2020.08.06.05.20.06
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 05:20:06 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id df16so18645292edb.9
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 05:20:06 -0700 (PDT)
X-Received: by 2002:a05:6402:1ca6:: with SMTP id cz6mr3691217edb.310.1596716406105;
 Thu, 06 Aug 2020 05:20:06 -0700 (PDT)
MIME-Version: 1.0
References: <pull.693.git.1596634463.gitgitgadget@gmail.com>
 <fc0d2b103ec080fa38e5d51bf2205b7360c1b601.1596634463.git.gitgitgadget@gmail.com>
 <CAPig+cRX3_ArTYQwc1jWHznBxLf+j0McYSo=nPq4C319J=DBvg@mail.gmail.com> <4ef90c30-6c06-a355-69eb-9c8e10c6bef6@kdbg.org>
In-Reply-To: <4ef90c30-6c06-a355-69eb-9c8e10c6bef6@kdbg.org>
From:   =?UTF-8?Q?Marco_Trevisan_=28Trevi=C3=B1o=29?= <mail@3v1n0.net>
Date:   Thu, 6 Aug 2020 14:19:39 +0200
X-Gmail-Original-Message-ID: <CAALaScnJfaJg5moOL5DAFb2yDpkT03emVAZnBZs3+uo8rGbOLA@mail.gmail.com>
Message-ID: <CAALaScnJfaJg5moOL5DAFb2yDpkT03emVAZnBZs3+uo8rGbOLA@mail.gmail.com>
Subject: Re: [PATCH 2/3] mergetool-lib: keep a list of cross desktop merge tools
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Marco_Trevisan_=28Trevi=C3=B1o=29_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Il giorno gio 6 ago 2020 alle ore 10:16 Johannes Sixt <j6t@kdbg.org> ha scr=
itto:
>
> On a side note, the refactoring that happened in 21d0ba7ebb0c
> ("difftool/mergetool: refactor commands to use git-mergetool--lib",
> 2009-04-08) did not preserve the original order of diff tools. The
> spirit was to prefer meld over kompare and kdiff3 with GNOME, and the
> other way round with KDE. But since that refactoring, kompare is always
> first in the list.

Well, actually when DISPLAY is set so basically always (as even under
WAYLAND that's defined for XWayland apps) meld is still preferred.

I'm not sure it makes sense to have tortoisemerge or kompare if no
display is set though, but I didn't want to change the whole thing.

--=20
Trevi=C3=B1o's World - Life and Linux
http://www.3v1n0.net
