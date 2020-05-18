Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FECFC433DF
	for <git@archiver.kernel.org>; Mon, 18 May 2020 22:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08B6920674
	for <git@archiver.kernel.org>; Mon, 18 May 2020 22:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ppnDyGyo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbgERWYw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 18:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgERWYv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 18:24:51 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967B5C061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 15:24:51 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id dm14so12745619qvb.7
        for <git@vger.kernel.org>; Mon, 18 May 2020 15:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0bErl2rN0wa0rc5GnQtOQjA4i209u/42dLW0O/cdDVg=;
        b=ppnDyGyoWqir3cUA56I3RGD5NDsdJQ3AvsEN9f5LfFtgtTStVtOvmuXBJ8UFx15A8c
         1rWv5U2KJOeLc4BBAlRnCTtqlu02IL0z0Kj/DJwkoKWsjidmP39cb06utZijkxJjMp4P
         2WdmJO1yDx8FUNJ8+FhRj9isTY8Ps4NCOKy8krKI9inNZptV902vRuwh8pQ7OO9M0gv2
         /piWhIJjwO+xx3PbRj3HfLaj5CKPSJPMb2E6ZkvzFiNF+ODK0ehakFRGPIfxgjJ7mxOu
         7g//Cb0hJjW8yUCmUEKpbZkYPFiD0gNXKR6Zhjb+pnfcedxPCx2hPBH4yuvisJ9RhPYt
         +U3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0bErl2rN0wa0rc5GnQtOQjA4i209u/42dLW0O/cdDVg=;
        b=q4M2CEKbUEW2n22nT8BM4As+8YbdjZRibg2VsEaMkDdm68CXtX7CbghpaS1i5Z43nJ
         0EAlaXnVvBFqB3QZe0dmZe8wL6q6oQWWAejgC+VYPi9B5Ts/sTJBmOBIhpG0DZhHgdVB
         nL3FJJJBA7zZPQb2XEPMu0sMfKPTIBvtC65FzBth/Syb5IOQhwlKitKxVpe3KNUGkNin
         XgYfKLfeSUWgd+brmqUjVHCF6f1kon7U7QJ9Rgd4nRvH51P2+BzpIhtt5fnEwSeA3yB6
         DmWopVIQdewQqYdTayva0QSF569jRUJlVm6bczFS38UOca4CJuc8BUrVe+cM8f0wygEb
         /DWw==
X-Gm-Message-State: AOAM530i8pzNxbywAerFNhBX8IRrFya+YEYutYiqDWlt+Y7szsjRDMB4
        cMBdSQu53YkgJXZpfqN7WBRLWzeAqplcse/Wc87J
X-Google-Smtp-Source: ABdhPJwanx3gCe2rEKNpQJY0PIoXbxM0bjDF0wHs+GRJ5Veyx7sZtta0iWRnIxoNf5KaabGilRqDd5Lwv6MwMunlwWa6
X-Received: by 2002:ad4:4141:: with SMTP id z1mr4094327qvp.227.1589840690709;
 Mon, 18 May 2020 15:24:50 -0700 (PDT)
Date:   Mon, 18 May 2020 15:24:47 -0700
In-Reply-To: <xmqq5zczx4mn.fsf@gitster.c.googlers.com>
Message-Id: <20200518222447.15967-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq5zczx4mn.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: Re: [PATCH] wt-status: expand, not dwim, a "detached from" ref
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>  (1) record not @{<stuff>} (or <branch>@{<stuff>} for that matter),
>      but the actual starting point in the reflog (e.g. in the
>      example this patch would have introduced a regression,
>      i.e. next@{u}, we should record 'origin/next'.  In the example
>      this patch would have used degraded output to prevent dying,
>      i.e. @{u}, we should also record 'origin/next')---this also
>      will fix the "the branch's upstream may be different now"
>      problem.

This sounds reasonable. I took a look at this.

The part that converts the user-given refname (e.g. "@{u}") into an OID
is the invocation of get_oid_mb() in parse_branchname_arg() in
builtin/checkout.c, and get_oid_mb() eventually calls repo_dwim_ref()
which has access to the absolute branch name ("origin/master"). I did
not try plumbing it all the way, but I tried overriding "arg" with
"refs/remotes/origin/master" after the call to get_oid_mb() and it
worked.

For reference, the stack between get_oid_mb() and repo_dwim_ref() is as
follows (the line numbers may not be accurate because of some debug
statements I added):

  repo_dwim_ref (refs.c:597)                                                                                
  get_oid_basic (sha1-name.c:875)                                                                           
  get_oid_1 (sha1-name.c:1195)                                                                              
  get_oid_with_context_1 (sha1-name.c:1812)                                                         
  get_oid_with_context (sha1-name.c:1959)
  repo_get_oid (sha1-name.c:1610)
  repo_get_oid_mb (sha1-name.c:1382)

Besides the increase in complicatedness of all the listed functions that
we would need in order to plumb the absolute branch name through, I
haven't checked if the absolute branch name is the one that we should
use whenever we write to the reflog, or if there are some times that we
still want to use the user-specified name. I'll take a further look, but
any ideas are welcome.
