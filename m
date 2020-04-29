Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135ABC83004
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 19:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E635C205C9
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 19:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgD2TGq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 15:06:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35286 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgD2TGp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 15:06:45 -0400
Received: by mail-wm1-f68.google.com with SMTP id r26so3256062wmh.0
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 12:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yOrP2Y4c6nNw51j4juC7pRQ9EdwA9xaNKkuW2OYk0s4=;
        b=TjE52xpOsAfplDtn20sZGwJjymPki7IcJVcm8qG2oWnG5wra6K2p9/x2bvG+vv2yMT
         KcL93orFNn54dxMxkdkaU+y4TSlsRAcv/Dsu4aFcjTejUYzUoz9jqvkN12lKbRprAo3K
         sKL6mZIjUcq8qwr/0gK+vyUEgDxxLWu5QhkMg5qQdmSAexNWFhyPx+Img3uXv04xl5XB
         DXNQzTkFQkO0EmKgdSEiRRZweRe24ofsYWc2Ll3H+PojkA7D7V2i+H9tlv6Ip+6SzNfN
         osOOUpqYlz+RNEWYZ86QS5igm9sOMsjMTe49CkgsYy3fxySm3po9zaBgJErAYA7TbzHm
         16ug==
X-Gm-Message-State: AGi0PuZAoeJLvI4yJQa/HIp1w95cDEDq2LUdNljy7obIpJBQmMF7VBxH
        xL1H9CTGaInkxOF7ojj53VsAkGX84I5CHHMhgHDNAw==
X-Google-Smtp-Source: APiQypKka9hKp/EV2YvoToqhw86WR/GekZ5mbRa9WQR5YBAfbnvCRLyzmkBk/BziQ7/HtNgFx3wjLA/adXhz48phpFA=
X-Received: by 2002:a1c:64c5:: with SMTP id y188mr477718wmb.130.1588187203150;
 Wed, 29 Apr 2020 12:06:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200429130133.520981-1-pickfire@riseup.net> <877dxyo1k8.fsf@osv.gnss.ru>
 <20200429190013.GG83442@syl.local>
In-Reply-To: <20200429190013.GG83442@syl.local>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 29 Apr 2020 15:06:31 -0400
Message-ID: <CAPig+cT7sBn58THC_PGw-xoSH3BmZiiO31yJwOL-TV3gAhATHQ@mail.gmail.com>
Subject: Re: [PATCH] branch: add '-' to delete previous branch
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Ivan Tham <pickfire@riseup.net>,
        Git List <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 29, 2020 at 3:00 PM Taylor Blau <me@ttaylorr.com> wrote:
> On Wed, Apr 29, 2020 at 04:37:27PM +0300, Sergey Organov wrote:
> > Ivan Tham <pickfire@riseup.net> writes:
> > > Add support to delete previous branch from git checkout/switch to have
> > > feature parity with git switch -.
> >
> > Maybe I'm late on this, but to me, who leaves in the Linux world,
> > "a_command -" strongly suggests a_command will read further input
> > from stdin.
> >
> > Is this short-cut /that/ important to create yet another confusion?
>
> I think that it may be causing more confusion now than it would be after
> Ivan's patch. 'git checkout', for example, also treats '-' as a synonym
> for '@{-1}'.
>
> In my opinion, it is fairly clear that 'git branch -D -' means "delete
> the last branch", and not "delete a list of branches from stdin.

I can't find the discussion right now, but I have a recollection that
"git branch -D -" was explicitly rejected when "-" was being added as
an alias for @{-1} to other modes and other commands. The reason for
the rejection was that branch deletion is a destructive operation (the
ref-log, in particular, is gone after deletion), and "-" alone
provides no clues and no context that you're deleting the branch you
intend to delete. (The lack of clues and context isn't a big deal for
non-destructive commands, such as git-switch.)
