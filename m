Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0796C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 13:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C32F61002
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 13:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238212AbhHDNac (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 09:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237011AbhHDNab (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 09:30:31 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F41C0613D5
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 06:30:18 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id x8so4465394lfe.3
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 06:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=btWDXVt2Eg6oBpNziIvzSmObPRgUEWrxTfbEerN8pV4=;
        b=mUD0rFqoxpvdvzx/CeVYDvH3MRusgiSMU5h2QgC2IUvX6TZxRMmiKHxo0UZ1PSmvDa
         VLCrI4WHd4bCaQPlOIVji9y+lSLo8Pzq1usHxyLa8T+Gte+2qT8fP3xbg+IxcowpwFaF
         LGlV58Zpfyj27W6OSXSaCaP1LySerxkvwqu+k6ySS6eMkT/JXu+4qCR/1SdWY/n505rB
         zro+qlqNBa0EUL2hsMTnxVgvy4NunVQUcPFzXkCsEsehmYLqO0+aShKv0akN9hoxfe2Q
         0kW3pmYW1n4dXcO35hgIBaFX67jc25EEDhnA7D/DANfGX+1kLUtBhn+JnDW5yvLrkKB9
         MSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=btWDXVt2Eg6oBpNziIvzSmObPRgUEWrxTfbEerN8pV4=;
        b=IJJE8Dhr99gCJdti0tGHbgEDv1/PunoHo9+uGWXOsrb/LtJWTDeuyKw70cQcKqNivD
         pAXDH+LITZc/Y8JlDp00I3NOefigTBDRMF1CAvip+vRAChUOFA1xFyZEd2S5glXtxQ6k
         VTMbriFI6/QykUI+uw2nnlS7ZmBkqUj75jYWNaX3pn+ZKe85u/PFUqpqGvragttQqS1c
         EUyrosjAkf8VjIFpfcEmAkDfG5/E/pqP0M0I9b3PXZkAggWkPA78QXwmFg6MpQARp63e
         FuSCsKwpNpJBuc5+QT96XVPON1VB6RngHP6GVgGztB8eFZ2srwW+v+oZx3qKUTZHmDv2
         TPpg==
X-Gm-Message-State: AOAM531CCQyX+yMZKq9XCRS+dIKa7zWGOAkSEF3opSKM4wOEF66R6Q4r
        SQfsbAbxFRMKjpvnb/enbnA=
X-Google-Smtp-Source: ABdhPJzpSx8IvnzZOeIvonMnCsqKi8vrrONmfsoOoZLx1Zq33lzMsKZUkxNBJx3SiA/kaY8hg104+Q==
X-Received: by 2002:a19:484a:: with SMTP id v71mr20801320lfa.561.1628083816780;
        Wed, 04 Aug 2021 06:30:16 -0700 (PDT)
Received: from paasan.lan (150.37-191-137.fiber.lynet.no. [37.191.137.150])
        by smtp.gmail.com with ESMTPSA id r5sm197946lfc.265.2021.08.04.06.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 06:30:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, rn+git@sigpipe.cz
Subject: Re: [PATCH v2] clone: Allow combining --bare and --origin
Date:   Wed,  4 Aug 2021 15:30:10 +0200
Message-Id: <20210804133010.25855-1-oystwa@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <xmqqv94mtdyj.fsf@gitster.g>
References: <xmqqv94mtdyj.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi again,

Thanks for accepting the patch.

> It is somewhat unfortunate that we do not say what the name of the
> "origin" is anywhere in the resulting configuration file.  The only
> way to tell that "--origin somewhere" was used is to notice that there
> is only one remote and its name is "somewhere".

This reads as self-contradictory to me. The word "origin" is nowhere in
the configuration file, that's true. But that's because the user chose
it to be that way, and the name the user chose is in the there.

The reason I see it as self-contradictory is that I see two different
usages of the word "origin" in your email:

 1. A *term* meaning the repository that was cloned (e.g. 'name of the
 "origin"', remote.originName)

 2. The *name* of a remote ('there is only one remote and its name is
 [not "origin"]')

Seems you are aware since you write it in quotes :-) 

Both usages appear in the wild and are even mixed sometimes, but in my
experience it's not a big deal; it's usually obvious from context. I
think the second usage is the common one, but the name is so common that
it leads to the first. Is this something we'd like to tackle? If so, it
just occured to me that it certainly doesn't help that the switch to
change the name referring to the repo that was cloned from "origin" to
something else is "--origin".

> I do not think "git fetch" in such a repository knows that it needs to
> fetch from 'somewhere', even whe it is the only remote repository
> available to us.

Changing git fetch to fall back to a remote not named "origin" if that
is the only one configured makes perfect sense to me. (I am skeptical
about remotes.originName since that favors the first usage outlined
above.)

I have cc'ed the origin (pun overtly intended) of this patch and
discussion for their take on it.

> Instead of "usually the thing is called 'origin', so let's make sure
> it does not exist", we may want to say "there is only one remote and
> it is called somewhere because that is how we named it", i.e.
>
>	git -C clone-bare config --name-only \ --get-regexp
>	"remote\..*\.url" >actual && echo remote.somewhere.url >expect
>	&& test_cmp actual expect

This seems like like a better test than the one I wrote.

By the way, I noticed you already fixed my mistake with the repo name.
Thanks for that. I sent this as a v2, but as you can imagine I did it in
two steps in real life. First I removed the test then later I wrote a
new one, and in between I rebased my changes. In the mean time new tests
were added. I noticed they failed, but I didn't realize that was my
fault.

Øsse
