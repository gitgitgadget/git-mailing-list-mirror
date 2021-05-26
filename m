Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1618C47087
	for <git@archiver.kernel.org>; Wed, 26 May 2021 02:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8108561430
	for <git@archiver.kernel.org>; Wed, 26 May 2021 02:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhEZCy6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 22:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhEZCy5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 22:54:57 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC02C061574
        for <git@vger.kernel.org>; Tue, 25 May 2021 19:53:27 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so30603158oth.8
        for <git@vger.kernel.org>; Tue, 25 May 2021 19:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=hOFSwF123Te6WataeK5x5OwDGswzun5bz9bm0AMljX8=;
        b=WjB9M5fhuh4A4NK6RVnTwaIvxY03s6NjdTscADpUlL9mit3PUNlJZfiGiVPYXbSvfT
         JGVmpD1RkVdMe4LKItX8ZflWvBOLXf/lJ+3HCICYhxtFuqC8YqQfELMmMESR43Wlk2eO
         X40Be/Wp2VHjUwkC5tp6EH7X0qsr1/Cf4rGNdAmyw7HnC67J9JOAUK++BnnShDjjTUic
         LwW0koxi+sj4F1ALjcTctq+Jm1difmrQSgtO6eS0CI9FrmdaDCgTU3wmuURC1Cp7FaUk
         6dgEM5/xTln021jeEeKwHo6Zi/g4cvCbuJvtbEVDpeiED67Jl5NvAdq59PE6hReVITnJ
         DJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=hOFSwF123Te6WataeK5x5OwDGswzun5bz9bm0AMljX8=;
        b=Ou2+bk2SpTAcpM3dCpRYNwb3XM7Y8xo2jsnrJ6z3C9o76Rpo128uG2rUQiRYfMREat
         TGg0t3ZMUBsG9IJeqv7MsFbWXYfXpmrbW5VizU9171VHQShEsURBPSczuxtxkJqV6NwZ
         cJBcBVdeYRzGe7xeJRN9eCzQ8KvcFw3fa2i1ypPLQBx9b4ukOpxnkpsJ9ZIPpEfkws4l
         +fVXHpgFs3ZIf5XrZ637Ci/6fiBbJ6CHmW4HawGUIuMUstaInS8kKSbwH0P2au8FAryV
         9bOBFc6aWNf84lGdD9VDi1H/RWhfV6kP99hh96px6FC4wCdaeY+jVM4ZzzZVMXW/n6IT
         FP5w==
X-Gm-Message-State: AOAM530CcZQWP6iYRFABobv1KCJdPifELkcWTuozmXpQIcrhlAN67SWL
        BoT5ZHWqGdB0G1XnXrEbUw4gS7YoY7WGbA==
X-Google-Smtp-Source: ABdhPJyaPvYKA2ru0qSngmBaYnOHtEkqgF8MVODm0sC+RlpdmkzW7a8Q8ucF087eCDQKUSkkwY1Yxw==
X-Received: by 2002:a9d:77c7:: with SMTP id w7mr606406otl.364.1621997606618;
        Tue, 25 May 2021 19:53:26 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id k7sm3932960ood.36.2021.05.25.19.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 19:53:26 -0700 (PDT)
Date:   Tue, 25 May 2021 21:53:24 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Andre Ulrich <andre.ulrich@smail.fh-koeln.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Message-ID: <60adb824bac10_2c7f620844@natae.notmuch>
In-Reply-To: <20210524061355.Horde.I7EpK9A1l-KtI_TwFo97eNd@webmail.th-koeln.de>
References: <20210522154815.Horde.rqiNSyIc3CGJECACotWLO1T@webmail.th-koeln.de>
 <4c1c3dbc-7a89-02db-3883-b7eea644cd83@kdbg.org>
 <YKrsC9CaG/KDvDBi@camp.crustytoothpaste.net>
 <20210524061355.Horde.I7EpK9A1l-KtI_TwFo97eNd@webmail.th-koeln.de>
Subject: Re: fast forward merge overwriting my code
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andre Ulrich wrote:
> So the last point is where we still want to do some fine tuning. Right  
> now this looks about: my prof fetches my edits and locally checks out  
> a branch to compare the changes with git diff.
> But in this diff view you can't edit the files. So you have to  
> separately open up another window to edit the changes (lets say my  
> prof only wants to keep some of my changes, but not all).

So for example after fetching your changes your professor sees this:

  % git diff --cached
  --- a/README
  +++ b/README
  @@ -1,5 +1,7 @@
   This is an example document. Lot's of things to fill in.
   
  -[[ insert formula]]
  +The fromula is:
  +
  +  y[1], mu * (1 - y[0] ** 2) * y[1] - y[0]
   
   This will help students jump straight in with simple examples.

The professor can then open the file, fix the typo, do some other
changes, type `git add --update`, then do `git diff --cached` again to
see if that's the output she wants:

  --- a/README
  +++ b/README
  @@ -1,5 +1,7 @@
   This is an example document. Lot's of things to fill in.
   
  -[[ insert formula]]
  +The formula is:
  +
  +  x[1], mu * (1 - x[0] ** 2) * x[1] - x[0]
   
   This will help students jump straight in with simple examples.


What you are saying is that it would be better to do `git $cmd` and in
that command you would be able to view the staged diff, edit the diff,
and after quitting the editor the diff is applied to the stage.

Essentially leaving everything ready for a commit.

Sort of like a combination of: `git diff --cached`,
`vim $problematic_file`, `git add $problematic_file`, `git diff --cached`.

Correct?

> So my Question is: is there any possibility, to be able to view (and  
> even edit, if necessary) the changed notebook in the merging process  
> (as in my example with the 3way merge)?
> Or is the only option to separately view the diff and edit the  
> notebook (two seperate steps instead of one)?
> 
> The latter would also be acceptable, if it really is the only way. Bu  
> it would be nice, if viewing and editing could be done in one  
> convenient step during merging.

You are describing `git stage edit`, a subcommand I suggested back in
2014 and went completely ignored [1].

Your professor just types `git stage edit`, fixes any problems she sees,
quits the editor, `git commit`.

Done.

I just rebased the patches from 2016 and they seem to work fine. If you
are interested let me know.

Cheers.

[1] https://lore.kernel.org/git/1398449567-16314-3-git-send-email-felipe.contreras@gmail.com/

-- 
Felipe Contreras
