Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E91C433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 17:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F03AC2054F
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 17:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ClQtyycw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgHURUd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:20:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40484 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728044AbgHUQQK (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 21 Aug 2020 12:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598026567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=k13RLLvoUA6rsxLuOHqN4WkqcorC158Mu/bNctVRAKA=;
        b=ClQtyycwhTrMG6RFan7PaBiRGQ79LRF2j0tRRMOxeTwNhcnv4i2X1+XkgTZKvvWV6TEaYy
        gO+E2Bcuzrsa3uehO87xyidlnRHQoC/LVxGOz3RzIBRNvJafuMf2TQOcBhZQGPV8WiJAeD
        QBGQKklF5xA6XAxZZO9QY8HYdP+DsZQ=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-4nAEqJcrOpWmORBdh5K-XQ-1; Fri, 21 Aug 2020 12:16:01 -0400
X-MC-Unique: 4nAEqJcrOpWmORBdh5K-XQ-1
Received: by mail-pg1-f200.google.com with SMTP id c3so1293178pgq.9
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 09:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=k13RLLvoUA6rsxLuOHqN4WkqcorC158Mu/bNctVRAKA=;
        b=Z3s9C8uuonWn2pAH68ald2IBs9OKp+Ft/10O5timnuqyXvz1K0q1hHXJ4+ZapVjFAL
         xWbCaURYy0AkBeHHI7TqiD9f0xZfwQvj+CSyPuhFmUByTdmANrG8QsXhbj1JRNF5HbIa
         59zAjPsWY1BhAehD7mu3wEXEWyxlzT6WbE18E+XHRl+2+w3Ic78pQ/rboriNa64CeiGA
         Tl6pOkFudFKbT6UWYRMSdTMaKbKTOGNWWwGYeNwoDfm5/A1D2leY33IrgElh+VGJiy0i
         to93X40ByD8stU6LpPB8OtU2Ti65sX9WgytWH3J8jr0KzwWIZEahwqpnZmLK9hdeMbCJ
         /eRw==
X-Gm-Message-State: AOAM533zhS93+1XaqjO3BxXwZDdXYJqxSt6aR8bMKiAWx3USgdhPxKwk
        Z7vs0P0iaTL/Ftc1G0SOtyF5te4vNHdkZersVfbXqrMkQMicY0Q2ewc/fLfbVayORvY05s2bTaV
        jKwp0B2ijyn7iBIdww14gZr4AgRYd
X-Received: by 2002:a63:505b:: with SMTP id q27mr2696443pgl.91.1598026560158;
        Fri, 21 Aug 2020 09:16:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJys83gtiKABoPTiWWfqCj81GUrAbtJEA8a0ZuzmONYQEqCc2SeEkgsHspdAGx1SkBHTcE2ULenTRP781oagJMo=
X-Received: by 2002:a63:505b:: with SMTP id q27mr2696425pgl.91.1598026559824;
 Fri, 21 Aug 2020 09:15:59 -0700 (PDT)
MIME-Version: 1.0
From:   Alvaro Aleman <aaleman@redhat.com>
Date:   Fri, 21 Aug 2020 12:15:49 -0400
Message-ID: <CAOW=8D2J3t3cE32q2xNqSOPTa6gxR5gSuJUCCj5MSj58ccc3Cg@mail.gmail.com>
Subject: --author arg on commit only works if there is an email configured already
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone,

It seems the `--author` arg on the `git commit` command only works if
an author email is configured already somewhere:

Sample that I would expect to work and that does not work:

```
$ docker run --rm -it golang /bin/bash -c 'cd $(mktemp -d); git init;
touch test; git add test; git commit -m message --author "A U Thor
<author@example.com>"'
Initialized empty Git repository in /tmp/tmp.TiNqOZsw9C/.git/

*** Please tell me who you are.

Run

  git config --global user.email "you@example.com"
  git config --global user.name "Your Name"

to set your account's default identity.
Omit --global to set the identity only in this repository.

fatal: unable to auto-detect email address (got 'root@aedfbe0df193.(none)')
```

When configuring any mail first, this works and uses the mail
specified in the `--author` arg:

```
$ docker run --rm -it golang /bin/bash -c 'cd $(mktemp -d); git init;
touch test; git add test; git config --local user.email
"mail@domain.com"; git commit -m message --author "A U Thor
<author@example.com>"'
Initialized empty Git repository in /tmp/tmp.1drhE2Rgmh/.git/
[master (root-commit) b3dad37] message
 Author: A U Thor <author@example.com>
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 test
```

The git version:
$ docker run --rm -it golang  git --version
git version 2.20

