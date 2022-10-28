Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDB2C38A02
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 22:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiJ1WuD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 18:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiJ1Wt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 18:49:57 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AF815817
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 15:49:54 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id g24so6053127plq.3
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 15:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2bDVClNhgveUC1bRozuXI3D4nkXYnjJN0y7Ew6fU7QY=;
        b=lNKE6bhRzI+Cw9s3Y9YTXORsf9J3exeMw+jnOmIFvq9GKdEVQsoQrPXwFMZgoZOV0F
         eB3j47igiXE7/FG6ZroGuB2EVvpMh6CwCoBg/Qk1xLjXI+hg8nB68hjx5HqF7ArQ5eaR
         0WOpDtJVmfAza1n9CEzBynCzFSW2sbCWcgRnHQmzSWiqlsHPf4TqZrf+bsn7KbMPtvdo
         0q8zj0+g2TKUI9EHXe4n7bRFR0ioNnAH1lcNIGjTpOSivY+k99RKpNhvvjbbRIGmKKpJ
         lbmJhFUDe6WMeGvNktp7XLTvN3AiZdRcUWX1gMRAioWoAMECO6iIpbJ6vo/JXXhD6wt2
         UGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2bDVClNhgveUC1bRozuXI3D4nkXYnjJN0y7Ew6fU7QY=;
        b=bAeF75UUTck9lCUxxOTD4AMIvWZ+bP5+mLtdRh1/l391UiFGcH5cK7OZk+HmE5kvne
         mYP0q/JnLsc/ZT0bnpQgmYmWhYFx1FZC+XHXMg3DHYAAqlJvI5/Hzr2udoFMlKEsueIU
         HlL/pQmDfEbdeJjiAD5QB2iSwPbZ5ujdAuq3dQiJrIRXod8R3tsLuXekp3EDx3vRIcaO
         mDkFSXOBRJBqTB3CHBHnGNe6ikfZOJzNoxUPG5JlR+XykbiQ5wTRjltQTRb9oZTUr41B
         Momgd2EAWYt86gFy6iYbq9Ab+MirsjCFggfJ2zTvrXWolEz96NPAbRErkYadkO+05ZQA
         k9vg==
X-Gm-Message-State: ACrzQf176X6+puyn0Si+aPs8E+izjrhOfrA2REKyIDwg6G48Aqe40VT1
        PgvxcLf4nDtI89TFHqoX+B5FH5nB0fw=
X-Google-Smtp-Source: AMsMyM6aFTf3Wpa7+fTMMvTrqnNpeQx5EV/wVGr+mSTn4HNbXxolH1mBCmQ3ePtgM2u7r/QC8U9N6A==
X-Received: by 2002:a17:90b:1e0c:b0:213:7030:6b11 with SMTP id pg12-20020a17090b1e0c00b0021370306b11mr12101433pjb.29.1666997394290;
        Fri, 28 Oct 2022 15:49:54 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id h3-20020a056a00000300b0056c0cde1a16sm3291865pfk.134.2022.10.28.15.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 15:49:53 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Julien Moutinho <julm+git@sourcephile.fr>
Subject: Re: [PATCH] adjust_shared_perm(): leave g+s alone when the group
 does not matter
References: <xmqqr0yrhco6.fsf@gitster.g>
        <Y1xNrDB10XEcAa0d@tapette.crustytoothpaste.net>
        <xmqqbkpvhb0x.fsf@gitster.g>
        <Y1xWBiZUAbPmt71W@tapette.crustytoothpaste.net>
Date:   Fri, 28 Oct 2022 15:49:53 -0700
In-Reply-To: <Y1xWBiZUAbPmt71W@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 28 Oct 2022 22:21:58 +0000")
Message-ID: <xmqq5yg3ftri.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2022-10-28 at 21:51:42, Junio C Hamano wrote:
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>> 
>> > On 2022-10-28 at 21:16:09, Junio C Hamano wrote:
>> >> Julien Moutinho reports that in an environment where directory does
>> >> not have BSD group semantics and requires g+s (aka FORCE_DIR_SET_GID)
>> >> but the system cripples chmod() to forbid g+s, adjust_shared_perm()
>> >
>> > I would personally use a different verb here because I have the
>> > impression it's offensive, at least when used as a noun.  Perhaps
>> > "limit" or "restrict" might be more neutral, or we could pick another
>> > verb which expresses our displeasure at this design (maybe "impair"?)
>> > but maybe is less likely to be emotionally charged or offend.
>> 
>> castrates? butchers?
>> 
>> tweaks?  That's quite neutral.
>
> I think "butchers" or "tweaks" should be fine.  I might say "modifies"
> as well.

I've decided to weaken it a lot by phrasing it like so:

    ... but the system forbids chmod() to touch the g+s bit, ...



