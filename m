Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BDF01F97E
	for <e@80x24.org>; Fri, 23 Nov 2018 10:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409323AbeKWVHN (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 16:07:13 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:35944 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393878AbeKWVHN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 16:07:13 -0500
Received: by mail-oi1-f171.google.com with SMTP id x23so9582071oix.3
        for <git@vger.kernel.org>; Fri, 23 Nov 2018 02:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=9kqSj0ExcvDSDAbQd2KCUynVRdgvKLE+U9yq0PNCt2Q=;
        b=LVPtdOKAAMF7YVrAueSdIsN4dHka+bDIc6VI/HnA9YfXmYGBDSh/BDN7RtnGeL7w14
         pbgQ4N8ymKZp79lqxaqMLJ/7VeymBm/bn7ESKxVlA6S+KSI/XyBdauw+EeFQSg2QfjKX
         ncvO92VLI9/X+Y6722lUFlG3CC2ikQPnXVECRR8zJBBpd8UHH6jHZ+7/I29lGMmFZXao
         8rVBUjgx0/FSnUWLGKhXNS/kOVd5GMY/heqCAaBOMcb5DkUbQQN229Oc/eAZmaTOqgNc
         DMOizpr7TmoBxC5ZqvTGK1d3PrNHeRZDDsoD61GkGa3VmwrLLBGMzhDPMXL7y2ERqaAC
         UzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9kqSj0ExcvDSDAbQd2KCUynVRdgvKLE+U9yq0PNCt2Q=;
        b=ijHXqdoFcx1Yw3f6e3DCgRT7z2XDi8m2ROYMEvNnjllR5AbyGDzNwfrAIVzP+efkor
         FVSUlITtKUmUAMsJP8KLN2fCinLFcFYCOP2UtDOcIo9tdhQqk/8vD/EOaUM6x4EM/Pip
         MKT4UIPlgzAXUqIqG3gk0IlqVSAEwJu0we6axTDfaGR+4EyJxxTEcqI1FQgp+aqAJgls
         +pFUuXGh30GMk/iUUVzw5J0wOAC8n8sREVUt/KQG+GXCicT78ffq4Ifw7LoGWp26uWnF
         odYILohRHOuFF/4RP0yoquREkuYKPdGqSI7G2Pb1DyWFMBaeuEDKes4bzBtbHHZmUvZ8
         iwNg==
X-Gm-Message-State: AA+aEWaeEzbzFZuHjS+yUPXsXA97NT3JojPXKfS/SfIVGWXMWcp2VEVY
        KJ0T6SdBa2XueHe6nLpEJpv5Ur7US/SsnyAV3kJDqQ==
X-Google-Smtp-Source: AFSGD/WEGq0Unt1ri770/xW+45NMkMBeH8lfSyDlkV4TFyv3drYgVVlvZ4/fhMMGFT1HOQXOJZkj/SSACy3GZf8XLug=
X-Received: by 2002:aca:a805:: with SMTP id r5mr5576409oie.5.1542968612004;
 Fri, 23 Nov 2018 02:23:32 -0800 (PST)
MIME-Version: 1.0
From:   Guilhem Bonnefille <guilhem.bonnefille@gmail.com>
Date:   Fri, 23 Nov 2018 11:23:20 +0100
Message-ID: <CA+BUw6gjfpiHhy+jYzxeO4NDOKiMUH0XZ3-c5o7ygdKBCKWm2Q@mail.gmail.com>
Subject: How to efficiently backup a bare repository?
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm managing many bare repositories for development teams.

One service we want to offer is to let developers retrieve old state
of the repository up to 30 days. For example, one developer
(accidently) removed (push -f) a branch/tag and realize few days later
(after vacations) that it was an error.

What is the best approach to do this?

Currently, we use a classical approach, backuping all the repo every
day. But this is far from efficient as:
- we accumulate 30th copies of the repository
- due to packing logic of Git, even if the content is mostly similar,
from one backup to another, there is no way to deduplicate.

Is there any tricks based on reflog? Even for deleted refs (branch/tags)?
Is there any tooling playing with the internal of git to offer such
feature, like copying all refs in a timestamped refs directory to
retain objects?

Thanks in advance for any tips letting improve the backup.
-- 
Guilhem BONNEFILLE
-=- JID: guyou@im.apinc.org MSN: guilhem_bonnefille@hotmail.com
-=- mailto:guilhem.bonnefille@gmail.com
-=- http://nathguil.free.fr/
