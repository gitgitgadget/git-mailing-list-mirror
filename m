Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271F2C2B9F4
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 09:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F40726141F
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 09:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhFYJRb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 05:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhFYJR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 05:17:29 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86184C061574
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 02:15:08 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id h21-20020a1ccc150000b02901d4d33c5ca0so5372269wmb.3
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 02:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=99pwuTCzrCx7+pKLGdAGadltALpi6HDPj46SK/0FXdY=;
        b=UtO+F+V/Dm2u1Au3/+vhreQnXkzg7IjZy3/lyJLZSSBi1aMrg9SAcqIf4OYviup7+o
         1VUzTUK4H94CHOuHZzypXtnFGgGPq1UKsCi4+CcIPlLex+NMpkbeEKJ3TKOcYmU9xF2F
         sje3b+0Wv+rY/VV3Rwj0NTjtP7CR7Q+SCv1SrvofyoOxQ53UCOFkFkHHNaUV4dKZfaia
         LH3gLRN0gHqC/x4vx9Rzux1SD9+Oo79S91bhisHBKf66qcRDflWmaLPgh+QeOOTDkGHG
         pn38D1trUt4oFmf8t3tpSt2Zp/2NRtfagZDgSHJwLMkyoSo6dhf2yeOydqQX/q2uE146
         FwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=99pwuTCzrCx7+pKLGdAGadltALpi6HDPj46SK/0FXdY=;
        b=jzPRJg5CdaiYfpR/GAwYOuSntxlA50g61XDWDBmzRFsi59StjnxmesQQHL+HKp1sC8
         9QjI0FeGdR9HDL4Gn7BnYNfHdowwND+pOeTKAStQJuizSOI48RxLZ4g7/tbjG0m1mNGJ
         Cx9iE5V40fQJE9n6aMU3eqNGYtUhYlSqYvvrTfLZWaJLlVba5zOi1DKT+E5dGrAkT5Df
         cgPtVKuok+0Mg3KQl/ai/6KHRAGwdTZ3iKqX2/DMGYPEtsyFEgawqP2I1OYOIcR/4v7U
         TFl9XijXCROVG6eYvyJK21Wwu7AlQMTLJWnoipYb+sB3aJ5c0HLDYo7+Xp1sE/mG+Hks
         VThA==
X-Gm-Message-State: AOAM532j3r8YS//W2CZVOGOIw/HjdggbYInHB32D8w6D7HOmIHM2N3CN
        5lH7DwfOB4wz+/Rvn6NI+BFirk8VPw4=
X-Google-Smtp-Source: ABdhPJzqk7HiCkcHq9QlmlpPdtBRYJUnv5I9z8V4QMdVibRg+GB5jX3VrNW//Jj4jVRDa10abyQ3tw==
X-Received: by 2002:a1c:c911:: with SMTP id f17mr9499603wmb.60.1624612506906;
        Fri, 25 Jun 2021 02:15:06 -0700 (PDT)
Received: from [192.168.5.102] ([87.116.163.143])
        by smtp.gmail.com with ESMTPSA id k2sm5484645wrw.93.2021.06.25.02.15.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 02:15:06 -0700 (PDT)
Subject: Re: Definition of "the Git repository"
To:     Kevin Buckley <Kevin.Buckley@pawsey.org.au>, git@vger.kernel.org
References: <7dd55e85-38eb-7346-ff10-7124102cd22b@pawsey.org.au>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <d4429a6e-9681-6a79-1e91-19c129fa02b4@gmail.com>
Date:   Fri, 25 Jun 2021 11:14:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <7dd55e85-38eb-7346-ff10-7124102cd22b@pawsey.org.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/06/2021 03:44, Kevin Buckley wrote:
> 
> In the way I think of it
> 
> git init
> 
> initialises a Git repository, however, the only thing that changes
> as a result is that a .git directory has been created, ergo, the
> .git directory is the repository.

Another way to look at it could be that you possibly have a repository 
already, and `git init` only makes it a Git repository... ;)

Joking aside, for a looong train of thoughts, see that other reply[1].

Regards, Buga

[1]: https://lore.kernel.org/git/9099ab09-f6d0-f1e2-1b8e-a55d22a903c5@gmail.com/
