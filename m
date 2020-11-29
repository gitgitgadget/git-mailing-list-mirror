Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067C3C3E8C5
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 10:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB649207BC
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 10:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQgCgyII"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgK2KYU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Nov 2020 05:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgK2KYT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Nov 2020 05:24:19 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5EDC0613CF
        for <git@vger.kernel.org>; Sun, 29 Nov 2020 02:23:38 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a16so15026257ejj.5
        for <git@vger.kernel.org>; Sun, 29 Nov 2020 02:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=iehMsmW1UjPOr+mZRLQM0yLtbJFSy5Kf2BrR8RZhQV4=;
        b=iQgCgyIIrP/m36ESX9TNPrKJuCqrJ+sVoZnM/MKY2ycqUqE2syXCPE8OA4jjf/sg2j
         t4rcexm+11kEDhaNrrxZVYk2Ru++zzKJsg6E3GmFI2gnRKCDXTm1MSea0lsveCAfh1PW
         vrX6DaaARGwHw7QOMDpfQxbIziO4TxlcIjdhMvvHDwoB6bQme3FQNpz8g31E3lIa/xdi
         tTFlBXytCLpA5JreZJnNEVnW+DNpfCSfpPi/m68+PPgdorPu79TrC1J2+HFHz7LZe8uL
         lO+HGRWTlhg+dxQnwnxKXclrE33Zneu+UJCy/w242kWll7c4xbSD38jAn4OO/ah/W5yW
         3tMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=iehMsmW1UjPOr+mZRLQM0yLtbJFSy5Kf2BrR8RZhQV4=;
        b=ancPXeZtNhjAACo1PR2mROEj8XqZD+7oDWnwMzstEJfMY+1Mi/WIhjoWzJbG5JAqDV
         blB/vbEx9xFJCiUi/3hkfRJuWD3QabsHitWwUHDchBB0ouUmVOf90Bqpe9k/0aRXmAnf
         XJef6Rj1vtcheVPzB3zw6iS/3728E5fmeuW8I2pzMsOWXlNPK4GD3aE68cLR4qBxrbIk
         UPOJEOo2TWjAdlV2NcF86/H7YjUNZN+bhDFcqlmqb511ni5e8MfYKC+YsIkFb91HU/9U
         YlZKUzYkbEu6bFlQWtCROcj0qzUYGvIUJrdaxGfRBjkyRVcZH0EoOJitIjg3xdQH7Dx/
         T2JA==
X-Gm-Message-State: AOAM5304qBxe3cBiwM5XbZETiqFrgo/g32nWoU+hThmCr1/7g5OTWloy
        BG9ohKwOsU7ZtQlVH+WapLER4j7kD+At9Q==
X-Google-Smtp-Source: ABdhPJz7HNH6OU5bslcEVzqMYDl7S2/XIy6rpppF6tRhNR8ayaTzh0FVrn1cmSBVL7aNbCQ5KZjzew==
X-Received: by 2002:a17:906:ae55:: with SMTP id lf21mr8869612ejb.101.1606645415898;
        Sun, 29 Nov 2020 02:23:35 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id l22sm2941968ejk.14.2020.11.29.02.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 02:23:35 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 05/20] merge-ort: add an err() function similar to one from merge-recursive
References: <pull.923.git.git.1606635803.gitgitgadget@gmail.com> <91516799e46ebbc91fb6b1811164fe7c9a15a3ad.1606635803.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <91516799e46ebbc91fb6b1811164fe7c9a15a3ad.1606635803.git.gitgitgadget@gmail.com>
Date:   Sun, 29 Nov 2020 11:23:34 +0100
Message-ID: <87im9ojwbd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Nov 29 2020, Elijah Newren via GitGitGadget wrote:

>  static int collect_merge_info(struct merge_options *opt,
>  			      struct tree *merge_base,
>  			      struct tree *side1,
>  			      struct tree *side2)
>  {
> +	/* TODO: Implement this using traverse_trees() */
>  	die("Not yet implemented.");
>  }
>  

Looks like this doesn't belong in this patch & should instead be
squashed into "[PATCH 02/20] merge-ort: add some high-level algorithm
structure".
