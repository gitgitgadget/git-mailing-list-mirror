Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6810FC3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 19:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4160620746
	for <git@archiver.kernel.org>; Mon,  4 May 2020 19:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNHBk9mi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgEDTJ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 15:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725981AbgEDTJ0 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 15:09:26 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E3BC061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 12:09:25 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id s30so495781qth.2
        for <git@vger.kernel.org>; Mon, 04 May 2020 12:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=cjWue2bQ/fV54dGhMTofnDebWnEN10XV78H2Kw7sLFc=;
        b=iNHBk9mi+fggoCS6BQVBmnFCG3o1r8Tk8xzR9Isyl1EcwHh54L/Frgt8i7osuLHNos
         NfQr2oprWQoH96ebH9QUgEDGnlP1klUthLz+lBfgLEyEwHBN4Gb8CVsVnFY5J5X6tDYX
         2Xox4qXREVOxxXU8qTOtGit0g4UMxDtYJMnk4015HYh3tRO+/mDxHZvdXkfHp+Ml4Sdh
         VJCoGkoxsFR2DQGjS9jJAOWCH/kfVyIouFOQ+VhdlExBnYYq1S2ar7+w/EsEVCo8myUz
         wdSbEXqhYmNkvybOzj8hAPVbDFrSmDmpAXrHI6yETneATieriqFAd3FJZ12oSmqri5FX
         gZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=cjWue2bQ/fV54dGhMTofnDebWnEN10XV78H2Kw7sLFc=;
        b=RLijdNtFFw93nDEB3UDiJjHzICvWf3odPvq2hD5I3Q622f0p7QQ7viGh3SxSWZi+xU
         XVhBG+LIG2z/TPmem6VwLdQO+1H1i8uaIm+nd/VRy4VOHEcYMJsXPaJxcPgtxh2UL+E4
         SdYpDqd0u6Skf9L4FHopuHkZmTPoCAZrUQ1zL2Fm5feBh7fFgfnuV/tyScNF+IoUyucx
         wZ1xhoOdz/JBgkeRjL/Ru+qsMsCbDALGpkG9oDRUSs5dDwMgBK72NIYEYBnRYQidTVZt
         zVqnCNxSge0KLmAPlcM8/vqTs5S2ste57i/wRZZdOTCY+s0t4p6f2lsYIbZSpNa/VhQD
         ru/g==
X-Gm-Message-State: AGi0PuYvxjO3GakLwAGfMtUCk7Q5mx41DPypEtdaChf+PpI5H2yKwwqe
        Lk7vW7UP/tGJkqi7N4G/z1Y=
X-Google-Smtp-Source: APiQypIZDW4Zc9EA0AN/s7PVfIaJiOi+xne1gzDnKPQP3Dm4q+Zk7d5qyRUaxIgiO/difQbNcgQBLQ==
X-Received: by 2002:ac8:470e:: with SMTP id f14mr616986qtp.87.1588619364533;
        Mon, 04 May 2020 12:09:24 -0700 (PDT)
Received: from LeoBras (179-125-207-129.dynamic.desktop.com.br. [179.125.207.129])
        by smtp.gmail.com with ESMTPSA id h25sm10964556qto.87.2020.05.04.12.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 12:09:23 -0700 (PDT)
Message-ID: <aeff4d773cc69b6845e89a79a6de79d3137b7da2.camel@gmail.com>
Subject: Re: [PATCH] send-email: Defines smtpPassCmd config option
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?ISO-8859-1?Q?Bel=F3n?= 
        <carenas@gmail.com>
Cc:     git@vger.kernel.org, Jan Viktorin <viktorin@rehivetech.com>,
        Michal Nazarewicz <mina86@mina86.com>
Date:   Mon, 04 May 2020 16:09:07 -0300
In-Reply-To: <xmqqees3odrb.fsf@gitster.c.googlers.com>
References: <20200501105131.297457-1-leobras.c@gmail.com>
         <20200501125308.GE33264@Carlos-MBP>
         <xmqqees3odrb.fsf@gitster.c.googlers.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2020-05-01 at 08:50 -0700, Junio C Hamano wrote:
> Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:
> 
> > > +of `sendemail.smtpPassCmd`), then a password is obtained using
> > > +'git-credential'.
> > 
> > this last part on git credential is just undocumented, since it is already
> > doing so since 4d31a44a08 (git-send-email: use git credential to obtain
> > password, 2013-02-12)
> >  
> > and of course, assuming you use a credential helper that keeps the password
> > encrypted you could use that instead of this new feature.
> 
> Up to this point I understand your response.
> 
> Documenting that "git send-email" can use "git credential" for its
> password store, if it is not already documented, is of course a good
> change.
> 
> But I am not sure why this is "a good alternative".  Having more
> choices that do not offer anything substantially different is a bad
> thing.  Is this "new mechanism" better in what way?  Simpler to use?
> Faster?  Less error prone?  Something else?

The main reason would be "simpler to use".
At the point the developer is configuring smtp, adding another line
with 'command to get the password' instead of 'password' is way more
intuitive than configure a credential.

Best regards,
Leonardo Bras

