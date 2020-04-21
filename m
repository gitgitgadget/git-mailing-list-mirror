Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8BFC54FCC
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 22:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25590206D9
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 22:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=it3xl-ru.20150623.gappssmtp.com header.i=@it3xl-ru.20150623.gappssmtp.com header.b="RXtdSyS/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgDUWcr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 18:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgDUWcq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Apr 2020 18:32:46 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3831C0610D5
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 15:32:44 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id o127so356282iof.0
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 15:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=it3xl-ru.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=nS2vaxWq2CslCr6cDy764tcpG+PBGN9pupqM8BY5KMs=;
        b=RXtdSyS/tjNNrI+7sbgy3fA668uopYUbbPNeb6HEzhKxOWch6exAwf2/8hxqjYjzgp
         TNvufv7O7bhf3EIr708ss++RkCiK6KKUf36OJR8rMqb/U7xAiPN/bgqD5wuhKGQHNhap
         bXhLfP75mUOka2AmRcnR+8zxNAGokIPutUNbDvkyyDJ1zVTd8KptIt2nhE1/hh3UOVpu
         nVCNmqgHWUyW6XqBloAs/hJD+C/jW9FZLgwaSqVeY8pl8U6xk35XRM5TWNwY7i7u9dMZ
         astt3rR5BMw/YV27bKzQhbgjeGyfEMR+2rMSwHN3UIUexxnLsUNBxVigQ3HFDKoqe9oq
         IUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=nS2vaxWq2CslCr6cDy764tcpG+PBGN9pupqM8BY5KMs=;
        b=BjSyMy3HvW5+tRIq7kiiE9bM9J7q6YaAISwm3+PyHumR9IBQdwiGqe6Ek9jGex3ZrD
         xuz36BeZ8R7KoWxG0Qf/663wc36VdXUTOoXnRQ5zz1K/s+gElpBvlrVIDIiM8zqu4YlJ
         wRh/2Njm/h6tNoAzU8ArOYuTz8O2BDntrz1HsCpGPiEWWGyejix0H2tQ1kJe3QE4Go+6
         JRLZxF5O+pQ8EdgcyLxnLQeEhYxRY5RTk/hdA1S2xTDaEt8JjlxawmxE+CcVDsiItVIj
         Xq03GpqKdTHjJoOx8aM/OZNmYIN7QHTkOc3KHJsKqKqinKqDN5A4aAXtjp4ZBBzoxEvO
         ltfQ==
X-Gm-Message-State: AGi0PuZfrQllOH2NgoUlMWxvVjqWevKwsXeYb53JDsHca5GmUntnGF8N
        y9L/A0tWrgMTQR6RB+aQurZo79s+Mr/eYnsIyPh5MTKo4kQ=
X-Google-Smtp-Source: APiQypIMFTzC58WhUQ7to9jH3qcTxNC7UgUwPlcTB9utbtt11xVe8z1i8gcCv3e3dt9xPh8M2D6OTj03ChLmpf5C95I=
X-Received: by 2002:a02:cd2c:: with SMTP id h12mr21990576jaq.2.1587508363993;
 Tue, 21 Apr 2020 15:32:43 -0700 (PDT)
MIME-Version: 1.0
From:   Ilya Tretyakov <it@it3xl.ru>
Date:   Wed, 22 Apr 2020 01:31:46 +0300
Message-ID: <CAOrRacVviJP3w98-=QpFKYp630cN3gZQYnvAWZXeKqZRk2UDXg@mail.gmail.com>
Subject: Credential helpers are no longer invoked in case of having sub-folder
 parts in a repository URL. Since 2.26.1 version
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Credential helpers are no longer invoked in case of having sub-folder
parts in a repository URL.

For example, if we have a "/my-proj/" part in the repository URL.
The following configuration doesn't invoke a credential helper script
in 2.26.1 version of Git but invokes in 2.24.1.2.

[credential "https://git.exaple.com/my-proj/my-repo.git"]
    helper = !'/c/some-path/bash-git-credential-helper/git-cred.sh'
provide  repo_b


A workaround here is to cut the URL to a root view.
For example, we can use https://git.exaple.com/
instead of https://git.exaple.com/my-proj/ or
https://git.exaple.com/my-proj/my-repo.git
as below.

[credential "https://git.exaple.com/"]
    helper = !'/c/some-path/bash-git-credential-helper/git-cred.sh'
provide  repo_b

BTW, the following configuration still works in all Git versions.

[credential "https://foo.bar/my-repo.git"]
    helper = !'/c/some-path/bash-git-credential-helper/git-cred.sh'
provide  repo_a

If this would be possible, please let me know if this could be fixed
in future Git versions.
Or that I have to adopt my tools, described below, to this new
configuration limitation.

JFYI,
I have a tool to synchronize remote Git repositories. This is when two
remote repositories on different servers behave as a single
repository.
 - https://github.com/it3xl/git-repo-sync
I often use this tool with my own bash credential helper on different
automation servers.
 - https://github.com/it3xl/bash-git-credential-helper
And now, my Git-credential helper isn't invoked for repositories that
have additional parts in their URLs.

Of course, I've found a workaround but some people may want to
configure more specific credentials for specific URL-s on the same
domain.

I am aware of the latest vulnerability discovered in the
Git-credential helper functionality.
I hope this was the cause of the trouble I described here. ))

Kind Regards,
Ilya
it3xl.ru
