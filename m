Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7622C4332B
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 22:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562B220724
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 22:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajBU8oI8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgCUWFS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 18:05:18 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:46078 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbgCUWFS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 18:05:18 -0400
Received: by mail-pg1-f172.google.com with SMTP id m15so5006459pgv.12
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 15:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=G8yNljJwNQju/GxoEDi6PXx6/E3m8wiPppMlGMjnKZY=;
        b=ajBU8oI8MAbFj7IZLrZTY6Wb5tEKs1uNRpi1bgmWVVuS9aoeVQsVSqbfAsiOL2vAA3
         1fd0FmEiNAFzj/yBL3/wmquXIpanB2AET68Sif3FRMJ2J/tEkw+BugPxgaoKbJvt3guw
         btkKKAKprX1auznTIjMua4eZFzPPqBeuAiSdV8PMTedIlxhL67K7E6Zx1JrsCSwnIhGA
         bhG2mt67rMDaHh04HAW6NCw3vPpXCb8hkTQdy59BT68kk74UXDgKbIz4YUeu90I9hJ6Y
         uQBBX2DhwFDgFPemkXK1ybFRjBfqUffUVl287Pwd8HhnVBaxGSSN1uE3B6rmHRMuXfa7
         rnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=G8yNljJwNQju/GxoEDi6PXx6/E3m8wiPppMlGMjnKZY=;
        b=APpovetIazm13UBFSeqnrMJ+P4h1//acOFwY1TkIWB7wAk9an06x7NC+LyHAqIOWrM
         IMIWjw9GO2L5efL9rO4q9srs/x/1gR/D8EUYEjF37Vm7w0+MaKdBTTFk1ims8gR+Lg9M
         p6qhAxCtN3AmSE/WBrAReS7EoSb89tRqnK3L2dlu++QvGXL85KQN/3Jf3pI3oPpCm4s9
         mWriWhVLl38OZUPgLIU5snPfAP/P52OjNSiOOZGrDWyESC4WS5tQZTJrvK9TuqOO6iRI
         91NKc9R4uHK8kQXLU97yrLYqpkrutuk+ZVdYAVCy1iJWxkmiezumQAk7VpXgC8dcK2Nk
         7kaQ==
X-Gm-Message-State: ANhLgQ2j5STWM7b11E5qSrOREuHhFYxtTMde/f3jGLOmcijMkqAz858D
        DxzVfAoIGBO/nkHMbBdeQ68=
X-Google-Smtp-Source: ADFU+vu8j9ImXYNJuAZMu8vdB7N091M1MACU7TnwKOrlqU79H+dhAd9B41ow4rqKfpIcEew/yL1jAw==
X-Received: by 2002:a63:4282:: with SMTP id p124mr15665768pga.59.1584828317158;
        Sat, 21 Mar 2020 15:05:17 -0700 (PDT)
Received: from [192.168.0.113] ([27.106.4.235])
        by smtp.gmail.com with ESMTPSA id k3sm8289409pgh.34.2020.03.21.15.05.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Mar 2020 15:05:16 -0700 (PDT)
Subject: Re: [GSoC Project RFC] "git log --oneline" improvements
To:     Junio C Hamano <gitster@pobox.com>
References: <28aee28c-8e8d-763a-66c7-d365025e56a2@gmail.com>
 <xmqqwo7ea99z.fsf@gitster.c.googlers.com>
Cc:     Git Mailing List <git@vger.kernel.org>, chriscool@tuxfamily.org
From:   Parth Gala <parthpgala@gmail.com>
Message-ID: <a67e0d2e-5bcd-8ac7-648e-51c1dc0f72ef@gmail.com>
Date:   Sun, 22 Mar 2020 03:35:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <xmqqwo7ea99z.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Parth Gala <parthpgala@gmail.com> writes:
>
>> I went through the discussions here[1] and here[2] and what I could
>> conclude from [1] is, the 'git log --oneline' command currently shows the
>> decorations of a commit before the commit message but after the shortened
>> hash due to which the alignment of the messages is disturbed like this,
>>
>>      3f07dac29 (HEAD -> master) pathspec: don't error out on all-excl...
>>      ca4a562f2 pathspec magic: add '^' as alias for '!'
>>      02555c1b2 ls-remote: add "--diff" option to show only refs that differ
>>      6e3a7b339 (tag: v2.12.0-rc0, origin/master, origin/HEAD) Git 2.12-rc0
>>      fafca0f72 Merge branch 'cw/log-updates-for-all-refs-really'
>>      74dee5cfa Merge branch 'pl/complete-diff-submodule-diff'
>>      36acf4123 Merge branch 'rs/object-id'
>>
>> And if the decorations were to be shown after the message and you were
>> checking the logs just to see the status of a branch rather than the
>> contents then you would again be at a disadvantage, since you would want
>> to have them visible right next to the hashes. Besides decorations at the
>> end would have the inconvenience of being truncated at the end of the line
>> on smaller screens.
>>
>> This format for --oneline with decorations was decided upon,
>>
>>    b9df16a4c (HEAD -> master)
>>              pathspec: don't error out on all-exclusionary pathspec patterns
>>    91a491f05 pathspec magic: add '^' as alias for '!'
>>    c8e05fd6d ls-remote: add "--diff" option to show only refs that differ
>>    20769079d (tag: v2.12.0-rc2, origin/master, origin/HEAD)
>>              Git 2.12-rc2
>>    076c05393 Hopefully the final batch of mini-topics before the final
> Hmph.  Who decided that such a format is a good idea?  I do not see
> anything decided positively in the thread [1] you referred to.

Okay, right.
But this format does overcome the problems discussed in that thread.
And yes, if `--oneline` is preferred to consume no more than one line,
then as you mentioned below, a `--pretty=concise` format seems to be a
good idea here.

>> In [2] such formats with date and timestamp are discussed along with
>> compatibility for --graph option as well,
>>
>>    === 2015-09-17 ===
>>    * ee6ad5f4 12:16 jch (tag: v2.5.3) Git 2.5.3
>>      === 2015-09-09 ===
>>    * b9d66899 14:22 js  am --skip/--abort: merge HEAD/ORIG_HEAD tree
>> into index
>>    |   === 2015-09-04 ===
>>    | * 27ea6f85 10:46 jch (tag: v2.5.2) Git 2.5.2
>>    * 74b67638 10:36 jch (tag: v2.4.9) Git 2.4.9
>>                         ..........
>>    * ecad27cf 10:32 jch (tag: v2.3.9) Git 2.3.9
>>
>> So these are the two main formats to be enhanced along with as many options
>> of log as possible. What are your views on this ?
>>
> Making the "--oneline" format to consume more than one line for a
> commit is probably not what we want anyway.

For this format can we build a new option say `--time` or `--log-time`(duh!)
which is compatible only when the other options don't include --notes,
--pretty or --format(in which case `--log-time` option gets ignored).
Here I will have to probably build upon Jeff's work to include the
other options that the script supports too.

> Coming up with a new format (say, "--pretty=concise"), or a new
> option that tweaks the behaviour of "--oneline", are possible ways
> to add a new feature without disrupting existing users' use cases,
> though.
>
> Thanks.
>
