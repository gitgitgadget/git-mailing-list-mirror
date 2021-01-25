Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C49CC433E0
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 02:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2680422E03
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 02:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbhAYOYV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 09:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbhAYOWk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 09:22:40 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA6EC061574
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 06:22:00 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id c12so9739048qtv.5
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 06:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sZAtncR05zWLLHoaHqVL3VjYnxwphczznb3KhlHmznE=;
        b=2JWFus56hc7efQUGjqTs9oY9BC7JmyNBn/WaB973zuSrS2NKTt8MOcWalNz8FXZRKt
         aMYidy2NXSYOvzfN3IQGPo9HJhXUnEXgjtPgcUv1PhdAamE2MXq1XQm66zoFaAHubwdg
         duUBfj5cdsCONq1B2VVDBBOrMAND1utpj40sN5sCJu44BF0NBhEjwxykbQ3xXec06oOo
         GS7HBqL2aVsnXviTiTt2ZGzLpljwAy0qtdN/L2njDqFi2ZOmRSmBCcETzKKOw5ayffE8
         gna0mfP0KB6/r15Qzm9KPzfgeva31j4t72YuAOtOWE86OoWwUZWXebZYuzvea0aH/Rg/
         DZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sZAtncR05zWLLHoaHqVL3VjYnxwphczznb3KhlHmznE=;
        b=G0Y7+kCLyXgwQHReoJYigwfN9eBrs86gvb6kRwNHHRz5q80ZB+CdPpUWlbdivducrC
         wC6rufVtRYD1IEsWgw3yTwOXwEG5G5fcSR4+oIBTaBylyJNueoagEt9Io8tbXT8f20iZ
         CUSqf2k9CDYQT0e/np3YwtsHqrdkRtIVnrMazwXUyy2v+oyRJq17MBhfSBwccNui9s4i
         jTIvM5mk3gx9K2d6Kppcs/aNQQLaQEK/ZnR77JQ6gOz2KP0q4VPHG/TnJBAb1Fog0bjg
         zfq/blS36mxwIhLThyM1GkoL3erzP6U7/i3jpuK3X59fVlrbI7C3u/CKWSwxMefvH3bu
         QrRg==
X-Gm-Message-State: AOAM5307KgEGpd6JMvS/NFxtVohK+FugW3l0FioC2sf7JZg3yx+IWVzn
        DXTIxBhUljGOryEKmloYbnf6Iw==
X-Google-Smtp-Source: ABdhPJx7eTIykxETyBOgw7SgqiYwclX+ljqGvEdNmMWWiubX3WcwETtXgtRc+d05Fxz4zC4FALIJBQ==
X-Received: by 2002:ac8:1094:: with SMTP id a20mr672315qtj.248.1611584519337;
        Mon, 25 Jan 2021 06:21:59 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:d8ad:42c:f23b:d0ef])
        by smtp.gmail.com with ESMTPSA id i18sm12018953qkg.66.2021.01.25.06.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 06:21:58 -0800 (PST)
Date:   Mon, 25 Jan 2021 09:21:56 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Eugen Konkov <kes-kes@yandex.ru>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Can not rebase to first commit
Message-ID: <YA7T8fo5zngSD+zd@nand.local>
References: <1327609829.20210125123816@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1327609829.20210125123816@yandex.ru>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 25, 2021 at 12:38:16PM +0200, Eugen Konkov wrote:
> I can not rebase to first commit.
>
> This is how to reproduce:
>
> kes@work ~/work/projects/general/Auth $ git tree
> * 67857d5 (HEAD -> dev) asdf
> * 1e99034 (local/dev) Initial commit

(Unrelated to your question, but I assume that 'git tree' is an alias of
'git log --oneline --graph' by the looks of it).

> kes@work ~/work/projects/general/Auth $ git rebase -i --autostash --rebase-merges 1e99034^
> fatal: invalid upstream '1e99034^'

Yes, this is because you're asking to rebase your branch onto the parent
of 1e99034, which doesn't exist because 1e99034 is the "root" commit and
therefore has no parents.

'git rebase' has a special option for exactly this case, which is
'--root'. By replacing '1e99034^' with '--root', you should be able to
do what you want.

Thanks,
Taylor
