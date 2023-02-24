Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9289C7EE2D
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 17:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjBXRM6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 12:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBXRM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 12:12:56 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AF1619F
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 09:12:55 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id qi12-20020a17090b274c00b002341621377cso3530027pjb.2
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 09:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+neLJqAMLYYOqHZqKvlVlb7TEaoIJSapMuyFWtvijTU=;
        b=e2Qv3H2Otyvdk7rBWZ945KNtjmEa0laOsRv109ljNPGYuXJ3UrVEBSKpKSu3OW+AkM
         EF42dFWuxphiNTpUTqkV/D7U4688fgUypSrxJVhJM9dlfTPbgyt0BlMaQEkXy73HeoVU
         HheE7db7tX5iAfrWf6xNbRTyWJJlRvhRltJAJyvQLw/916bYgZhI9xEACwcAZ10kJ+Ri
         EeTkEhQmsB7h/f5RbRimSKT/s7hwjyaxRQnxKfVjNMXyyRzhqxeN4KUa0Sd1z4h6m9nM
         pLXPCtP/PxweoiI0qHz3jAud8PKEJY+XQMxTU3O3ceZZ/+jjAqFqquXYYOQp8V8D0CmY
         xOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+neLJqAMLYYOqHZqKvlVlb7TEaoIJSapMuyFWtvijTU=;
        b=q3ZFObj4HrQdXPS5dCxYgvwq4XjTNW0OOskBCYcf6e4918Y38ko0Yr7SwI8dyHQ8FQ
         O/SGXvItMeKQKZkXnXiS6TPXE6C59MStnkS4kPOeiYbWz/Zi4prAfN4rAYQkLnZMYLT1
         Mg8k4HKHcbAXPOKxdrJXl+NL12AanhfSwffICgDTLQgy+LeDXPzdH4+DBvmES4SQrZJf
         OOUD+mStVrNmXK56rWk3wakgToEmeLM58WuxeITAQ4B5bVJcEx5wm1Yt1WGjqmJxBOda
         R2eDBzFFa+B/VUoAq4Wftg0W3Jw75XTZqnGR5yimPmsMuN1V2Jwvf0WKhXA547ujKdT1
         3K6A==
X-Gm-Message-State: AO0yUKXY48Ys88nWyvjueMog5uQrTsXXD6+F7iGBNFYU3xHOQ7s1+kHj
        Z0n3GExpYrwBJz+wp3EZAvQ=
X-Google-Smtp-Source: AK7set/uQFbQxs/JxAPtBfawn4JASNpOShFgZ+m/IoAyhq+JdQ68/DDPoBkXRyFfmLe1fUiLYAGdAQ==
X-Received: by 2002:a17:902:da91:b0:19a:7648:512 with SMTP id j17-20020a170902da9100b0019a76480512mr22631923plx.30.1677258775246;
        Fri, 24 Feb 2023 09:12:55 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id 10-20020a170902c14a00b0019aa6bf4450sm10475142plj.188.2023.02.24.09.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 09:12:54 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] [RFC] push: allow delete one level ref
References: <pull.1465.git.1673951562.gitgitgadget@gmail.com>
        <pull.1465.v2.git.1675529298.gitgitgadget@gmail.com>
        <966cb49c388b652861c773ad7430875bf7896c16.1675529298.git.gitgitgadget@gmail.com>
        <xmqqbkm64f3t.fsf@gitster.g>
        <CAOLTT8TxtysmA_Ug8-+XB02QLigQnp20eBgdCjHkdZHXidnCmQ@mail.gmail.com>
Date:   Fri, 24 Feb 2023 09:12:54 -0800
In-Reply-To: <CAOLTT8TxtysmA_Ug8-+XB02QLigQnp20eBgdCjHkdZHXidnCmQ@mail.gmail.com>
        (ZheNing Hu's message of "Fri, 24 Feb 2023 14:02:49 +0800")
Message-ID: <xmqq4jrb2dih.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

> ... Therefore, generally speaking, it's better not to let users
> create/update special one-level references.

The question was "Is it that we are actively discouraging one-level
refs like refs/stash, so removing is fine but once removed we do not
allow creating or updating?"

You could just have given a single word answer, Yes, then.

> Certainly, I can remove the previous section as you requested.

I didn't request to do anything to the change.  I asked you to
explain why you allow only delete without create/update, and without
knowing why, I didn't have enough information to make such a request.

I think "we discourage a single-level refnames so allow deleting one
that may have been created by mistake, but do not allow creation or
deletion as before" does make sense.  As long as that is explained
in the proposed log message and in the end-user facing documentation,
I am happy with the new behaviour.

Thanks.
