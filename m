Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BF5C27C40
	for <git@archiver.kernel.org>; Wed, 23 Aug 2023 21:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237989AbjHWVr4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Aug 2023 17:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238475AbjHWVre (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2023 17:47:34 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77520DB
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 14:47:32 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5922380064bso35581557b3.2
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 14:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692827251; x=1693432051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gOuw8KXMnCWJo5Zn4GCJq1veEStcwSt1iIYH01iuEgs=;
        b=4VgfxNxndht7xAsFbzhANEZhIIORMhYB7oAtqz+3ltDeMt0jfaNOcAab9qRHHJPj+Z
         X32siPOpBQXYvwPRwqK+qxwlpvCS0xd++5GpMh2BdD2Ix5QKCz+vsa/7G36DV3BTpMXq
         TF6VcjSQ6BRcjfX61dKCcsK1xzhbcy2tjLF/BotDWgmv1eSl/akME1RRrOX6AW1MTabt
         UnBEAAhsyJdIkqm2OIl72NiJLGxyK4jV3rDlsgRHmKu/HI2/eClGxx7CXdjZrj0RzzbI
         M19UrNiwEIhZOOhchE9lLX4fc0k46kxtNQ2CagMcTVQlWmE+AHgs2FEC00ZwM+7u8JDZ
         w5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692827251; x=1693432051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOuw8KXMnCWJo5Zn4GCJq1veEStcwSt1iIYH01iuEgs=;
        b=GfvoJ24zKPLE74UDLe59x5OP7XAlu4KZp9rg/HUp07YraJTBn39Fdf2qEzUgHi/zaO
         3u4kEMLDrtPKBWtKNeMz7h5CKivCCBJsKVy9kLzuBmBdB7PvoiigE/KVGPJC/qOftjNY
         TTOcHJ4V2aNqVhZOdJR9EAwXE6iu+Ex0AQGEv3HeZKVBvecbPTjiI7vW0lCCGlK3mU/E
         pxP/G+8KrbNRs8pK98PHgJZSyRbG64EXag6DLU74elS+AaGHK+86fS2h7pjP9vWhAxZt
         ROklxYwVN8xZkqMt9cnG+oDv4d8CVAcZw6CVWkBVkYq/z7YcBOOOVqm8/lyYgMRjcxhT
         JhGg==
X-Gm-Message-State: AOJu0Yyfcl59QZNIGdaZGpza7Ssf5H/I5T4RXUDaE/NfzOS4P25V5o4N
        hKZH7GObUDFZMYAww7uhoLLOSfmjGa6eSx9SXhvzfw==
X-Google-Smtp-Source: AGHT+IHRJ2QYlCP6XjBRE8kDNVoGFjwBd4D6O5ea28nMzjzZ+ilyg6wBOkUKUml++Kt+F22lGS0v6g==
X-Received: by 2002:a0d:ca0b:0:b0:58d:f1fe:5954 with SMTP id m11-20020a0dca0b000000b0058df1fe5954mr14333398ywd.32.1692827251607;
        Wed, 23 Aug 2023 14:47:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x84-20020a0dd557000000b005869f734036sm3571414ywd.19.2023.08.23.14.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 14:47:30 -0700 (PDT)
Date:   Wed, 23 Aug 2023 17:47:29 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: 2.43 release date adjustment?
Message-ID: <ZOZ+cbkrXsEcQyaW@nand.local>
References: <ZOYdG8RtPIgymtBV@nand.local>
 <xmqqpm3dg27i.fsf@gitster.g>
 <ZOZR0jesPpCDNbRj@nand.local>
 <xmqqh6ope8v6.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh6ope8v6.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 23, 2023 at 02:39:41PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Perhaps then we should shorten this cycle by a week and plan to cut the
> > release on 2023-11-13.
>
> I still do not see the point.  Do you mean you do not want to work
> between 13th to 17th of November that would be the "final regression
> hunt in -rc2" week?

That wasn't quite what I was saying, but maybe I am just confused by
what you mean.

I am suggesting cutting the release on the 13th of November instead of
the 20th so that we have folks online for the first week after the
release tag is pushed out to fix any brown-paper-bag issues.

Then, after the release is no longer fresh, we can expect many US
developers to take the week of the 20th off.

> If you have a specific reason to expect a post-release bug hunt,
> that would change the equation, but otherwise, I am not sure what
> you are trying to achieve, compared to the original plan to tag on
> 20th, give developers week off after the release for Thanksgiving or
> whatever the excuse to take a week off in your parts of the world.

No specific reason to expect bugs. Just trying to line things up so that
we have (a) people around when the release is tagged, and (b) don't have
a release hanging over our heads either during or immediately after a
week when most US developers are offline.

Thanks,
Taylor
