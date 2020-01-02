Return-Path: <SRS0=b7P8=2X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1967FC2D0DC
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 13:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC6E20866
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 13:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5JciITx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgABNux (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jan 2020 08:50:53 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39145 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728342AbgABNuw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jan 2020 08:50:52 -0500
Received: by mail-qk1-f194.google.com with SMTP id c16so31374890qko.6
        for <git@vger.kernel.org>; Thu, 02 Jan 2020 05:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=mc6XLju3RdfbQ87iPFRZ1aUA+P2kTE6s2j5U7KBVpR8=;
        b=i5JciITxnbcZPkd1He7bD45duhySLVHEosVh2UZlixW0KOyc8IgfV8PNFIjMVy81UO
         Zqua+UZCfjv3GBg8Itjw7PaTMgv5XcaTLyNHKp4f26GPITNEl8UPG39Hu7RgRjM/zDtq
         zrNSZnggOnx+en0RHw/nAeEKyZjBdOcVDllTo3hQyEfeIoVV9o5CXTM96Z5MyWiogkTU
         55FP+ylxMp/IY17DqVG7j7FvHRGR/WFcKs9iS6yjBOEHQQ30ad9Mwdm+9RvnKmXa5wAd
         WBtkC2TKAn05jLE278h4ZbSbvcI4WvqwkOj7liNKTR7MkZKut56woc97lgTyfz+NUwKe
         9PWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mc6XLju3RdfbQ87iPFRZ1aUA+P2kTE6s2j5U7KBVpR8=;
        b=SL6zxxMo6x8Xdzv9H6dA9zMAIxsDxMT4jTg4cWWc02Bi6Xoub37xDB5hKMqd5Fj/8r
         jkaiZ2iTO58Tz6ZeYqamRe0bSm6vTIAL9S6YytRN7n9kpjZmY15Q0SteynK/Fo2xoX+f
         F6e6bUrSJM1DdQEzf/+hBPDSg3/5UC7E7/tol8jLs8u+Sz3E6JoHvN8dElxslBN2AwF6
         JUZWWjo4JcGOb5i+dgYcUyQV7YcJ24GQLZpOthkZG7ubJejJu298JVs7ZkejC+Fgo5fa
         Mz2bGaZClWY5jtxte8VQcT/gid7W8yFFdptEcvGZFkl7FyEld9wclvMSkaEQYthSC5vx
         LMTg==
X-Gm-Message-State: APjAAAWehtQZl5LuJarrlpdMhFhB+R+smx482lNtiBsC6Yr2oFGTFuhz
        HBMUETqe72+/Hi7aByyT5FCOaTAo
X-Google-Smtp-Source: APXvYqwFWqo8JxOb5NYafJZ3XG21LTNAUHyfUyEx5ET+1KTE2fpmFtz/TT1Gr0m72fJ2FTCgKpk+xQ==
X-Received: by 2002:a37:354:: with SMTP id 81mr67496384qkd.276.1577973051626;
        Thu, 02 Jan 2020 05:50:51 -0800 (PST)
Received: from [10.10.31.126] ([24.229.121.34])
        by smtp.gmail.com with ESMTPSA id u57sm17031271qth.68.2020.01.02.05.50.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2020 05:50:51 -0800 (PST)
Subject: Re: [PATCH v5 0/4] git-p4: Usability enhancements
To:     Junio C Hamano <gitster@pobox.com>, Luke Diamand <luke@diamand.org>
Cc:     Git Users <git@vger.kernel.org>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.675.v4.git.git.1576245481.gitgitgadget@gmail.com>
 <pull.675.v5.git.git.1576504942.gitgitgadget@gmail.com>
 <xmqq8sncj991.fsf@gitster-ct.c.googlers.com>
 <CAE5ih7-ptmmb2UurBw+k+2ZjZQuOkLJ3c-eBoOXKrPX0CJeErA@mail.gmail.com>
 <xmqqh81omd5m.fsf@gitster-ct.c.googlers.com>
From:   Ben Keene <seraphire@gmail.com>
Message-ID: <c95fe073-9bea-9dcf-4579-e9125cc55f39@gmail.com>
Date:   Thu, 2 Jan 2020 08:50:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <xmqqh81omd5m.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 12/25/2019 2:13 PM, Junio C Hamano wrote:
> Luke Diamand <luke@diamand.org> writes:
>
>> $ git log --reverse --oneline --abbrev-commit
>> origin/maint..origin/bk/p4-misc-usability
>> e2aed5fd5b git-p4: yes/no prompts should sanitize user text
>>     - looks good to me
>>
>> 608e380502 git-p4: show detailed help when parsing options fail
>>     - also looks good to me
>>
>> c4dc935311 git-p4: wrap patchRCSKeywords test to revert changes on failure
>>     - why not just catch the exception, and then drop out of the "if-"
>> condition and fall into the cleanup section at the bottom of that
>> function (line 1976)? As it stands, this is duplicating the cleanup
>> code now.
>>
>> 89c88c0ecf (origin/bk/p4-misc-usability) git-p4: failure because of
>> RCS keywords should show help
>>    - strictly speaking, the code does not actually check if there *are*
>> any RCS keywords, it just checks if the filetype means that RCS kws
>> *would* be expanded *if* they were present. The conflict might be just
>> because....there's a conflict. As it stands this will be giving
>> misleading advice. I would get it to check to see if there really are
>> any RCS keywords in the file.
> Thanks.  Ben, let's keep the first two and discard the rest for now,
> which can later be replaced with updated ones.
That works for me.  So, are there any changes that I should make at
this time, or just let the rest die off?
