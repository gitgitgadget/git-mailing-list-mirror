Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E750C38A2D
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 18:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbiJXSWm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 14:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbiJXSWR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 14:22:17 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177B867C82
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 10:02:59 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 187so2616889ybe.1
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 10:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rIRgL+fUAJ+cm023/f47fQ7Qwz6zIipIpcEEz4h2Bzs=;
        b=lsi5tdSOOGv8HOptmFZjlpYicl4W2RrZQrlkYuYL1RULTao5O7Ux2PdVOe3zBH49sk
         xRPXTsUm8dKOdr5LMhbL1/V0ZfESMrN0YOJKVdjnQkgOfXpLSd2JnF/uWNDUTqtIiUHk
         Rc5eaZg31oplOZ6xsUHd2n1AE2+fevv2GukfPaFeinwMgJXHdUz5X6fnd6tm84Qn/Kts
         HUTSEvN3XINE3HhRZEVE4Z2Ut8g/hsov+eznWvzlR87OpQAsAJQoW9cFa1GVP95y7p2i
         kdi6HJj3gjF67wxz5UCS69ujiGSHUfmI1CySjAwcUkvcjcqR+XTX0JH1j+TySyvDFsiC
         TFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rIRgL+fUAJ+cm023/f47fQ7Qwz6zIipIpcEEz4h2Bzs=;
        b=fMHfH+OXVSVjQnX1Yoz7CBW0aUHS5AOawVP0+J/Pygu5MIYgkfVheSgW2ty+eskyLy
         B4k5K8k2oyrQWbKFwl028yEfDyglKNfb2M8fd/LUosEa+q1/3xr+S0PRrS3f5WEE0rWr
         hPg2HnozhDXJifNnc9gOooYvai4IZwpP+9mqQyYQLSNkXCQgE8XUw2yrMrZUKUwb6AJH
         v+/zCAhfrBwthNpfaH8uYDcNf4oJBwaG7EmJC58ZWONBHiwTd4f0pnf0QhcenOBTOxig
         2zdddaohS/hAKu6sBmx7sosh/YSDssHNl9OABVHdS7BetweUQOQZ4iG0NVOTZV8SCVR5
         xYng==
X-Gm-Message-State: ACrzQf3+Q4ymPXULchP25zNpPoyIeio4803RbBvHr3DZ0NVBBGbQ2NJa
        9w2KU2xvdrAJMMGIoEAjBW1HBUm2Rj/L9r6xKXFHZA==
X-Google-Smtp-Source: AMsMyM6jUmkwnOHnUxxhgJwuS5qiKjtjscDfHVBpArfmj6lonLVCXDfw5NvC892JROIPWxJAfevxErdhEeKmIgnnYDA=
X-Received: by 2002:a5b:7c5:0:b0:6c1:12dc:3f94 with SMTP id
 t5-20020a5b07c5000000b006c112dc3f94mr30394754ybq.640.1666630867238; Mon, 24
 Oct 2022 10:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <20221020232532.1128326-2-calvinwan@google.com> <xmqq4jvxpw46.fsf@gitster.g>
In-Reply-To: <xmqq4jvxpw46.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Mon, 24 Oct 2022 10:00:56 -0700
Message-ID: <CAFySSZABaWSKw_OxyPEU=C_iLOmPa=pPahWaeta=JaAf2q_GEg@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] run-command: add pipe_output_fn to run_processes_parallel_opts
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com, avarab@gmail.com,
        phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> In my review of one of the previous rounds, I asked which part of
> this functionality fits the name "pipe", and I do not think I got a
> satisfactory answer.  And after re-reading the patch in this round,
> with the in-header comments, it still is not clear to me.
>
> It looks more like sending the duplicate of the normal output to a
> side channel, somewhat like the "tee" utility, but I am not sure if
> that is the intended way to be used.
>

In this case, I was hoping "pipe" would refer to the redirection of
output from the child processes to a separate custom function, but
I can see that duplication != redirection. Maybe something like
"parse_child_output" or "parse_output" would make sense, however,
I didn't want to imply with that name that the only functionality is to
parse output. Besides that, I don't really have any other ideas of
what I can name it...
