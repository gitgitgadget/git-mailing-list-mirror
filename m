Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC190C4332F
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 00:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiKBAmA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 20:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiKBAl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 20:41:59 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0111705F
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 17:41:58 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id hh9so10423002qtb.13
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 17:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2t8+MuuWKjdHxe6zeG0FQd0wBex6rC4kpzgqRUHB18=;
        b=HfYQZQ79yQJpXwMK/D0mVwyKbUlhvhzwPHnvSWlYgl8ICYWHUQr3tqqAc71ChIWKlP
         c6yyT3KDweZO3wO0hlqabTR7roNblra0Z7kqIFg4RSXUBBjL03p5f2Q5gQjxARo02/QQ
         gOj/X/v+Ote360qjpiUR/Lbfzeop9r90IyL72ChrAo7JJI4Nnn0pzSSnSxCBmYbjIUu4
         cv2v7QfDRFKmatFCmjhVRximVfMvB/kHHQaU67sdVYwx8FBFaEMUH+DIpYploFtt9xW2
         0RCXST6LRmbxUQnkn7p8LvjmMbGE0V4+Nrl2iDgOnXg+sWro0wx9pQSBy1nJZ/8hM3Li
         b/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P2t8+MuuWKjdHxe6zeG0FQd0wBex6rC4kpzgqRUHB18=;
        b=J7CTwM1a7eRbrLGf6Bspn4dewKY8sZI5LzMFewI2lzCcXmZKBIvfAdMWJWi1wK1Z+5
         Gt2C6iHl0pjY1OMQFQXMsWzvRR1xCmI0MAXyp4t7AgpHLAc7WVRA4C7sCQRIwWV2mA9W
         JDVIJ2OzkO0zvXqUZMQpxY9dK3eDlbm+VTm9BTvm/OOZLAschDeSB/dlXH0P2trmv7yF
         jTkWbhG/HIqcF6ybUElBv2ZFsIHcOekcZbRdGhFokx9yLhOsUg/XXiT32pMjQJJNeiNE
         jr12la1R5VYb6tYdQhAaqOXAoQPaJAegiM+U8tzjivFE6MKOyxFUuG5dnEvrtADf4ME3
         irvg==
X-Gm-Message-State: ACrzQf3fi7JrQhL2rjxAnIloLEfedUH9VNjl78swbmMoUxSYEGb08e44
        zrDvVsomkiSBDDDqBzb8S8MDh1Qat5U=
X-Google-Smtp-Source: AMsMyM41qEUagBTb5ydObBr2uEo+LAfT6VsIL9F6gyTk8lZtUsmwTECj29d9xk9NiB+jYivD7XLBlQ==
X-Received: by 2002:a05:622a:2282:b0:3a5:2575:ce7e with SMTP id ay2-20020a05622a228200b003a52575ce7emr11183191qtb.604.1667349717451;
        Tue, 01 Nov 2022 17:41:57 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id f20-20020a05620a409400b006bbf85cad0fsm7695171qko.20.2022.11.01.17.41.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 17:41:56 -0700 (PDT)
Subject: Re: Git Bug Report: out of memory using git tag
To:     Jeff King <peff@peff.net>, Martin Englund <martin@englund.nu>
Cc:     git@vger.kernel.org
References: <CABYbkvP=fMmaFUD3bQbeQ-XKiMSP6g-u0p7Vq1Qt_K5=D5WJ+A@mail.gmail.com>
 <Y2EPgICMsmzKvCC8@coredump.intra.peff.net>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <38d50c30-c6a3-5989-6e01-47c5467d9d6b@gmail.com>
Date:   Tue, 1 Nov 2022 20:41:55 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Y2EPgICMsmzKvCC8@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Le 2022-11-01 à 08:22, Jeff King a écrit :
> On Fri, Oct 28, 2022 at 03:29:33PM -0700, Martin Englund wrote:
> 
>> What did you do before the bug happened? (Steps to reproduce your issue)
>> I created a signed tag (git tag -s) using a ssh-agent key and then ran
>> git tag -l --format '%(contents:body)' v0.6.1
>>
>> What did you expect to happen? (Expected behavior)
>> I get the output
>>
>> What happened instead? (Actual behavior)
>> fatal: Out of memory, malloc failed (tried to allocate
>> 18446744073709551266 bytes)
> 
> Thanks for the report. This looks like pointer or size_t arithmetic that
> has gone negative. Here's a minimal reproduction:
> 
>   {
>     echo subject
>     echo "-----BEGIN PGP SIGNATURE-----"
>   } | git tag -F - foo
>   git tag -l --format='%(contents:body)' foo
> 
> The issue isn't unique to pgp signatures; the problem is in the parsing
> done by ref-filter's find_subpos(), so any signature type exhibits the
> problem. At the end of that function we do:
> 
>       *nonsiglen = sigstart - buf;
> 
> but "buf" has moved beyond "sigstart". Presumably because it uses
> strstr() to look for end-of-line in buf. Since there isn't one before
> the signature begins, we go to the end of the signature.
> 
> The bug bisects to 9f75ce3d8f (ref-filter: handle CRLF at end-of-line
> more gracefully, 2020-10-29). Before then, I think our loop was careful
> about moving past the start of the signature. Author cc'd.
> 

Thanks for letting me know, and for the simple reproducer, that's very useful.
I'll try to find time to fix that this week, but can't promise anything.

Phil.
