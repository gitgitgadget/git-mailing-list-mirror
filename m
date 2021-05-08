Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AD9C433B4
	for <git@archiver.kernel.org>; Sat,  8 May 2021 04:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B77E613C5
	for <git@archiver.kernel.org>; Sat,  8 May 2021 04:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbhEHEmI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 May 2021 00:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhEHEmI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 May 2021 00:42:08 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301B5C061574
        for <git@vger.kernel.org>; Fri,  7 May 2021 21:41:05 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id 69so1657489plc.5
        for <git@vger.kernel.org>; Fri, 07 May 2021 21:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=n5iUmG+3rZfQj7yQPN5/n2Fmsyoe2P1lPMvdf3fbUzk=;
        b=h1kRf1uLRwPu5sFkwGDcMe33qjmQ663169J6w3DGS0r7JQm3EKwVn3msiYZeZCEtaJ
         6yuOVTJmv3GCrC/ZhSsgizrKCsHarjPoA3Gpms8w1QkHOY3LCNyEXL7x0XJXZwyq7Z/s
         lz80Ei8lrxTq5ndTZsrL2n3EQpIk57jcQBRG19R5GfqN8IMER/BHfGAF5UVRhXKZ+D1x
         7IZZZEIDIG6Qtyo5brzaaafv1IRfpd+aid+8g/yoecNxhh0mkvcaH5sqK4rRbxUn8Mh2
         H9lFVPCby/naELhhbzUGaTJl+0ib607mdSaOW/3zgkfk8KmxOmFYnO5ZcyKRCv3cxwa9
         3J1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n5iUmG+3rZfQj7yQPN5/n2Fmsyoe2P1lPMvdf3fbUzk=;
        b=ERJSKcSL1MvDt8iH82BU7h0+hgm5T7gaufch9riR+bbpZP+aJb4WCFUFF5JeeW4E2L
         hpey+dJi5EK8zwUWUOuQonl0WJUKubaig/mJmMPYeZ37u2c4E0kaQql9IBeM3x1iP2Ch
         pIHBWx0qdzqNnzaaOiX93r544AAC5yViF+CzC/YY7jUOBef+yub2wLOZ8jUvx9FJIP4M
         QfbKPtKxaMTnDL+ExRpLr1Za69CzJOjiNn1RAyqVA3Qgd1+kbXeSuRWYc8DD0cyaCXIK
         T14e/oyFkgB1FKaZ01qcuUm8Q5ZVC2MzOAOWRzA2NCnobWQcJEg47eNmSYzPBDp12qL8
         +NOA==
X-Gm-Message-State: AOAM530WjOz+A1Gc2XKLlNN8rI7No3MDiTCUqN6szkssK7UHBvjEX5dn
        FK5ezKEtoLJBQ7Wkz8bGEN+MrdGGQ5lAJLnh
X-Google-Smtp-Source: ABdhPJxToBdAp8WupDbxqtmfw8HGAlBkVTwY+qpsdYQXkBzkEBkxT0Ak/hLKXbeKg4VLAKD01Tqkvg==
X-Received: by 2002:a17:90a:4e81:: with SMTP id o1mr26257563pjh.7.1620448865451;
        Fri, 07 May 2021 21:41:05 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-34.three.co.id. [116.206.12.34])
        by smtp.gmail.com with ESMTPSA id e5sm6040075pgj.91.2021.05.07.21.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 May 2021 21:41:05 -0700 (PDT)
Subject: Re: Pain points in Git's patch flow
To:     Git Mailing List <git@vger.kernel.org>,
        Sebastian Schuberth <sschuberth@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        patchwork@lists.ozlabs.org
References: <YHaIBvl6Mf7ztJB3@google.com>
 <22a0a383-0ae1-c7d1-75f7-7dfdfe5fb504@gmail.com>
 <87fszn48lh.fsf@evledraar.gmail.com>
 <CAHGBnuOVmzzhgW6GanHBXNb22UW3P1m3i6PJnOUEhYPO76hH4g@mail.gmail.com>
 <20210419214921.afurkxy7oru6bny6@nitro.local>
 <20210508020855.GF3986@localhost>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <6f42d6e2-087a-4c95-1aa1-31ee871c06b4@gmail.com>
Date:   Sat, 8 May 2021 11:41:02 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210508020855.GF3986@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/05/21 09.08, dwh@linuxprogrammer.org wrote:

> Think about it like this. Right now, I could use an IMAP client to
> download all of my emails from GMail, store them in mbox files, then
> use the IMAP client to upload the email to Fastmail or SDF.org or some
> other email provider. Or better yet, I can install local tools for
> working with my email. The fact that email providers/tools are largely
> interchangeable and replacable--despite Google/Yahoo/Microsoft's best
> efforts--gives maximum power to users.

Well, I use Thunderbird because it supports Gmail accounts out of the box.
But I wish I could use Mutt or similar, alas Gmail requires that I need
to enable 2FA and s/<google account password>/<specific app password>/
in order to access Gmail via Mutt. I currently steer clear from 2FA, because
once upon a time in 2018 I screwed up (locked-out) from my older account,
which IMO mission-critical., for I couldn't pass all possible verification
methods for that. So I created new account one in about Día de Kartini
(Kartini's day).

And yes, Google/Yahoo/MS have webmail interface for their mail services
(Gmail/YahooMail/Outlook), but for purposes for sending to vger.kernel.org,
these above are rubbish because they genereated HTML emails, and vger hate
HTML emails.

-- 
An old man doll... just what I always wanted! - Clara
