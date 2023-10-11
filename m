Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C67CDB474
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 18:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbjJKSRk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 14:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235177AbjJKSRe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 14:17:34 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BE9123
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 11:16:40 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-66d0ea3e5b8so780266d6.0
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 11:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697048199; x=1697652999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgiXv/fuAOQndjZcV2JYKyJy0suGAklpdfyZv+54Nxk=;
        b=P/0s81OgmWRKaq8nYHrHA99jQy0R9XyNkF+BofKJGPskDjkL8KrSJjEuKBMZzP74Cc
         6Si0IxQPRsoUDHKnuZ0qmizKPnoLDwIH2BH87IHg2FvRYEn2Aj75F0QtshNM4eS6R0Be
         D00DxTCH/7tgfBfnqYQC4x8wkccWeduddhTFqKc9GOhLXkpN0S920SGpLeeARfSykT4P
         RlqkToXgZ7UyN2QTS9gIXWzf+DaDb0pRWf/O6MzHZmzsy9m5CtnGcl30aOojI+wOERe/
         NzhGCOqozN+oB+rhQSyIFu5/cLKQubqvK9k4n8/PNBmZHIxuyt7/MBgzCSmr/r97crzF
         FsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697048199; x=1697652999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgiXv/fuAOQndjZcV2JYKyJy0suGAklpdfyZv+54Nxk=;
        b=gWPTK+xbwcGNFCRz/zat/kuq084Iaq/hG/9RyX+XWSwib2is5FD7oxPby7R6YJBDYJ
         uo3VBLP4UV29U0kDbUHpzyS7s+4dKfL8WuAjA2Zg4dUXWHrpchRE8V6JCb0hgKPNQNwd
         VD/kM5VpuMcTVi+gGVb7XF1oczWK85AIW7XxdN0LoPCwHoSxzjesbRDChurn5kKeSu4V
         MYfConIC//rPe9Rfyxq06ldCeumOSR2O41gZ4hlMCvno42emwP6MK5YpGXRlBHSuDsvq
         kndHYwk/499pykri960CXtyMz537HUoEj1bUw0UXRIDnwdBUL9HXoWnl14wNvmF9A7TI
         XjPw==
X-Gm-Message-State: AOJu0Yw51o7zZ8y/GlmZjq7Ydbgik6oGI1Dgq5PwVTcNp4817Le3SJuX
        JsunKLiKFK+JeXZXBHutVbLvFm93CGmlFvwUaHJIxGJezAc=
X-Google-Smtp-Source: AGHT+IFgYEXb8U1MpfeWK0BHzueGQ4t+GRCkDMuuqFjTB3B4j8hvv45eKvxAbPeuWu+Ye9c/bTENVphj7OIYzBEy9g4=
X-Received: by 2002:a0c:cc06:0:b0:66d:3b0:35fc with SMTP id
 r6-20020a0ccc06000000b0066d03b035fcmr3343257qvk.34.1697048199150; Wed, 11 Oct
 2023 11:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAHKF-AvUxH1Ar3Xijjb4_8N+_kssPHZVHqQSAE9kDGRfTYHyxw@mail.gmail.com>
 <20231009204341.GB3281325@coredump.intra.peff.net>
In-Reply-To: <20231009204341.GB3281325@coredump.intra.peff.net>
From:   matthew sporleder <msporleder@gmail.com>
Date:   Wed, 11 Oct 2023 14:16:27 -0400
Message-ID: <CAHKF-AsjY_P6mbAs7KWcgL39KbLbu9OE9XiLabghhTn-f0ybzQ@mail.gmail.com>
Subject: Re: gpg.ssh.defaultKeyCommand docs bug?
To:     Jeff King <peff@peff.net>
Cc:     Fabian Stelzer <fs@gigacodes.de>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 9, 2023 at 4:43=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> [+cc Fabian, who wrote this code]
>
> On Fri, Oct 06, 2023 at 01:14:49PM -0400, matthew sporleder wrote:
>
> > https://git-scm.com/docs/git-config#Documentation/git-config.txt-gpgssh=
defaultKeyCommand
> >
> > This command that will be run when user.signingkey is not set and a
> > ssh signature is requested. On successful exit a valid ssh public key
> > prefixed with key:: is expected in the first line of its output. This
> > allows for a script doing a dynamic lookup of the correct public key
> > when it is impractical to statically configure user.signingKey. For
> > example when keys or SSH Certificates are rotated frequently or
> > selection of the right key depends on external factors unknown to git.
> >
> > ---
> >
> > The command does not actually work (for me, git version 2.42.0) with
> > key:: prefixed.
> >
> > It only works if I cat the public key as-is.
> >
> > I only figured this out because the docs previously said it took the
> > format of ssh-add -L, which also doesn't not contain key::.
> >
> > I am using this script for my "dynamic" key discovery:
> > #!/bin/sh
> > f=3D$(ssh -G $(git remote get-url $(git remote|head -1)|awk -F':' '{
> > print $1 }') |grep -E '^identityfile'|sed 's#^identityfile ##g')
> > cat $(eval realpath ${f}.pub)
>
> I'm not very familiar with this part of Git, but looking at the code
> which parses the output of gpg.ssh.defaultKeyCommand, it splits it by
> line and then calls is_literal_ssh_key() on it, which is:
>
>   static int is_literal_ssh_key(const char *string, const char **key)
>   {
>           if (skip_prefix(string, "key::", key))
>                   return 1;
>           if (starts_with(string, "ssh-")) {
>                   *key =3D string;
>                   return 1;
>           }
>           return 0;
>   }
>
> So your script works because the pub file starts with "ssh-rsa" or
> similar (and so would "ssh-add -L" output).
>
> The user.signingKey docs say:
>
>   For backward compatibility, a raw key which begins with "ssh-", such
>   as "ssh-rsa XXXXXX identifier", is treated as "key::ssh-rsa XXXXXX
>   identifier", but this form is deprecated; use the key:: form instead.
>
> From reading the commit messages here, I guess this is about supporting
> non-ssh key types (e.g., my TPM-based key is ecdsa-sha2-nistp256 in the
> "ssh-add -L" output). But I'm not sure who is supposed to be put "key::"
> there.
>
> You said it "does not actually work" with "key::" prefixed. What
> happens? In the signing code we make a similar call to
> is_literal_ssh_key() that wills trip off the "key::" prefix, so I'd
> expect it work. But I could also believe there is a bug. :)
>
> -Peff

It gave very confusing errors!

key::ssh-rsa ABC123 me@localhost (no new line)
error: Load key "....: invalid format?

key::ABC123 (yes new line)
error: Couldn't load public key ...: No such file or directory?

key::ssh-rsa ABC123 me@localhost (yes new line)
works, I think

ssh-rsa ABC123 me@localhost (yes new line)
works (the script I provided)
