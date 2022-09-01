Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0ED5C6FA82
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 20:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbiIAUqG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 16:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbiIAUqF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 16:46:05 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CA959276
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 13:46:03 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id i191-20020a6387c8000000b0042b44ad723bso67198pge.19
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 13:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=6/ZoNIyA131c1WnzpptR0NeJ8D/xILR6Q67KRfqKjgc=;
        b=JA0pHyHCdQgyBAFpwy3s7TBRz+Yb1VoeKZuf/PsIqgHVqnrX8yMp145oNS3lJUPC4Q
         UTltgw4aLO0gQSpaVufBauKkcuMLlWSIrM2VhYiIwXbPaYe+sXpaWLN6BbQK9v0pGXQR
         Q5DXN40A5szShw6voydhDWZbzxGTcFDS2KvNDPc9k/9s/Ji1ISt3+BAu47NOYtNrvLxh
         Rl5ejUM/U2dfoOdWJIwFnNHz6afp0dCrqx43ArBbDPvaXZIWTk99A1je4uJr257tng4/
         pLnj6j65XXCO2LNu2p4yI8aR41qE8+fJUGcQCoQtvPCAqPVrYRtKZ5wSjfkEXV1SPuKA
         +WnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=6/ZoNIyA131c1WnzpptR0NeJ8D/xILR6Q67KRfqKjgc=;
        b=WCfnRXtBd3wVi9n+MKWrhofV7iXgfDJmp2KYizEDHDhjX6e3WBQ2oMskqqjYYqZ1CD
         yOPLeu0kexw7jeJd9d+o+YXuFQg8MS7Wivg7Wtfb8xX4h/Ippt/WZT/KN5j19iAbicCu
         KvYvLQLNEwKYnanFz//VFRxkd4N2nxqgwqmZhtpuQTv9BlMm+CJCEmrolJOVQwQFCVQu
         APs20TLWYq1brJAiHQo7KLGrYyfrYGQwMQU8Y8zm14z1mU0DUIYwZTNVPfxOsR215u3L
         MvB98NJEemLf3H60PRybkUBHixZZq26sMCuz318J8sQgg1dJpd2zTJ0vMxba8N0wMjRn
         uh+g==
X-Gm-Message-State: ACgBeo0hTIY7s2pHX2kOEN9xlnacPmo1qzPQKXXZU+gs2Zhgmv+4T6J3
        u7tbvAVerJGAy9TapaZhpEMpTGWdiPpkww==
X-Google-Smtp-Source: AA6agR7SDrcTMFKXZTqB2iGYZy5fAc5gEJ9Zg8yIE2/darGB3pmvMIbBKSFqP+UJfgbBAoPTzBPnPXjiUsI0yA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:f64a:b0:172:7576:2124 with SMTP
 id m10-20020a170902f64a00b0017275762124mr31440070plg.155.1662065163414; Thu,
 01 Sep 2022 13:46:03 -0700 (PDT)
Date:   Thu, 01 Sep 2022 13:46:01 -0700
In-Reply-To: <20220901200135.515907-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20220901200135.515907-1-jonathantanmy@google.com>
Message-ID: <kl6l35daddrq.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 4/6] submodule: return target of submodule symref
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> diff --git a/refs.c b/refs.c
>> index 90bcb271687..d72015c95e9 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -1784,19 +1784,21 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
>>  }
>>  
>>  int resolve_gitlink_ref(const char *submodule, const char *refname,
>> -			struct object_id *oid)
>> +			struct object_id *oid, const char **referent_out)
>
> s/referent/target/ throughout this patch, I think.

I prefer the word "target", but this is a break from existing
conventions, e.g.

  int refs_read_symbolic_ref(struct ref_store *ref_store, const char *refname,
          struct strbuf *referent);

We can do this change, but I think we should also change this everywhere
if we do.
