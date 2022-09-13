Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0500C54EE9
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 17:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiIMRHC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 13:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbiIMRG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 13:06:29 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396628E9B5
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 08:56:02 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id b21so12267222plz.7
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 08:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=tFytja89/uDrnzy+i2+3g1GOTKrcQ4lGd3+G0jnk9LM=;
        b=GtelzaMCaF/C7wCTi6ZYeaJu/w+hal5BtoQFw4p5YhG+3+MIuRJGr5Ih4Z/6ip+ZsX
         fzeqZVc5Lt3aaseTKoxAG1BxwHVRWfxy8GNBZw7hiT6DoEehEEgV1oVy9rHO38EA/cYY
         okdZtMre92uWycisSnzn0Je5eFNp2N+vYZq0xWCRUxOG+SEhPqr1XAq0fywCpDvVePq5
         L7ZsvKoFpR5A3O+9mZM7hjdOe/odl/PwNzILukvRPx+7kiqsMQXnAYGVC0SHjSAsXgoH
         ZOMW5cAiy7NfHqMoBJfLiKbRQ16UGN9b7hvLEjRZTtdkquK1MgI5sFIkq5I78y/o7+4s
         3b8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=tFytja89/uDrnzy+i2+3g1GOTKrcQ4lGd3+G0jnk9LM=;
        b=ltWlkhDYhE4Ft7mWmq4oa2J7AEEYdSNTKUjxx48FxugL5nDmnHMRrGMXhXL6Wh7+pR
         OfKKU9E+NEa6ML5pZbmVlHBO2edRaSt+/cwnbQEKtY1J6zvTWN9HWN0JlNr9amTz2zPZ
         +4uYtsJRkimzyco6EK9JAI0YWJgYv3abKSvD8+3XOqawOzuHdfO6yqqiG9sVTNasw45F
         hMqmDQ5uSx+ZNRC+g8AurlrRdgKhnSVkZ1q27L7hM0Tz07Sw5V46jz9o8aYqHSBj/nzB
         4cHS30guy0HHr8kINeWoyytXr7CVnnwZz4GRkbo32nV3m/z1bQX1Ln8Ys9XscXXlgsG+
         EthQ==
X-Gm-Message-State: ACgBeo3nEjOntHuPEhg/BhpBIFHV8Wun5/KPr1g6PnqEF1zwn42qcm3s
        sh3ESrOaBP11dEusA2Jk3vQu0oCmxEE=
X-Google-Smtp-Source: AA6agR7g+5RqgeeTZA5/gAGlM9jYEUCF8mpfA3UUbSQQlQpwucGzDmG7VnmZ/QoNGRJhKOdShu6p3w==
X-Received: by 2002:a17:90b:17cc:b0:202:bccc:f552 with SMTP id me12-20020a17090b17cc00b00202bcccf552mr4720158pjb.154.1663084556629;
        Tue, 13 Sep 2022 08:55:56 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d3-20020a170903230300b00174abcb02d6sm8521423plh.235.2022.09.13.08.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 08:55:56 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Conners <business@elijahpepe.com>
Cc:     "git" <git@vger.kernel.org>, "hanwen" <hanwen@google.com>
Subject: Re: [PATCH] reftable: pass pq_entry by address
References: <183353220fe.d7826593472673.3445243727369286065@elijahpepe.com>
Date:   Tue, 13 Sep 2022 08:55:55 -0700
In-Reply-To: <183353220fe.d7826593472673.3445243727369286065@elijahpepe.com>
        (Elijah Conners's message of "Mon, 12 Sep 2022 21:53:41 -0700")
Message-ID: <xmqqbkrjb75g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Conners <business@elijahpepe.com> writes:

> In merged_iter_pqueue_add, the pq_entry parameter is passed by value,
> although it exceeds 64 bytes.

Do we have any hard guidance like "do not pass an data item whose
size is larger than 64 bytes" in our coding guidelines?  If not,
make sure that the reference to 64 bytes does not look like one.

While this patch is not bad as a change, we are going to make a copy
of the value with structure assignment at the leaf level, I am not
sure how big a deal this is in practice.

In any case, wouldn't it make sense to make the "we pass reference
not because we want to let the callee modify the value, but because
the callee deep in the callchain wants to copy the contents out of
it" parameter a pointer to a constant?  I.e.

    void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, const struct pq_entry *e)

Other than that, looking good.
