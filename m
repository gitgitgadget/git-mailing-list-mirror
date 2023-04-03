Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052CDC76196
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 15:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbjDCPmU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 11:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjDCPmS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 11:42:18 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69FF26A5
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 08:42:17 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id kq3so28392041plb.13
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 08:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680536537;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ykFFC7V6WHOJz3dt0YCHIazrkduZ6E2iVg52I+fcl/8=;
        b=a5G6gb/e/Sv9Ky5ZQ78suPDbVQZj9Kajuq6TmMQs6rzBXM0Yf/sjeaSlAFu1/zjOEu
         EVAYPhIB6dhtOSiYpsSfjLrpX63wEqFSac/OAeSrPQFy10vJH7W0SccexXvC9GeoYFDD
         JoPsdFWkori5HWO7nJppNXket3uFojNBcJPVz9zgcoZMj8sE+GtSHdiH0YXkLOHvrEoN
         s+tJnnws9DOh+p7qpjs22wGVQGzgGnNyRl6mYiyPEhbNxR7apcYB+kOMVjIS7j/oeJru
         vZj7MR7eqeBrTgJeqJtUzr8idh64xbvVKnHwTZ/hZy++NrqDfguB309iFS8HejGeuhY7
         k/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680536537;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ykFFC7V6WHOJz3dt0YCHIazrkduZ6E2iVg52I+fcl/8=;
        b=aZRmBV7ei2raq3oaNULgcRdpg9sPb9bJQKFTF7U4nEbxS7zz7+WkgdqcmITdh6rt1W
         M0L4ZX+PL91qCNWjuqsNeWaLnAVnOotqh0qx/yNUak8a/mKQ4GEjR9GpQqSzLR+45GWo
         8isoBIv71HqXcXeNK45SY0Nb0tIA/MHTA5zCcrpEywsoOMdV5ZOHevtUA+8CSl56jR7N
         ITiatOaB2vSn5Q9K+kl45E/+DnILjcid86iUFROIDNKT4xpCNwMpl1LNFhxMKyxvgOmZ
         4VKgEM2iO0/fJZlq5FMHjDQcXfeKj5kskUAcT6R51Xf4s9J54ifexN4g2FWe1ANw9TMX
         4eRw==
X-Gm-Message-State: AAQBX9dwDU1l9jV7Qgirq9n2G1hCzyhvP2OMzY/6ULZtlGBMDwo8LZdl
        e28WVtcAlcnrN5j1mnguYOU=
X-Google-Smtp-Source: AKy350Ya0B+qSkzEa+MPoyJE+6Z7SOcPzHtXbm10ZAt0WYDj4oAZ/qyNw1wdqYaGsZhylbFJGgaKRg==
X-Received: by 2002:a17:90b:4d83:b0:23f:9a73:c20b with SMTP id oj3-20020a17090b4d8300b0023f9a73c20bmr40456289pjb.18.1680536537061;
        Mon, 03 Apr 2023 08:42:17 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id d19-20020a170902b71300b00198d7b52eefsm6771562pls.257.2023.04.03.08.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 08:42:16 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Robin Jarry <robin@jarry.cc>, git@vger.kernel.org,
        Tim Culverhouse <tim@timculverhouse.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH RESEND] hooks: add sendemail-validate-series
References: <20230402185635.302653-1-robin@jarry.cc>
        <66099367-4ea0-7d2a-a089-7a88e27f695e@dunelm.org.uk>
Date:   Mon, 03 Apr 2023 08:42:16 -0700
In-Reply-To: <66099367-4ea0-7d2a-a089-7a88e27f695e@dunelm.org.uk> (Phillip
        Wood's message of "Mon, 3 Apr 2023 15:09:32 +0100")
Message-ID: <xmqqo7o59dlz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>>   diff --git a/git-send-email.perl b/git-send-email.perl
>> index 07f2a0cbeaad..bec4d0f4ab47 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -800,6 +800,7 @@ sub is_format_patch_arg {
>>   			validate_patch($f, $target_xfer_encoding);
>>   		}
>>   	}
>> +	validate_patch_series(@files)
>
> This happens fairly early, before the user has had a chance to edit
> the patches and before we have added all the recipient and in-reply-to
> headers to the patch files. Would it be more useful to validate what
> will actually be sent?

I actually think the original intent was to catch errors in the part
of the file that can mechanically be created before letting the user
spend time on editing, without realizing that a later stage will be
rejected due to the auto-generated (e.g. came from a commit object)
stuff.  I do not know why we need another hook to do pretty much the
same thing as the existing one (which could be taught to spool and
then the last round to validate, in addition to each step rejecting
incoming one as needed), but at least calling it there would be very
much in line with the existing one, I would say.

Thanks for a careful review.
