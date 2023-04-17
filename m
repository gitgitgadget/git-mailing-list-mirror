Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E32BC77B7A
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 17:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjDQRIa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 13:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjDQRIT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 13:08:19 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B33E8A43
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 10:08:13 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id w11so26847439pjh.5
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 10:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681751292; x=1684343292;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vMZ90oTGg5KH8UVBdwYA4Ps7tv+4RaNAFyNPSHNa1So=;
        b=oD/icXTyFWC+6OZQl3AcRCsdwxlzVhMbOiUQTyehVNDl9DAKpWG9DljSoIEOr12nDV
         h6pS4oXAHCT+7qBGJY/v4E58xteS+u87Sw6wMCBrA2/SmYuxdSGhODYuqBW9q/MNH1a8
         lXqXFHeVF1uah+Hilvym6TJtk5odGd6inWik1aIC1y2q/Gc6efQLuoFHXqEsOJ+NUIqg
         BclvVtZgv+1IM8PXeYBH8K/0zaMk0BaW5KgxYW2TSyk7kCDCFS9q91v9MG2bjCy3nJLw
         So9C3VWCIfhV46VQOq6Om3f7iG2AzZyT+b8CcdPrfkRWfU2pg7CqARXm2QSjHLH5OtVv
         ml2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681751292; x=1684343292;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vMZ90oTGg5KH8UVBdwYA4Ps7tv+4RaNAFyNPSHNa1So=;
        b=lRWSRpBeHy8+AwiZftRjsKEDf0Sya1zdDJzvCFQVm6Nvw8GXVs4e7ucVKKzz5JOMHT
         obr8m2ekdUGom+mSVYG8dcQFSEar0gu65G1eeoyen0iu+lCkObi6AqR0gfkh8ALOKtde
         4d74cPdO0SGTLdagYso2K6PjZ2Ak4nJ6+4l6AgV4Ikc2E+5AJDX17AQudSirwZJvyfEa
         mwe4srJqNsYUEnI/YVE0+aYBlu2ZDI/Yj1FYaDbuI5gGdsDT4LOrwlJbs8yuCohPIZ3c
         pPfjqWb8+Ba7fBo+rHlEcHmvyI/rF6toivbjGKxvpSJLicpzuFn+B+AW3lfbYRVVR/KS
         9Bug==
X-Gm-Message-State: AAQBX9cZ3dkEnCnNQ9SiEzsUfizIFgpDqy6zgpkVBjeUrzuCLkF9543e
        1NUDXSOTCZmPFx4W9Qt/ENU=
X-Google-Smtp-Source: AKy350YvnlnpDnOtiXMmB20YeI6Jwc4zB4iLbiClfoPK1LbZghOEeg32sxcMu7gR6gZKeWiNjJQ/zg==
X-Received: by 2002:a17:90b:1bcc:b0:247:2ed1:e96e with SMTP id oa12-20020a17090b1bcc00b002472ed1e96emr14236684pjb.18.1681751292318;
        Mon, 17 Apr 2023 10:08:12 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id lp18-20020a17090b4a9200b00244b13111e6sm322707pjb.38.2023.04.17.10.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 10:08:11 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Berat =?utf-8?Q?=C3=96zdemir?= <Berat_Oezdemir@deichmann.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug/Weird behaviour with git pull
References: <AS8P194MB1575B12A6A11E3CBC6537C26E29C9@AS8P194MB1575.EURP194.PROD.OUTLOOK.COM>
Date:   Mon, 17 Apr 2023 10:08:11 -0700
In-Reply-To: <AS8P194MB1575B12A6A11E3CBC6537C26E29C9@AS8P194MB1575.EURP194.PROD.OUTLOOK.COM>
        ("Berat =?utf-8?Q?=C3=96zdemir=22's?= message of "Mon, 17 Apr 2023 10:34:50
 +0000")
Message-ID: <xmqqmt36mo78.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Berat Özdemir <Berat_Oezdemir@deichmann.com> writes:

> - cloned the remote repository. 
> - checked f1 out
> - checked develop out

OK, so at this point, you have "f1", which is a copy of the origin's
"f1", and you have "develop", which is a copy of the origin's
"develop".  And you have "develop" checked out in your working tree.

> - run git merge f1. Merge was successful. 

OK.  "develop" has one extra commit (i.e. merge of "f1" into it)
relative to the origin's.  You made sure automated merge goes well.

> - Did not pushed

OK.

> - run git reset --hard origin/develop -> to undo the f1 merge into develop

OK.  Now your "develop" is the same as origin's again.

> - run git pull origin f1

This is "Please fetch f1 from origin, and merge it into the branch
that is currently checked out in my working tree.  It may conflict,
or it may not.  If merged cleanly, create a new commit and advance
the branch that is currently checked out".


> What did you expect to happen? (Expected behavior)

> I expected that "git pull origin f1" will just update the f1
> branch (fetching and merging with origin/f1). In my case I
> expected nothing to happen since neither local f1 nor origin/f1
> did changed while testing. Just develop changed locally, but it
> was resetted.

The expectation is flawed.  What is the closest to what you describe
above is "git fetch" (which would update origin/f1 together with
other remote-tracking branches under origin/).

If you wanted to update your "f1", one procedure you can use is

	$ git checkout f1
	$ git pull origin f1

"git pull" (and most of the commands that create a new commit based
on what you did, e.g. "git rebase", "git cherry-pick", "git commit",
"git merge") works on the branch that is currently checked out.  If
you want to do something to "f1", you would check out that branch
first.

> What happened instead? (Actual behavior)
> "git pull origin f1" created a new commit, which was the
> previously resetted merge into the develop branch.

This is expected (see the explanation for "run git pull origin f1" above).
