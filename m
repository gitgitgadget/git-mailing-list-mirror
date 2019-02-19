Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 018621F453
	for <e@80x24.org>; Tue, 19 Feb 2019 04:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbfBSESL (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 23:18:11 -0500
Received: from mail-it1-f176.google.com ([209.85.166.176]:52381 "EHLO
        mail-it1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfBSESK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Feb 2019 23:18:10 -0500
Received: by mail-it1-f176.google.com with SMTP id r11so3129074itc.2
        for <git@vger.kernel.org>; Mon, 18 Feb 2019 20:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=hw4ZV4leVh+/O3w8z/jSey6kN61tovdU+QmkDyXAiaI=;
        b=UCggXIdr+A/KOJvo1/WF/7L29FOHukyBS5LM5wFEmGcWHW8LpCqBRVhbQolC56TAA2
         lAQLgdsxZVrU2u7KCMlLEX5UVv39MlWIvU7RPf59m/yi5xJlJ4XwpuZmL0yP1+xSy4SC
         oxJvqSLYfRW/IBqQvRUABevxbxSN1Fja7wRsDd+lfLfRBHKunF7M03M/4X9wb5a2lgf2
         WBWcJ4OGMm9DPLDjGTwEew9iRmhClpNwP2Ax/1qt0UsH81rZ8A2++jyvp0LPPe1DOqzJ
         oW9BZbZdRFYXTHlY2jRFNzl8oxjkJTOhfQHKP4tz7OE64AqLp55nscxsAJGxSMLtqlXb
         Phew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=hw4ZV4leVh+/O3w8z/jSey6kN61tovdU+QmkDyXAiaI=;
        b=Yxp2OMi0CdyNu6wi04YzCzBQWvHhHR0/EPNXf2TDYuodPrroLPQiNWYKtL1VNbtWjt
         /BDNBnCvKXrvzO8zzSeOkxTQHr98Tnxzn0AicIaeW7/PoKPkxL+dAbPL30eiWZ046/9R
         Nq6/hxMd2EJqoV7TL4l5dVFCzOLAK2MGDmv34YniCKmsp+djOxKzbyTYz0LOGpaAecZ1
         8/yjdh+Oqc13kl/cTmNGyPTugxLkdCOPnwslCyE4hvNOUKdhUJ+cYxWAFBzu1dQJapD+
         Zql+3P9ibpmZL2xx4ZJAC06xHrXkTTsosRyYiRnmjKc2RC89xd5mO2vbeHGlzJqXMfIr
         dpRQ==
X-Gm-Message-State: AHQUAubjdDpBDFrvrtKUnsNcdiOor9jB8ZDbYovV+K2TSLBIVf7huQpJ
        mjXQ9TU8jSNA5vLdcYuKjFIyNjUgJqU2QFIm4/0WBmt4
X-Google-Smtp-Source: AHgI3IZBTv0hgwyHG/fQ6MHNvJykNps597HCs6O1NAJMkvNRy9FNOdDbanswhG/nor7iwEwZ1neNAhBKrp26Ny0gdSg=
X-Received: by 2002:a02:a397:: with SMTP id y23mr12942363jak.41.1550549889804;
 Mon, 18 Feb 2019 20:18:09 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Sebasti=C3=A1n_Mancilla?= <smancill.m@gmail.com>
Date:   Tue, 19 Feb 2019 01:17:59 -0300
Message-ID: <CAJPSwc1GuifK9BdssWQsf+oVY0Aw+PLM1pgAiis7UdV1tZrpew@mail.gmail.com>
Subject: git rebase --continue after solving conflicts doesn't work anymore
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've always used "git rebase --continue" as the help shows:

    Resolve all conflicts manually, mark them as resolved with
    "git add/rm <conflicted_files>", then run "git rebase --continue".

and Git would apply the conflicted commit without issues and the rebase would
continue.

But since Git 2.20.x it doesn't work anymore. Now after solving the conflicts
and running "git rebase --continue" I get this error most of the time:

    error: unable to dequote value of 'GIT_AUTHOR_DATE'
    error: you have staged changes in your working tree
    If these changes are meant to be squashed into the previous commit, run:

      git commit --amend

    If they are meant to go into a new commit, run:

      git commit

    In both cases, once you're done, continue with:

      git rebase --continue

    error: could not commit staged changes.

Now I have to run "git commit" first to commit manually and then do the "git
rebase --continue".

I've compiled 2.18.2 and 2.19.2 to check and the error doesn't happen.

It is present in 2.20.x and current master v2.21.0-rc1-9-gca1b411648.


Is it a regression because of the new rebase written in C?


-- 
Sebastian Mancilla
