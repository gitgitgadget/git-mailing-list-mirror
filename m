Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A799EC77B75
	for <git@archiver.kernel.org>; Mon, 15 May 2023 07:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbjEOHAY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 03:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238149AbjEOG7w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 02:59:52 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CCCBE
        for <git@vger.kernel.org>; Sun, 14 May 2023 23:59:51 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1addac3de73so26295545ad.1
        for <git@vger.kernel.org>; Sun, 14 May 2023 23:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684133990; x=1686725990;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=259quEDmqrQO7lXVnP21LosCJaWJqiwwZcEqjDJisWo=;
        b=VoVuBqmTFq82oMRAv/XD4i46PaNyDXONjByF8MKv0efgP+8HlLoQtCoJwetZ5VDOpF
         5UJQOO80+ENVlxLmRzVvgu8/v1wbXbyEWUpBF+Qawo6W+xwgjQSQ4uQAtWaRhhHL6sVg
         F9G1ZHQQoIi1+Z8zWULzvJ30MDmzpsPUKXjwQPLlZNJ9vtgNivMkTdzEP975hMhefk9o
         BYhAUOFdgjBC29Hc+mVfOyUVQBgGTIcn5Ls/YWodGQUR/7zqCJCYHABuKoPGZqc6U6uf
         GsUxl9eUkgcDselUgK7JL4NyVtchB4628quXOZhg7UBGKomvmjeFsZQXFAPhWlj0MZ80
         O7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684133990; x=1686725990;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=259quEDmqrQO7lXVnP21LosCJaWJqiwwZcEqjDJisWo=;
        b=f9FrkD2h/HX39LY20GmjI9FL5wD8ihHvkcSGnYg9cLUNFD7l5H127MFiYUJC3ROzmT
         8zYsWJxWuLQ5oEXDU+rrlLQevlde97D9bZPqE+NnVSVRLJt5/FQAVlGKgOYUFLwh5Tgn
         aFQiDooTvRzkcRoRjiVxf9oSQK6DxPb5oMde08h2Ud0d7+zInEZV11aqGin/56K+O0k1
         F5DCTtb45t8kIUhhA2HI2WdwOZbZHYX+iBDvqNk9IkTfF3ecEMaryzSQ9e5qILRzx5RZ
         m8YBOA66BGTqrerSARP4vBWLz0C8gFhdk1QEsAEFZbTZ+xi0POBmON3ptvUt9rZquTVt
         Bmtg==
X-Gm-Message-State: AC+VfDyxd6PaDpl1AgJYhithWHmj6pQI3sX2YPwKKKmb2fpu+kphtOKq
        Q/jzQmLc6+gsAMYQnqJayyY=
X-Google-Smtp-Source: ACHHUZ4zrT8F1xNc/JCsDm2P5vba35gZfhROvVlUGVAMATp5xbY+tmZpbq+dsblBkLwXjbUQ9edfAg==
X-Received: by 2002:a17:902:e882:b0:1ab:fb6:1e72 with SMTP id w2-20020a170902e88200b001ab0fb61e72mr44736794plg.42.1684133990459;
        Sun, 14 May 2023 23:59:50 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id bd8-20020a170902830800b001a967558656sm12543316plb.42.2023.05.14.23.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 23:59:50 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 3/3] tag: keep the message file in case ref transaction
 fails
References: <cover.1684067644.git.code@khaugsbakk.name>
        <999af290af4c6850aa3faa2cc95adbac3b7a3984.1684067644.git.code@khaugsbakk.name>
Date:   Sun, 14 May 2023 23:59:50 -0700
Message-ID: <xmqqsfbyaxll.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kristoffer Haugsbakk <code@khaugsbakk.name> writes:

> The ref transaction can fail after the user has written their tag message. In
> particular, if there exists a tag `foo/bar` and `git tag -a foo` is said then
> the command will only fail once it tries to write `refs/tags/foo`, which is
> after one has closed the editor.
>
> Hold on to the message file for a little longer so that it is not unlinked
> before the fatal error occurs.
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---

As I said in my review of [1/3], TAG_EDITMSG should be documented
just like COMMIT_EDITMSG is documented.

Other than that, looking OK to me (I didn't read the patch very
carefully so I may have missed leaking and/or use after free,
though).

Thanks for working on this.
