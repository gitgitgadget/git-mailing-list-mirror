Return-Path: <SRS0=AWh0=66=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C53C433DF
	for <git@archiver.kernel.org>; Sat, 16 May 2020 08:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55A9920728
	for <git@archiver.kernel.org>; Sat, 16 May 2020 08:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkS0O+0n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgEPI4q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 May 2020 04:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgEPI4q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 May 2020 04:56:46 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F684C061A0C
        for <git@vger.kernel.org>; Sat, 16 May 2020 01:56:46 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id s1so5139585qkf.9
        for <git@vger.kernel.org>; Sat, 16 May 2020 01:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DobMxXllVksr9mq6zWbk0ugcZloImOde3KrMChCWsvs=;
        b=MkS0O+0nydaF9WTRgYWHuCxpPl2lwz7zbX0vRT5uIsoJqlMsOrnXoqSjGKSQVVJ8Cl
         kdQMUG9kzV3GYKRdICKo4ien7BpBG1DJQ3k0unsm0HGwg4pJs8nIYd/QM55VV21IscCD
         piG/a4XUqeD3usnyxSwkUWXp42Atc+DWKAimRdsjIR6YrBlZv+T+W0IH3nmTPDSaXYe/
         g0xOnzgYnUvVffcg32UvDSZBx5qMuCI/ksdKhZoJmRdcJJribj8WyE3cVW3X5wxQDftZ
         JIHrhvZ9RAPwCE0AuTBUot4h1DT+YJ22AILR51KO4TWe5Xkuer7agvB+CgygZrxCOP4Q
         jRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DobMxXllVksr9mq6zWbk0ugcZloImOde3KrMChCWsvs=;
        b=lfxTUmnQGEesmPwJrmJg95ZdceKjhru/WGryro59gaanu2Oqs0QylB28M3yV7n40W5
         evSrCnATyJIq74QDTd5+iHLVgDTRJnf3aMzix3eggg9SbwKGMrgY2G4aCxY7en+rxWgL
         TKRm5Q0sa1RgXhF+5/Qpk3QK0ANZihJquTGtegRMDg+Vm2mJnsX/DGSGipAHY+VTpBs0
         IlwaiYP76UnVWzlPFAst0CcgaqlFsdiDxXpQ7ic7i+CPFeUr6iiROzUg9CS/wjEjpt5S
         oKG0mdSl3OC8r9l81EreTWjYwwaY/ETDKizDid5mhSbAmpG7iKd3Pkqs90mhxeJiEbMu
         WAHQ==
X-Gm-Message-State: AOAM532m0BDXkn8fd1WQlWgYd7cm03GunbdKjoq13EI0WwdsqCkuaUUm
        yDamAJic9Uu7hWY8KKrD9Ec=
X-Google-Smtp-Source: ABdhPJxAcWwirdPN+NIRUnqZ2gshT8wbiyWfmaDXlmp4qicmt09dPkoc1QTZKzvVt7wowV9enfvASA==
X-Received: by 2002:a37:7603:: with SMTP id r3mr3926888qkc.243.1589619405647;
        Sat, 16 May 2020 01:56:45 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id q54sm4007356qtj.38.2020.05.16.01.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 01:56:44 -0700 (PDT)
Date:   Sat, 16 May 2020 04:56:42 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, gitster@pobox.com
Subject: Re: [PATCH 2/2] submodule: Add 'quiet' option in subcommand
 'set-branch'
Message-ID: <20200516085642.GA16726@generichostname>
References: <20200513201737.55778-1-shouryashukla.oo@gmail.com>
 <20200513201737.55778-2-shouryashukla.oo@gmail.com>
 <20200514101534.GB28018@generichostname>
 <20200516055016.GB3296@konoha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200516055016.GB3296@konoha>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 16, 2020 at 11:20:16AM +0530, Shourya Shukla wrote:
> On 14/05 06:15, Denton Liu wrote:
> > Hi Shourya,
> > 
> > I'm not really sure if we should have this patch at all since I don't
> > think that set-branch should be printing anything at all.
> 
> I thought that the Documentation has the mention of the `quiet` and it
> wouldn't harm printing something when the branch is set. Is this not the
> right way to tackle this?

I would argue that it's unnecessary to print anything. If a user
provides an invalid option, then an error message will be printed. If no
error is provided, then a user would assume that the command succeeded.
Take, for example, `git submodule set-url` which behaves similarly. It's
silent on success. Printing on success would just be noise.
