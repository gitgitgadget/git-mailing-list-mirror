Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493BBC43217
	for <git@archiver.kernel.org>; Mon,  9 May 2022 17:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239571AbiEIR0R (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 13:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239770AbiEIR0J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 13:26:09 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0824826087D
        for <git@vger.kernel.org>; Mon,  9 May 2022 10:22:15 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n8so14523308plh.1
        for <git@vger.kernel.org>; Mon, 09 May 2022 10:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6j0L9cZjZsJjpWZGaEQQpIaqKBLIhH6t1c81WwPAICU=;
        b=qTfqqL2EpYQGxgyqTvUcSrldHqbOAmyFHhkjRiFEi855/gEGWIdejoSj7+b9DZsu7g
         4n89E/wbA5d/fqo25jzcxjY9vYbvLpJB8lRh5z6UTaIfLxW/f87clZcbd9g/ftjI8CfF
         qpkgJQ77VIXAfDHvxkzh0ghh7FUKe5pLSnrFepS8qjVCTU1LUh50P2QasMY+7+Q9xtUW
         76SYh/qVFi6Z9hBTqmw2whZJI60KmVKpV4RGMH76CpPDvdGtk6b32/f8O+XhU36CiD85
         4sPxe5fpOq3Hlzrb/mDXhK98k7bf1+LwoAcPdm0VkeJXgqAE3tj6VO426mQTHVPuMxvf
         fstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6j0L9cZjZsJjpWZGaEQQpIaqKBLIhH6t1c81WwPAICU=;
        b=bdTNmFdqBKWSzNPZJCI8fndbN8Gjj/ZqEgFPb6njHJoTbq8JhGM4d8RXmAIgPH8VSJ
         QSc/hnfE2wb41bXNCInmnlr//2dPTPytexEQlm5yRaTmiroBo5b8j9WApnw+BLi3grj/
         1RuUt1JSeqxIoEBlv7fYX3fRapcbM+vT9qCp2o9ejkALNCXBiCHXA/zWgouVAt6rzBG/
         GpNk6E1zuA/dN8RlSnKzrLN0FjOwmIZJ1GBmtUyHrHasC7ffDPPXC2chCuTLA4xm0XGI
         1De2bxEvyDe5A51qk9BssiwLAwmNJz+lqIFwOCZZRUhZERJsS+vq7L7yBEujmT1gBIEU
         VRVg==
X-Gm-Message-State: AOAM532WbEJxmX8UhX4EZEDf9lSJpR26+IIcX+JkZ2gRPsqMmiLpI5b0
        wFwrkexQn5S9ohcvv7aU1dk=
X-Google-Smtp-Source: ABdhPJzdSqpc5fFbeRS85Dc96tqPnsddyFO/fyVTK7xa7F5bQtJfhnM27Pgmas0T9XuNC56dbEhrYw==
X-Received: by 2002:a17:90b:4b4e:b0:1dc:74d0:c8d4 with SMTP id mi14-20020a17090b4b4e00b001dc74d0c8d4mr19118589pjb.138.1652116934279;
        Mon, 09 May 2022 10:22:14 -0700 (PDT)
Received: from localhost.localdomain ([2409:4061:2bc7:fe6a:45d7:9aca:a60d:d904])
        by smtp.gmail.com with ESMTPSA id 19-20020a17090a019300b001cb978f906esm8995076pjc.0.2022.05.09.10.22.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 May 2022 10:22:13 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v4] builtin/remote.c: teach `-v` to list filters for promisor remotes
Date:   Mon,  9 May 2022 22:51:57 +0530
Message-Id: <20220509172157.28593-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <Ynk0mADTSJU/xVUd@nand.local>
References: <Ynk0mADTSJU/xVUd@nand.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> wrote:

> But there was a good question raised by Phillip in
>
>     https://lore.kernel.org/git/ab047b4b-6037-af78-1af6-ad35ac6d7c90@iee.email/
>
> that I didn't see addressed in your response, which was "why not put
> this behind a new `--show-partial-filter` option"?

Actually, I addressed it[1] -

> ... Another point is that
> it's important for an user to know which one is a promisor remote and what
> filter type they use. If we go with the current implementation the output
> would be let's say - 
> origin <remote-url> (fetch)
> origin <remote-url> (push)
> upstream <remote-url> (fetch)
> upstream <remote-url> (push)
>
> By seeing the above output anyone may assume that all the remotes are
> normal remotes. If the user now try to run `git pull origin` and suddenly
> he/she discover that some blobs are not downloaded. He/she run the above
> mentioned (1) command and find that this is a promisor remote!
>
> Here `remote -v` didn't warn the user about the origin remote being an
> promisor remote. Instead it makes him/her assume that all are normal
> remotes. Providing only these three info (i.e. <remote-name>, <remote-url>
> and <direction>) is not sufficient - it only shows the half of the picture.

If we use a new `--show-partial-clone` flag, users can get to know about
promisor remotes only if he/she use this flag. As I said in the refered
comment, it may happen that the user unfortunately use the flag AFTER the
accident - to know about if that was the promisor remote!

See this also[2] - 

> ... If
> we can specify `(fetch)` in the output then why not the filter of that
> `fetch` on which the behaviour of `fetch` functionality highly depends?

Taylor Blau <me@ttaylorr.com> wrote:

> But I can see where it _would_ be useful. So it would be nice to be able
> to turn the extra output on in those cases, but _only_ those cases, and
> a flag would be a nice way to go about doing that.

Adding the extra flag is not a good approach to me due to the above reason.
But at the end of the day, all of you have a lots of experience in this field
than me. You all could better tell which one is better approach.


[1] https://lore.kernel.org/git/20220501193807.94369-1-chakrabortyabhradeep79@gmail.com/
[2] https://lore.kernel.org/git/20220502145624.12702-1-chakrabortyabhradeep79@gmail.com/

Thanks :)
