Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E32F1F404
	for <e@80x24.org>; Wed, 11 Apr 2018 23:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752178AbeDKXZk (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 19:25:40 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:40776 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751942AbeDKXZj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 19:25:39 -0400
Received: by mail-wm0-f42.google.com with SMTP id x4so6540685wmh.5
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 16:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RhKV1lRa0nPqA+OZJGFpSaLBgPvQPOVBM8ak2sL//JU=;
        b=EADnp4QFfzh4Sc12ixa22W1OjeHS+TqhgfkOlrixXL8fZRwMbyxbgPknu3HKw5aRJ3
         0VBODLQMwOtaqUzpOEfnT+DltJW3sbzmbLtLZKWtikvI6jUyaoanh+bUhowjdRoyICZa
         P5lZvTDro//q1mvrn/+xGhEGvJb4ZZ2fg35hKugU0V0Qq6+8LCBbKFCkYNwJLp0PQ2Td
         extMBP+espujX7+zpza7awZ6oVVwxjT22wEKHf6ATTOlW0TX3TsQlyLskqNGTC5rY6qC
         te4UQpRbSJ3ZC8eQFbEAfEEh7DLC/R21BTqC3XkiKTjQ6vMLIDiMKCH57ficRBoYq1XT
         RHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RhKV1lRa0nPqA+OZJGFpSaLBgPvQPOVBM8ak2sL//JU=;
        b=uEvL7eM/JAXh16I1dcvJeFF2bA0V6x9XGD4gzRmKfStuUw8PakVJOrGPEx4RlfhpkJ
         wqZCMwZWsd8booHCPzm69HgqtcwvBfVwZ7BbCQIHZjzqEqnk6WsFc0jkckP2OxEbZwJg
         PuuCPuhCW3avS4g62HMJIhbAkhJdq5ocqM9NexHaGjUi9ZzvwesOUsS9QyO+CyqXiifq
         a2S1ubhCPbSRGxbMguQ95Yr3DAKDXpMYXpfpTusBMU6QU1SjbKTfojw1c8oy60chIk9e
         j+hV0TLdAP1YVuk6hBR9GResJt/jSGZIsCKhWoWOkMSQP8UJyiGkeT0qK+mKKav5qMuz
         J2VA==
X-Gm-Message-State: ALQs6tA5YY0GqNyvrNvMdQHxt9u6tOr59h49reCasGeEbUEocP0vddJN
        9Ax1u4pvjb8elKtU7JEr+Yo=
X-Google-Smtp-Source: AIpwx49jcTTrZbAlO5hphHNofhSXh+r5KxCe0cqR9gRDAimRcAApxixPLogPCX1ewWB1ZJreAPhH4w==
X-Received: by 10.28.116.20 with SMTP id p20mr4009319wmc.24.1523489137918;
        Wed, 11 Apr 2018 16:25:37 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e10sm4382811wri.23.2018.04.11.16.25.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Apr 2018 16:25:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Harald Nordgren <haraldnordgren@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v14 2/4] ref-filter: make ref_array_item allocation more consistent
References: <20180402005248.52418-1-haraldnordgren@gmail.com>
        <20180409014226.2647-1-haraldnordgren@gmail.com>
        <20180409014226.2647-2-haraldnordgren@gmail.com>
        <CAHwyqnURebvfW4rGz9RAbe7B9p6ZDy0jUueDFrYE30dmjCtMVA@mail.gmail.com>
        <CAGZ79kYeM=CqKSWTL2tdDXWueMGoki4zAUmFy4wbhtagN7gEAA@mail.gmail.com>
        <CAPig+cQzWAbEVBJ8O0yKYHQ02EaGTx9CeUyF67xozeT2-FL0EA@mail.gmail.com>
Date:   Thu, 12 Apr 2018 08:25:36 +0900
In-Reply-To: <CAPig+cQzWAbEVBJ8O0yKYHQ02EaGTx9CeUyF67xozeT2-FL0EA@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 11 Apr 2018 14:56:21 -0400")
Message-ID: <xmqq37014973.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Apr 11, 2018 at 2:07 PM, Stefan Beller <sbeller@google.com> wrote:
>> On Wed, Apr 11, 2018 at 10:57 AM, Harald Nordgren
>> <haraldnordgren@gmail.com> wrote:
>>> There have been no new comments for the last few days. I know Jeff
>>> King will be away for the next two weeks, but should we still move
>>> forward with this? The initial reactions to the idea seemed positive.
>> ...
>> It will be merged to next and if no people speak up (due to bugs
>> observed or such)
>
> I would guess, however, that Harald is wondering more specifically
> about the "--sort" patch he added atop Peff's patches. Disposition for
> _that_ patch is not specified in the latest "What's cooking":
>
>     * hn/sort-ls-remote (2018-04-09) 1 commit
>      - ls-remote: create '--sort' option
>      (this branch uses jk/ref-array-push.)
>
>      "git ls-remote" learned an option to allow sorting its output based
>      on the refnames being shown.

Thanks all for summarizing.

I think the preliminary clean-up patches by Peff are all
independently good and can be advanced, even without him being
around.  I haven't formed a firm opinion on the doneness of the
latest round of the "--sort" thing.  I usually do not explicitly
write "I haven't formed an opinion" in "What's cooking" report,
so please read the lack of "disposition" as such.
