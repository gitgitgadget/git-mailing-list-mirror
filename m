Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFFFC433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 19:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BF636023C
	for <git@archiver.kernel.org>; Tue, 18 May 2021 19:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244507AbhERTWJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 15:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237739AbhERTWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 15:22:09 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F498C061573
        for <git@vger.kernel.org>; Tue, 18 May 2021 12:20:50 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id v22so10836933oic.2
        for <git@vger.kernel.org>; Tue, 18 May 2021 12:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8t58F02wY0YjEZYl/kRBg60BuqpWb0aVXjsFTBK/ZoQ=;
        b=AnvB0lyk9pGsnoLCDKxrj/wa05QwPAAHysfGbzkxQAhARXPZ2bPgKnrD91jlX1Q6cE
         XOAGLAngRnBVM7Yv4XqzqFSeLD1Kh7FF/HFH2xlMaEd2PwLK82rmYteOixZ+msdgP3Xq
         Qi937R0MogdIR/f1BDziUpyCH3Dk8glFu4HNPeCqRkb+HJ3OICCZlXivJ3h2BlOf/QDN
         doT9oHv/TGFI5izapVAx5JsNlwxH6Q5gGerNjjKazZlKhbRMKFOFo0akRNPQX49PhoCA
         YIFlnGC5urhM7H8XSTyYIlOqJJ/wdGf+g2+v/vphcr92e0p2w2OldR4Nv72DafKtBrtk
         NM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8t58F02wY0YjEZYl/kRBg60BuqpWb0aVXjsFTBK/ZoQ=;
        b=QINm7JFWa4H7lBNQ1HAW3Ep9fyQwZ274nJWhuA1IpJnFf5njB46+OK+p5VAU0grCis
         rbmEhcyzuY0aSF2E+SGSIYuv2Cgy76ktZ/mIOoR8i0d5VdgfK+2jYIwxMrjsOshOk44y
         FcrPk2bHogCRV0s0GXaRE253XelzGbgfQMR1QB6SaIBdss9P+kWH6wRhlCpBS+oiL9m1
         2OPq7jmwd16BmzbHNK+7s8qbU5lCGBROK8p2yvXG4T1ozl04EWZSBHi+0mhOe6JFgK9u
         Wmqpe4Jvpqg2EmFiOhpN+/OM2BFjSxh9Ec9Vu65cT/6KF3InDViu2dyocd+BM56UYm22
         9cnQ==
X-Gm-Message-State: AOAM532KcryWtcKshqOvgCOKQ6pra5SLiB9nIc72HRVRBIjVB0XGNJko
        Drub/Em/XsE0neyR+WkSjT4=
X-Google-Smtp-Source: ABdhPJxQlkDubIjD+a8oYwEUJc8ew7bptwHQOmf8GQLUPFprA0dCW607bB6mpHDeDjd6AhZpApgLyw==
X-Received: by 2002:a05:6808:561:: with SMTP id j1mr4761665oig.24.1621365650061;
        Tue, 18 May 2021 12:20:50 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:bcf4:c194:74a1:9906? ([2600:1700:e72:80a0:bcf4:c194:74a1:9906])
        by smtp.gmail.com with ESMTPSA id d185sm3608109oib.25.2021.05.18.12.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 12:20:49 -0700 (PDT)
Subject: Re: [PATCH v3 07/12] unpack-trees: stop recursing into sparse
 directories
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
 <pull.932.v3.git.1621017072.gitgitgadget@gmail.com>
 <598375d3531fabe8582cb6d93838df09e1bd06c3.1621017072.git.gitgitgadget@gmail.com>
 <CABPp-BGc_Cduk3aFJqk4MjJ2k6KMDWSnwZfJM+E-1oK8txsf7Q@mail.gmail.com>
 <CABPp-BEdWMnzUay9R_GnbiWzuddrFMu87DLmCz4_s8HaBsrYQQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e583fe80-4872-0e2b-622f-8288d2b18bd0@gmail.com>
Date:   Tue, 18 May 2021 15:20:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CABPp-BEdWMnzUay9R_GnbiWzuddrFMu87DLmCz4_s8HaBsrYQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/17/2021 10:06 PM, Elijah Newren wrote:
> Sorry, I spoke too soon...
> 
> On Mon, May 17, 2021 at 7:03 PM Elijah Newren <newren@gmail.com> wrote:
>>
>>> diff --git a/unpack-trees.c b/unpack-trees.c
>>> index ef6a2b1c951c..703b0bdc9dfd 100644
>>> --- a/unpack-trees.c
>>> +++ b/unpack-trees.c
>>> @@ -1261,6 +1261,7 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
>>>         struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
>>>         struct unpack_trees_options *o = info->data;
>>>         const struct name_entry *p = names;
>>> +       unsigned unpack_tree = 1;
> 
> Here, you set unpack_tree to 1.
> 
>>>
>>>         /* Find first entry with a real name (we could use "mask" too) */
>>>         while (!p->mode)
>>> @@ -1307,7 +1308,8 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
>>>                 }
>>>         }
>>>
>>> -       if (unpack_nondirectories(n, mask, dirmask, src, names, info) < 0)
>>> +       if (unpack_tree &&
> 
> You check it's value here...
> 
>>> +           unpack_nondirectories(n, mask, dirmask, src, names, info) < 0)
>>>                 return -1;
>>>
>>>         if (o->merge && src[0]) {
>>> @@ -1337,7 +1339,8 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
>>>                         }
>>>                 }
>>>
>>> -               if (traverse_trees_recursive(n, dirmask, mask & ~dirmask,
>>> +               if (unpack_tree &&
> ...and here....
> 
>>> +                   traverse_trees_recursive(n, dirmask, mask & ~dirmask,
>>>                                              names, info) < 0)
>>>                         return -1;
>>>                 return mask;
> 
> but you never set unpack_tree to 0, so this is wasted effort and you
> always recurse.  The previous iteration had a case where it'd set
> unpack_tree to 0 in a certain case, but you deleted that code in this
> version.  Why?

It appears that the changes to unpack-trees.c are no longer relevant,
and instead the changes to diff-lib.c (which were already out of place)
should instead be the focus. In fact, those changes to diff-lib.c can
be simplified and moved to path 10, so I will do that.

Thanks,
-Stolee
