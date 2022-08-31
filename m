Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494E8ECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 17:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiHaRoF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 13:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbiHaRnr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 13:43:47 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AD9EE38
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 10:43:24 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id az24-20020a05600c601800b003a842e4983cso24219wmb.0
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 10:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=HaXNiuyasE47O4KeEFHlCkZiYq4wSGcUE4MCVBHJxLk=;
        b=Ta+1rTtnfP2UtNhfPtD6KRt0LKeYumZmOqtzFu/TW4VLe0G3X1DdYSp+Na5Nvcw4DL
         ZTbsVKCBkPRQQD4NvZQAlDBiCH9Udy9dPaUpYzPopi+O67b5LTZ68LhZ4RfVFAaurSgi
         /LL74+TAUvdk2zcBSQe14/wWPlz8zya74Moxmz0Lk+5wZs+7iK9GrHq2flGORytUwDu6
         ZADL5YHw5UStxlGXFWIS332gPCR7b2t7pn68jHvBf/DgMGAE8dyDotHr2ICRGP7H5jLm
         +vcY9D/DKdWIaaXSpZyI4xuqdmsnl+hJqdNWqZlgpEpKLKLMnQqgXRQBafqOkKlbNaDa
         a31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=HaXNiuyasE47O4KeEFHlCkZiYq4wSGcUE4MCVBHJxLk=;
        b=CknTecxqizPdQk7T3wufUus+18bgtjHfVTQCZ03ylUgGvebfGRbXdUWbEUWv5Q64oP
         D1jmBV/yzJagUsgEzZ8RRiG9000uXUdBpRCfMIrHBqLSbgcboXaMOzeXUpRhyQzLTnXi
         ifvB9U1IJ9ubio0HdVOIQ/8K3anpKRz+4BVD75has0kqcj6UeKMZXGWEvikbrAZdsR5r
         7MP37bNFnNlINXCzqa8YmBNaGpUYdwvwbhBlRkaE2aj3SlJg17wVWi1E42ZDLHQep36v
         j6hOx6u9N/8MrUU8yBNjvSTGZ8mwIj8rXfCneOkW8GuNyJslUOJ6Mgj0wfJtPA+ih8Yy
         p9gw==
X-Gm-Message-State: ACgBeo1VnB5i5+oF+BqV4U+dlr6KGmnp0efVl+jBrmi7Tyg/Qtd+/Y2a
        /cgqhb8FGrs8ifYHdPd0cFwxW0YKHLWEGtudDYwuqv85Lck=
X-Google-Smtp-Source: AA6agR4ldzb7lGWoIffbH4IltL3QbdEIRhSReKhju40wfGCdi09XK/Wou7YU/tb1fVwRuwppTJsG+NQQBu6oyHzGmzY=
X-Received: by 2002:a05:600c:3556:b0:3a6:220e:6242 with SMTP id
 i22-20020a05600c355600b003a6220e6242mr2597771wmq.145.1661967803134; Wed, 31
 Aug 2022 10:43:23 -0700 (PDT)
MIME-Version: 1.0
From:   Lana Deere <lana.deere@gmail.com>
Date:   Wed, 31 Aug 2022 13:42:47 -0400
Message-ID: <CA+4x=b_eyETm6FM1-b_RMhUmCxm9OT0dZLjTciu13CUs6cccKg@mail.gmail.com>
Subject: upgrade 2.18.0 to 2.37.2 question
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've built the latest version, 2.37.2 on my CentOS host and am trying
it out to make sure it works before deploying it widely.  I ran into
an error I don't understand "Your configuration specifies to merge
with the ref... but no such ref was fetched".  Searching on the web
turned up posts suggesting that it indicates the remote branch was
deleted, but that is not the case here.  I can pull using 2.18.0, just
not with 2.37.2.  Is there some configuration change which is needed
to switch between the old and the new version of git?

Here's an example:
$ /re/tools/linux-x86_64/opensrc/git/2.18.0/bin/git pull
From http://githost:7990/scm/dp/d2s_sw
 * branch                  feature/switch-to-qt5 -> FETCH_HEAD
Already up to date.

$ /re/tools/linux-x86_64/opensrc/git/2.37.2/bin/git pull
Your configuration specifies to merge with the ref
'refs/heads/feature/switch-to-qt5'
from the remote, but no such ref was fetched.

.. Lana (lana.deere@gmail.com)
