Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889DFC47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 08:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ED376124C
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 08:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhFHIN2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 04:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhFHIN2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 04:13:28 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB765C061574
        for <git@vger.kernel.org>; Tue,  8 Jun 2021 01:11:35 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id t140so15524030oih.0
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 01:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=O4fW0eZSjdDzPq+eWlAKkvcB1zqc0vRAHDmqI7cgmiY=;
        b=HuIIqgcRa87CH7rVYA9ZIEgHH7kwAhwJ7affMnShll28pEuzVhMh+Uwch5VOLwucz0
         2k9OKsh7U7rYWomt08nPhwVY0wAgYcU9IM7FXy70m7F3RQmxuw07xcl+eNQz9YK+C7Rz
         eux/3rH1aFf6TxLeFaFEnmiK6yc9TWjDxN5uwij9lebPUV1I6d1fm477w3+ztk+lAEGz
         UoHt3qIU+O3IVEcj1FCJ51GtW/l6/WZCT5WLWCZJ9dgRrMqizB4hmR51i1fObR1LLbEM
         g/loCjpbqdAZ8MjCeK1qOX9CUF7hoKG6FJAQ5tHXgrOkRkojAn9qfpl8MnQVHnBHM8PB
         RUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=O4fW0eZSjdDzPq+eWlAKkvcB1zqc0vRAHDmqI7cgmiY=;
        b=jn6KMrThz9BbfIyyCSUTlo+2hlBvPlQONTmwJmN2Ul7oiR8+AhYTPJZkDeKXnio8JO
         fXJSOOdqg3nPpmZmvmSOkYJjSnkN0/UKRjVl4YbiVOqq4UQBKVKm4YWvW/8tJnY9SfBP
         2ioO2f0zp2rrkBm6+MPKONtsXlQ3wn3B96+ypH6emDzI4ZbWq8u9eq3doXrI1LDyHLH8
         JdRBIPy2dKO1Or4JjJoDDj4pwvbH4kYlaS/CgSiK8PthFjL8b4nP2Jb0d3fUalNp7267
         nUkwVpNK+SmZZ7gisiAG0a4mFa86aku1kqIafjqsL0QvqHUTijDyPzBOrKeePUZl5C3I
         u8rg==
X-Gm-Message-State: AOAM5324m6XK9fF2BqWkgfnDSzF0+nQ8vwJexW2Fbev1MIIgJHml+Ll1
        X+5XBQd2emlhJywRZoosHkY=
X-Google-Smtp-Source: ABdhPJznY/sluFrh9IPQAV/cNo3BKpTbc5O3GBkZ/ordkG3Muopud9bZoFfgvZqwQtS7JogJHRoeXA==
X-Received: by 2002:a05:6808:13c5:: with SMTP id d5mr972226oiw.163.1623139894853;
        Tue, 08 Jun 2021 01:11:34 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id k14sm2675419ooi.21.2021.06.08.01.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 01:11:34 -0700 (PDT)
Date:   Tue, 08 Jun 2021 03:11:32 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, stolee@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Message-ID: <60bf2634beff5_1a700820836@natae.notmuch>
In-Reply-To: <YL8X7PepIggpKlSl@coredump.intra.peff.net>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <d2c079264955b3bd6c3a5ef77a9c3684206f8475.1623085069.git.gitgitgadget@gmail.com>
 <YL8X7PepIggpKlSl@coredump.intra.peff.net>
Subject: Re: [PATCH 4/4] CodingGuidelines: recommend singular they
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Mon, Jun 07, 2021 at 04:57:48PM +0000, Derrick Stolee via GitGitGadg=
et wrote:
> =

> > If we use singular "they/them" pronouns instead of "he/him" or "she/h=
er"
> > pronouns, then we can avoid this congitive load on the reader.
> > =

> > Using singular "they" is also incredibly efficient. Choosing a gender=
ed
> > pronoun is usually arbitrary between "he" or "she". Using constructs
> > such as "he or she", "s/he", or "(s)he" are more complicated than
> > singular "they".
> =

> In general, I do like the efficiency and readability of singular "they"=
.
> As a native speaker, I have no problem reading it, and I have little
> sense that most of my native-speaker acquaintances would, either.

Does this sound correct to you?

  We thank the reviewer for their helpful comments

> One thing that gives me some comfort is your research here:

You should look into a carefully crafted usage note written by a panel
of linguists and writers.

https://ahdictionary.tumblr.com/post/147597257733/updated-usage-note-they=


Not a blog post written by a psychologist for an association actively
criticized by many scolars (Twelve Scholars Respond to the APA=E2=80=99s
Guidance for Treating Men and Boys).

https://quillette.com/2019/02/04/psychologists-respond-to-the-apas-guidan=
ce-for-treating-men-and-boys/

-- =

Felipe Contreras=
