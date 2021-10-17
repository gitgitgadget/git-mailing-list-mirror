Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24A0C433F5
	for <git@archiver.kernel.org>; Sun, 17 Oct 2021 00:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4663610D2
	for <git@archiver.kernel.org>; Sun, 17 Oct 2021 00:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241263AbhJQAcP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Oct 2021 20:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233536AbhJQAcO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Oct 2021 20:32:14 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E89C061765
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 17:30:05 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id a13so2390919qkg.11
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 17:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=4bV8YrTm5Y+EOvcEnSieI0VHIalj8a2u4bLUGmWUd84=;
        b=L+Ln8G6c+DxqT4RLrURbLJNMCXmyqwQfiZBV2ZJfQx5GtlJYzbsZH2LADO4VbSdjFV
         Ho1YXcAtyqVCfX62gxOjfhSQLEbQ2QHD99UR10Xz7KbGwjs00dMoturdmr1JGZfnm4ol
         Ewo9DsKBKUGcMkGd9DVl1C1WEPU9HMdj+zEN3kenpTbAdf4jpgd/0myaBnX+TaPE0fDy
         eni8gk1aen1OXE+/au74KUJTX+PwggMRgL9kHbiareg7W7IeYN/i0RkwsUwQGl9ZmpiW
         IUDOmSheBYHnvTs23kbk8zzWCZoz4FEr5GrVhYUSuRR2ywSq2jtJwJO6QFWTEI3mBKDr
         Cq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4bV8YrTm5Y+EOvcEnSieI0VHIalj8a2u4bLUGmWUd84=;
        b=ZkKL9ejuR0PRD4jFSrqj147KoZXJWQGo0nJ7XdqhXs35c3WaVJpsYdn1scaZIw/Bir
         +sKI2oVn6jOP+F5s3rllZfS/GNJsWDdr3PF+g5mjcDhOsfNP9YkU7bTqjEO5HbTqy5TE
         UqMipBKS68NEvNFq4++bb1R8eQQ+hO0LYJhlR+vxVJZQ8avU953kJSLJH+8VzEzCPrV9
         qlPlo2Z3/iuJp4HHCurc+I0PaV06ZUu61j58cDcTrIAlNg2Z83xU4Ry3mib8bBQR43LQ
         wy0HWpqtD65XyJsqD9CVtnaKu5SHMpD2ezHzc7ZzKNK+KaRPckCVMrPTupasPYT+NOyj
         Uo7w==
X-Gm-Message-State: AOAM533NjGWkHA4d26/E1sTMQ/ejVAd3NC9ZITOcVdrlnneFPmCTt1mO
        9FLBre2KIwvCzVHlJ5TYCijhlyLQdXY=
X-Google-Smtp-Source: ABdhPJzLXJ/me7X3TRqlv9W3lAawgylJtzg/ARrjSnDVyHu21e3Dm5Fm4s9mZBCqo6CSGtq4y+gEcg==
X-Received: by 2002:a37:9dca:: with SMTP id g193mr16275219qke.124.1634430604566;
        Sat, 16 Oct 2021 17:30:04 -0700 (PDT)
Received: from [192.168.50.110] (modemcable214.63-201-24.mc.videotron.ca. [24.201.63.214])
        by smtp.gmail.com with ESMTPSA id d24sm4407608qtq.95.2021.10.16.17.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Oct 2021 17:30:03 -0700 (PDT)
Subject: Re: Possible bug with checkout and submodules
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Adam Hutchings <adam.abahot@gmail.com>, git@vger.kernel.org
References: <CADTYju0PpHHG1=S3N4MDWk5yZqb5t_KUhiDvZ_2i-vXFUT_LDw@mail.gmail.com>
 <YWsffmtRQKQGxkiR@camp.crustytoothpaste.net>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <0d8ade7b-e5af-88ec-3e33-96d6c356b714@gmail.com>
Date:   Sat, 16 Oct 2021 20:30:02 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YWsffmtRQKQGxkiR@camp.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Adam,

Le 2021-10-16 à 14:52, brian m. carlson a écrit :
> On 2021-10-16 at 18:44:04, Adam Hutchings wrote:
>> Hi,
>>
>> I may have found a bug in Git but I'm not sure if it's intentional or not. I
>>
>> checked out to a new branch to test a PR on my repo, and the PR added a
>>
>> submodule. I init'ed and updated the submodule, and when I was done testing, I
>>
>> went back to my main branch. However, it did not remove the submodule, and
>>
>> produced this message:
>>
>>
>> ```
>>
>> $ git checkout main
>>
>> warning: unable to rmdir 'glfw': Directory not empty
>>
>> Switched to branch 'main'
>>
>> $
>>
>> ```
>>
>>
>> A friend of mine has managed to reproduce this behavior. We believe the expected
>>
>> outcome is to remove the submodule folder, but this does not seem to happen. Is
>>
>> this intentional?
> 
> This is intentional.  It may be that the submodule has data that's
> ignored, it could have local changes, or it could have additional
> unpushed history, any of which would probably be data users might not
> want to lose.  As a result, we don't remove the directory unless the
> user has run "git submodule deinit".
> 

... or unless you run 'git checkout --recurse-submodules', or just
'git checkout' and you have 'submodule.recurse' set to true in your configuration.

Cheers,
Philippe.
