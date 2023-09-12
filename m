Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85920CA0EC3
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 10:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbjILKQp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 06:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbjILKQN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 06:16:13 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7291035A5
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 03:15:33 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-403004a96a4so33683375e9.3
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 03:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694513732; x=1695118532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4W9yNZYAyEOo4sbbLwcxEerjUeKyfq5J7/QRL274HdQ=;
        b=A14H0m1FJoUNlinuq55kX672sYVQEUgjYbtH3qvQ+eUBMLmQztPZCuJgr+bI7we8VL
         x6f3gUc+1/qvN+spqfSWxAY+HSgN7cC8IgJ/iY2D8Yz12hXyv0Z+QLzb+e4ymekCnIz+
         nsh0Y7QlDxGen/2ZrbpkS0bg99GOPl7XF0aekPE22T8kfPcbhbZ5eHwVjvp+n8frPz86
         aIsn/zaxlq35yCpU0jVMVk7zeOjYY9LCAG9dBUFE4M0SJgTEAmVQyoSzY3apaqklIDX1
         KYAwsZjaUuukU22qyrywbqocndGyw40FtwTosEc3cMXYBQX/3bXAjgM65UMaCDMM76f+
         Nndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694513732; x=1695118532;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4W9yNZYAyEOo4sbbLwcxEerjUeKyfq5J7/QRL274HdQ=;
        b=UMtWuPB//lIetnsWTgcnvNrMDOfq4ZA72jj8QRjcatMV+dIZGpLoeHCbV6ble4Gi0U
         A7XS4noQIPmYCnpMxN/7ZT/bhx5lCh+XAiyvXP6gO5i6V/dnZXpT/YnUkV6uNpj86XRI
         j1Gl2GH5UtJshMpIwVo2cm6osioUKA/MdgQTd3LmcTvjSmfE/Cqz89Y4R4xUv5ssxZMq
         eYJXMErTiDX8FZzeDAOqahVxJRnD3BgTOJ6D6dxTH4AX6c0TXX62htMp68DEnOxwQ4BE
         18AvAcTKToSrjN2TiIuu9lxVPtv1JvZXgjtDSYtzpTdIU1S8iZgWibLVW3T9cWraJ80P
         /BUA==
X-Gm-Message-State: AOJu0YzBRRk3ah0Za2kLtOgItSF/jOsmPdFU6Bdb7/m+B4w8nf3umA1p
        /WrLhUya+V57GlqxD3AFILztpN3kk7CXQQ==
X-Google-Smtp-Source: AGHT+IGOkMsM02BezwEy3Vr5YgyFKM/pkroGhlbltwD2Rml75vLq3TXoCd4uMcqnqknJAl+DnyKeOQ==
X-Received: by 2002:a5d:654d:0:b0:319:71f7:2427 with SMTP id z13-20020a5d654d000000b0031971f72427mr10137971wrv.66.1694513731522;
        Tue, 12 Sep 2023 03:15:31 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id o21-20020adfa115000000b0031f9bdb79dasm7015105wro.61.2023.09.12.03.15.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 03:15:31 -0700 (PDT)
Message-ID: <45ee4ad1-f7a3-43d8-99ef-329efc9fcdba@gmail.com>
Date:   Tue, 12 Sep 2023 11:15:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] t3404-rebase-interactive.sh: fix name of a rewording test
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20230911122108.199207-1-oswald.buddenhagen@gmx.de>
 <xmqqwmwws5gn.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqwmwws5gn.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/09/2023 23:36, Junio C Hamano wrote:
> Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
> 
>> The given test name made no sense to me at all; it seems to be a
>> concatenation of two unrelated things. This was introduced by
>> commit 0c164ae7a ("rebase -i: add another reword test", 20-08-20).
>>
>> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
>>
>> ---
>> actually, i don't understand what the test even does. shouldn't it, to
>> match the description, actually dirty the tree and verify that the
>> operation fails?
>>
>> Cc: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> As a typofix the updated text looks more correct, but the above is a > very good point, so I'll let Phillip, whose 0c164ae7 (rebase -i: add
> another reword test, 2021-08-20) introduced this test, react first.

Thanks. There is a typo, but that typo is a missing "and", the title 
should be

no uncommitted changes when rewording and the todo list is reloaded

The purpose of the test is to ensure that

  (i) There are no uncommited changes when the editor runs. i.e.  we
      commit without running the editor and then reword by amending
      that commit. This ensures that we have the same user experience
      whether or not the commit was fast-forwarded [1].

(ii) That the todo list is re-read after the commit has been
      reworded. This is to allow the user to update the todo list while
      the rebase is paused for editing the commit message.

All of the action happens in the functions called from this test. 
set_reword_editor() sets up an editor that runs "git diff --exit-code 
HEAD" to ensure there are no uncommitted changes when it is run and also 
updates the todo list. Then check_reworded_commits() checks that the 
commits were reworded and that the todo list was updated.

Best Wishes

Phillip

[1] https://lore.kernel.org/git/20190812175046.GM20404@szeder.dev/

> Thanks for spotting and fixing.
> 
>> ---
>>   t/t3404-rebase-interactive.sh | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
>> index 96a56aafbe..31ee5bc1f6 100755
>> --- a/t/t3404-rebase-interactive.sh
>> +++ b/t/t3404-rebase-interactive.sh
>> @@ -758,7 +758,7 @@ test_expect_success 'reword' '
>>   	git show HEAD~2 | grep "C changed"
>>   '
>>   
>> -test_expect_success 'no uncommited changes when rewording the todo list is reloaded' '
>> +test_expect_success 'no uncommitted changes when rewording' '
>>   	git checkout E &&
>>   	test_when_finished "git checkout @{-1}" &&
>>   	(

