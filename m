Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B405AC77B61
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 10:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243475AbjD0KRV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 06:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243276AbjD0KRT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 06:17:19 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E52E187
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 03:17:18 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-2f27a9c7970so7446595f8f.2
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 03:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682590636; x=1685182636;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JcL0tqazHB14WYDkRqHWCm3rCXbeWTEJAHaalSwaaSE=;
        b=c0ACFqIa4lT0CCmE8EmfdU3DjoS+UJv7mipam76nSVou67DiknTRaZl8KDbQ8I7yNQ
         KbpueGOPdzt1ETyZQU2BOsNbCDTdYptK+kSCB35dFiFOP4g/LMY8CnWqZ+gNNjxL6q4i
         9L+JO0IeFaMSskkAPqts6IHgk3ex7y/cRiWr+O/lRFtBCDqLAbiGOIiLIgSTvNSvz5OE
         kLP2exjFRsZfW01v8lL5mjARNB1+5vLxm3+OIZI6fwqQGUTqmp5YqNn2mvlP8VJRRN9V
         4mSh5owqj1S8zPAdGaUhK8LGqwk3ZcGIBac1PjYnUrmSBod6rrHYhPmx0kkd4WC9A3WC
         vbbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682590636; x=1685182636;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JcL0tqazHB14WYDkRqHWCm3rCXbeWTEJAHaalSwaaSE=;
        b=JA/CLDkIGuiPkufvSdFq6Bo8krXojJmP/Blk0mCesbHZ3egpcyGgqVySYN75P0NHhe
         IOJHmvJA3bX7fFgp/ZMbJLYC+44HlpY8BYcJ0azx0RUehdqA59heWVoexFsgOv36mR/q
         qohV4BRvnsuF8cUHxHbuPZ36YHL7tmZWky+OiZwabD3Jffn3FKD6XjIzzWQ26XHdOMiQ
         KNjrLUGPmXod5qDJnz6ZunXjrQORGihU3/KYDukGzQaD3yctcSKsX2unNfq5LXat5h7k
         ZreBSrOV1uy7oCwy1nORv6IQS1csuEJmQKHEtnx9hYck4RAyH6vMs6rqdwLgnA6hVmnD
         2+nw==
X-Gm-Message-State: AC+VfDxvZn9EJRXXjaAKsVi1AvO1yMDSswJhDhh2WvbBlYGVjkRksVrx
        Iob7elNeHuwCYxogyvxS6Iw=
X-Google-Smtp-Source: ACHHUZ7dXJRcomHgz95cMb138sYLXr1sxfmk7A5IE8dys/x2ttSBrogFniEPIGZstqc4qNYRAuudpw==
X-Received: by 2002:a5d:4147:0:b0:304:aad4:b1ed with SMTP id c7-20020a5d4147000000b00304aad4b1edmr1019358wrq.13.1682590636247;
        Thu, 27 Apr 2023 03:17:16 -0700 (PDT)
Received: from [192.168.1.195] ([90.255.142.254])
        by smtp.googlemail.com with ESMTPSA id c1-20020a5d4f01000000b002fc0de07930sm18131929wru.13.2023.04.27.03.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 03:17:15 -0700 (PDT)
Message-ID: <1fd54422-b66a-c2e4-7cd7-934ea01190ad@gmail.com>
Date:   Thu, 27 Apr 2023 11:17:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/6] rebase -i: remove patch file after conflict
 resolution
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1492.git.1679237337683.gitgitgadget@gmail.com>
 <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
 <227aea031b588977f22f3f97faee981d79ade05c.1682089074.git.gitgitgadget@gmail.com>
 <xmqqwn25jbzw.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqwn25jbzw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/04/2023 20:01, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> When rebase stops for the user to resolve conflicts it writes a patch
>> for the conflicting commit to .git/rebase-merge/patch. This file
>> should be deleted when the rebase continues.
> 
> Could you describe the reason why this file "should" be deleted a
> bit better?  Once the user edits the files in the working tree and
> tell "git rebase" with the "--continue" option that they finished
> helping the command, and the command creates a commit out of the
> resolution left by the user in the working tree and in the index,
> the patch may no longer is needed, so I can understand if this were
> "this file can be deleted"---in other words, again, this explains
> why such a change would not be a wrong change that hurts the users,
> but it does not explain why we want such a change very well.  Is
> there a reason why a left-over patch file is a bad thing (perhaps
> causing end-user confusion upon seeing such a patch that apparently
> is for a much earlier step in the rebase in progress?  If so, that
> might be a good justification to say we "should").

Yes that's the reason - we don't want a stale patch when we stop for 
another reason, I'll improve the commit message.

Best Wishes

Phillip

>> As the path is now used
>> in two different places rebase_path_patch() is added and used to
>> obtain the path for the patch.
> 
> OK.
> 
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>   sequencer.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> The patch text itself looks good in the sense that it correctly
> implements what the proposed log message claims it "should".
> 
> Thanks.

