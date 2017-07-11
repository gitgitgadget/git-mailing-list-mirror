Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 596E1202AC
	for <e@80x24.org>; Tue, 11 Jul 2017 15:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933727AbdGKPpQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 11:45:16 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:38730 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933691AbdGKPpO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 11:45:14 -0400
Received: by mail-it0-f41.google.com with SMTP id k192so25098489ith.1
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 08:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Fhr5bIPYpcwdA1TTPLaTM697xDuUROo27ehAXSTXyOw=;
        b=ASRk0AUUdVhmVlTh/EBrWPs5hSMEqlenQ9std2dgATybi2sOyS4YEzb/uj690NOpL2
         +9/D3Vr5lEd4mR18TTyttzcyyoD6EoOn0npQSztXaXL6BnYLeywMSrZIoOAa0HsAP/a+
         fd4n4YPyX44GT06gcpMiEGDC+tFZ2m2+vOuJoWv9iFYLxrval6tvbp9JWkQqkYTokFn6
         3P+9udhWIiRTe/fPr5vDHM+zwv2jT6KF8Tiihoqpyfn/3O1uKa1pAiIHX5MnoGv11vvy
         HdjXoj7bqSNUiLgQXABbsIqBzfudDpND779iluPIdQYrVJq74+iBgwb0LC6Lb9TwWy28
         EXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Fhr5bIPYpcwdA1TTPLaTM697xDuUROo27ehAXSTXyOw=;
        b=H+zGHbrS2kYDi0edXRiqlzNJUeEPsvHpXtwe9qLIV39RiMvXRrC4BKLzvpGmUT5Fhx
         puZ5csMhIG6qHrxrOvVsuzEsrIGLbltKtIwiSWf7P9fgcz3x/PmcBBl/9vOIMv8Z3hCg
         qv7Ayh5oK6oTk8AfwTKKvq1FPjHo2Ll5m0I4jV68scMPrXxrsO5bNTc07a/y99NmBcK1
         NRrZWFVyPiEG0uiKZLInMrpqmRPbNLDPSNOWb+y0bqK5RwPJXUsvaqLu7b0w7zr6xz3e
         UNcQQqB7HCs6NeaEaUHzdfP1uXLI4guiRJZyxvXKbnvbhQeVmme7tkT+D3mbAMOH4hz4
         hjUg==
X-Gm-Message-State: AIVw1131hrL+MCc8UGxf7jrgLj0GQ8U6yA+rrqPEDNzIWdWs03M32vWy
        pH48XQ2ZXI9yL8LA4ZTkqlmyy1EcrGuQ
X-Received: by 10.107.12.13 with SMTP id w13mr554761ioi.207.1499787913788;
 Tue, 11 Jul 2017 08:45:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.26.138 with HTTP; Tue, 11 Jul 2017 08:45:13 -0700 (PDT)
From:   Nikolay Shustov <nikolay.shustov@gmail.com>
Date:   Tue, 11 Jul 2017 11:45:13 -0400
Message-ID: <CAEcERAz3vYekvJ8SM1FfdAVsP3LMVqA1O3yoJVThvg-0fPtVCg@mail.gmail.com>
Subject: "groups of files" in Git?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
I have been recently struggling with migrating my development workflow
from Perforce to Git, all because of the following thing:

I have to work on several features in the same code tree parallel, in
the same Perforce workspace. The major reason why I cannot work on one
feature then on another is just because I have to make sure that the
changes in the related areas of the product play together well.

With Perforce, I can have multiple changelists opened, that group the
changed files as needed.

With Git I cannot seem to finding the possibility to figure out how to
achieve the same result. And the problem is that putting change sets
on different Git branches (or workdirs, or whatever Git offers that
makes the changes to be NOT in the same source tree) is not a viable
option from me as I would have to re-build code as I re-integrate the
changes between the branches (or whatever changes separation Git
feature is used).
Build takes time and resources and considering that I have to do it on
multiple platforms (I do cross-platform development) it really
denominates the option of not having multiple changes in the same code
tree.

Am I ignorant about some Git feature/way of using Git that would help?
Is it worth considering adding to Git a feature like "group of files"
that would offer some virtutal grouping of the locally changed files
in the checked-out branch?

Thanks in advance,
- Nikolay
