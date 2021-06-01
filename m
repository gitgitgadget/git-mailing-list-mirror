Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14318C4708F
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 23:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3E96610C9
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 23:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbhFAXm3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 19:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbhFAXm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 19:42:28 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FC8C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 16:40:46 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id x196so621717oif.10
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 16:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=S9ntUFGJWV43kj5hAz2uSspu2IxNi+9yMef5iXy9o3g=;
        b=aCh3M1yTI/Hm7cETVoFLtP+481WjDZirxrvXQ3G2QsRHzvkeRIq1ZSBZEB026rw76e
         eKP0tNvotPDKdpepkpH/4h7dDI2vd9vO8Yd1n67B/W86DbTkF7Cu66H8Fh+IsOdVAYi5
         XdGwpzNzM+nSO2dWSFclgBaoT2uXem+zb9nSi+f5GFtOFWpCd2lhWxVku0R2ZM4gLJgp
         gF1+4Z8chJehMAizbWyqw2Zv6Srs7eR5EL/irbGHDVKxZW1taCV9NdeixhTO1gk1y+Hs
         fRMSkzZ/LIlXlJrNJ7EuGc5bB7HBely9GNd7DpzS2I6fiY/33oRT3XJ1mRiUHfvdRO2f
         58YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=S9ntUFGJWV43kj5hAz2uSspu2IxNi+9yMef5iXy9o3g=;
        b=lxqWwm5N3z+nBZolA7JfoJ9zBbTK4YdlbckTMxahriQLZdv+y3eIkAyFs1RLLo0RrY
         jbbBQPqBdHXTkX1XARxPkgJNS9SPAJaHjQCFvcpupSepjNbTfCjrnJXzElhhvE0OoLQ+
         qR/xSiwu7PFg9ntlu2ixSxCGlMEIUWclIeOwPQhnzDLT41SshWI/SPLsOm1Zsb96xsN+
         TDalfqVRIvkuaF73T7qUmjxXjoDDo30jg1++P6Uw2LxW4Nr5g7r3LNOEJqkBt1OFXwJ8
         uumV7C1IgWTW0nM3jAD/df61wb+AOoV5of9+54fUL0g9GqfRcOdiuh4wag/Km6+YQhDM
         ZZyg==
X-Gm-Message-State: AOAM532bnbT+JtigGWSYSEDJ0CLeQOVqHmvWrg8doDz2meLCECAJ2TTe
        t95Gx3k7tnMnOJ8AXqHfmv23PMeT6k7aqg==
X-Google-Smtp-Source: ABdhPJyiDnV0l0Riz9x4SpOLt1G587wAhTlrhEUwBN8bJhs0h75qZSgUvOH/dU2lj9QCqyxKVf0Byg==
X-Received: by 2002:a54:4494:: with SMTP id v20mr19263403oiv.74.1622590846053;
        Tue, 01 Jun 2021 16:40:46 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id e14sm2364145oow.11.2021.06.01.16.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 16:40:45 -0700 (PDT)
Date:   Tue, 01 Jun 2021 18:40:44 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder.dev@gmail.com>
Message-ID: <60b6c57c3cac1_4044208f@natae.notmuch>
In-Reply-To: <20210601205229.46974-1-davvid@gmail.com>
References: <20210601205229.46974-1-davvid@gmail.com>
Subject: RE: [PATCH v4] contrib/completion: fix zsh completion regression from
 59d85a2a05
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar wrote:
> A recent change to make git-completion.bash use $__git_cmd_idx
> in more places broke a number of completions on zsh because it
> modified __git_main but did not update __git_zsh_main.

You might want to try this in the future to reference previous commits:

  % git show --quiet --format=reference
  59d85a2a05 (git-completion.bash: use $__git_cmd_idx in more places, 2021-04-22)

(one of the aliases I'm missing right now)
  
> Suggested-by: Felipe Contreras <felipe.contreras@gmail.com>
> Signed-off-by: David Aguilar <davvid@gmail.com>

I have not tested this particular version, but I have tested similar
changes, and this should work:

Acked-by: Felipe Contreras <felipe.contreras@gmail.com>

-- 
Felipe Contreras
