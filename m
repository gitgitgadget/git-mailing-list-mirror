Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAD3C4321E
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 21:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbiK1VcW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 16:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiK1VcT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 16:32:19 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F375F2BB1A
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 13:32:17 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id j16so19459182lfe.12
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 13:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vCQh6SWtIZJ2fKGNefAN4CkA0FJwtNXf3hOFVgSfr0s=;
        b=bGtc0WXgVhArbZjI3eH7j9YWxRpFu+SraDo/2bh7+EOPIhB8sACmRn2h22u+3XxTJi
         9mqfE4m6D8laJ1oUTg9XPaCp4SUqF1dWjucoYFNQZpjixQEzGUaHqgqQ9QNxVJr/F21s
         PgpAk0lep5TPLj3kvjW6HsxohAds7RaIW/He2k3GJ43Ym+77q8vOup0v4CxgnxrwZvWa
         c0TFDe69mY/yc8c3GTtUSyDWNArtL9ZbMsTu/HqCJ4SHnhli73nP/uK+qpmHy3MMKQLQ
         tuxUIXpE6baMhPzAJNy7dx9+Nf9I1+LyRydCZMwaGDwGwvYEgdqtqahXM1i4pGtUDiUl
         fh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vCQh6SWtIZJ2fKGNefAN4CkA0FJwtNXf3hOFVgSfr0s=;
        b=gSSbykcglKiOYdU2IiQNxeLATBoKokwI9FtseFKxZ6nrhzR3SuGMm3oraIDJnaZSSj
         Oas9Ozl8l4XsEZ+AQMkVS1F3XNHrgY2qvsLioeh6SmtG3cWnguV9zjtfEfTzKFGM10Q3
         6zgDeQlN8ZhlzG4dwR7lrm/Lh3jDRV1wHlqZWZsX4ArnmFR9LKS7eCVJCIeGNV5HF9FF
         Mr0OJ8ems0nJqY2EJ9JzzaPmFmHXqgEXoGvzMDlOuAUMLGhDzit/sBv4wK5PBPRXk4ob
         Wn8aWluPjxj8R+YjsCruIwXf+DtG+8H23W6I2z6xiC58IYlBmgF5AhgYrOtvhlNb7pnY
         JfWg==
X-Gm-Message-State: ANoB5plpg2huf+pTdZGUaaK5/owYpJV1t4dS2mrn8fcKgRQkST9fyxCe
        ijNNk77wvJIRHbet0lzrH3CMeFe6rey6DlPvSTFDq8lWPg==
X-Google-Smtp-Source: AA0mqf5+k0Euu8h/uRr2Ph93VgbdwS8U5ZM8lenjlCIJB/ZktloAb/DiMc8g3ON6ysCPpWC/r+ikykiZeR+PtGpxFas=
X-Received: by 2002:a05:6512:298f:b0:4a2:4365:7da7 with SMTP id
 du15-20020a056512298f00b004a243657da7mr14855246lfb.639.1669671136042; Mon, 28
 Nov 2022 13:32:16 -0800 (PST)
MIME-Version: 1.0
From:   Yuri Kanivetsky <yuri.kanivetsky@gmail.com>
Date:   Mon, 28 Nov 2022 23:32:04 +0200
Message-ID: <CAMhVC3ZHsGJs8XJPZOPYCWBCHJOkp8xnau=5xH_Bj33JUZ4DNA@mail.gmail.com>
Subject: push.default and "git push"
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I've been reading the documentation on git push lately, and there are
a couple of places I don't quite understand. From git-config:

> matching - push all branches having the same name on both ends. This make=
s the repository you are pushing to remember the set of branches that will =
be pushed out (e.g. if you always push maint and master there and no other =
branches, the repository you push to will have these two branches, and your=
 local maint and master will be pushed there).

(1) What does "remember" exactly mean? Is this a round-about way to
say that when you push a branch it gets created? But no, it won't push
a branch, unless it exists remotely.

Actually I created a script to examine how these modes work:

https://gist.github.com/x-yuri/20f24f628db1bcbf272c055b33c18889

And from git-push:

> When the command line does not specify where to push with the <repository=
> argument, branch.*.remote configuration for the current branch is consult=
ed to determine where to push. If the configuration is missing, it defaults=
 to origin.

I've found that if there's no remote named "origin" it pushes to the
first remote. Or so it seems:

https://gist.github.com/x-yuri/888261d182fdab92040760138ea10a22

(2) I wonder if the documentation should be amended...

Regards,
Yuri
