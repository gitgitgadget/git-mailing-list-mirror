Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A29EB64DA
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 00:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjGUAbM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jul 2023 20:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGUAbL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2023 20:31:11 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781A7269D
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 17:31:10 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c647150c254so2494899276.1
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 17:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689899469; x=1690504269;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WE1NSUwXY/RGdy3/PXmKSCWsJp1+wgUxyyYTbdN0d/k=;
        b=eogSjRGBtNWwZLZZVckCa/8NqFpFescOeOX1m305vXm029TIK7wYlxaufjbdP0EONW
         KfJ+6NHxLwCeM+RbILrEfKRBRdEixFaRuCmAZswVA7qSmIZ4VU6xrmKTCH2FHcLbFwvj
         m1DYIdRWTmWbVKHh6UfdjGacX1YCcHWPzOLrD2/fLrLtLfCOpgt8yipxbGYEA3eKnKws
         n3i7+u5W9a+PrIgp7NK7rZ3ioeB/HWWItl56Fa+AmXR8QN2cYnxRUisGc+DgTppZnKP1
         0ZCNtrAczvh16SjZ1T6fWkid6eotaPeoqKYuQ9hd1tkWE9zMYYmTwVvDmFnN0PJfqiB3
         gK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689899469; x=1690504269;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WE1NSUwXY/RGdy3/PXmKSCWsJp1+wgUxyyYTbdN0d/k=;
        b=XWXpgjxW+to/amsUKivOb6ZXbMU3NCh7dOjHapl3POPoEQJ9+iih6Lmq2IbaOAFdDW
         B7r+Qkh/6aSLFGYZ51SJwLopGoB6WRedQ+StT0AcNu+acqwHGBHyhxqaAMJN9QHWNU+x
         TX1uNVl7aXF2QVW9qRLgCtJxbJiH2d5xcH2Mq2stGb3ezh7l1qzC2DQz0//tohF6uWPc
         xw2E2qVlnE+hQ2nLyE3Nfgsa+vpvSQilc7q/2WJ3qc/AbXZNvGAYW6VWp/lMPH4XfKFF
         +pfLnroipAHpfVajf3CW0WxrKBj6AH463YzcT2vanJ05r1X1bM3FRnQAU3zcYp3gJ9WM
         bfPw==
X-Gm-Message-State: ABy/qLZGVwiNKeF/ZftBaxt1JFJmMUHhgGsOXRukHh3X0YrObNdbSIjd
        KHbdNw1705Hbhn0DsVr+PHvHkb888oTGq6F3s5fo
X-Google-Smtp-Source: APBJJlE2UgkYZZaDRXFSCmrFSSEKf+hbbiPKCslKcyQ/XIHY6oCqQuiRBNCy/sR/4jzqB5SO9fmKtWOCpl9CkLbIg7pn
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:d142:b4af:6ea8:6b8b])
 (user=jonathantanmy job=sendgmr) by 2002:a25:ad1f:0:b0:cf9:3564:33c7 with
 SMTP id y31-20020a25ad1f000000b00cf9356433c7mr72184ybi.0.1689899469748; Thu,
 20 Jul 2023 17:31:09 -0700 (PDT)
Date:   Thu, 20 Jul 2023 17:31:07 -0700
In-Reply-To: <4461d2163e8fbd0cc3fb7f3f7b101df529420604.1689891436.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230721003107.3095493-1-jonathantanmy@google.com>
Subject: Re: [PATCH 2/2] config-parse: split library out of config.[c|h]
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Calvin Wan <calvinwan@google.com>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
> Begin this process by splitting the config parsing code out of
> config.[c|h] and into config-parse.[c|h].

I think we need to be more careful in how we split. It would be easier
if there is a concrete use case, but some preliminary questions:

 - "respect_includes" is in the library, but callers might want to opt
   out of it or provide an alternative way to resolve includes.
 - There is a lot of error reporting capability with respect to the
   source of config, and not all sources are applicable to library
   users. How should we proceed? E.g. should we expect that all library
   users conform to the list here (e.g. even if the source is something
   like but not exactly STDIN, they should pick it), or allow users to
   customize sources?

In the absence of more information, the split I would envision is
either something that can only parse a buffer, its error messages being
very generic (the caller should turn them into something more specific
before showing them to the user) (but one problem here is that we must
postprocess includes, which might be a problem if the output of parsing
is a flat hashtable, since we wouldn't know which keys are overridden
by the includes and which are not); or something that can take in a
callback that is invoked whenever something is included and maybe also
a callback for access to the object database and that has full knowledge
of all sources for error reporting (or allows the caller to customize
the sources).
