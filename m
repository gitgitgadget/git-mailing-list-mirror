Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB0BC7619A
	for <git@archiver.kernel.org>; Sun,  9 Apr 2023 01:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjDIBXd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Apr 2023 21:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjDIBXc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2023 21:23:32 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B5E59F8
        for <git@vger.kernel.org>; Sat,  8 Apr 2023 18:23:30 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-54ee0b73e08so45881647b3.0
        for <git@vger.kernel.org>; Sat, 08 Apr 2023 18:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1681003410; x=1683595410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aXOBQC7e2r26xYLfZKHNIvih3tb3+yooJd3wKEqQWnY=;
        b=TUeY0AB8w7y7a79RhAwoVbgK6gZI0dkYYzQd+ZNezg4+9D9PGIBgRBBftvto+YpcNK
         TrNzwgTbsDYcDJ4Jo2LBxRo/wNb0L1tsGkEEHfDH2SJJlFyMaiE2sz7MW3yRyQ2Qj16/
         i7oaGodUtBMuPBuboXlT3EY6T1Htn3isopwsw85/0OzFUTRyg1yLC+KbhKCu4ZUZgwBU
         GBPWzEyXMvycYKtB+tDsoKMF7MlpwgHlzy1HZRjnO9CRN3aBuivRD3U7RhB37FkJb02L
         0+oLgNjlNcVY5mitjp2EO90i80DH6P8QUmUHeP3cYXe1cQJHbGA9TArTtAcgk323NONv
         f8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681003410; x=1683595410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXOBQC7e2r26xYLfZKHNIvih3tb3+yooJd3wKEqQWnY=;
        b=J/nIJS9mRlu8Xr2vXEGZxeuxUcXV9UPar7kJPkjl+dHSNEvcpu+qyP7gJufjy3xLgm
         LGuS3C4ofISScTlNkmpj+5iulv7Z8sOl0sKVwkhzWKgq2nFBBZzPD+vyKILKrHfgayo7
         6h+3xt8lufwpxwFlaG5RUlyWwS8AsJnmxb/eT0XQsX7HKa82Sm8kmfrU6ghQPnnTA6Te
         I6kn8J4yHiN6fK33YRqpFGFXJpFGDYUbGY4PjL95v5cMxGPruw3Us5tGu7hOkrr67wNd
         0QOsvuH68DuAKr22MniG8eMB4G8i/sob6krevvwEbBfqz6xLwqyGDfGetcVYPqFKNHat
         zShw==
X-Gm-Message-State: AAQBX9dS9LxZJBB0DiBP3RfMVgeWIxbi6tQgyk4/GgriIFpnCvNA7J5p
        XbiJ1lqih4yRRX/g3pivLenhN7GQn7jl4hEWVKbj0g==
X-Google-Smtp-Source: AKy350YPnIFD6KITENKBYC6Y2YYbyXJ57uzxZu4IX5qRGWtqyPGlUuI0lNTmSZ9plxmm+D3zmR88wA==
X-Received: by 2002:a0d:db06:0:b0:54d:38d4:4f56 with SMTP id d6-20020a0ddb06000000b0054d38d44f56mr2422941ywe.26.1681003408375;
        Sat, 08 Apr 2023 18:23:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id dc14-20020a05690c0f0e00b00545c373f7c0sm1984004ywb.139.2023.04.08.18.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 18:23:27 -0700 (PDT)
Date:   Sat, 8 Apr 2023 21:23:26 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        johncai86@gmail.com
Subject: Re: [Question] Can git cat-file have a type filtering option?
Message-ID: <ZDITjrSU7jADX/Jw@nand.local>
References: <CAOLTT8RTB7kpabN=Rv1nHvKTaYh6pLR6moOJhfC2wdtUG_xahQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLTT8RTB7kpabN=Rv1nHvKTaYh6pLR6moOJhfC2wdtUG_xahQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 07, 2023 at 10:24:22PM +0800, ZheNing Hu wrote:
> However, `git cat-file` already has a `--filters` option, which is
> used to "show content as transformed by filters". I'm not sure if
> there is a better word to implement the functionality of filtering by
> type? For example, `--type-filter`?

There is the `--filter='object:type=blob'` that should do what you're
looking for.

In other words, if you wanted to dump the contents of all blobs in your
repository, this should do the trick:

  $ git rev-list --all --objects --filter='object:type=blob' |
    git cat-file --batch[=<format>]

Thanks,
Taylor
