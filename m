Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC419C43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 10:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDFB72070A
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 10:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWXjpLNr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgCZKsm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 06:48:42 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40937 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbgCZKsm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 06:48:42 -0400
Received: by mail-ot1-f66.google.com with SMTP id e19so5296072otj.7
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 03:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=I2yvodq28avzTcEjaNe1jT++51deIGw9rJoqIeDWWtc=;
        b=SWXjpLNrfOTkw4kTBnPLn3G83R9rLT1AyAIsmIEgkWqgG7AvNK3QNfBbzcRs3Q/5kD
         SmQJAGP3ocUPjKvweyGDDPes52P5l5LX36rtF+6BshwLq2EQ6cKb0gNwj2fPTlNpfEwa
         uxCGNWq/n81wx25WZbZZ7UXOsLFaBBS0wudW2L9shTwhWTJa4T/ftHta0S8WfjjO1LsK
         mS7AIrKydt3kxEw6cgF8NfcK5HsrmIr+pyGPhSvk6HVrFtKKeJrURsBnY4mnj1/YVwVc
         /AbvGkR5p0tBB5XIiOKFpfiLLqb/yF8w9UxeKmrvTrK4aCMPMfMuN1G/i4L8xSTya1gf
         T75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I2yvodq28avzTcEjaNe1jT++51deIGw9rJoqIeDWWtc=;
        b=rONm8QO8a/WnuwNc7j0edTAiqIGMeOpRS5WAd4GQOa0oUP0NCdL3EmwlWXR1nQ1ZG7
         /QlbsyYhQ2C5CLlxPuzHE3s6oxlYBF0eJUhFD6OggoSbRKZB+6CBY2wcItFpgXS1DVil
         U04EqaZELDNWJPu1Ww59INcjSJrjSWZUBbCGqDZbVp8G4O1VewnyGl/xw7Siwi650KyZ
         S5P0LBz6jbODvo/YvCPF+8TL61jUFVQKPifxvDwkKl/+AhbxPLBfWrCtyy2jIPOxppyu
         6TTTUZ2SCUNiyrWUPKgOWxNaFhf4yVtkiYxulawJxOXiiqJeMXzfSQto8aKoos0QT4bY
         GO5A==
X-Gm-Message-State: ANhLgQ38X1U647UGFXubYzUzpGrwjdDesmAeDIybv5luOm3g5eQ9g2fm
        bmnRotJZKv2/iRUtuDCppYqUiYVQd4c=
X-Google-Smtp-Source: ADFU+vv6hkiAZ2zaD1OL/ALu29drVrieCIP+ByJfiIKLGnflWSXPFYeDWAW29S3uF8klz/xG/rA32Q==
X-Received: by 2002:a9d:2c64:: with SMTP id f91mr6034371otb.17.1585219719656;
        Thu, 26 Mar 2020 03:48:39 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id j5sm526392otl.71.2020.03.26.03.48.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 03:48:38 -0700 (PDT)
Subject: Re: [PATCH] p5310: stop timing non-bitmap pack-to-disk
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20200326075436.GA2199958@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <cf64c47a-481e-3802-3ce6-a2a583cd7c75@gmail.com>
Date:   Thu, 26 Mar 2020 06:48:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <20200326075436.GA2199958@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/26/2020 3:54 AM, Jeff King wrote:
> Commit 645c432d61 (pack-objects: use reachability bitmap index when
> generating non-stdout pack, 2016-09-10) added two timing tests for
> packing to an on-disk file, both with and without bitmaps. However, the
> non-bitmap one isn't interesting to have as part of p5310's regression
> suite. It _could_ be used as a baseline to show off the improvement in
> the bitmap case, but:
> 
>   - the point of the t/perf suite is to find performance regressions,
>     and it won't help with that. We don't compare the numbers between
>     two tests (which the perf suite has no idea are even related), and
>     any change in its numbers would have nothing to do with bitmaps.

This does make me think if there is a way to adjust "./run" to test two
different config settings or command-line options instead of just two
different build versions. Perhaps something like

 ./run "HEAD -c core.commitGraph=true" "HEAD -c core.commitGraph=false" -- p4200-line-log.sh

But that's just musing on my part.

>   - it did show off the improvement in the commit message of 645c432d61,
>     but it wasn't even necessary there. The bitmap case already shows an
>     improvement (because before the patch, it behaved the same as the
>     non-bitmap case), and the perf suite is even able to show the
>     difference between the before and after measurements.
> 
> On top of that, it's one of the most expensive tests in the suite,
> clocking in around 60s for linux.git on my machine (as compared to 16s
> for the bitmapped version). And by default when using "./run", we'd run
> it three times!
> 
> So let's just drop it. It's not useful and is adding minutes to perf
> runs.

I agree with your reasoning. This is not a critical path for clients,
and all servers should be using bitmaps.

Thanks,
-Stolee
