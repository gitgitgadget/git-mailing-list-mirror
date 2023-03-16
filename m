Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8E0C6FD1F
	for <git@archiver.kernel.org>; Thu, 16 Mar 2023 16:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjCPQol (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Mar 2023 12:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjCPQoj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2023 12:44:39 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365341C587
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 09:44:14 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j13so2229307pjd.1
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 09:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678985053;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RZXH4A+Lcui8AP0joP/U9GnvSXE2bbybwGxkMX3FgrE=;
        b=bZhWWwMNk1muvFMSmbFwNStk0bmAdVFgdGNzR2M5KkJFJ5DVJ5aSFqZnmTC1qVsMb2
         Z62vf2exS8RiYhjigQQIAbPExEgizWGj5DJp0A83KVbqmLLS51rHzgMrYs03f7BvZuMa
         tCM4si+96hYDu9P+Kab5yWDzlngt9v9yAOa47HUYoFIh3TLO/Jdd/Sc2ZLkgo5EwzrVA
         b4qELfB2TY+UJGOOCJv8y8grJ3kVrTy3PI1ZSmNWETHOjFZhUQrPO0v9l122czjbKdAV
         04owleF6q8qpiRzJzPwwFB7uFXbp+RAwD4VUDPiQkmxoozR7n9iuevFy+KDaKqrgqzJM
         dFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678985053;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RZXH4A+Lcui8AP0joP/U9GnvSXE2bbybwGxkMX3FgrE=;
        b=L/EwqQul67NG25Pslv+UIJAAkFPwOYitUWJCuEFRkkZWzuqZZc7dBZT+zQm9DzNSzy
         X6gCjLyyqisDDZFWRb+aDf5IyNHGvJ9Pl2uDraglNys1r+Xsgp21WnlkEG0IyvROL936
         /lGOuBgP+3vKYuxOPst8NVLxDWwFdC3PnjdFjBNlk9qRGUA+A8hZBzN9GUZSI3joy+uZ
         uJpgqVojr5mJ+fPxGA2wNUAsbL6OhnUmChqpj49LFrVyHbWpusTUcP1PJcAjQitIJKUa
         4VZKnTJ60hOnfbU9xdAH4tw7pDH0a67imyX7XCbLh9b5Ounw4vOx7FLThIK7Cchzq6K0
         Kj3g==
X-Gm-Message-State: AO0yUKXgciOxHCudoGMOXBpiEjdfg75FFpOBianhpTZGqXeS5y4ORPg/
        MAU4bPE5U0P0JfYF/NwAi9I=
X-Google-Smtp-Source: AK7set/5Ez2dCPM2FIoAhmf10PqoubBUUjERtV0Qp/jCKwQSeFimcUmN/tAc4bUYWTsSobLug0XvjQ==
X-Received: by 2002:a17:902:e5cc:b0:1a0:468b:4b1f with SMTP id u12-20020a170902e5cc00b001a0468b4b1fmr4708135plf.0.1678985053569;
        Thu, 16 Mar 2023 09:44:13 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id kv3-20020a17090328c300b001a04ec08990sm5811582plb.268.2023.03.16.09.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 09:44:13 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     John Cai <johncai86@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] diff: support bare repositories when reading
 gitattributes for diff algorithm
References: <pull.1459.git.git.1678758818.gitgitgadget@gmail.com>
        <ddd7cbb6-4f4d-ba0e-857e-5981779326d0@gmail.com>
        <20230314191833.qmiisyvsu2ppu4sh@pop-os> <xmqqttynoyg4.fsf@gitster.g>
        <ZBMn5T6zfKK+PYUe@coredump.intra.peff.net>
Date:   Thu, 16 Mar 2023 09:44:12 -0700
In-Reply-To: <ZBMn5T6zfKK+PYUe@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 16 Mar 2023 10:29:57 -0400")
Message-ID: <xmqq1qlomysj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If you have a static list of attributes, that is OK (though you are
> presumably better off with /etc/gitattributes or similar that covers all
> repos).
> ...
> but still tell users that "json" is a well-known name, and if they want
> to get the same treatment for an arbitrary file "foo" that they would
> get for "foo.json", they have to add attributes mapping it, like:
>
>   foo diff=json
>
> inside their repo.

Yes, you described the reason very well why we didn't add "global"
or "system-wide" attribute files.

Thanks for commenting on my somewhat tongue-in-cheek "devil's
advocate" remark.

