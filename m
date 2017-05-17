Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41EF22027B
	for <e@80x24.org>; Wed, 17 May 2017 17:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754295AbdEQRog (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 13:44:36 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36347 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751566AbdEQRof (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 13:44:35 -0400
Received: by mail-pf0-f182.google.com with SMTP id m17so10818597pfg.3
        for <git@vger.kernel.org>; Wed, 17 May 2017 10:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=us/Aru/iUBKM4z2/4QX9Ogu2Q/Sz0sShLdW2uBczgMk=;
        b=GiaQsXFcCvYfnMvkNfoKwenb1gQXvNfwaJgQwVSk2Hzk2h5ziylfvBmLilE674BvRP
         ltStq7yAOnvXUUFPBx1abU5+0X3Z3OR9fhOx1DD8Qifqd5j3SAoREL5Hm9YuiihITsGU
         kldq4JbufRorVw1T3gfb7WMdecLKnXygBoVTgjUOg3yPteoYNX3UdMldZiIf2f8yFe9U
         GerZijMrgmpeUsRxPekMEkyIFTxAmhSjvuEirw7yfsM9599UvnoHRiC69AvvYm12fGVw
         vzoz/cMa0Yp4FITX4rRg2CH5CU6KV5neH6lTPtlZ3BNe00i9DHsvbJiRRM4zGvYkeOUg
         RjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=us/Aru/iUBKM4z2/4QX9Ogu2Q/Sz0sShLdW2uBczgMk=;
        b=olwUnNSepoX2YyA6edHyN2dfN0w6+qB995dcPM8+xJiTtAVUO4YAFngweYLNPlgP0e
         RlSBfAQlCpxVBdk/e+eUBbk53Nu3hCnBkH/Xi5IUUS1Umy8BofUs0I23jbQM5v/k7Fb6
         QTxB+QryImDekeDo7/gJQC/Qg8K4NeMNHpx9n8aEm3yzc9SUvr7v9fyYzopy/nl6BjPE
         xIlfFW6k0s2PIg6yAtOeWppLP7q4+ldYZ3atXiLgkOnYBCeA9s0SsJX/iIumo5QOkIFx
         qyl72FL7RLKvMRCa27czVwi5pByZUdtYy5tL1fPyTdddH2zsA84jYXrT224FGETb/R4I
         KyoA==
X-Gm-Message-State: AODbwcD38mWCEVTVeY+AByqVubw0QepgIaiuQk5y+9K77gkKD+7O0JiW
        /uMzDp1nM0NqkjjdV/eaSDQYKNfOE3+Z
X-Received: by 10.99.116.7 with SMTP id p7mr4967277pgc.162.1495043074195; Wed,
 17 May 2017 10:44:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Wed, 17 May 2017 10:44:33 -0700 (PDT)
In-Reply-To: <5ec5f3f9b4c9fc9f719d116b48dcf7b61e74ae49.1495014840.git.mhagger@alum.mit.edu>
References: <cover.1495014840.git.mhagger@alum.mit.edu> <5ec5f3f9b4c9fc9f719d116b48dcf7b61e74ae49.1495014840.git.mhagger@alum.mit.edu>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 17 May 2017 10:44:33 -0700
Message-ID: <CAGZ79kYF=MnJKrQakDbEQoR8r2MyeHro9vtzzmggwm6NXH9T2g@mail.gmail.com>
Subject: Re: [PATCH 12/23] ref_transaction_commit(): break into multiple functions
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2017 at 5:05 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Break the function `ref_transaction_commit()` into two functions,
> `ref_transaction_prepare()` and `ref_transaction_finish()`, with a
> third function, `ref_transaction_abort()`, that can be used to abort
> the transaction. Break up the `ref_store` methods similarly.
>
> This split will make it easier to implement compound reference stores,
> where a transaction might have to span multiple underlying stores. In
> that case, we would first want to "prepare" the sub-transactions in
> each of the reference stores. If any of the "prepare" steps fails, we
> would "abort" all of the sub-transactions. Only if all of the
> "prepare" steps succeed would we "finish" each of them.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---

Code looks good to me.

>  /*
>   * Transaction states.
> - * OPEN:   The transaction is in a valid state and can accept new updates.
> - *         An OPEN transaction can be committed.
> - * CLOSED: A closed transaction is no longer active and no other operations
> - *         than free can be used on it in this state.
> - *         A transaction can either become closed by successfully committing
> - *         an active transaction or if there is a failure while building
> - *         the transaction thus rendering it failed/inactive.
> + *
> + * OPEN:   The transaction is in a valid state and new updates can be
> + *         added to it. An OPEN transaction can be prepared or
> + *         committed.

All of these states are valid, OPEN is not more valid than the others. ;)
Maybe:

    OPEN: initial state. new updates can be added to it. An OPEN
        transaction can be prepared, committed.

Is it possible to also abort/free an open transaction?

> + *
> + * PREPARED: ref_transaction_prepare(), which locks all of the
> + *         references involved in the update and checks that the
> + *         update has no errors, has been called successfully for the
> + *         transaction.

Maybe add that it cannot be altered any more? Possible ways out are
commit and abort IIUC?


> + *
> + * CLOSED: The transaction is no longer active. No other operations
> + *         than free can be used on it in this state. A transaction
> + *         becomes closed if there is a failure while building the
> + *         transaction, if an active transaction is committed,  or if a

The wording here is off as it doesn't use the lingo as introduced before.
(What is an "active" transaction?  I think you mean OPEN in this case)



> + *         prepared transaction is finished.
>   */


Also s/prepared/PREPARED/, add "or aborted"(?)
as that is also a viable way IIUC.

Thanks,
Stefan
