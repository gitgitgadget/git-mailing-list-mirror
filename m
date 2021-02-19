Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3818BC433E0
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 15:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3D1464EAF
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 15:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhBSPrw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 10:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbhBSPrm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 10:47:42 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38D2C061574
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 07:47:00 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id q77so6078391iod.2
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 07:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=technoplaza.net; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=2I18rWtP8l8r83SC27b1Y2M7YGMqbqbAD+jwKGgQX7E=;
        b=QiuHxc8NlUodu6kHxRrngv/n8+AdEFeSc44Ema2arqnFu5SU5ZN99wbeRvEmjUia7J
         tLs0No7WJ8QkLp8JrelnHJQ9Y2agg9/bEYW9DY1pk8RIhWfdvI6R9szuDBtPIscmAehw
         qGt6MjgI/+MlahNBZS1OdxrYZEBA8cCwTKHtKYUn1bFoxbV1f7eceIbHUhwlz1bcuwM5
         nUY3xxaBik/fFmKzSkvbrWNdNpgJUWLPFnSKXcd8UaKL/Ay3MPzP3P4ibEc3YM0F+tFZ
         o2XLQ+uj+biz9glkz9yOFJXcl32bXCsMxRmbHcTIAmQ1l9jaIPUATWdD3sRSUqwyBZFY
         iR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=2I18rWtP8l8r83SC27b1Y2M7YGMqbqbAD+jwKGgQX7E=;
        b=co/RA4y8xHhgNlzW78cmQunbQp9ga8q1II3rvKREDd7qXQpUxUjqrOrx0SHYjMv6R5
         TQOiHG3W7TN+kdszniVtjw1hcnrHajzoynAwn3A/uhEWPB9nyMHPcOPOPC60XpdYvCBt
         I4guP9TyVPi7/HbPFgBop6Zdi4aDnfmRs4xxvD5SbDExZqHfTENYKP6YjJFIEIFpnGHj
         g92PxHYukE2tLnMJi0u1A3UImiO2NayQjrw5/ho0zhvNpcV3LqubBHmzxgYO/hLX0nrk
         0KPdZOYGnDiLoDkiOCQxGivuTBbhFohV+2Q1CbyOv4pn7j+e/7mZ/SqQns2fFQgL7q4F
         6oaQ==
X-Gm-Message-State: AOAM530VP7Jz2S/NYmFt2jmJDRsMO7XaF/nxni1uoowWRVogEJQzqy2I
        /GGJKMtauADxAPPMNE94wQ628HcavFjnXhBCt0WtlVojp82gbQ==
X-Google-Smtp-Source: ABdhPJxy0LrxAnwLLEWdYJ3zAvqZAO/k3E5ei+vGHAcMzIwmLxjtT36DF0j1WDdMSAIeTUA4WFSPITd7V/gFkCv6+dA=
X-Received: by 2002:a5d:9641:: with SMTP id d1mr4338147ios.123.1613749619976;
 Fri, 19 Feb 2021 07:46:59 -0800 (PST)
MIME-Version: 1.0
From:   John Ratliff <john@technoplaza.net>
Date:   Fri, 19 Feb 2021 10:46:48 -0500
Message-ID: <CAP8UukiL0niGSm3o7uYNBzL3FP-UEgfOuq-Tu=fksWJkerT5fg@mail.gmail.com>
Subject: git credential cache timeout questions
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have configured my git to cache my credentials for 12 hours using
this section in my .gitconfig

[credential "https://mygithub.example.edu"]
    username =3D myuser
    helper =3D cache --timeout 43200

However, the credentials don=E2=80=99t always seem to expire after 12 hours=
.
Sometimes I come back the next morning and the credentials still work.
This is generally after leaving at 5:00 PM and coming back in the next
day at 9:00 AM, well past the 12 hour timeout.

Is there any way to see the current timeout value? Is it a rolling
timeout (i.e. any git action resets the timeout)?

If it happened once or twice, I would assume I just forgot that I did
something with git later than I thought. But this happens frequently
enough that it=E2=80=99s difficult to accept that as a possibility. It=E2=
=80=99s not a
daily occurrence. My credentials do expire=E2=80=A6I just have no idea when
they will.

Have I setup my gitconfig section wrong?

CentOS 7. Git 2.24.3.

Thanks.


--John
