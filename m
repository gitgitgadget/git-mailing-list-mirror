Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	ZIPFILE autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C75C433C1
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 08:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C353619FE
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 08:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhCYIAC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 04:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhCYH7m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 03:59:42 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E378C06174A
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 00:59:42 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id d2so1366463ilm.10
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 00:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to;
        bh=w14Z3yIxizW+PPp8DX15E+VfObxvFngh6bMJgKIcZsA=;
        b=WtPMn1nIuFr6FUXFEU2sY3L3aqbHHiXYQgi4i/CA5PGdAwLPxvh+wOqZIoRhp5UbMu
         3oe2P1l9nTRiKhnARPFrYbbfSczwvYGAobQpLkYaWe3Xh8aBhehwKSHIK26wfUAzOocv
         it7G59hFcsSJn1z/1XqXJO0R3LOpMiWFPNKtPS12sfWBMGty4DxmBrY5tVYBhM2YKMbb
         eyXvWdC3Jem6t3va7L6d8YdnbsUJPrqgxUBdHv8EWnp4oKlWpDGbkLvuN2MLpWjpVLFz
         17IacG0lmmqht2qwtYj8CVnPAANLQ7pichpUMWCvOB4e16jiJSsPI72a3gnJ/NV64Qmj
         r3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to;
        bh=w14Z3yIxizW+PPp8DX15E+VfObxvFngh6bMJgKIcZsA=;
        b=W0SXzkyIDEet3EO1uqC7EFp3HjgruUSYiLYHfkxIwUG2e6/uE9qZ05Jv/tZmxcVADf
         OcaRHfjkDNRoRIG6dsJyiOSyu7ZHaYkTXkdPk+HiY544BhcYt2VK/OTBsQedTLLmPVn5
         3rSsMfoMaaj8DGQWw0HOjNt8XMO2SttE9ysTG7xF8XkjtHvi/nrziN2DBUBGQc2Cokj6
         bZaE0uqK5eYYrkWckn5BHmtdakxPj/kbeFRJsk/5HrCweq/avsq3acWyCp4SrrZItq6t
         ugjKZHEhaSnkXkkxrBhqAn/TrxsZX1t0jOk5d0Z2H7v25zWTZGrRjE9nZqAzx0xDBWCl
         /EQQ==
X-Gm-Message-State: AOAM531CVkNWYLaYp2gNh2W/CEXtxYISCnMzl4uUxYJ++GaX5k8XM3Nc
        0GgVDsB0z0/C6ZVZbDJ5yNJFZI0qaMYYb4CKNfUIXyJD1AU=
X-Google-Smtp-Source: ABdhPJy52/tLgw2GR/kCJdyCzISU/KnTKh+Jfkfqdnipjtpos8QUeM+lbxZ/Gigb5MzR7VmTnV8JmL0AwUZV07WVxOg=
X-Received: by 2002:a92:c883:: with SMTP id w3mr6142151ilo.212.1616659181456;
 Thu, 25 Mar 2021 00:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAH8yC8mnaEpnw8xCKsyBg0XXsuwhiE10AFXFDBdH2AW0qUP3HQ@mail.gmail.com>
In-Reply-To: <CAH8yC8mnaEpnw8xCKsyBg0XXsuwhiE10AFXFDBdH2AW0qUP3HQ@mail.gmail.com>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Thu, 25 Mar 2021 03:59:27 -0400
Message-ID: <CAH8yC8mqaexYBh57YXf4Vd98GbpjwU6wKM2MyAbCa2VaqNheHw@mail.gmail.com>
Subject: Re: not ok 47 - log.decorate configuration
To:     Git List <git@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000003be48a05be57ccb4"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--0000000000003be48a05be57ccb4
Content-Type: text/plain; charset="UTF-8"

On Thu, Mar 25, 2021 at 3:57 AM Jeffrey Walton <noloader@gmail.com> wrote:
>
> Hi Everyone,
>
> I'm testing 2.31.0 tarball on an Apple M1:
>
> not ok 47 - log.decorate configuration
> #
> #               git log --oneline --no-decorate >expect.none &&
> #               git log --oneline --decorate >expect.short &&
> #               git log --oneline --decorate=full >expect.full &&
> #
> #               echo "[log] decorate" >>.git/config &&
> #               git log --oneline >actual &&
> #               test_cmp expect.short actual &&
> #
> #               test_config log.decorate true &&
> #               git log --oneline >actual &&
> #               test_cmp expect.short actual &&
> #               git log --oneline --decorate=full >actual &&
> #               test_cmp expect.full actual &&
> #               git log --oneline --decorate=no >actual &&
> #               test_cmp expect.none actual &&
> #
> #               test_config log.decorate no &&
> #               git log --oneline >actual &&
> #               test_cmp expect.none actual &&
> #               git log --oneline --decorate >actual &&
> #               test_cmp expect.short actual &&
> #               git log --oneline --decorate=full >actual &&
> #               test_cmp expect.full actual &&
> #
> #               test_config log.decorate 1 &&
> #               git log --oneline >actual &&
> #               test_cmp expect.short actual &&
> #               git log --oneline --decorate=full >actual &&
> #               test_cmp expect.full actual &&
> #               git log --oneline --decorate=no >actual &&
> #               test_cmp expect.none actual &&
> #
> #               test_config log.decorate short &&
> #               git log --oneline >actual &&
> #               test_cmp expect.short actual &&
> #               git log --oneline --no-decorate >actual &&
> #               test_cmp expect.none actual &&
> #               git log --oneline --decorate=full >actual &&
> #               test_cmp expect.full actual &&
> #
> #               test_config log.decorate full &&
> #               git log --oneline >actual &&
> #               test_cmp expect.full actual &&
> #               git log --oneline --no-decorate >actual &&
> #               test_cmp expect.none actual &&
> #               git log --oneline --decorate >actual &&
> #               test_cmp expect.short actual &&
> #
> #               test_unconfig log.decorate &&
> #               git log --pretty=raw >expect.raw &&
> #               test_config log.decorate full &&
> #               git log --pretty=raw >actual &&
> #               test_cmp expect.raw actual

And here is config.log. Sorry about that...

Jeff

--0000000000003be48a05be57ccb4
Content-Type: application/zip; name="git-config.log.zip"
Content-Disposition: attachment; filename="git-config.log.zip"
Content-Transfer-Encoding: base64
Content-ID: <f_kmol4j980>
X-Attachment-Id: f_kmol4j980

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
AAA=
--0000000000003be48a05be57ccb4--
