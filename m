Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0955C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 17:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF8516101A
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 17:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242091AbhIIRvb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 13:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237255AbhIIRva (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 13:51:30 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16399C061574
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 10:50:21 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id w17so2169266qta.9
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 10:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JL/LbbOV3wPwxgZLyqXajE28KnmJIlmRkpljJSLOHW8=;
        b=nkE4UUITLEa0f22xbfR94JBoIFDdwhInNBjH7KWh0/ETssVNwhw5pp5dkvquiK8ScM
         MoWytPN2PAYc0NHwN9tXHDrdrfz25UYTzRwl2kWAPDkzaSmk6UrxYZ+MdxtFW4YXd6NL
         dwMa/HU6oSU5OpvTB7m3aDTdPAyO+2b40pBmIt09Im34CjhKZjbeSfRA8/SgK3mNoRbi
         ud7OkjuaggmGx6fQxFtCDCrGLq0nJzb28AYVUqvw1hoHW+2pYiP/vkvPcnsML7IaAmfT
         bMjwCk6+xZ+Du5afjRL/y/03v9xjwt/tWfxel2d7CHl3RLEuDHrh5VMn9MbLWgziXBj2
         fyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JL/LbbOV3wPwxgZLyqXajE28KnmJIlmRkpljJSLOHW8=;
        b=wFWOjW4vaiNDucA/XFqui/fTW8RGc9Shoc4+qp7eI733Sqpo7jpQ93Ap7kg4n8J918
         O/ooZNqoCIPZobHpI9t7CH/Ry4ZfmCuhVaxjplWIqr21Ea41bM0OUDD8bpBeUKO+hPiv
         BrIKzoCPlZDBHT/kQJThtjMbQoGIrcb8Y2x136iuyZU4qpbuaif0yGHmzV1Bzq+b2+E+
         0pex1j2Ds3j1fHcc+ec0JfiJPGVIl9zhy82poXicWWaDoJR1ztG1M1071aX5HrxOeuoF
         FvCIYzakniN8DuTWnTsi/VawOX3ZmbaSQKUy0ZU7+rAX1DHgG4bvAHGPebtyXoLZxfZu
         xsyg==
X-Gm-Message-State: AOAM530/ltxgI9Qjjw8Il17Tfg6E9Cn161j+slHrZEFNfBSndI72KPIM
        GQEjWnaHeKbkZopgMeDIzBk=
X-Google-Smtp-Source: ABdhPJxX6rjSoHMhUHUa4/RjY0y5N19+bUw/Ub4/zU4lWXO47zKTImxaHwSjk8dJtud8f2OKeg04iw==
X-Received: by 2002:ac8:51da:: with SMTP id d26mr4091030qtn.331.1631209820178;
        Thu, 09 Sep 2021 10:50:20 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id o23sm1515523qtq.7.2021.09.09.10.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 10:50:19 -0700 (PDT)
Subject: Re: [PATCH] Docs: web server must setenv GIT_PROTOCOL for v2
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Junio C Hamano <gitster@pobox.com>
References: <20210904151721.445117-1-konstantin@linuxfoundation.org>
 <YTOW352xtsbvJcKy@coredump.intra.peff.net>
 <20210907211128.mauwgxupbredgx7w@meerkat.local>
 <YTiVDo4m5B5RcfCg@coredump.intra.peff.net>
 <YTiXEEEs36NCEr9S@coredump.intra.peff.net>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <64a5aaf1-64af-3599-8520-ff3b55411e2a@gmail.com>
Date:   Thu, 9 Sep 2021 13:50:18 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YTiXEEEs36NCEr9S@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

Le 2021-09-08 à 06:57, Jeff King a écrit :
> On Wed, Sep 08, 2021 at 06:48:47AM -0400, Jeff King wrote:
> 
>> Both of the included examples here have been tested to work. The one for
>> lighttpd is a little less direct than I'd like, but I couldn't find a
>> way to directly set an environment variable to the value of a request
>> header. From my reading of the documentation, lighttpd will set
>> HTTP_GIT_PROTOCOL automatically, but git-http-backend looks only at
>> GIT_PROTOCOL. Arguably http-backend should do this translation itself.
> 
> So having discovered this, I kind of wonder if these documentation
> patches are barking up the wrong tree. There is no reason we would not
> want v2 to work out of the box (after all, it does for git://).
> 
> The patch below does that (and could replace both my and Konstantin's
> documentation patches).

I agree it's nice to make it work out of the box, without the web server
admin having to configure anything. But, I'm not sure we should completely
drop the documentation patches: your patch will only affect future versions
of git-http-backend, and users of previous versions will be left without
any documentation as to how to configure it for protocol v2. So I would think we should
keep the documentation patches, maybe with a mention "this should not be necessary
in Git 2.34 and later versions" or something like that (since your
commit message mentions that it "generally" should work like that depending
on the web servers).

> 
> This also makes me wonder if we should be documenting the use of
> AcceptEnv for ssh (which sadly I don't think we can make work
> out-of-the-box).

I think it would be a good idea to document it, yes. FWIW I found out about
it at https://docs.gitlab.com/ee/administration/git_protocol.html.

Cheers,
Philippe.
