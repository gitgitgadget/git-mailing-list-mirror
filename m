Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50624C2BA83
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 22:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F0EB21775
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 22:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZ1rHxwU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbgBGWEY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Feb 2020 17:04:24 -0500
Received: from mail-pg1-f173.google.com ([209.85.215.173]:45248 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbgBGWEY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Feb 2020 17:04:24 -0500
Received: by mail-pg1-f173.google.com with SMTP id b9so453308pgk.12
        for <git@vger.kernel.org>; Fri, 07 Feb 2020 14:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hq3Q0/JIwipe+OBaXVjg0FqdMJrAjiWtXITsy31k7c8=;
        b=BZ1rHxwUBvYJO8uCMB/fxcCpWLsm1JZqj3nnanHVydCNlqv8Qx1ggCqnrAKJrV7pPe
         Ro369MSDbqN5EYwDcA0KjSbQtmrt1GHc7VphhhnW+Nb/mOh8629S8YLz8jyLoAcEctMk
         Cc70BSE5tfhmiNcT4yhz9BwV/VppGGGOBPxma6XoDkNXcPt2fN0/3PqHPu4bHk93P4x0
         Lgl+QuFlZUQDAxDQTzAs+kH7qndBNCzrqhhyGnnNVW1h3N5ADJTd2rHgb58kK5PR8U1J
         RMppQv0YSg4hz66dX/bfzA/OxZIJXgoslz+O96BZUQeiEOXkTJG1znCJ5RIoygreFdMB
         5cLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hq3Q0/JIwipe+OBaXVjg0FqdMJrAjiWtXITsy31k7c8=;
        b=tBnCCwsIIhMDQmRTS+PytBmeuHc6NyltDgZOUTxR6xRKHIHlCCfvvyLj1fIKDmKKhn
         O6auzCz6wmZa7eSty+vkNQhouXlfF/orsKiPtUJpQ2BtVjFoUj5TqkM5awP9NkHcMD/W
         EBrEx2R4dhFXEBuTiYXQVpNuEl/h34jaBbk6RrLBmrzhD9NA/ZiI6qzu4Y4tpNIt4iD6
         LeYa+DfQV965gpKqBterhvDNbZEKvEkxhcCQKdbaiszGA8yW5h4m98VfA+G/TqvS6IMz
         tBQdBHO6MEmbmGbeuSgY/hGYQR0IxAIW3n0g7FSrrwu8E53NLI8FGLezO5eILGCuiBg5
         XFsw==
X-Gm-Message-State: APjAAAUUu79ssI2b6Q3Se9KIgmbD4cwsiF3uUVoyyflisLCik90qfxg+
        LluWn+G/vXHgW5/Etf8tBRo=
X-Google-Smtp-Source: APXvYqzLIcemUtg1gIB9LjqdCGKHcvJEruO+oScJvxgbyl7zf498OTSNXDlfPvrAqENKnrRG2VzLGA==
X-Received: by 2002:aa7:8e85:: with SMTP id a5mr997438pfr.24.1581113063203;
        Fri, 07 Feb 2020 14:04:23 -0800 (PST)
Received: from konoha.iitr.ac.in ([103.37.201.174])
        by smtp.gmail.com with ESMTPSA id d4sm3568661pjz.12.2020.02.07.14.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 14:04:22 -0800 (PST)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     bgoglin@free.fr
Cc:     git@vger.kernel.org, Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: Re: fatal: cannot rebase with locally recorded submodule modifications
Date:   Sat,  8 Feb 2020 03:34:03 +0530
Message-Id: <20200207220403.28961-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <660c39af-d0f2-5e4c-66a0-5c78b646b023@free.fr>
References: <660c39af-d0f2-5e4c-66a0-5c78b646b023@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Brice,

The error you are facing here is actually a bug in the
'git pull' command[1]. When one tries to use the
'--recurse-submodules' tag with the command, it tends to fail.

> Why is failing here?

Going into a bit detail of 'git pull', the command actually
is a combination of 'git fetch' and 'git merge'(unless any
other tag is specified i.e. 'rebase' here which would mean
a fetch followed by a rebase). Quoting from the documentation:

> Using --recurse-submodules can only fetch new commits in already
checked out submodules right now

Using the '--recurse-submodules' tag will try merging/rebasing any
changes(updations, additions, deletions, etc.) made to the fetched
submodule(s) from upstream, i.e. the _un-checked out_ submodules into
our local repository which will cause the error to be thrown as it is
not supported right now. This will therefore create the detached HEAD
just like the one you obtained.

The "workaround" is to do a 'git fetch' and then merge again after the
'git pull <tag> --recurse-submodules'.

The presence/absence of 'git reset --hard' before the pull  won't create
any difference to this error in my opinion.

Regards,
Shourya Shukla

[1]: https://git-scm.com/docs/git-pull#_bugs

