Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97521C2B9F4
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 11:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A9F961264
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 11:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbhFSLO4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Jun 2021 07:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbhFSLOz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jun 2021 07:14:55 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E45AC061574
        for <git@vger.kernel.org>; Sat, 19 Jun 2021 04:12:44 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ho18so20182780ejc.8
        for <git@vger.kernel.org>; Sat, 19 Jun 2021 04:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ef8pdN7QZLLJ2cjc0sXbPqB3CFwbYKTlfy3S1RX5C+w=;
        b=f0Smi8dFOm7Ovi9owVRdBQQXY6PQ5RCrQsZBz1/eqWKd9qkkKcO6Wj08VnM/uY2/79
         wzA5oqwuPed6ADiIiD7QHxeLqfCslJE/TF3965QK6vWVohtc3Nvm2IGsNT8z1wwkdY/t
         3m1T/ZWeQQzjtCzv98+VOx6enHOMwc4iI82Vsoq9M3z2spJK0vN9mGNtHaYftvSOqI2F
         MnvGXYnsL3u/PEjigy228mr48xpss4EgXSAjnv0aTPMKNLCz7qTVJw+O81EDHysasonW
         fBHzooCncLBy5uIO+rQHs/N9aJuedHDK12A31dOUxrNdLtO+VOjdLZYbKgSuDMqbwwM/
         D/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ef8pdN7QZLLJ2cjc0sXbPqB3CFwbYKTlfy3S1RX5C+w=;
        b=O0sBPAiFMuxTLf0LFiNDoVhgVhN+19SV5MdHStj5Pqb0FZ3Gy7AKeGukmAfG1w8Ybm
         GFzUgqA9uUn/OEjl5DHRfBNJVMV0FX+TdPfVb3DgcmElUObbj3Xg/s8EZXM2KGBEeF3+
         3d00rePpBSrFLqwoSZfZ7eK3wrW6G1+15mHTHU7kRJAnvm/CWo+qHrrMAI8bjsQ9VY53
         OWoEK2BlrfSfGrQCFFoe7ANvoFOh5t3ry3oBvfalu3+cODv2xhVlqzX4ZAAKMVYETy3I
         yge6jPwfitruRJMMflWVanPldQkCIWSPPCfZThVpzgrnSGVIwrZse6ln0uP7Dpw89G3l
         q0Yw==
X-Gm-Message-State: AOAM530/RtqToulQjwCAWPDKzkzN30d+eVMpPhp81/syxAC0C1l74H3a
        IhSbDzSlaNJBskyVpru+zfcP6+C0LorhmjOYf8dVhg==
X-Google-Smtp-Source: ABdhPJwBtw3uYPbbMc29G2VRTjV52dVvZprdM87NpR/5pYByRQeo6BaxpPjUqlmYjyAgcLXmyrA5IA==
X-Received: by 2002:a17:907:9d1:: with SMTP id bx17mr5959400ejc.322.1624101162909;
        Sat, 19 Jun 2021 04:12:42 -0700 (PDT)
Received: from ?IPv6:2001:a61:34c8:7e01:39e2:683d:7a5c:2a16? ([2001:a61:34c8:7e01:39e2:683d:7a5c:2a16])
        by smtp.gmail.com with ESMTPSA id s2sm7786180edt.53.2021.06.19.04.12.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Jun 2021 04:12:42 -0700 (PDT)
Subject: Re: [PATCH] blame: fix typo in documentation
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Barret Rhoden <brho@google.com>, git@vger.kernel.org
References: <20210618221104.42260-1-rybak.a.v@gmail.com>
 <8921ac50-e628-9a60-2a8d-1b8cc2a5a056@gmail.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <7cbbd59b-d5e3-4b96-a1ee-a242a7839028@gmail.com>
Date:   Sat, 19 Jun 2021 13:12:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <8921ac50-e628-9a60-2a8d-1b8cc2a5a056@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/06/2021 07:27, Bagas Sanjaya wrote:
> On 19/06/21 05.11, Andrei Rybak wrote:
>> As can be seen in files "Documentation/blame-options.txt" and
>> "builtin/blame.c", the name of this configuration variable is
>> "blame.markUnblamableLines".
>>
>> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
>> ---
>>   Documentation/config/blame.txt | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/config/blame.txt 
>> b/Documentation/config/blame.txt
>> index 9468e8599c..4d047c1790 100644
>> --- a/Documentation/config/blame.txt
>> +++ b/Documentation/config/blame.txt
>> @@ -27,7 +27,7 @@ blame.ignoreRevsFile::
>>       file names will reset the list of ignored revisions.  This 
>> option will
>>       be handled before the command line option `--ignore-revs-file`.
>> -blame.markUnblamables::
>> +blame.markUnblamableLines::
>>       Mark lines that were changed by an ignored revision that we 
>> could not
>>       attribute to another commit with a '*' in the output of
>>       linkgit:git-blame[1].
>>
> 
> That above is not typo fixing; that is correcting configuration variable 
> name.

This issue in documentation of git-blame was introduced when the config 
option
was added in commit 8934ac8c92 (blame: add config options for the output of
ignored or unblamable lines, 2019-05-15).  It first appeared in v6 of that
series [1] where it was called blame.maskIgnoredUnblamables.  In v7 [2] 
it got
renamed to blame.markUnblamableLines.  v7 of that series is the first 
time when
incorrect blame.markUnblamables appears in Documentation/config/blame.txt.

As far as I can tell, it's most probable that Barret Rhoden just missed one
place when renaming this config option between v6 and v7.

If we shouldn't refer to this patch as typofix, how about

	blame: fix name of blame.markUnblamableLines in docs

or

	blame: correct name of config option in docs

or

	config/blame.txt: correct name of blame.markUnblamableLines

?

[1] https://lore.kernel.org/git/20190410162409.117264-5-brho@google.com/
[2] https://lore.kernel.org/git/20190515214503.77162-6-brho@google.com/
