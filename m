Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D336BC433DF
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 22:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B20F9206E3
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 22:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgGZWbv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 18:31:51 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52823 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgGZWbv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jul 2020 18:31:51 -0400
Received: by mail-wm1-f68.google.com with SMTP id x5so11873510wmi.2
        for <git@vger.kernel.org>; Sun, 26 Jul 2020 15:31:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fhBj6K7ziN2Qsy/OQ30sJ0aqevb55K0bHJNSNWxy/AM=;
        b=sZ47RTsmpR7gY0QYUPQZXvfTBdcusf7BKnfI9shzeKNYbtZyYRbI2QltL4KOHelElR
         9dWUP3zubtE+/Z2I/ckK724gNdqyuBvppId+fJSpYwQf00g2SrZ6zXC1hC3dKt2PsOdh
         zbx7r0WAupWEX89XuUCOCY+1Cm1YrucTnceAsSd+z11BC1W/GZfGR0dvcTqhDpNqaib2
         GGZyk6At8KKnO9yM0eQOKTxVc0BSZ0NCGKZY2cxme5BkPFcGqysoKioGYB+H3nm+uTWj
         7t2kYWqBWOj298Mv0GByYlRN1mIT8uOTmRAp9SzCszeouIb/0b1syOSpO40Jly9Wcg8/
         1rCg==
X-Gm-Message-State: AOAM530a2Ru15nggPSAsHWPLQSM0y151J3+t5XvjhIZGH99sUqD5o6V3
        JnV2AdeEoxqn47aeArCcEZC6DhGeWjt+v/DEypY=
X-Google-Smtp-Source: ABdhPJx/DveElfZ8gBz8A4FsiZURSTIQB/iSAe6ZVu1Buy2w/vyjJLkrySTbRBWGadDxtNUBq+mGva2v4BYq9dBiTL4=
X-Received: by 2002:a1c:5f41:: with SMTP id t62mr17379813wmb.53.1595802709509;
 Sun, 26 Jul 2020 15:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200726195424.626969-1-sandals@crustytoothpaste.net> <20200726195424.626969-5-sandals@crustytoothpaste.net>
In-Reply-To: <20200726195424.626969-5-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 26 Jul 2020 18:31:38 -0400
Message-ID: <CAPig+cS0Ap_47w+cqVipe8yD902YRO+AYStrn7mHOJQCnXuLcw@mail.gmail.com>
Subject: Re: [PATCH v4 04/39] t3404: prepare 'short SHA-1 collision' tests for SHA-256
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 26, 2020 at 3:55 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> The idea of the magic value "ac4f2ee" in this test is to make the
> reworded commit `collide2` have the same shortened ID as the commit
> `collide3`.
>
> To port the same idea to the SHA-256 version of Git, we therefore need
> another magic value that causes the same collision, but this time with
> the SHA-256 version of the commit IDs.
>
> In this patch, we add code guarded by `GIT_TEST_FIND_COLLIDER` to do
> exactly that. Essentially, a large number of integers is appended to the
> commit message "collide2" to find such a collision. To make it easier to
> find such a collision, we reduce the number of digits to 4.
>
> The `t/oid-info/oid` file now lists the values found in that way, and
> the test cases are modified to use those values.

This seems to be saying that t/oid-info/oid has been updated to
contain the colliding OID's generated for this test, however, those
OID's are actually specified inline in the test itself (which is the
appropriate place for them since they are specific to this test). So,
this paragraph/sentence probably ought to be dropped.

> As the tests are no longer dependent on SHA-1, we also rename their
> titles to talk about "commit IDs" instead of "SHA-1s".
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> @@ -1262,23 +1263,54 @@ test_expect_success SHA1 'short SHA-1 setup' '
> +test_expect_success 'short commit ID collide' '
> +       test_oid_cache <<-EOF &&
> +       # collision-related constants
> +       t3404_collision sha1:6bcd
> +       t3404_collision sha256:0161
> +       t3404_collider  sha1:ac4f2ee
> +       t3404_collider  sha256:16697
> +       EOF
