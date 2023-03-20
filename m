Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB66C7619A
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 19:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjCTTo3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 15:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjCTToH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 15:44:07 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EC610A91
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 12:40:08 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id z10so7284866pgr.8
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 12:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679341208;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8qHfgO+3KHYahPPuG8oXkNhP5/sdUxcMXOvL6/x9PUU=;
        b=NaxSVyJlsnvc+Ap6N8lZXFAlwJSYE10Pwqxmtglvczry+FGPnSvQwb0eermhmVCE9K
         ikV7VElMAmhxU0d03KdhJ4RZZ+VLLs9e7+x+KEDIhWT7PGiWip8R99e7kTRC5FWjd5zv
         jFxAoMj7XyQUebfM9kHFLoTWvpZ8CuF7fXPqPthSb+YUY2Z4T3Hx0sCjtaTlAJyu+bv+
         9JaXsCA9DTg5FFo3lsgkz1VS4UIacPL4Wru6kJlLqqeekOElPFrKHJbVKByVF43fZbvf
         TtEUwFXsgx926ALLBjWLk7MYVIU/C1iJp1yuLDZI1ziim91kwBSccQ1Cg05Ww6ZRkjDj
         rNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679341208;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8qHfgO+3KHYahPPuG8oXkNhP5/sdUxcMXOvL6/x9PUU=;
        b=BQJ4AUDU58KuHCBEJfQcDV8ORCYsZpu/h4G2ZPRmfDV4sRQOwfFzbKcDupLJulwh8w
         phdP0o99txDXk85svVVUSwj0wTcDUSyr6hT2fygL5GTokNZ4D0HF+WyuJzWgLYRoEYWt
         zC/nrGSUBy8ippx5lP9efPhs99WUaHrowvZpsgWdW7jwtN0vw/p6LfgBe5Uv2GfgzYW+
         6JnnnzrxTqMTZlLQAduwk4ni0j7xHj+gVZyFKVJGLXiWLqhLjXqsiSqbcANE65ETjDWv
         BQ382RFdd80JfzbMlumnPam9hxPAmHxUCustxCikYG/NDGq1MeNwBtzpVHBpoWu8c61k
         UuVg==
X-Gm-Message-State: AO0yUKWfAbVWTW9k0+lyIVlsOBt6MctHy228o4AamvmkJdQzI2MSggU0
        ohzRrQ0TyjXKyi4K99gZVLQ=
X-Google-Smtp-Source: AK7set+nz4yGYilldrIWUpFb9oaaXcUoIWOyn6S3D+qh9/7Eg03cVtAW4/U/gLpPQ/460Nhmd379dw==
X-Received: by 2002:a62:1dc7:0:b0:627:e577:4326 with SMTP id d190-20020a621dc7000000b00627e5774326mr16842pfd.17.1679341208270;
        Mon, 20 Mar 2023 12:40:08 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id n21-20020a62e515000000b0058bc60dd98dsm6705107pff.23.2023.03.20.12.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 12:40:07 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul Eggert <eggert@cs.ucla.edu>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>
Subject: Re: [PATCH 2/2] git-compat-util: use gettimeofday for current time
References: <20230319064353.686226-1-eggert@cs.ucla.edu>
        <20230319064353.686226-3-eggert@cs.ucla.edu>
        <20230319193449.M629601@dcvr> <xmqqh6ufo01u.fsf@gitster.g>
        <xmqqr0tjmk6d.fsf@gitster.g>
        <047178a8-ccf5-1cab-e670-8f1c64f9ca3c@cs.ucla.edu>
Date:   Mon, 20 Mar 2023 12:40:07 -0700
In-Reply-To: <047178a8-ccf5-1cab-e670-8f1c64f9ca3c@cs.ucla.edu> (Paul Eggert's
        message of "Mon, 20 Mar 2023 12:00:22 -0700")
Message-ID: <xmqqfs9zky94.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul Eggert <eggert@cs.ucla.edu> writes:

> It might be simpler to use the gettimeofday workaround on all
> platforms, rather than having an OVERRIDE_TIME flag and complicating
> config.mak.uname. gettimeofday should be portable, as it's already
> used elsewhere in Git without configury.

That is an excellent point.
