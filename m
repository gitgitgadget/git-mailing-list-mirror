Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D28FC433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 21:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343961AbiCHVn1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 16:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236104AbiCHVn0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 16:43:26 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344CBDC3
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 13:42:28 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id e7-20020a17090a4a0700b001bc5a8c533eso298882pjh.4
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 13:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=tt7Pt3cmhYXtmrAO9FXJrxmCa/lZaJDjboMYuV1pkaQ=;
        b=LDCJBDUjnXLvivEQFHc7fekQdDy5MP0DAZidviwvN7ZFTWU8g0vghORtTbFWfHMY1Q
         fFO/o31UEYrtXkxnpvAqMO14aTXG+b/d0pFYnI5A5oR4NWQTdWiPFg1MWk2Wp7ieGqLL
         3kN95ImvE2ZxuZurBVm3otNRWsMy8iX8dJ1FH+susbNWqKTRbZndOrnKPdSRwmoF53ab
         lcQRHPM6D4iS+orvZpHCYtfAZHopXnjtSY+rzK0zVNx+WPA21zugIbaXfZUQG3F8XIXn
         70gVRu17AM/YyFmhRwJhwDNi+ot9iZr9f8Q/8eBaIa4KrbBQFcsdXRTIuwuXElUq4ve3
         pgug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=tt7Pt3cmhYXtmrAO9FXJrxmCa/lZaJDjboMYuV1pkaQ=;
        b=46lqfNIuDkNs4fByahOss4yJ0HRmPQn8E0I6Ssvs7DX+RgD1QAriIFUFxD39jaEIzc
         FM+B6g09+E0fIdLfQtg/2K+v++B5qQ3HtwLe7Vnckj/TlqHwuf1uHh3pzUkcnrNbi0KQ
         h63ZlxbTb5lxZCIPFDyvMtYMq06rWhwBU1TT2Gi0ZoSjJC9cpqj8SVco6ycPMX4XoHM2
         svJPZrIUyqZNxqH6fxcdXXBOjpwcBf7/SZFjwu1451BV/b4vA8on/XyQe0amTlIuhbDk
         gd9W8X9MqBvn1mn+T4RzzV/R/1WjZWx4OrYtyW2mxRo+vCNbopFEQj6y1kIGV5RGl8Au
         oHHQ==
X-Gm-Message-State: AOAM530/cZF7apTJfdhhDqodzngV6XpFII1aRIkDfftrqhmbuPSpaizR
        AGE0JAHEUJ1fXIdB9YNlp4I23Y3OhbgUOf4ZlRM1
X-Google-Smtp-Source: ABdhPJwga4jZm73qm4tl1EZdEcaTOPw0xkRG3vwsiksZiyqgWqLgZfIBvvps925x2EeK42ZXrhV22e/gtnJPnqfNv0iR
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a63:8348:0:b0:380:abf8:ae3c with
 SMTP id h69-20020a638348000000b00380abf8ae3cmr1719365pge.5.1646775747603;
 Tue, 08 Mar 2022 13:42:27 -0800 (PST)
Date:   Tue,  8 Mar 2022 13:42:22 -0800
In-Reply-To: <20220308001433.94995-1-chooglen@google.com>
Message-Id: <20220308214223.3856920-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: Re: [PATCH v5 00/10] fetch --recurse-submodules: fetch unpopulated submodules
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> - <20220304235328.649768-1-jonathantanmy@google.com> I've described the
>   differences between the no-submodule-in-index test and the
>   other-submodule-in-index test (their comments now refer to one
>   another, so the contrast is more obvious), but didn't reorder them
>   because I thought that made the test setup less intuitive to read.

Thanks - the comments make sense.

> - <20220304234622.647776-1-jonathantanmy@google.com> I added
>   expect.err.sub2 to verify_test_result() but didn't change
>   write_expected_super() to account for sub2. It turned out to be tricky
>   to predict the output when 'super' fetches >1 branch because each
>   fetched branch can affect the formatting. e.g.
> 
>     	   OLD_HEAD..super  super           -> origin/super
> 
>   can become
> 
>     	   OLD_HEAD..super  super                   -> origin/super
>     	   OLD_HEAD..super  some-other-branch       -> origin/some-other-branch
> 
>   (I could work around this by replacing the whitespace with sed, but it
>   seemed like too much overhead for a one-off test).

Overwriting just the super part works for me, thanks.

The only thing remaining from me is my comment about fetching OIDs from
one submodule into another (of the same name but different URL) [1], but
I looked into it myself and we can probably postpone handling this to
another patch set.

In such a patch set, we would probably need to store the URLs that are
reported by upstream .gitmodules somewhere. (I forgot that we don't use
them in this patch.) And then, either implement an autosync function
(like "git submodule sync", perhaps gated by a "--sync-submodules"
argument so that users can include it when fetching new commits and
exclude it when fetching historical commits) and/or use those URLs in a
diagnostic message to be printed when the fetch fails.

As it is, the existing fetch-into-submodules-at-HEAD also suffers from
the same flaw, so I'm OK postponing this to another patch set.

So,
Reviewed-by: Jonathan Tan <jonathantanmy@google.com>

[1] https://lore.kernel.org/git/20220304234622.647776-1-jonathantanmy@google.com/
