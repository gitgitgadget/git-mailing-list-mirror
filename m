Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4595CC433B4
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 07:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB46C610E7
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 07:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhDBHEV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 03:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhDBHEU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 03:04:20 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5229AC0613E6
        for <git@vger.kernel.org>; Fri,  2 Apr 2021 00:04:20 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id p12so752643pgj.10
        for <git@vger.kernel.org>; Fri, 02 Apr 2021 00:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=fD54uoBjedNu6QoZcbDZdgWEMbhlMZgrljWlauLY270=;
        b=ZjpcXluAKTAEQcO1JI2Oyg1alc7uNanc/QJoESIL7j1CKM05kfD8OwMf1rffzWoXBC
         mHKUtTOdAinaddxQLxastiLEScEIo+CnD4AjlOTIHOjYVMhdptEfTYvh8Yw5XTuImpV7
         GOSm/bTv+5EPWhD0Id0EoUSDdHr1xbVT1JZEFbvysfBF4Y+SH1GFEdWDDsvaGVsEdefk
         h5qYxJbmgQXH9YkUJfG0O5qNl6UmUdyr5F330ItiouSML8QZHgCDbW0W2NkW8PIHgvbt
         5OWEEsey1SzcZNOpfmyqgtlmFJnXBx6KlX+Qybt1Xdg9sslIbmHiioe5WOe92gLz0SXX
         C/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fD54uoBjedNu6QoZcbDZdgWEMbhlMZgrljWlauLY270=;
        b=IH9VDAfL50pi1aio5PgKNOj5bxC8NRP8e7NC14Stx1kNHLq2bbxL5/fd/fSoQtR81C
         ofQkVK5ghzhJeMWCHAokvqiJzlOKJDyThIa7VeZ5oz0jZoWeeDe+o2b+qHhFl80/UJgS
         EK6uk0TIQkrJt0oFVXhFx1kaZ748lsIgNYO5FICAFLViTNQVMTbyR7ZV0hIxtEPETumN
         WA4aITG11DEsIXkNYPoFArGVLdFhjZVkcgtxCnfZGh2OKYZJJlsHECNdT2GBanoOxVKf
         J/Ws84mOeeJd+wx/Fa9J46BaxwnuGdeeCV9oCMrVFeLdYmPbT1UpTqlgob5p3TpfY4yX
         xFLQ==
X-Gm-Message-State: AOAM532Fpq7llp0GDBxNVnApDBjJM7yAPq4CTeoLJzDN8Oja5Z8HsVPI
        rR2i7dW6tSJoE+sSCW5asoaBMp6HoNALHOQ4
X-Google-Smtp-Source: ABdhPJxAK+W4gPsS8dQ7z8rxT4GGX5/gwQGfyiu5x54N0OegtP0rG8zWU6sm2WG3GjnMmd4b1Xsa6g==
X-Received: by 2002:a63:ce03:: with SMTP id y3mr10723091pgf.414.1617347059485;
        Fri, 02 Apr 2021 00:04:19 -0700 (PDT)
Received: from [192.168.10.22] ([125.21.249.98])
        by smtp.gmail.com with ESMTPSA id bg16sm7050238pjb.43.2021.04.02.00.04.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 00:04:19 -0700 (PDT)
Subject: Re: [GSoC] Draft Proposal (Convert submodule to builtin)
To:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
References: <195bf718-6226-43c9-8c58-167388d3d99b@gmail.com>
 <f5b9ea24-e2f7-6c54-b4ff-86cef27527f7@gmail.com>
 <CAP8UFD1PC=vQCXLLoECPzFc8BGGfQxptHE5+Et11F-=3-twZYg@mail.gmail.com>
From:   Chinmoy Chakraborty <chinmoy12c@gmail.com>
Message-ID: <5f4be1d0-0cf2-b39a-b4ca-c71b1676aecd@gmail.com>
Date:   Fri, 2 Apr 2021 12:35:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD1PC=vQCXLLoECPzFc8BGGfQxptHE5+Et11F-=3-twZYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 4/2/21 12:01 PM, Christian Couder wrote:
> I agree that proposals should be sent to the mailing list in a textual
> format inline. It's ok if you also send a link to a better formatted
> version of your proposal, so that people who prefer to read the better
> formatted version can do so. It's ok too, of course, if the final
> version uploaded into the GSoC web site is the better formatted
> version.
>
> Sending the textual version to the mailing list inline could make it
> easier for people who want to comment and discuss it, like patches
> are, which will help you make a better proposal. Later it might also
> help people searching the mailing list.
>
> Best,
> Christian.


Sure, I'll send a textual format of the proposal as well.

Also, I've submitted the draft proposal through the GSoC website

as well. Please have a look through it and suggest any required

changes :).


Thanks.

