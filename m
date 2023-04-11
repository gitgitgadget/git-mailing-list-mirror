Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B34BC77B6F
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 09:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjDKJur (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 05:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjDKJuk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 05:50:40 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4CA10C3
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 02:50:39 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m8so17859358wmq.5
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 02:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681206637;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LiEG7UAKFkkwqY+3lXQf08YR6eOAPjzarWa4YHwWqjc=;
        b=JNPsx/RGdc4Lp23ulujgoy7hsA3sCOhOqnVkMHfP3xTLJPEAlMmij2mxCIWlPfQa9u
         qRiXXKuqn8ymvlDicgUUlxEB+834u8ieMDrsOSb3G+Fb5kH5Ksb0aWVhliIPnB20DDqZ
         Lg8oqWnlwzsmulvI/+fiqtBMxR1zgYqNXiC05rnHF9wmh2qJiuz4J8WHn+ZINw3HlHaL
         m8FwtsPdR6H4uCfVH+v7M/URNXoPSNvcQ1cgaJv6loKFfzfHgmSYo0AqODeUapr0xmaq
         8aPaDeqrVlJOgt81iS/AfO+Nbu37tftPYVr/sO4lWYezVvddiRL6rqg8VcLluAWGxOb4
         f6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681206637;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LiEG7UAKFkkwqY+3lXQf08YR6eOAPjzarWa4YHwWqjc=;
        b=gx/vvwH5dhGMEYyxlNT+DAUtHjtZgHRIJdO5DouxlkZqkS9wPiKqiasKTlDJNr7/KL
         iSr9EH1o5mOGmS5jrUaPs/mOXiNi6+0QoibkW08h3qHR4TDs03SLbL2ENos+1t1cHKpR
         /vNgzRK7G2L/wWqXIViv+3bxSbHiZfpjlvFTdyE5HVLr+NaciU6sdXcX7ccA93TfRrrR
         ZCJnNRboelUa+sCDzIkqG+CC5hNZCW1s45rh83SSRvOdL2+k+5yazdC5a/vIl3Vz6dMk
         3ROIFWamXxM2PIN/pblOMDCwwCDFpPdvnXU6aBc3IoOkBDzJgqZMuJ2G2ITXlMeYWLrt
         YBCQ==
X-Gm-Message-State: AAQBX9fpRSEZF5ROTHurmF+DRC26mnEannGSnZUjKQIvikaiBMVrswxs
        QYaM6PTsKMR1u1QdyBKZYnOpzJKMQ3U=
X-Google-Smtp-Source: AKy350Z6MZl0amfiDaEvHinAfVPFPuF5OhNl15xLfg1oWHWn5gyTIuee/iAAmRwV3WRkfS6R6bZRwA==
X-Received: by 2002:a05:600c:28f:b0:3dc:4b87:a570 with SMTP id 15-20020a05600c028f00b003dc4b87a570mr9670193wmk.35.1681206637468;
        Tue, 11 Apr 2023 02:50:37 -0700 (PDT)
Received: from [192.168.1.195] ([90.253.53.152])
        by smtp.googlemail.com with ESMTPSA id b2-20020a05600c4e0200b003f04057bf1bsm20078617wmq.18.2023.04.11.02.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 02:50:36 -0700 (PDT)
Message-ID: <53849a41-405c-e488-8c9f-49b211d9a7d4@gmail.com>
Date:   Tue, 11 Apr 2023 10:50:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Possible bug in git-rebase man page
Content-Language: en-US
To:     Stefan Haller <lists@haller-berlin.de>, phillip.wood@dunelm.org.uk,
        git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de
References: <db535468-c991-df18-61bd-ec312fdb5ca0@haller-berlin.de>
 <51aca4bd-0f2b-0689-4b51-260349cc4151@gmail.com>
 <f3e522f6-294d-4c08-b261-34d8e5b03b46@haller-berlin.de>
 <7e99ff9b-99b7-1ea9-4131-43f507780284@gmail.com>
 <dda64e68-1390-0b4d-bb93-65f745ab1300@haller-berlin.de>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <dda64e68-1390-0b4d-bb93-65f745ab1300@haller-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/04/2023 07:12, Stefan Haller wrote:
> On 06.04.23 14:07, Phillip Wood wrote:

> Ah, I missed that, thanks. But it does this only after special-casing
> the "[new root]" label, which does contain a space and needs to go to
> the end of the line. This is weird.

I think it is by design. Unlike normal labels "[new root]" is not a ref 
and by choosing a name that is not a valid refname it will never 
conflict with a normal label.


> This whole topic started because the todo parser that we are using in
> lazygit has a bug where it doesn't recognize the "[new root]" label
> properly, and this is because it does split the line at the first
> whitespace, but without special-casing "[new root]" like git does.
> 
> How would you recommend we fix this? We could replicate git's current
> behavior exactly, but then this would break when you introduce comments
> later. Or we could anticipate that comments are added at some point, and
> already split the line at the first # (trimming whitespace before that).
> This would not exactly match git's current behavior, but it would be
> good enough because git never actually uses whitespace in label or reset
> lines except for the "[new root]" case.
> 
> I'm leaning towards the second option myself. Any thoughts?

I'd got for a slight variation of the second one where you just ignore 
everything after the required arguments for each command just like the 
reset command does - it does not require the comment to start with a 
'#', it will accept "reset mylabel this is a comment".

Best Wishes

Phillip

> 
> -Stefan

