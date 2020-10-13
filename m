Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85716C433E7
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 08:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28CDB20E65
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 08:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7efLxIl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbgJMIAs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 04:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727744AbgJMIAs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 04:00:48 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB946C0613D0
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 01:00:47 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id e2so20758627wme.1
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 01:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=7Vb+Go24lm9AskSfiZTgOGxIq1QEdEV74LC1XqDJ1qE=;
        b=i7efLxIlEbPvMlUQnpsZGCJReTIWT5O2v278t1vV+m7n8Z2D1lCi7t1Y4KJAqwaxIy
         0xLlTfTEexTdQQmpWfOBhx4hs5sdkVjh2QU/c8mH4QMKjpTbuNKnYk6kZOaSzYEwBZWD
         8qUQe26Z6gyJvUaZo3RFkda0aAL1D607zQQf6VEfgOOqCupsFmUsJfG0d0KGWwIqTssC
         kxzewptpogyQaIV4NoP2wZzeO6OlaeyIjE9nsmk/26+GPx3VYtlDF3cPC10On0q3fV8a
         czswvsD0KSauYyw+e0IfGzXGwAz1kwAFPCmQlNAl2nXJmjO5teLQjHked6A5Y7Ei46HU
         jHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7Vb+Go24lm9AskSfiZTgOGxIq1QEdEV74LC1XqDJ1qE=;
        b=rWgLdvQefa899YqihyRT2s2UCrQWMmTywyRkW29WzM0MuNOKX2GuIRGgo5fdc0y1ej
         YPAat/LXZiBBfBcA9W9dNSb9CCpyRHFoCsONc0qCMVt+cxG9GSXPANxNAR2Yz4CKkyom
         V6Xeykrccuffp/XiheZVwqnDyPKlEskLew6okyaMdFeDCupndCcGo3f8JjKufiLL8RJc
         GtgQTzml3KmzftJtwZ9OABf6S3eLo3qgKil6zzJ9Vjr9W4tuYz1PfLxd0GkA2IvPsQb/
         hZ9hi9Fq91Sav64qIUttdD27Y5lF3kdSEHTJXq7I84+2hRh2vGXU7cDMBHSvs4SSJkXF
         fojQ==
X-Gm-Message-State: AOAM530C8tAgy7SjYM0O8nM6lI7xRsxIemyJ60CjY/6hV3oNl07RwZbf
        OBJxd2svMYULfjrXbg6XWywfoqm+cku59g==
X-Google-Smtp-Source: ABdhPJxDqr2oqrFZbpLOE2ueItyU1JmZABS9S+IrOGj/PqpqJewLgwn5OLsyo8UOzswebRxJumRPFw==
X-Received: by 2002:a1c:5a06:: with SMTP id o6mr14770924wmb.181.1602576045631;
        Tue, 13 Oct 2020 01:00:45 -0700 (PDT)
Received: from ?IPv6:2001:470:6389:0:74a7:785a:816e:5c16? ([2001:470:6389:0:74a7:785a:816e:5c16])
        by smtp.gmail.com with ESMTPSA id w1sm28117454wrp.95.2020.10.13.01.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 01:00:44 -0700 (PDT)
Subject: Re: bug report: gitk crashes on git commit with emoji (utf-8)
To:     Peter Oberndorfer <kumbayo84@arcor.de>, git@vger.kernel.org
References: <1e06bde8-ae70-2653-5112-c97c9ee021da@gmail.com>
 <3318fdd6-5709-1d3c-64d8-01d029803635@arcor.de>
From:   Tomek Mrugalski <tomasz.mrugalski@gmail.com>
Message-ID: <13bc5c41-8989-5551-51ba-eec30b59900c@gmail.com>
Date:   Tue, 13 Oct 2020 10:00:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3318fdd6-5709-1d3c-64d8-01d029803635@arcor.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11.10.2020 13:47, Peter Oberndorfer wrote:
>> $ ~/devel-ssd/git/gitk-git/gitk X Error of failed request:
>> BadLength (poly request too large or internal Xlib length error) 
>> Major opcode of failed request:  139 (RENDER) Minor opcode of
>> failed request:  20 (RenderAddGlyphs) Serial number of failed
>> request:  3065 Current serial number in output stream:  3148
> 
>> Is there a workaround I could try?
>> 
> I managed to work around this problem by installing the Ubuntu
> package 'fonts-symbola'.
Hi Peter,

Yes, the workaround works on 2.28 on ubuntu 20.04.

> Testing with your repository, the Emoji is still not displayed
> correctly but gitk does not crash anymore.
> 
> This issue (and the workaround) seems to be tracked at 
> https://bugs.launchpad.net/ubuntu/+source/git/+bug/1852985
Uh, missed that. Thanks for the pointer.

Hmm. It seems this is very dependent on what kind of fonts are in the
system and the lib could crash. You may possibly consider implementing
some sort of --dont-display-utf8 option. Or perhaps waiting for the
xlib bug to be fixed is less involving option.

Anyway, I can again use gitk.

Thanks again for this great software.

Tomek
