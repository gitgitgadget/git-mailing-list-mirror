Return-Path: <SRS0=LEOb=ZX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E75C43215
	for <git@archiver.kernel.org>; Sun,  1 Dec 2019 00:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E89E220833
	for <git@archiver.kernel.org>; Sun,  1 Dec 2019 00:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575160867;
	bh=4XITr9luwAC8C8Dq6SKGDOAGrDrz6jihPYC4KW54HQg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dvTZoXwgoB03SO4+J+6Nccdurpw8d0ya7xifb/4JyR10c0NbBUST/Ksa7gs7OU6Hz
	 teeDBo7sP+kllc9Nm32OwrGlXNC4f63ep7zRu/spWTB1O13kHHN6UN4YZDY1em501N
	 41idcT94ADVfIjMizQBotHDDwdxfHwVMaD5HqGPw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfLAAk6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Nov 2019 19:40:58 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40947 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfLAAk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Nov 2019 19:40:58 -0500
Received: by mail-lf1-f67.google.com with SMTP id y5so12537854lfy.7
        for <git@vger.kernel.org>; Sat, 30 Nov 2019 16:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D5KsBUM8JPybDXiUpn5VQxvK/h7+Y2vajWRzHP60FL4=;
        b=bMO4gHAAReaAa9vawpWAqbJqwziS8m4F59UGT7LFZBRbuY/+ZXOd6zXE2VmTjpeFcD
         csNKArPGBeAixXoAgRRYNBjq0OZWH8+6jfBXW7dOuLt6okhMcuEOB2bJYnPup02YSO52
         qAJhlQ10rVZXIue3kNBcXrCAzqLxtniIcRGPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D5KsBUM8JPybDXiUpn5VQxvK/h7+Y2vajWRzHP60FL4=;
        b=JHYVpDi63vL1qR4Hno5vYpp/rVgbTRhtoTwUMY78Jt/0MquMGfg09J7mBkvzSKY+XA
         /5+wCXJOJUNDupFJ7e////2twxn/SG6umbIkgFuUVpJ+gGUMYXf4IjJX9qzhvpG6DmTm
         tx/SjRO1Ek/tJXB1XTTdeDP3kn9dMkTJqyBsXnHnyMhffXVbVOTj7WyBTUAcryj1xiHb
         ODcXCnwGWlCaD/V7UDIG9BykrFd4So5NKpZPLtmDhJKwIjDNERpUoRZU1a/WdFUSiDHb
         Myaf9+TMmC0I3p4mc1VV4YWQsUKmOEdPnbdZ+k50poJe/nQ+w53RbsmEQ55MyvI99Auo
         yRtA==
X-Gm-Message-State: APjAAAU+VU8cCHfV+wvn6Tx9jTgJg0BHppQHAylmCSc6XXdczXYRHz2N
        BBQArXctSUmD7COa8S+T981muF9kW1w=
X-Google-Smtp-Source: APXvYqygAnVM09snscWWKuOkIRU9Xev6wnkhEK0y4wjcK18JP/AwEmVTI94CZC64XjzThD1ujLQ35Q==
X-Received: by 2002:ac2:4553:: with SMTP id j19mr40687413lfm.142.1575160853663;
        Sat, 30 Nov 2019 16:40:53 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id r9sm12840127ljm.7.2019.11.30.16.40.52
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2019 16:40:53 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id e28so11617167ljo.9
        for <git@vger.kernel.org>; Sat, 30 Nov 2019 16:40:52 -0800 (PST)
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr27980802ljj.97.1575160851969;
 Sat, 30 Nov 2019 16:40:51 -0800 (PST)
MIME-Version: 1.0
References: <20191126093002.06ece6dd@lwn.net> <CAHk-=whH-wrF7dx_+NgpYi8pK0vovE2mEFE3sgEYXAQZcPwBjA@mail.gmail.com>
 <20191130171428.6c09f892@lwn.net>
In-Reply-To: <20191130171428.6c09f892@lwn.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 30 Nov 2019 16:40:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjrRu1BB+GRXn+k2oEWZHm03p19MnQqbSfgn=mMiWnCkQ@mail.gmail.com>
Message-ID: <CAHk-=wjrRu1BB+GRXn+k2oEWZHm03p19MnQqbSfgn=mMiWnCkQ@mail.gmail.com>
Subject: Re: [PULL] Documentation for 5.5
To:     Jonathan Corbet <corbet@lwn.net>,
        Git List Mailing <git@vger.kernel.org>,
        Junio Hamano C <junio@pobox.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[ Background for Junio and the git mailing list - Jon's pull request
to me had a lot of whitespace damage from CRLF line endings for some
of the patches he applied. ]

On Sat, Nov 30, 2019 at 4:14 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> So my tooling is "git am", nothing special.
>
> All of the afflicted files arrived in that state as the result of a pair
> of patches from Jonathan (copied); I have verified that the original
> patches also had the DOS line endings.
>
> The problem repeats if I apply those patches now, even if I add an
> explicit "--no-keep-cr" to the "git am" command line.  It seems like maybe
> my version of git is somehow broken?  I have git-2.21.0-1.fc30.x86_64,
> FWIW.

Hmm. I wonder if the CRLF removal is broken in general, or if the
emails are somehow unusual (patches in attachments or MIME-encoded or
something)? Maybe the CRLF was removed from the envelope email lines,
but if the patch is then decoded from an attachment or something it's
not removed again from there?

Can you attach (not forward) one of the (raw) emails that shows the
problem and keep the git mailing list cc'd?

             Linus
