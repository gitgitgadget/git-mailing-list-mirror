Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92FAC76196
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 22:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjDJW1K (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 18:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjDJW1J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 18:27:09 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3552103
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 15:27:08 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id ik20so5821330plb.3
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 15:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681165628; x=1683757628;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Is1EESRmeNwfoNJaZn2ACBOZumfJnHbaCa6kCBvuzo8=;
        b=acfX9RaYyF1/d0JUOKSgg2ahlReqjZf42wnklCEDYR/c+QLAez/jsDhNvJbORo1XyR
         4iILBzYMuXz6ApRmSCiyIRYbDdnlee4xtvM6BHjxVPKqgDPE3IDz0guG5qEJSF5Yvc7e
         IoqqX0ikuiNEVj2g//CRkFq4aH3Gt6o03LhHQq32wF8liAJZEZWpGLe74VraKEr5lqpB
         0lt/N49tjUZVCG6IHZoWgDNj3fIQJw/rNZxQYC3X5JaXCU+cUn2bePeHFttDAiTrXBgS
         iZnL7BwesE08kr5ywJ0y2BwdtL4cgjLiwq8ZM3UyaYJzBmX28jklYRtMHBWBiBEJ/Lfg
         wYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681165628; x=1683757628;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Is1EESRmeNwfoNJaZn2ACBOZumfJnHbaCa6kCBvuzo8=;
        b=CujztuzqohVs7iIG/TX9ycogzzuQp79POxKneFEPUojZq3IbmUx3NNBwtpKFE3pEug
         SVdHWCmfFiDOSxrIZVlPsoN9vD76tI+TzrecJDzZ4muV4HonGoGYHivBTqmJztydAeAI
         fdSKeMr5wDMLrhoLnxCbgkcMQPa6olo22eLwmBpofqypX399TOe3EIE9aI0Fvo6FXUtB
         OmO+FCwTFrftQWxUaPX+9oAVH1JRzrsbr3EnO2C4IeD6sIghea5r6nb5+CblgAlkHApk
         UF+AJLx2LuFEdfiSsDY0P+FP13lkZtx6XCq981RvFv6626qx8hbAlnrL9Bri4tLRZRkB
         KeGg==
X-Gm-Message-State: AAQBX9ctjnJcc3SD6jPo/K+G/aP8BvWHzNvQvovsekhy+wi0aEQX5PAP
        G/WvjaXSqFQ7OhZGGMw9ogc=
X-Google-Smtp-Source: AKy350aljvKpiTexPsmMm1i3R1NQmuaAy08H2CERm+QRWzQYdXr1LRFYbTLjgvgdcan+/AqSYsucGg==
X-Received: by 2002:a17:902:a617:b0:19f:1c69:54b5 with SMTP id u23-20020a170902a61700b0019f1c6954b5mr558566plq.12.1681165628058;
        Mon, 10 Apr 2023 15:27:08 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902aa8a00b001a21a593008sm3404547plr.306.2023.04.10.15.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 15:27:07 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v2] clone: error specifically with --local and symlinked
 objects
References: <pull.1488.git.git.1680652122547.gitgitgadget@gmail.com>
        <pull.1488.v2.git.git.1681165130765.gitgitgadget@gmail.com>
Date:   Mon, 10 Apr 2023 15:27:07 -0700
In-Reply-To: <pull.1488.v2.git.git.1681165130765.gitgitgadget@gmail.com> (Glen
        Choo via GitGitGadget's message of "Mon, 10 Apr 2023 22:18:50 +0000")
Message-ID: <xmqqttxncr0k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

>      ++		if (errno == ENOTDIR) {
>      ++			int saved_errno = errno;
>      ++			struct stat st;
>      ++			if (lstat(src->buf, &st) == 0 && S_ISLNK(st.st_mode))
>      ++				die(_("'%s' is a symlink, refusing to clone with --local"),
>      ++				    src->buf);
>      ++			errno = saved_errno;
>      ++		}
>        		die_errno(_("failed to start iterator over '%s'"), src->buf);

I doubt you need saved_errno in the code immediately after this
patch gets applied, as what you are saving is guaranteed to be
ENOTDIR so you can just restore it before you fall through out of
the block.

It however would not hurt, though.  Especially if the condition that
guarding this block is likely to change in the future, we can view
the apparent waste as paying insurance premium to protect from
future breakages.

Will queue.  Thanks.

