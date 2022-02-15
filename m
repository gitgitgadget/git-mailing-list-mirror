Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF719C433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 18:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243007AbiBOSPv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 13:15:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242956AbiBOSPm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 13:15:42 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C66119879
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 10:15:32 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id f19so7857122qvb.6
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 10:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=0qAE1IF4upGHKnX5V2kz7wwLupaneoCVy1LXDoQca10=;
        b=IUjGUh5uMuUQsrSEQgAWx10CIJ6/SO4ZAt9q6qb87Mtfb1xpbC7pEq63ECAOHwhuRj
         jeB03DND7YmEreRtTsbMf4ob3qP9VtjRzZczB0z+56QYlSyyz2RTVVNkO9eymdjLVZra
         ctuybiApiNsiOZkRWudqFIPtz7JXD1AkmX5gyraiUK2Cve6a/SwIn8VF3TAdkkc1FsoV
         Hj9MyG0037ToZWyNJqBVCprrKtpoXSMzRM6UqWbpEKod92/WtjjyM2YXc43vJcMqrsDa
         re3S4DU/NvGWWqJdSx9tKcyaL9wJTBEdglcTCgzwx8l2zXXNANYYBrMHScRzavDAWHTV
         eQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0qAE1IF4upGHKnX5V2kz7wwLupaneoCVy1LXDoQca10=;
        b=ZPJFC5CNZKm3xnuDFYoFmB/O3M2VW27TftVNb/P9E3QxSngkpuiy+ImTx3lSSh8MC8
         1+fOvrb5lkjjU/PNtGUDbY+++5O1ljPRhLie5ms2ym7J+sFfDHL582wHJlDWFb6co2md
         /28qRJrCPHyPIvGcTP8BtAwRKJhQSFV2xdXJh6nni1Ec1o1e0oGndQ9q2o21TcoZ/Pgv
         Nm8/etJMA8L5RhDZX83XbKTyQjLV7zzDFmljBPrdNAEzq1A1ZycJPdIWPVWxNK9fTax9
         YaTFFlNEpOX+qamS7nGaXEXyvBUDA0HZQKOL3owK6NAUxi1Wmmk6z7Blh7kPEey8NyD2
         9ynw==
X-Gm-Message-State: AOAM530B0Dbo1UWFVcjGTmFKBQPMT1x2wsTg69MvA0j0jH2ZAgq826us
        Vh8UuBAX10zOJiYt/t6NJoT5nW1SK1g=
X-Google-Smtp-Source: ABdhPJzxJ9O19veqW8BI2MIDL5WEdOCwy/5ZEufRBv5SQ0uTidn7W7IWdJDjTaSXdtDAXsqvZsbl5g==
X-Received: by 2002:a05:6214:262a:: with SMTP id gv10mr303656qvb.98.1644948930015;
        Tue, 15 Feb 2022 10:15:30 -0800 (PST)
Received: from localhost (cpe-142-105-146-128.nycap.res.rr.com. [142.105.146.128])
        by smtp.gmail.com with ESMTPSA id x13sm18438223qko.114.2022.02.15.10.15.29
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 10:15:29 -0800 (PST)
Date:   Tue, 15 Feb 2022 13:15:28 -0500
From:   Ben Boeckel <mathstuf@gmail.com>
To:     git@vger.kernel.org
Subject: Quoting of paths when pushing to Windows over SSH
Message-ID: <YgvtwEPMCH3974e7@erythro.dev.benboeckel.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

It seems that some quoting when creating the SSH command line for the
SSH transport needs some extra logic to handle remote hosts which are
not using POSIX shells (namely `cmd`). With the Windows "Enable SSH
Server" built-in feature, it ends up failing with this being attempted
(as reported by `GIT_TRACE=2`):

    run_command: unset GIT_PREFIX; GIT_PROTOCOL=version=2 ssh -o SendEnv=GIT_PROTOCOL hostname 'C:/Progra~1/Git/mingw64/libexec/git-core/git-receive-pack.exe '\''remote/path'\'''

Of note here:

  - I could not figure out a way to have a path with a space for
    `git-receive-pack` (it just kept saying `C:\Program` is not a
    program regardless of what kinds of quoting I tried), but DOS
    shortnames suffice here at least.
  - the remote path is single-quoted which is not stripped on the other
    side, so the error that `'remote/path'` does not exist ends up
    happening.

I do *not* want to change the default shell on the other side because it
is actually useful to be `cmd` in this instance (for `vcvarsall.bat`
namely) when logging in manually. Some potential solutions:

  - a way to set the shell to use on the remote for ssh command;
  - a way to say "use double quotes, not single quotes" (or some other
    way to tell `sq_*` that we're not talking to POSIX on the other
    side).

I was able to move forward for now with this patch that I'm using in a
specific build to talk to this remote (on top of 2.34.1) because I know
I don't have any special characters in my instance:

diff --git a/connect.c b/connect.c
index eaf7d6d261..a286feb812 100644
--- a/connect.c
+++ b/connect.c
@@ -1393,7 +1393,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 
                strbuf_addstr(&cmd, prog);
                strbuf_addch(&cmd, ' ');
-               sq_quote_buf(&cmd, path);
+               strbuf_addstr(&cmd, path);
 
                /* remove repo-local variables from the environment */
                for (var = local_repo_env; *var; var++)

What might be the best way of making this work more widely?

--Ben
