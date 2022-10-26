Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF45C433FE
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 21:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbiJZV07 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 17:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbiJZV06 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 17:26:58 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FB77B5BC
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 14:26:57 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id cr19so11081783qtb.0
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 14:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W5cF/ChoOfo8K9iROQ8phCW6CaAex46mWsjj1vArtV4=;
        b=o4yPm38eb5cZvQ+EzahTVXEgiE3OwIpFI58jPfFtvxMr7r/ozRK0gLhgnAV1hbP7x7
         wVY+1+x+MwdEgI6gFuumvOhQ7q+oXjJIPV20RN/Kslzs5eCJvYTZhobmXcvAsVFC446N
         Swd3PISHpItazhUU33wLy1I1oP5/TcANC8FuKs8B90YtTL4d2loyVyc9QPsLH6OzKPIX
         f93h1lByawoTdz32qkq52mAYzkg1WlVU9lpmpCFRZvaZNDFkfRKwuJi1WechwZRmWTGR
         Ek0LDwJCNpE9rbYlo1e6toN/h+FK8j81Ckr7zquu+t78hfadFyktT66DmNeXDrus0RFF
         AGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W5cF/ChoOfo8K9iROQ8phCW6CaAex46mWsjj1vArtV4=;
        b=cIOrCGzej+Tx9/iIOpswL9DU4yvLbnkX4oelClLXLgSGfdtdHQcvUVwRWdXBaVSM8A
         u9ea1VIrB+Bw8n9gNBHrc1Rk+NQ8idde/mqAReStlUKOQgYtWh18Xy1T/9Aur8yqH3/7
         QyhjhGjCGAeXlvA2i49Au2QFiI+fEywvYsuLxXvszCpl3WECSRrUN1U3jVllYbL4GFXM
         bVOyeheqrVyEmhSPMb1/JLCFwFlNRSuM/r+AKB66XB+fHQN9LOo33kD1GFUz76ZeZDSa
         nBrekhjcWLnG6KwEoN/1CkkqZVJddjMyOawztR+qvqCuQmFmXi3EuX8FYHyQeLR0UUVv
         aLAQ==
X-Gm-Message-State: ACrzQf0XyTNMdP/pKgVxDgcuexxo0fm68kYgQRZysURNrqzAKEz/hDG5
        fJq7hg6T1QZjTJBR/TlPfL0=
X-Google-Smtp-Source: AMsMyM5TdHVQtoDfOIh16nRzhL8wPQBn3K3tsJO8qTMEluj5XU58cLHbGptsGfcumQPlJhfcAJ6OgA==
X-Received: by 2002:a05:622a:4c8:b0:39c:d6d2:32f7 with SMTP id q8-20020a05622a04c800b0039cd6d232f7mr37952374qtx.517.1666819616563;
        Wed, 26 Oct 2022 14:26:56 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id o19-20020a05620a2a1300b006ee9d734479sm4796225qkp.33.2022.10.26.14.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 14:26:56 -0700 (PDT)
Subject: Re: [PATCH 9/9] subtree: fix split after annotated tag was squashed
 merged
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Luke Shumaker <lukeshu@datawire.io>,
        Thomas Koutcher <thomas.koutcher@online.fr>,
        James Limbouris <james@digitalmatter.com>
References: <pull.1390.git.1666365219.gitgitgadget@gmail.com>
 <86a842d50345f6d4d0b16c78d565474be6f8068a.1666365220.git.gitgitgadget@gmail.com>
 <221021.86mt9pdtcw.gmgdl@evledraar.gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <b83b8c41-07c9-ba5a-93a0-ed0ae4c9d3cd@gmail.com>
Date:   Wed, 26 Oct 2022 17:26:55 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <221021.86mt9pdtcw.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 2022-10-21 à 12:37, Ævar Arnfjörð Bjarmason a écrit :
> 
> On Fri, Oct 21 2022, Philippe Blain via GitGitGadget wrote:
> 
>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>
>> The previous commit fixed a failure in 'git subtree merge --squash' when
>> the previous squash-merge merged an annotated tag of the subtree
>> repository which is missing locally.
>>
>> The same failure happens in 'git subtree split', either directly or when
>> called by 'git subtree push', under the same circumstances: 'cmd_split'
>> invokes 'find_existing_splits', which loops through previous commits and
>> invokes 'git rev-parse' (via 'process_subtree_split_trailer') on the
>> value of any 'git subtree-split' trailer it finds. This fails if this
>> value is the hash of an annotated tag which is missing locally.
>>
>> Add a new optional argument 'repository' to 'cmd_split' and
>> 'find_existing_splits', and invoke 'cmd_split' with that argument from
>> 'cmd_push'. This allows 'process_subtree_split_trailer' to try to fetch
>> the missing tag from the 'repository' if it's not available locally,
>> mirroring the new behaviour of 'git subtree pull' and 'git subtree
>> merge'.
>>
>> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
>> ---
>>  contrib/subtree/git-subtree.sh     | 26 ++++++++++++++++++--------
>>  contrib/subtree/git-subtree.txt    |  7 ++++++-
>>  contrib/subtree/t/t7900-subtree.sh | 12 ++++++++++++
>>  3 files changed, 36 insertions(+), 9 deletions(-)
>>
>> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
>> index 2c67989fe8a..10c9c87839a 100755
>> --- a/contrib/subtree/git-subtree.sh
>> +++ b/contrib/subtree/git-subtree.sh
>> @@ -453,14 +453,19 @@ find_latest_squash () {
>>  	done || exit $?
>>  }
>>  
>> -# Usage: find_existing_splits DIR REV
>> +# Usage: find_existing_splits DIR REV [REPOSITORY]
>>  find_existing_splits () {
>> -	assert test $# = 2
>> +	assert test $# = 2 -o $# = 3
> 
> This "test" syntax is considered unportable, I'm too lazy to dig up the
> reference, but we've removed it in the past. Maybe it's OK with
> git-subtree.sh", but anyway, it's esay enough to change...
> 
> ...but looking at "master" I see one instance of it in git-subtree.sh
> already, so maybe nobody cares...
> 

I did not know it was not portable, in fact I used this form because while
reading the rest of the script I found that was the style used already. 

So I guess I would leave this as a further cleanup for someone wishing to make
'git subtree' more POSIX...
