Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3FEC433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 21:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236339AbiGRVzz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 17:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbiGRVzy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 17:55:54 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B75427FD9
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 14:55:53 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-10bf634bc50so27557852fac.3
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 14:55:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kRNtBsLvM6SFOcDPp1jRGPyNVg5xAnEj54efzyJ/K0I=;
        b=zgCfvuG29ixQkuK+bdFOOzcshCIEYvmoaKpkqe56smEcTdel3Ww2vKlM0bkZoSRJtl
         oTQb+RpKoi/InK2801NJDFgQn7Dfn1BH7W+Zo7vqJbCoC6d8lb5grKC+pVKA0OxOwq2C
         6oaFMF1EZ+1Or/bRHZop+n8FJqQObIaPND4FjTBdipWqAoPGpM7pLyAN/PRs5iSWcM0z
         D8voXsi3nvtmDuChY2Ffiu++W8G4yduNNQ+MTo/uyQj3vhaLy14HMB2+tr3Ep08K/27S
         wr3auFROEQoNbUUKBnIUVmxVX5l7Ng4e69zDONSN4uOmXt9B42+khgdTCEtSNi2OuRWi
         4tMQ==
X-Gm-Message-State: AJIora9txPFmrYwCp2V30Z5KPaPIgrQnpc7iJkfYAWhktY9cbmTm3Whc
        VacPGqzTEv0v2pU/609u+wI=
X-Google-Smtp-Source: AGRyM1sRb2mQ7RFfcJmBP8mnAYRR7cHmAVI7EKfVoqF065ThI2HDGqweory5YQpIP+UwjJN0y2F94A==
X-Received: by 2002:a05:6808:118a:b0:322:35d7:77f2 with SMTP id j10-20020a056808118a00b0032235d777f2mr17961423oil.79.1658181352838;
        Mon, 18 Jul 2022 14:55:52 -0700 (PDT)
Received: from [10.0.0.141] (c-174-62-43-211.hsd1.nm.comcast.net. [174.62.43.211])
        by smtp.gmail.com with ESMTPSA id cb1-20020a056830618100b00616c46f6daasm5570888otb.31.2022.07.18.14.55.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 14:55:52 -0700 (PDT)
Message-ID: <d4a77fd1-6be7-6466-8c94-6e2552184094@kinzelman.com>
Date:   Mon, 18 Jul 2022 15:55:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: paul@kinzelman.com
Subject: Re: Possible git bug when working with Microsoft Mapped drives
Content-Language: en-US
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org
References: <f946c577-d3d6-212c-cec5-a6c63856b77d@kinzelman.com>
 <b5931787-3589-102f-cfeb-caeb8a07e149@jeffhostetler.com>
 <YtXS1s66fw/UCvLU@tapette.crustytoothpaste.net>
From:   Paul Kinzelman <paul@kinzelman.com>
In-Reply-To: <YtXS1s66fw/UCvLU@tapette.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you! Jeff was right on, but I didn't want to create extra noise
on the elist, so I replied just to him.

His suggestion of the --no-hardlinks
caused it to work!

Might be good to test to see if a drive letter is on a remote system
and do that automagically.

On 7/18/2022 3:38 PM, brian m. carlson wrote:
> On 2022-07-18 at 20:46:44, Jeff Hostetler wrote:
>> On 7/18/22 4:28 PM, Paul Kinzelman wrote:
>>> I'm using git version 2.37.1.windows.1 and Windows 10
>>>
>>> I've got two systems which are miles apart and so are not on the same
>>> LAN, and I have connected them together using the ui.com VPN and M$
>>> RDP/TSclient. I mapped each system's C: drive to be accessed by the
>>> other system as Drive X: and I can transfer files back and forth
>>> initiated on each system.
>>>
>>> I can also see all the repository files on the source system, including
>>> the tree of files under the .git directory. Note I had to unhide the
>>> .git folder so that I could see that folder from the other system.
>>>
>>> However, when I run 'git clone' on one system to get the repository from
>>> the other system, git seems to think the repository on the other
>>> system is empty when it's not. As I said, I can even do a directory
>>> and see all the other files.
>> I can't duplicate your setup, so I'll just speculate out loud
>> here.  I have to wonder if the "X:" drive letters are tricking
>> Git to thinking that the remote instance is actually local and
>> Git is trying to use some shortcuts. (For example, it might
>> hardlink them rather than copy them on Linux.)
>>
>> So I'm wondering if "--no-local" or "--no-hardlinks" or using
>> a file URL rather than a pathname might make it behave differently.
> It may also be the case that the remote file system lacks some
> functionality that Git needs.  For example, Windows can support mapping
> HTTP DAV resources as drives, but the DAV protocol is incapable of
> providing certain operations that Git expects of a file system (Git
> roughly needs something that's POSIX compliant, but can paper over case
> insensitivity) and thus such a disk simply can't work with Git.
>
> This may end up looking like the file system is empty because, for
> example, the function to query directory contents may return an error.
> The contents may not actually be empty, but because they cannot be
> enumerated in the way Git needs them to be, it appears that way.
>
> Again, I don't know if this is the case here, but you're the second
> person recently to have seen problems with using RDP for this purpose.
> You may wish to try SFTP, which should work (at least it does for Unix
> systems), or possibly SMB/CIFS (which may or may not work, but I believe
> it typically does).

