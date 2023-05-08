Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC74C77B75
	for <git@archiver.kernel.org>; Mon,  8 May 2023 00:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjEHAfB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 May 2023 20:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjEHAe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2023 20:34:59 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFDD8A60
        for <git@vger.kernel.org>; Sun,  7 May 2023 17:34:57 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-38e7ce73ca0so1869080b6e.2
        for <git@vger.kernel.org>; Sun, 07 May 2023 17:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683506097; x=1686098097;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAj5j1Z3o5nVILrZhSrnv2JnbXsd33/O2D9gZ7wG8LA=;
        b=Ih3LDY0XUK0i+QjYc4QX3fmIZ/ReTZ3bW8DqSwIYhBZ+UR1NBjf0bR0437+N1/I5u7
         pAduFU2+UxgX5NjIf/SVAztROq29Ux2oboG0lUw3Xf5AKcmpt0NHbEeu6etFcDrJEHjC
         oZ4lN56XayvpmwBJbusrRRReQN+B8DyTQS5iHhhmdi9k7ec5026V3ERbyPltSdpjuWQY
         2l78JxAQKEAp4/B2jf6B5OEVX1d+Xm821ErcNSjpzedJ/D+vDeAl5GOwmHRYVAVEADoo
         AuYV1Lfo95OEOFIfuxGLmxecLrpEgz4PL2XGGtrenuN4LW55AovXwoNgaRXUTSrv15ys
         WtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683506097; x=1686098097;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jAj5j1Z3o5nVILrZhSrnv2JnbXsd33/O2D9gZ7wG8LA=;
        b=e4dtDsEy4E5HkysDorNj+57mU4lsXqHhF2QmoO54tK/11t4UY+jHIdnnTOeR0QhBf+
         otyIFcBJE8b2l1fmRIm99R77p8anlLD9sReFDZ/9Q/j/u891VsS2B3r/RfQJ7qSm4O3+
         VwpDEsbRmfYQCQpkswTajTSgjer4drpXQPxXYTA4bRPDjA48WZ+qzTt6t81xj3TQxpzg
         +JHUh6CmUzh7b6RPWc/TK6RSLz3LOSLuiu33iH1YHUVTHda55s9E8NlHiQjrEZtIqOn3
         exZ7cksLNTr8NKQRHYR3uV+uZ1Sdi9CmPXBOkjM1OOoJZ3/4qYs3xpZBJAAYTQacSoq2
         C6bw==
X-Gm-Message-State: AC+VfDwsIH+8W5s7N8yo0nVyQkWRz8wWLdpvMYN/JBn0fH4BJBu+NOf4
        tHvZ81BnBRdrgYoQYfzzh2c=
X-Google-Smtp-Source: ACHHUZ6OIO84kFU3trtCOsdKpXtdgFKEefx8I6UalpxSacj20pV6Q6rZWjQDiHubkIc5CWU32yrvvg==
X-Received: by 2002:aca:1117:0:b0:384:32ff:eb75 with SMTP id 23-20020aca1117000000b0038432ffeb75mr4350058oir.18.1683506097239;
        Sun, 07 May 2023 17:34:57 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id u42-20020a056808152a00b00383d9700294sm4938245oiw.40.2023.05.07.17.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 17:34:56 -0700 (PDT)
Date:   Sun, 07 May 2023 18:34:55 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Adam Majer <adamm@zombino.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Message-ID: <645843afce409_4e6129427@chronos.notmuch>
In-Reply-To: <31868D65-0456-4594-AB2C-C4735B8F1D75@zombino.com>
References: <ZEmMUFR7AJn+v7jV@tapette.crustytoothpaste.net>
 <20230426205324.326501-1-sandals@crustytoothpaste.net>
 <20230426205324.326501-3-sandals@crustytoothpaste.net>
 <xmqqbkjaqqfp.fsf@gitster.g>
 <20230427054343.GE982277@coredump.intra.peff.net>
 <6451a0ba5c3fb_200ae2945b@chronos.notmuch>
 <70103746-6980-baed-13d9-afeae6cee464@zombino.com>
 <64528158cdd1e_68229498@chronos.notmuch>
 <31868D65-0456-4594-AB2C-C4735B8F1D75@zombino.com>
Subject: Re: Is GIT_DEFAULT_HASH flawed?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Majer wrote:
> On May 3, 2023 5:44:24 p.m. GMT+02:00, Felipe Contreras <felipe.contreras@gmail.com> wrote:
> >Git was designed to make it *impossible* to confuse two commits with similar
> >data.
> 
> That was never ever the problem here.

But it will be.

> >> This is different. But aside, type + size + data are not really much 
> >> different from just having data in a hash function.
> >
> >It's completely different.
> 
> How so? Type and size are just about 2 and a dozen bits of data, respectfully.

Do you understand how checksums work?

Compare these two objects:

 1. 0beec7b5ea3f0fdbc95d0dd47f3c5bc275da8a33
 2. 6ba62a7c5e3e9a260c5a30adf2756882c02f12a6

Are they a) "not much different", or b) "completely different"?

Answer: doesn't matter, they are *different*. Period.

> >There are different philosophical views of what "security" means, and it seems
> >pretty clear to me that your view does not align with the view of Linus
> >Torvalds.
> 
> 
> I'm not sure why you are name dropping Linus everywhere

I don't know if you are aware, but Linus Torvalds is the author of git.

He also happens to be the author of the most successful software project
in history: Linux.

So generally his design choices are considered to be good.

> or assuming you know more than anyone here about hash functions.

I don't assume such a thing.

But I'm pretty certain not many people are aware of the integrity issues
VCSs presented circa 2004, that git hashes solved in 2005, because if
they did, they could have created an object model storage similar to
git's, and no one did (except Linus Torvalds).

> Your explanation is quite clear to me (and probably everyone else
> here). But I'll just leave it at that.

Is it? Then you would have no trouble steel manning my argument, which
you haven't done.

-- 
Felipe Contreras
