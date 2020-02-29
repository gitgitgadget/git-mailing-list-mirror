Return-Path: <SRS0=C4D3=4R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376DDC3F2C6
	for <git@archiver.kernel.org>; Sat, 29 Feb 2020 14:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04AB22468A
	for <git@archiver.kernel.org>; Sat, 29 Feb 2020 14:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3tY+KuS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgB2O2H (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Feb 2020 09:28:07 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:39300 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbgB2O2G (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Feb 2020 09:28:06 -0500
Received: by mail-wm1-f41.google.com with SMTP id c84so6391043wme.4
        for <git@vger.kernel.org>; Sat, 29 Feb 2020 06:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ExLDbJ2/chXAd5nd18C67dhcGDDcmEklazGWraxjyBY=;
        b=H3tY+KuSDjM84Fos1/Y/Yep4gIHlUfPLK0nvXBe/Y9Qbeo4WIC5Qc4T/a24gESjw8I
         lVDzIC6jEIejVTPG8o9YvV9LswHyaDvXrr65fuOdY7yU/hbs5PDEFgBkVrrfvOGJuRu4
         CKbotEKVDFzhsL9ggioBPmvFPiScCDCQQ0oGv8B8vXVTmpEJuiHRJlYvY+4/BPBYl1r7
         7T/XgkqxC/SRrNWS3HoAuDRGvWheNC43zxDbYDPrrKx79BjDbCOHS6+uK2js4UrO1/PW
         oEdDUKgtI31a9gy6p9c8wSMVuNUwfKkr0CuscExXxVZaH96Khs8dvKok5wz8M+wfvL7e
         cx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ExLDbJ2/chXAd5nd18C67dhcGDDcmEklazGWraxjyBY=;
        b=lRfG2YkLHJz5YLCkSARbSGFzdcN8RsGfamz3WU+JC1xwJjWgryuRZ/o98QsrQa1swS
         /0UPnlyyazyfmIoig1fA2E1Y4D8uDsrfWZClkiQB8lfNa6Ymo/zqpOFd3EigaWK4ijAX
         tZxXkoYzEEaoHb5w9n9y/WRlGZbGCK/5YaWpyGvVqzQCyvALjfLVmPPa5+vpZUh4jw4J
         y3sAFMznvM1DYpF/2jp7fBK8bc/PBs8H1V37LJ8YqC/gTHHGhEWfNvuBcF4XkRLAVJA9
         NQY+2iNbyEUa8H+nus1qHl/Qze8UrPx64p7odifSMbBgkoJUAHlClpJeDjD6muhho9FW
         4PeA==
X-Gm-Message-State: APjAAAXeb1iamVkTSkkqG6YkhcrQwSQRsy9imjpHW9bP6hvMwQ6fdkgK
        AIdxCucI9EaHW8imNYliYC0SjNo5
X-Google-Smtp-Source: APXvYqy8fh1VXC+juISY5+0IlIoA6UEnL0tiV9P4+RrKN4MIWT7CnW0CFs0n25sHAqvPW5woBLQH+Q==
X-Received: by 2002:a7b:c847:: with SMTP id c7mr9716382wml.3.1582986484602;
        Sat, 29 Feb 2020 06:28:04 -0800 (PST)
Received: from [192.168.1.240] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id i18sm14233037wrv.30.2020.02.29.06.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Feb 2020 06:28:04 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: rebase --abort Unespected behavior
To:     Blaise Garant <blaise@garantcoutu.com>, git@vger.kernel.org
References: <CANXsDork=bL=SUodXDzkcnjpPALm53e++UkVkJFWxaZPMBK-SQ@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <13cdf33b-7ca2-c391-fddd-53bdbae7f0d3@gmail.com>
Date:   Sat, 29 Feb 2020 14:28:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CANXsDork=bL=SUodXDzkcnjpPALm53e++UkVkJFWxaZPMBK-SQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Blaise

On 28/02/2020 17:36, Blaise Garant wrote:
> Hello,
> 
> I don't know if this is a bug but it was unexpected for us. I
> accidentally added untracked files through a `git add .` while doing
> an interactive rebase and aborting the rebase deleted those files. Is
> this to be expected?

I agree that this is surprising and undesirable but it's not unexpected 
given the way --abort is implemented. 'rebase --abort' calls 'reset 
--hard <branch we're rebasing>' so it will discard all the uncommitted 
changes in the worktree and reset the worktree and index to the branch tip.

The tricky thing with your situation is that the files are tracked at 
the point we call 'reset --hard' as they've been added to the index so 
git feels free to discard them. Perhaps rather than calling 'reset 
--hard' it would be better to use a custom callback with unpack_trees() 
that errors out if there are any paths in the index that are not in 
HEAD, the commit we just picked or the branch tip we're resetting to. If 
we do that we should consider using the same thing for 
'cherry-pick/merge/reset --abort' as well. --autostash potentially 
complicates things as the file might be in the stash but not in the 
other commits but lets not worry about that at the moment.

If your untracked files were ignored then I think 'git add .' would have 
complained or just not added them, but 'git checkout' and 'git merge' 
will happily overwrite ignored files so ignoring them is not always an 
ideal solution.

Best Wishes

Phillip


> To reproduce:
> mkdir test_folder
> cd test_folder
> git init
> touch first
> git add .
> git commit -m 'First'
> echo 1 >> first
> git add .
> git commit -m 'Second'
> echo 2 >> first
> git add .
> touch second
> git commit -m 'Third'
> git rebase -i HEAD~2 #set second to be edited
> git add .
> git status        #second should have staged
> git rebase --abort
> ls        #second has been deleted
> 
> Not sure this is an expected behavior.
> Thanks
> Blaise Garant
> 
