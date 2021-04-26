Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC76EC433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 08:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FB6361090
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 08:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbhDZI1v (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 04:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbhDZI1v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 04:27:51 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C611C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 01:27:09 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id u3so4440512eja.12
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 01:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:message-id:references:user-agent:in-reply-to
         :date:mime-version;
        bh=JEiR9NR+nVILoGS/KnTtm/EgAF5Td8EYagEgImkuGy8=;
        b=FILQoWoPjIoAwLAmClAYzB8zs+50ZtWK62MWwb4g4imfw1EQJaCJOLHjcTcTy3UUSQ
         wfi6+jsbFj/vPZiJHZWoMBweBnUeBaT5RTCx8FNSe2FC4P8qo8/ayjIn/z3H55nqISse
         uyLZf6KHJVlyvnJlcSJPYzrsT5TJjYAGkImS5EiHtBfM4Y5QIeQZ3aO3QnEx8U439ndi
         YiW/PpXbMg+m1/7Za4DaSlXW9ezqvPHqZQwFl5370gasKguKIIkXZpgFIrP2ULKZPJ3C
         Fj/1SDEeQ7lTJHzPnIpCujshTUBoMtNqSM8TGSnY6FxISrBGFtq69QTFBSXAOsEnqV2Y
         6MbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:message-id:references
         :user-agent:in-reply-to:date:mime-version;
        bh=JEiR9NR+nVILoGS/KnTtm/EgAF5Td8EYagEgImkuGy8=;
        b=TWlk68iaVoTRFC1WlVadUT3A4KN5md8brT/NHPcklhyIAfMON61hsVwJw0Ninj0xrj
         Ho1H5yCjeGDy19U5gaTtj10cFMMBRiBpHHJn+9EmIZNxe18+tdHiSULxQKjK8NJNArGz
         m7L6ID29wQ5CxkCbDArANDm5oRAZLJRPdJC+zLP9QO5luymzp/i+cGki1cIbqSk6fdnh
         phuf8m1Ssq566vMjznCdMRthovQ0kzTujGolQy2rjEZBPzKEENilvSR55yYY5jQq1W6V
         Yl7YY2AofgjtE8u9bM86jw+ppwPb9iyrZFA4jptra7UuSWvEyT8Vkg+3xax3MyKaOICj
         lgyA==
X-Gm-Message-State: AOAM530k4tn+OqwlMAVkL8jldtXXeH+f08YqN3UY4j5V9OCCIKP678F6
        AyQU9yo7xmsS/pdFN/P5ZxM=
X-Google-Smtp-Source: ABdhPJzBxsBQpmZK5IZBqaBwCryn1yjBuaKLV5TqjfnB2MgxBtfFkVKiQSd3/6unAjPHTU3HKEntBA==
X-Received: by 2002:a17:906:5052:: with SMTP id e18mr17381347ejk.112.1619425628260;
        Mon, 26 Apr 2021 01:27:08 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id b8sm11014724ejc.29.2021.04.26.01.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 01:27:07 -0700 (PDT)
From:   =?us-ascii?Q?=3D=3Futf-8=3FB=3Fw4Z2YXIgQXJuZmrDtnLDsA=3D=3D=3F=3D?=
         Bjarmason <avarab@gmail.com>
To:     Luke Shumaker <lukeshu@lukeshu.com>
Cc:     git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Danny Lin <danny0838@gmail.com>,
        "David A . Greene" <greened@obbligato.org>,
        David Aguilar <davvid@gmail.com>,
        Jakub Suder <jakub.suder@gmail.com>,
        James Denholm <nod.helm@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?us-ascii?Q?=3D=3Futf-8=3FB=3FTmd1eeG7hW4gVGjDoWkgT?=
         =?us-ascii?Q?mfhu41j=3F=3D?= Duy <pclouds@gmail.com>,
        Roger L Strain <roger.strain@swri.org>,
        Techlive Zheng <techlivezheng@gmail.com>,
        Luke Shumaker <lukeshu@datawire.io>
Subject: Re: [PATCH 19/30] subtree: give `$(git --exec-path)` precedence
 over `$PATH`
Message-ID: <87bla11oo3.fsf@evledraar.gmail.com>
References: <20210423194230.1388945-1-lukeshu@lukeshu.com>
 <20210423194230.1388945-20-lukeshu@lukeshu.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210423194230.1388945-20-lukeshu@lukeshu.com>
Date:   Mon, 26 Apr 2021 10:27:06 +0200
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 23 2021, Luke Shumaker wrote:

> From: Luke Shumaker <lukeshu@datawire.io>
>
> Other Git commands implemented in shell give `git --exec-path`
> precedence over the existing $PATH, but subtree gives the existing $PATH
> precedence.  Flip subtree's PATH around to match what other commands do.
>
> Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
> ---
>  contrib/subtree/git-subtree.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index 3105eb8033..9d365c9f2f 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -28,7 +28,7 @@ rejoin        merge the new branch back into HEAD
>  squash        merge subtree changes as a single commit
>  "
>  
> -PATH=$PATH:$(git --exec-path)
> +PATH=$(git --exec-path):$PATH

The history of git-subtree.sh suggests that instead of this change we'd
be better of removing this PATH assignment, and then later doing:

    . "$(git --exec-path)/git-sh-setup"

Isn't that closer to what git-subtree.sh wants here?
