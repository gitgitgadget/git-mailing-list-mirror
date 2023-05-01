Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CEDC77B7C
	for <git@archiver.kernel.org>; Mon,  1 May 2023 20:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjEAU7s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 16:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjEAU7q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 16:59:46 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702261AC
        for <git@vger.kernel.org>; Mon,  1 May 2023 13:59:45 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5208be24dcbso1947140a12.1
        for <git@vger.kernel.org>; Mon, 01 May 2023 13:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682974785; x=1685566785;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=peoMRvPs6nigBrRDMY5Wt8p/ELxT+WT3QnKW6rkEU/E=;
        b=IeOw9FGy2VRa006dmJpDLTYR6mzuG6h8eyo5n8y2CTSIV1rL1vLhhLSscFdNYVYhKs
         qxkRF4RELJ3BQap/fxN6ZsFLQNElBBAVduH0jW01Hu1TeTb3sNpxKGQlMU6pwWpOwoX9
         mxlOoDnE3c9+eQH68ruSsFw3VEb9XJgss5lhgWH3axznmqwDnIMxjzUfppzro/FTfV38
         XUcF9xJaOF+WUMscDTCrADI4NulOinGwJztKbVO7CH3SClUCUOG4mkN+H13WNZ8RTXjy
         zkkoeRFLxu52T8g9l3qOdTRJNEPEvq3Cw9eYG/4pWlxrH9HOkehGs1yPWeV7wSxHxFMW
         9EgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682974785; x=1685566785;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=peoMRvPs6nigBrRDMY5Wt8p/ELxT+WT3QnKW6rkEU/E=;
        b=SQ4eNkFTdsxL5F7cxOEO+vI43GxAAc0n81ESSY3BnYvLuR+m3hM4ArIHYUMfKf8vKy
         WNLF1f8NBsW5QuZWhY0Y8jPRJjO0VEm963Nu4IzGcWFxU+MshBDRfuisek8Tw1SZ7UFt
         WPp9a/bIBsPyRYXYJiFjY1npZYIETUgnyEryvfceumkj4/QsXXCnF2bLYcjfIJxEobNc
         pFg3Rr+CbbBwVIbPO7exa8B3l4JBN3vqAGAAzmmczTy1x46lWa+WhdjlWd8qCh4dzYxR
         6ybrDSebps+ogMHpJGAdwFk+IhQjUggrx4yrZ/sHtxKni6bTcsdyXourqM5EE9qkJNNl
         rzhg==
X-Gm-Message-State: AC+VfDyIqL5aEgiTgEVvI7EgxAGIGn1LXCfoVqTjQkgz6VIPOGODSvy+
        8a1hmRalQnL/7fNHdZbs+rU=
X-Google-Smtp-Source: ACHHUZ5yRxPWG78yPN0qA5+1OGrtUpRfDMpGFEoioQOsUUV34xFhfoJRQUdCJ8fRlTPWdwOPTMMHaw==
X-Received: by 2002:a17:902:e881:b0:1aa:f46a:380a with SMTP id w1-20020a170902e88100b001aaf46a380amr6200740plg.26.1682974784699;
        Mon, 01 May 2023 13:59:44 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id y9-20020a170902700900b0019c2b1c4ad4sm10232636plk.6.2023.05.01.13.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 13:59:44 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v4 0/4] doc: interpret-trailers: don't use deprecated
 config
References: <cover.1680548208.git.code@khaugsbakk.name>
        <cover.1682970213.git.code@khaugsbakk.name>
Date:   Mon, 01 May 2023 13:59:44 -0700
In-Reply-To: <cover.1682970213.git.code@khaugsbakk.name> (Kristoffer
        Haugsbakk's message of "Mon, 1 May 2023 22:02:37 +0200")
Message-ID: <xmqqh6sv4vjz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kristoffer Haugsbakk <code@khaugsbakk.name> writes:

> Replace deprecated `command` with `cmd` (patch 3). While visiting this
> file also:
>
> • rewrite heredoc examples to use files which are shown with
>   cat(1) (patch 1);
> • use input redirection instead of using cat(1) piped into `git
>   interpret-trailers` (patch 2); and
> • fix an example that didn’t work properly (patch 4).
>
> § Changes in v4
>
> • Patch 1: Use `/dev/null` instead of `empty-msg.txt`
> • Patch 2: Expand commit message

Looking good.  Will replace.  I'll ping Christian as the area expert
just in case there is something obvious we missed, but let's aim to
merge this down to 'next' soonish.

Thanks.
