Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB61BC4363A
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B76F20720
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mutual.io header.i=@mutual.io header.b="eIRF3PiO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgJ3Db3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 23:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgJ3Db2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 23:31:28 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3904C0613CF
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:31:26 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id 7so6744647ejm.0
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mutual.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=75U/DuIkRQMzQFNMiGh4aey6Xff/hDU8AQO5arqiA7o=;
        b=eIRF3PiOazOA+9zPkCz0FhwXoyrnz5GGUI/zXNtQSi6QqPz3as5EtsX3KyUSXLW+vB
         c32K58VUyOZ+3Yz7vd5KewCNWSfXXgn8RCvJ6rK6w36mAXvWwgwZ8wGRZ0Bj1GbyG3eH
         eg3cvh53/WwfMP6JMyAdxumf56Ey7BrzrlOC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=75U/DuIkRQMzQFNMiGh4aey6Xff/hDU8AQO5arqiA7o=;
        b=GRNCxiziDeiuW+W/Lf+C25f52Ae7vtZFDJDNgsQ+3FE0I4VCj32oNRwntS8ltqeIrl
         EEJnduf/fQSScX8Ef7b1bBLU2Rchk2PcR5vKvuo4TlzLKuIk7SArg9gAkXSUOB26uf+O
         Eh20MtcQyWAdtOjf2v543xB+BhRGRt6K+BljbjW1tJjprZ4heYN7cgk5jwFdjOpdkHij
         5u6uD3MiBRRF3f4GEs4PV5ICCz1tkTjB21KwYLg5BLyxeqtNkzrHnz+toNIeCWJNmJpm
         aoD0K+5ke7kSqeWtu3d9NiutdBSZQHNdYI8vCKsijG1DFvTWZageW+ymJR8QJ8xqrWrz
         MehQ==
X-Gm-Message-State: AOAM532BVTMYZc+wBXub4Up+KF9+M4NuD0R9DiEssWOmlX3R7ICobj5f
        s8B+VrD0Ajz9cy9tRR6NagbXObrj21Myzz4Sro4bnzXQrLnwJQ==
X-Google-Smtp-Source: ABdhPJwANCHgSlB8B71FcRFbwXF1nymm7VV2Oyw8mEDFoyX3Y722EqbTU2xECaxZ3TbJj5A7LSlMXjJ+xTNftiuvoWs=
X-Received: by 2002:a17:906:b197:: with SMTP id w23mr550072ejy.166.1604028685618;
 Thu, 29 Oct 2020 20:31:25 -0700 (PDT)
MIME-Version: 1.0
References: <1604022059-18527-1-git-send-email-dan@mutual.io> <CAPig+cTOkd248WKh5KyVfScRf8fqcOQPj4V3waGQ3XWEcugiKg@mail.gmail.com>
In-Reply-To: <CAPig+cTOkd248WKh5KyVfScRf8fqcOQPj4V3waGQ3XWEcugiKg@mail.gmail.com>
From:   Daniel Duvall <dan@mutual.io>
Date:   Thu, 29 Oct 2020 20:31:14 -0700
Message-ID: <CANo+1gvybEMEhQV2OWD8q3B9s=ztnJi_bFKo0eVVWwDRbYmAEA@mail.gmail.com>
Subject: Re: [PATCH] upload-pack: allow stateless client EOF just prior to haves
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 29, 2020 at 8:00 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Thu, Oct 29, 2020 at 9:51 PM Daniel Duvall <dan@mutual.io> wrote:
> > [...]
> > Instead, upload-pack should gently peek for an EOF between the sending
> > of shallow/unshallow lines (followed by flush) and the reading of client
> > haves. If the client has hung up at this point, exit normally.
> >
> > Signed-off-by: Daniel Duvall <dan@mutual.io>
> > ---
> > diff --git a/t/t9904-upload-pack-stateless-timely-eof.sh b/t/t9904-upload-pack-stateless-timely-eof.sh
> > @@ -0,0 +1,24 @@
> > +#!/bin/sh
> > +
> > +test_description='stateless upload-pack gently handles EOF just after want/shallow/depth/flush'
> > +
> > +. ./test-lib.sh
> > +
> > +D=$(pwd)
>
> What is the purpose of this assignment? It doesn't seem to be used
> anywhere in this script.

It's an artifact of my copying/pasting a previous test script as a
template. I didn't see it used in that script either, so I assumed it
was needed somewhere in the test libs. If that's not the case, I can
definitely remove it.

>
> > +test_expect_success 'upload-pack outputs flush and exits ok' '
> > +       test_commit initial &&
> > +       head=$(git rev-parse HEAD) &&
> > +       hexsz=$(test_oid hexsz) &&
> > +
> > +       printf "%04xwant %s\n%04xshallow %s\n000ddeepen 1\n0000" \
> > +               $(($hexsz + 10)) $head $(($hexsz + 13)) $head >request &&
> > +
> > +       git upload-pack --stateless-rpc "$(pwd)" <request >actual &&
> > +
> > +       printf "0000" >expect &&
> > +
> > +       test_cmp expect actual
> > +'
> > +
> > +test_done
