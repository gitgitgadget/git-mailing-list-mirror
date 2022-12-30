Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016F2C4332F
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 21:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbiL3VEL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Dec 2022 16:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiL3VEK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Dec 2022 16:04:10 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7BC10FE2
        for <git@vger.kernel.org>; Fri, 30 Dec 2022 13:04:09 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id p66so11686422iof.1
        for <git@vger.kernel.org>; Fri, 30 Dec 2022 13:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iKHWqcIKnJaVggLPpRmuV/9RN58g5qWdgMBwhaTNw7U=;
        b=GFeY5nVJzqgBIf3ZS/VwyRuLIW8oX2dkiLmptajbQpXStGpmuur+dfG5mEFT+hSk/H
         v8pK0dlQ8etYF3GqDsJ6mKKj/16mVlH5yfOmZI55BLWJsdHxcsiDDu3Zusgn2CfxVoLR
         M3moN9R50YMqEkTsYSoMCxJs/s/u9sa3FkxGCtiLsYvMOYVFoub4iOZvXgRM/9vGI8Uu
         W6mJHaOa5oBJ4dUd//6zh7TP/vcA75uKQoQ8VG/riMlAwG9A4uf2Jqog+KKer/1A5vqr
         UtBmhsJDgx2kKIFyQLtp8hNZlhbfh7zaojAQwLyS+rNcq9Z4yUUS3oVarpQqbUI6u3IV
         jxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKHWqcIKnJaVggLPpRmuV/9RN58g5qWdgMBwhaTNw7U=;
        b=kZN1xIEW5PBCdmV1QYjQURtJ5A25fqgORGD5cpLoAHsVzmyWUN47jpgemwxPN508YI
         u/0taUBaXpgdcaCTXaTZTJVJSfKpqwEoQhb4J0oeC3rq27eU0NFrx9z0IFWYvyYM64vJ
         Pt2FyzUMwwCjJDuHm5BoDn+ym1W2qjK2Eno5alBJLdxUQuJhm/Mbs4F8jW02tJ2QQ/L6
         rxRCxY730Qf8yVP33JZ7qWhMCHbGl0sT6Vuvg0DFUJvHO0yDi3UaZT1h0IT2QX0ghiBy
         QdqlKX8Y2eKGn+eHli3V4LlJ0Ik62GfltzVwGAlO8yz40E84F2Z6zm/ReplDlU+CF+/t
         rrYQ==
X-Gm-Message-State: AFqh2kqM4O/fFVGLKhmhYw0++EuSQLEwKzFWrmPS570fT2Cb1/vFTdpb
        jHbznhac44cAVXZ3WfgncA+JTA==
X-Google-Smtp-Source: AMrXdXtxMUdZ5w++FBQA9jSv6BwvZH816p7RagEJ9D5SfHHfuQ1sg6azdRQG8jWsXpEctPN3Bf3cSA==
X-Received: by 2002:a6b:7d0d:0:b0:6e6:726a:bd80 with SMTP id c13-20020a6b7d0d000000b006e6726abd80mr26537213ioq.6.1672434248434;
        Fri, 30 Dec 2022 13:04:08 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c37-20020a029628000000b00389de6759b8sm7220808jai.162.2022.12.30.13.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 13:04:07 -0800 (PST)
Date:   Fri, 30 Dec 2022 16:04:06 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     rsbecker@nexbridge.com
Cc:     'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [BUG] fatal: transport 'file' not allowed during submodule add
Message-ID: <Y69SRs9ifDPagOUo@nand.local>
References: <00f901d91a47$09400110$1bc00330$@nexbridge.com>
 <xmqqilhwp5g4.fsf@gitster.g>
 <011201d91aca$a5db7800$f1926800$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <011201d91aca$a5db7800$f1926800$@nexbridge.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 28, 2022 at 09:42:39AM -0500, rsbecker@nexbridge.com wrote:
>
>
> >-----Original Message-----
> >From: Junio C Hamano <jch2355@gmail.com> On Behalf Of Junio C Hamano
> On December 27, 2022 10:34 PM, Junio C Hamano wrote:
> ><rsbecker@nexbridge.com> writes:
> >
> >> As of 2.39.0, I am now getting fatal: transport 'file' not allowed
> >> when performing a submodule add after a clone -l. The simple reproduce
> >> of this
> >> is:
> >> ...
> >> This happens for any submodule add on the same system. Some online
> >> research indicates that there was a security patch to git causing
> >> this, but I can't find it. This does not seem correct to me or how this
> improves
> >security.
> >> Help please - this is causing some of my workflows to break.
> >
> >Thanks for reporting, Randall.
> >
> >This suspiciously sounds like what a1d4f67c (transport: make
> `protocol.file.allow`
> >be "user" by default, 2022-07-29) is doing deliberately.  Taylor, does this
> look like a
> >corner case the 2.30.6 updates forgot to consider?
>
> I have tried using 'git config --local protocol.file.allow always' and/or
> 'git config --local protocol.allow always' to get past this, without
> success.

I couldn't reproduce the symptom you described. Indeed, the behavior of
not allowing local-submodules to be cloned without explicitly opting in
via the `protocol.file.allow` configuration is intentional.

The patch Junio mentioned, a1d4f67c12 (transport: make
`protocol.file.allow` be "user" by default, 2022-07-29) has some
examples of why this behavior was changed in the 2.30.6 update.

If you run either `git config --global protocol.file.allow always`, or
replace your last submodule add with:

  $ git -c protocol.file.allow=always submodule add /path/to/subsrc.git

it should work as expected.

Thanks,
Taylor
