Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2BCC2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 18:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79AAE2082E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 18:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="svtdYqxH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgA3SRa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:17:30 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:36269 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbgA3SRa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 13:17:30 -0500
Received: by mail-yb1-f196.google.com with SMTP id w9so1840051ybs.3
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 10:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CpL4nSogNgGsRvENyNOFq+k3fZiSNaTUzMbBKjiETrM=;
        b=svtdYqxHcSIENFY8asdkK0h5Ypp3V/xXRQ2U/WXIoIXwxp6e0JOHcz5LSdesl7ToVI
         Yk4Thag6WBCnZg91eu7WP4Du/Sx8cx1hJiOViBg9qvLzeAJ22iCA+PDEgZqe2+DsLz/P
         L9hQS9zYzEmPFnyh9bpcm/SRppL3dvI0AgXF0N1biP2PBSaqbl82NwD5g14zOC0/r/vY
         svVWfVxeNOAFAh37vJD7TauSFnxIdTwp0kLFN69IuKLWx4SPZYQw+DiDE3T07SWdXr2A
         gpt1Z84jvzDi23sD5oyyqnNQjG7P6oZ8AF5N/DOKWihwXxEvMZY4Wg8I2GlxIo4QBB8Q
         V2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CpL4nSogNgGsRvENyNOFq+k3fZiSNaTUzMbBKjiETrM=;
        b=Quv9as8OD1DQqdlOkKIKQltC7JQTqrUa1iogkgWNYJC93bKgIrmA6TitSuy84Bp3qu
         9ZyWFVsKbXHYWgoOEVy3XhZhPAgR2cW7Gtt7ymiMS5CFEsJOhBvsWjDcW2Yns7YEm2Mn
         ULvDMsCLltIGA5FIeNMvd+Vev2Fc81UbKEJnL7x0LL+ZE7bTb3in6xMGAKWOF3WYUON8
         mSXH33Z/E5ubkHabLctqScEeMbxmewqOuk7kk49knpYQ1WTws7dK+blPAJy33RgXe7TV
         0IKj/7mpICObYCDCNcYbmI0Fa3rhpSPnxqEK4ccetSxHvEMtFxcKDYPUMSfDgjq6+0jH
         O5Nw==
X-Gm-Message-State: APjAAAVJajgws+vXX7YrxocCc6DktT/xKxmqn5LEORz7PaBkpC39C+Gn
        QQi2rktYi80L0RTpNsC84UY=
X-Google-Smtp-Source: APXvYqwh1RwXMnJZrRB8Qaoya5Ha0MNLca3ssqIuvvX43jhKHcJTFB6Fv2ipizSnkhBPnSzmRM0Mlw==
X-Received: by 2002:a25:d656:: with SMTP id n83mr5344907ybg.224.1580408249302;
        Thu, 30 Jan 2020 10:17:29 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id d9sm2882097ywh.55.2020.01.30.10.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 10:17:26 -0800 (PST)
Subject: Re: [PATCH 4/6] dir: move setting of nested_repo next to its actual
 usage
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Martin Melka <martin.melka@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <pull.700.git.git.1580335424.gitgitgadget@gmail.com>
 <3b2ec5eaf65c9fe44c4337a4cc2fc3dae6203d54.1580335424.git.gitgitgadget@gmail.com>
 <8d9a6047-26be-ff78-cf1a-9f2b35f927e0@gmail.com>
 <CABPp-BFbXJRW38CeGy78b22MfZ8cNizexCM-+n-ODqy+fOo2uw@mail.gmail.com>
 <1bc41d94-5d4d-4157-fc00-08b97fb20738@gmail.com>
 <d67eb395-3b6d-9558-0288-cd3878290c9e@gmail.com>
 <CABPp-BGe7ae+pf+HUdLE-xDoXEPDJ=5vWH4cnU9N6pZM2o1Q-g@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <21d3d07a-d83d-a46c-ba5f-56c90326cb48@gmail.com>
Date:   Thu, 30 Jan 2020 13:17:25 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BGe7ae+pf+HUdLE-xDoXEPDJ=5vWH4cnU9N6pZM2o1Q-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/30/2020 11:20 AM, Elijah Newren wrote:
> On Thu, Jan 30, 2020 at 8:10 AM Derrick Stolee <stolee@gmail.com> wrote:
>> diff --git a/dir.c b/dir.c
>> index b460211e61..0989558ae6 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -1660,29 +1660,26 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
>>         const struct pathspec *pathspec)
>>  {
>>         int nested_repo = 0;
>> -
>>         /* The "len-1" is to strip the final '/' */
>> -       switch (directory_exists_in_index(istate, dirname, len-1)) {
>> -       case index_directory:
>> -               return path_recurse;
>> +       enum exist_status status = directory_exists_in_index(istate, dirname, len-1);
>>
>> -       case index_gitdir:
>> +       if (status == index_directory)
>> +               return path_recurse;
>> +       if (status == index_gitdir)
>>                 return path_none;
> 
> I think right here we should add:
> 
>         if (status != index_nonexistent):
>                 BUG("Unhandled value for directory_exists_in_index:
> %d\n", status);
> 
> for future-proofing, since both you and I had to look up what
> possibilities existed as a return status from
> directory_exists_in_index(), and I'd rather a large warning was thrown
> if someone ever adds a fourth option to that function rather than
> assume treat_directory() is fine and only needs to special case two
> choices.
> 
> Or we could add an assert or a code comment, just so long as we
> document to future readers that the remainder of the code is assuming
> status==index_nonexistent.

I'm happy if you squash this into the commit. Thanks!

