Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E458FC54EBE
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 04:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjAJEtg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 23:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjAJEtd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 23:49:33 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11ED23FC92
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 20:49:32 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id s73so253558oie.10
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 20:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPLk5GEoCVNQFGIy/Bhn62KLBq7CL+fo8/SF5sIBfxw=;
        b=NfmaqhoAXNLa1Ak8endhh+Mfh27/qGRKdGedinm+6N8NWgJxJ13JYnftVKu0urnHIe
         XO9JJhb9IEi2ikuraktLjO0eZ20xpjUTj49HSvu2gTbaEv7KE4Iib8C7DTNsny/JU03T
         NGIFj7ChSTT0tasT3F8EGlQ3FkiKvb40EwUYwxox9GbSI1wT3bDrQRcJHWq8rQioCke/
         OBGhQR0G+1wVgZFy8p8d8d2w0VLt30TY6mhUWecxtJ5onwR+TNiZpRo3ajsk6hhM43Oq
         ODEvw4KFQYF9yvFHt2RbjJ5du5lLE2d4fQa01fMKT4b3leLevLp0teaBKpDHlzgzp7Wo
         huqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pPLk5GEoCVNQFGIy/Bhn62KLBq7CL+fo8/SF5sIBfxw=;
        b=mYTRuz+hF57yaP6aXb992FFPe0mF0hjhST6dqiry0Ihj2xMyRLI70Q0isVcus+m0BI
         F7yRVe+jvoRGfpZJRSx6wErG62C5vFZdYUeggjrEiwtGtPZJ13ISI3tnwZ54H61NYwcO
         VM2IgPt15tzvBuH9SEjTCWGw124E0TXbL8XqU0u0YYMeM0UcF8OCUdsU5qdwbMP306ec
         wF5H/IhO4wp8tL/W1Ocw60yu/x7TJ9o4DofHJXSeg2BneSR9gkZ4Fvznj+Iu8Zv8MHMg
         EpwFJecCUwf+QIUSlDbc/GD0o5eOS0+NdajGUSzi4k4lif2nEI84MoMuraK77c09oZB/
         HF9g==
X-Gm-Message-State: AFqh2kpcmhYSCYjoIlX/TubZwopaqzQDoSY2V53m7OTNUrPG9deCycXV
        oLiXB+pSUV/kjfjuqCyw8Z7nLyOXtZ0yFFjGLRU=
X-Google-Smtp-Source: AMrXdXvYLN4AD1kDp+d/H1mXruc6J/GmS72u7FDBU3Byilx+irrm99vG53ns++MA9PUSyC0LZtRj84gjcpXYYWEOWc8=
X-Received: by 2002:a05:6808:1d9:b0:359:f10b:5477 with SMTP id
 x25-20020a05680801d900b00359f10b5477mr3753236oic.277.1673326171306; Mon, 09
 Jan 2023 20:49:31 -0800 (PST)
MIME-Version: 1.0
References: <20230108062335.72114-1-carenas@gmail.com> <20230108155217.2817-1-carenas@gmail.com>
 <230109.86v8lf297g.gmgdl@evledraar.gmail.com>
In-Reply-To: <230109.86v8lf297g.gmgdl@evledraar.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 9 Jan 2023 20:49:20 -0800
Message-ID: <CAPUEsphgxU4R6PTEd1N7VwQ+Da1CRRvyNkeas0k2gn0WkDA+2A@mail.gmail.com>
Subject: Re: [PATCH v2] grep: correctly identify utf-8 characters with \{b,w}
 in -P
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        demerphq <demerphq@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 9, 2023 at 4:17 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>Rather than trying to opt-out with "/a" or "/aa" I think this should be op=
t-in.
>
> As the example at the start shows you can already do this with "(*UCP)"
> in the pattern, so perhaps we should just link to the pcre2pattern(3)
> manual from git-grep(1)?

Considering that PCRE is used internally even for cases that don't
specify -P how would that opt-in work?

For example, in a repository with code that uses utf identifiers, the
following will fail:

  $ git grep -w -E motion
  u.c:  int =C3=A9motion =3D 0;
  $ git grep -w -E '(*UCP)motion'
  fatal: command line, '(*UCP)motion': Invalid preceding regular expression
  $ git -P grep -P -w '(*UCP)motion'
  u.c:  int =C3=A9motion =3D 0;

Carlo

CC removed gnu and the obsoleted PCRE developer list (if really needed
would be better to use the documented pcre2-dev@googlegroups.com,
instead)
