Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E1BC11D3D
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 15:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A31246A2
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 15:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAWNWAAT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbgB0PvE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 10:51:04 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:38239 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729217AbgB0PvD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 10:51:03 -0500
Received: by mail-wm1-f51.google.com with SMTP id a9so4038529wmj.3
        for <git@vger.kernel.org>; Thu, 27 Feb 2020 07:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=AOZdCTkFGYzQJQYMZZdAM8APzusQeqi07TFMnVuAfRM=;
        b=XAWNWAATRmmYGLv3t0ZfEeauzcdNJvOaEGx/4CpXGXxWIOWY4Hys/23ZOTXO4VGKz3
         hJ1yrvnGiPNIZvKqYIEva+hRTD2oIrYmHSaPkP56tUQ07vHG3CgeIsUfZ+5divXWu/1D
         cgZ43gwbeOXF2FXTdDEoVrfTNna7FqRKjz3xEotx6iDCHsQ+EmKMTa8/o6teSmYVxWtw
         qBLhuY6r1kv3La7zAPF5Rkj4xqj4ESG1TxAVsqTNSzjCGcMhB1gNuILqNnPAeQiWgaOI
         3dfBLh4MByUN41bc/VsOIaTiJJja6lSZx1mIw5VrbuYr9UGcwMhg+0zQtzncOTAq2wy+
         ZBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AOZdCTkFGYzQJQYMZZdAM8APzusQeqi07TFMnVuAfRM=;
        b=gK4wxxQCOcXlAcOu+KqOWFekY+8glUNrbkHrLohg/9DwV54BiokfnEo1A1ASk86bPL
         GL1crLNeqjSbLXl0irdgdTgkve+ZdUXXQL/y4QEkwIUfhqEOT6EMPhSspMw0/drGUc+a
         3nkpkMg1kbDPvyG/pVjQu1XhrgYC2l0hEzFmZsO/h8vwb8KsUByVdcVK3rJaal+o3qoL
         QGeu3Zby6OSei6bdfVgokkmyBrIDLL5UpgjBnlF/nQm0h3RdFWMbFmzlTLrF6G0FSpmZ
         Ox2srUjITs632xY7GOCNOUCZa5G6R4bz2zRERAk6ykwdsG6yzFKrIZNS3YqXJV8cY7tG
         h/Cw==
X-Gm-Message-State: APjAAAX4ddNNRFXdzM9kIiR9VZsCDI3b41hwty7NJezdRFf32WGRcqOd
        RZGhMl1Hg9n0V4PMzf3EnWo=
X-Google-Smtp-Source: APXvYqwdAapssWs50Mcycka3APcu+jHwIIrQ1v9rSzK1h5Bcer2WS8BjBhBI+yl6XziOxTCBY1V3BQ==
X-Received: by 2002:a1c:f606:: with SMTP id w6mr122484wmc.109.1582818660618;
        Thu, 27 Feb 2020 07:51:00 -0800 (PST)
Received: from feanor (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id v131sm8332875wme.23.2020.02.27.07.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 07:51:00 -0800 (PST)
Date:   Thu, 27 Feb 2020 16:50:57 +0100
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: GIT_DIR in aliases [Re: Spurious GIT_DIR set when in a worktree [was
 Re: Nested submodule status bug]
Message-ID: <20200227155057.7idpa447ixo6sf6j@feanor>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Thu, 27 Feb 2020 16:27:52 +0100
References: <20200214224242.knmzkwx7ls4sote7@doriath>
 <0123F1ED-C421-4C1F-896B-E54C9D345A34@gmail.com>
 <20200226172338.unembhjhog36sqj7@mithrim>
 <20200227100557.ydouc4n3jphzbits@feanor>
 <20200227104330.hp7zf2suquxsf6zw@feanor>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200227104330.hp7zf2suquxsf6zw@feanor>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From Damien Robert, Thu 27 Feb 2020 at 11:43:30 (+0100) :
> And looking at setup.c:760 it appears that `set_git_dir` (which set up among
> other things the GIT_DIR env) is called because we are in a worktree.
> 
> More precisely: we have discovered a git dir (a git file), so we call
> setup_discovered_git_dir, which itself calls setup_explicit_git_dir because
> we are in a work tree environment. And set_up_explicit_git_dir calls
> set_git_dir.
> 
> So I don't know what's the proper way to fix this. Keep track when we add
> ourselves the GIT_DIR rather than when it is already provided and remove it
> before executing a shell alias? Don't run the full configuration setup when
> we are executing a shell alias anyway?

Sorry about the spam. Thinking about it some more, this has nothing to do
with submodules or worktrees, but about how we expect shell aliases to
work.

In Documentation/config/alias, it is documented that the alias will run a
the top level and GIT_PREFIX will be set.

In git.c#handle_alias, it is explicitly stated that shell alias call
setup_git_directory_gently because:
/* Aliases expect GIT_PREFIX, GIT_DIR etc to be set */

So one might argue that the behaviour I observed is not a bug, but it is
still surprising for me (as a user), and maybe this could be stated more
clearly in the docs?

Furthermore there is a question of consistency. GIT_DIR will not always be set
before running a shell alias. Looking at `setup_discovered_git_dir`, it will
be set if we are in a bare dir, or core.worktree / WORK_TREE is set, or if
we have a gitfile.

The annoying side effect is that I cannot use as an alias a command that
iterate over submodules and run git commands inside them, because in this
alias GIT_DIR will be set sometimes, and sometimes not (a quick fix would be to
unset GIT_DIR in my alias).

So what would be the best way to handle this?
Thanks,
Damien
