Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD8CEB64D7
	for <git@archiver.kernel.org>; Fri, 16 Jun 2023 23:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjFPXtx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jun 2023 19:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345807AbjFPXtu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2023 19:49:50 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23231297F
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 16:49:49 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b503931352so7761715ad.1
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 16:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686959388; x=1689551388;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ScV5/IfxUIaFXV9SecbZiD4QCDFafSqVH6QY9otmh+U=;
        b=tUk5dEtzAuOC4avPfKLdi8QFEAzhKBwcRbXkPB4BnnnlQnCLCqiOg9xj5cMBcDlcSC
         JXYEq+/0J84527ZrpzbQ2mZXkakRoJ2n1H3jo4U3dbs8d/dtg7xr3Az7ezFlyiWl2/wn
         HQ8X9/KbZYbGRbnwlU/7X4IXZb/bZqoY8GwohbRwJ2t2FzbJiyVu2PTMfX62NszOqT5f
         fPtX/7Ep/ew0y/A6CxgsNVjlfNNdIyMFFPg7Flb88sjRH+sld8kVu+afN1o0q/uH5QAy
         7vBJxRxalKFQ/3SrPRz7kCj5tAU8iB3kTDucGyIRY5JyxNYh2Jgq4p+IrgyD4xwzZm5K
         lovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686959388; x=1689551388;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ScV5/IfxUIaFXV9SecbZiD4QCDFafSqVH6QY9otmh+U=;
        b=C4aijuhIRS2Bi+4w0+pSvO3mvPgDbCyleZj2SnwopIaAIkEQSbcUAFei5OHROoSom2
         epiLErr9zpljp8eK2A8gsmUWo1mYZoHLOMI4ipR/j5HEvtudALhyiPm/l9EYdZVHKDri
         7rUXJOFZkzH7TTTX0OeAgvToFKKCOEbrSR+UScQnhyqD2kDU6/sr8Wd/fFT+kfNvnlvm
         B8PMyciOFMI1wIg5VGyQFmGqPL5QY01kwdrnDs4XGyF4OopnocUJ+oWC5Sgk+1ck5nEq
         qL7lfCduSSCIidrgx2qcfEVqMMXRLpYF3vCiuCkgXbgtz77nwJGIJ/bz5AFrxuvywTy7
         VEgg==
X-Gm-Message-State: AC+VfDzNVmPZDrJVlUjcNHbuzDyKzL8tg00Wmr8Ugj/wI+L1qm2s6WX1
        DcOxck8tVLFAVZ2fOwXofkOPJKmCHDg=
X-Google-Smtp-Source: ACHHUZ6Wi0S8cRBz0/TeSuUjGSBDtHqLquLGQnZVd2jxS9PquOz0X6gGYKDLwDzwkVrMOR+8jWQ/4sRHpV4=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:902:f7ce:b0:1b5:1b21:63dc with SMTP id
 h14-20020a170902f7ce00b001b51b2163dcmr570385plw.0.1686959388612; Fri, 16 Jun
 2023 16:49:48 -0700 (PDT)
Date:   Fri, 16 Jun 2023 16:49:47 -0700
In-Reply-To: <PH7PR07MB9467AD34C96AEE60D5A4369F8C58A@PH7PR07MB9467.namprd07.prod.outlook.com>
Mime-Version: 1.0
References: <PH7PR07MB9467452EBAFAB2C825295C0C8C5BA@PH7PR07MB9467.namprd07.prod.outlook.com>
 <42e4373e-b700-45a6-99cc-db2f8896d5b7@app.fastmail.com> <PH7PR07MB9467AD34C96AEE60D5A4369F8C58A@PH7PR07MB9467.namprd07.prod.outlook.com>
Message-ID: <owlywn0355no.fsf@fine.c.googlers.com>
Subject: RE: Possible bug regarding trailers
From:   Linus Arver <linusa@google.com>
To:     "eric.frederich@siemens.com" <eric.frederich@siemens.com>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Eric,

"eric.frederich@siemens.com" <eric.frederich@siemens.com> writes:

> B)
> Should anything that is retrieved via:
>      `git cat-file commit $SHA | git interpret-trailers --parse`
> also be displayed via:
>     `git log -1  
> --format="%(trailers:key=some-key,valueonly,separator=%x2c) %H %T" $SHA`

> ... why is there a difference?  (Explicit call to interpret-trailers  
> shows the trailer, but the log command does not).

For reference (using your repro script), I get:

     $ git cat-file commit HEAD~ | sed -e '1,/^$/d'
     A bad commit

     old-scm-change-id: THIS TRAILER GETS LOST

     --- let's mess stuff up ---

     Have fun
     $ git cat-file commit HEAD~ | git interpret-trailers --parse
     old-scm-change-id: THIS TRAILER GETS LOST
     $ git cat-file commit HEAD~ | git interpret-trailers --parse  
--no-divider
     $ git log -1  
--format="%(trailers:key=some-key,valueonly,separator=%x2c) %H %T" HEAD~
      a1d5cfede3cbd109a353235a495e66f86e7456e4  
1dd017bdd070190005e5e162d87afebcd61e0fa8

I agree with Peff that interpret-trailers and git-log are both behaving
correctly. For

     $ git cat-file commit HEAD~ | git interpret-trailers --parse
     old-scm-change-id: THIS TRAILER GETS LOST

we detect the trailer because interpret-trailers treats the "--- let's
mess stuff up ---" line as a git-format-patch-like divider separating
the commit message from the patch diff. This is working as intended.

Contrast this with the invocation where we pass in "--no-divider" and
interpret-trailers (correctly) treats the "---" as _not_ a divider and
so considers the "old-scm-change-id: THIS TRAILER GETS LOST" line as
part of the commit message's body text. As there are no trailers at the
bottom, it parses no trailers and nothing is printed on the output. This
is working as intended.

For
     $ git log -1  
--format="%(trailers:key=some-key,valueonly,separator=%x2c) %H %T" HEAD~
      a1d5cfede3cbd109a353235a495e66f86e7456e4  
1dd017bdd070190005e5e162d87afebcd61e0fa8

the git-log command already knows that it is dealing with input that is
only the commit message. And so it behaves the same way as
interpret-trailers with the "--no-divider" flag (treating the entire
input as a commit message). This is working as intended.

The issue (as Peff pointed out) is the insertion of the trailer by
git-commit before the "--- let's mess stuff up ---" line. Instead we
should make git-commit insert the

     old-scm-change-id: THIS TRAILER GETS LOST

line _after_ the "Have fun" line. If so, then the calls to
interpret-trailers and git-log should behave more intuitively.
