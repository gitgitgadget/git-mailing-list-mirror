Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A82CC433F5
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 11:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376557AbiBHLck (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 06:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356776AbiBHLA0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 06:00:26 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2C4C03FEC0
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 03:00:25 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id q7so1803527wrc.13
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 03:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=InJ1oh4NHGFS6O/MuhQyzPZd5QRob16xThlJceKWzT4=;
        b=Zjt3DAbV18wJo5kzAOCeYtZEvD24IpkV2QuIhZ1BJfafyDXuPQOif3CSTTCFA8vN2w
         nfjmOOxo1x/zIaIHJAwsDI7pfzs+DYDilh487idQSoaM6oZAjGtmbZfcvuNEfIJ8HpH+
         dlVmKEuZOCAq5gwr9skktkOyuvng7GBBLguxWw/Xu6SjphBPI8fmTh1fKgnQl6i0vwBp
         wql+ZDamzetnEIVXj3aB8ltrJ1f4k6INtXtcMtYA+iO9IGZ7aUfXuECIu57/7O/+J28M
         w9DecZ8qIpAFY1301ZicR1kgHobOLHdTOeCg7b5blX46lxKDofZcDDA/AvyEHnk+GyVP
         NUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=InJ1oh4NHGFS6O/MuhQyzPZd5QRob16xThlJceKWzT4=;
        b=0r4vNYCSYGX6gqj0AqWttuhiyg0hGjMigdGSbYYJG93hn0126nj7xbuBtyXF8FRJsP
         DnVD09QLceE4/nxFmsz75PPGOKtJKVIqoA4HPFfl2s0RaZLsQ6qIZyzooiYZ2+OoD/m7
         og2L02IrsO0e6A54GpGnhdL7bNp6X/nrOYx4cl26sGkp947naUW9renHx8gywWIfOHNM
         slFHmnpA1AYnK+20EcB4tjMy4Z+hSTHFk/vYOIFWClRicP6gbMEPQ0epHWvHE/TxB/VH
         vUeoLl5IMerl+sd1SvR6Omo3yZJ+946Bnyx7dGRbDaiEr4lHnYwyrGagTyc6FB8+3+eF
         wTXQ==
X-Gm-Message-State: AOAM530JENkJ+pvyGP8iP270kE+fX0cvEri6ZrLzzDCe/LAKZjkTgMbs
        0OwtlB6yW5rzKOSrpJ7T2v4vxCN2Mfk=
X-Google-Smtp-Source: ABdhPJz9gvjKnUzl+T8gGIds0jkAfEkccp6TJztrw+KGNd+1PmYovGwsy9tINad1Q1F8E2dPYvcrew==
X-Received: by 2002:a5d:4c4f:: with SMTP id n15mr2989352wrt.125.1644318023840;
        Tue, 08 Feb 2022 03:00:23 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id l20sm1872998wmq.22.2022.02.08.03.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 03:00:23 -0800 (PST)
Message-ID: <83ab0f7d-96d5-8730-edd7-693f10b09002@gmail.com>
Date:   Tue, 8 Feb 2022 11:00:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/2] cat-file: add --batch-command mode
Content-Language: en-US
To:     Jonathan Tan <jonathantanmy@google.com>, gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, me@ttaylorr.com, avarab@gmail.com,
        e@80x24.org, bagasdotme@gmail.com, gitster@pobox.com,
        sunshine@sunshineco.com, johncai86@gmail.com
References: <1b63164ad4d9ec6b5fa6f733b6095b2779298b36.1644251611.git.gitgitgadget@gmail.com>
 <20220207233422.14094-1-jonathantanmy@google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20220207233422.14094-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan and John

On 07/02/2022 23:34, Jonathan Tan wrote:
> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> However, if we had --batch-command, we wouldn't need to keep both
>> processes around, and instead just have one --batch-command process
>> where we can flip between getting object info, and getting object
>> contents. Since we have a pair of cat-file processes per repository,
>> this means we can get rid of roughly half of long lived git cat-file
>> processes. Given there are many repositories being accessed at any given
>> time, this can lead to huge savings since on a given server.
> 
> One other benefit is that with explicit flushes, in a partial clone,
> this makes it possible to batch prefetch objects.

Jonathan is there any overlap between what this series is trying to do 
and your proposal for a batch command[1]? For example would extending 
this series to get blob sizes be useful to you?

Best Wishes

Phillip

[1] 
https://lore.kernel.org/git/20220207190320.2960362-1-jonathantanmy@google.com/

>> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
>> index bef76f4dd06..618dbd15338 100644
>> --- a/Documentation/git-cat-file.txt
>> +++ b/Documentation/git-cat-file.txt
>> @@ -96,6 +96,25 @@ OPTIONS
>>   	need to specify the path, separated by whitespace.  See the
>>   	section `BATCH OUTPUT` below for details.
>>   
>> +--batch-command::
>> +	Enter a command mode that reads commands and arguments from stdin.
>> +	May not be combined with any other options or arguments except
>> +	`--textconv` or `--filters`, in which case the input lines also need to
>> +	specify the path, separated by whitespace.  See the section
>> +	`BATCH OUTPUT` below for details.
>> +
>> +contents <object>::
>> +	Print object contents for object reference <object>
>> +
>> +info <object>::
>> +	Print object info for object reference <object>
>> +
>> +flush::
>> +	Execute all preceding commands that were issued since the beginning or
>> +	since the last flush command was issued. Only used with --buffer. When
>> +	--buffer is not used, commands are flushed each time without issuing
>> +	`flush`.
> 
> The way this is formatted leads me to think that "contents", etc. are
> CLI arguments, not things written to stdin. Some of the commit message
> probably needs to go here.
> 
> I just looked at the commit message and documentation for now.
> 
> If you have time and are interested, we at Google are thinking of a more
> comprehensive "batch" process [1].
> 
> [1] https://lore.kernel.org/git/20220207190320.2960362-1-jonathantanmy@google.com/

