Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34124C7618E
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 01:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjDYBzg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 21:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbjDYBzf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 21:55:35 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DA119BF
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 18:55:31 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-3ef6e8493ebso10798681cf.2
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 18:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682387731; x=1684979731;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GVHV55zhWIBJTvoMfoLesGOXYpd6ZSh/u0El9PvmbmM=;
        b=PcyG6wAdp+65I6/YdAYlNi3CfQfte/taqGOsOQfCvM/rgotjFD/lyL+R3qd+0eu2Fr
         OFo9S5rsluxpbVMcvDFgE074OTm6MWoEgcbCLJK9SEDS2//KgGHEpK7EImZlGeMICexN
         SHB21wDqA7TqqW3BxuWc/kKT5UZfGTiAMBMBFptWzhLl7Q/dU3Uj6ID6AoTMvxcgoiz9
         qtc5fil6EcXZJIU8gJScbRe/yOq46jAQK2q6aF3Git9ydVLVu3W6jutUHWd89KKk+Jng
         HO6P5m3zbvzprjmyPMyHVnTFxdTMuxdjJWCmwkt1RmPj3kio6Olqxi6ezqhVx5ETJbim
         zSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682387731; x=1684979731;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVHV55zhWIBJTvoMfoLesGOXYpd6ZSh/u0El9PvmbmM=;
        b=ATvWoiF4ORTMrMLVQI1tP9jCaFFBe4fzS06cr8LWLqYiOOKd8GT90l4nJqc4zVZPUg
         jlJkMe3gJGTHREDNvBov6abDUCzeyf7GIkaTNs4A6ZnTMDPw0jzGAY4eUhTqzPQV0dHs
         Kx99O+sRNwwIZo4ITjuApsGOA0+y+Pp0B1eSWz0gqpdhnGeaWRRqQWb41Cw1BqNwPjFy
         vpDaf9a0I0lr5zuXslbdrHvUHDTNu2bFZcaJm8dPY1rAhMv5pJmfwcdfwbXbOXw2lhNt
         XDAyVEb0DBb7KE1sOluwAOSgfdZlouFaE1YJN95FYHlIQrj4g7xYzeR+1YJ1+ocPVupj
         vDxQ==
X-Gm-Message-State: AAQBX9cQLdh18zCcDAISEoP2XO41grblXJNcicHtvI2CHzLMzG83a4fn
        XjfMcPMVwnGg/PRUEsc6U7ny8ngXp8Y=
X-Google-Smtp-Source: AKy350YUDsPfroiuO5WhJ+0xCsfTGTfshMyhIOxKGedrsf7nRT2CPCHeef0WCjLC6kG83BO/CiZzuQ==
X-Received: by 2002:ac8:5bc6:0:b0:3ef:36d0:c077 with SMTP id b6-20020ac85bc6000000b003ef36d0c077mr22983032qtb.49.1682387730797;
        Mon, 24 Apr 2023 18:55:30 -0700 (PDT)
Received: from hurd ([2607:fad8:4:3::1003])
        by smtp.gmail.com with ESMTPSA id o8-20020a05620a228800b00746aa080eefsm4013459qkh.6.2023.04.24.18.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 18:55:30 -0700 (PDT)
From:   Maxim Cournoyer <maxim.cournoyer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] send-email: extract execute_cmd from recipients_cmd
References: <20230423122744.4865-1-maxim.cournoyer@gmail.com>
        <20230423122744.4865-2-maxim.cournoyer@gmail.com>
        <xmqqedo99cnu.fsf@gitster.g>
Date:   Mon, 24 Apr 2023 21:55:14 -0400
In-Reply-To: <xmqqedo99cnu.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        24 Apr 2023 14:46:13 -0700")
Message-ID: <87y1mgrail.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

And thanks for offering a review!

Junio C Hamano <gitster@pobox.com> writes:

> Maxim Cournoyer <maxim.cournoyer@gmail.com> writes:
>
>> This refactor is to pave the way for the addition of the new
>> '--header-cmd' option to the send-email command.
>> ---
>>  git-send-email.perl | 26 ++++++++++++++++++++------
>>  1 file changed, 20 insertions(+), 6 deletions(-)
>
> Missing sign-off?

Added locally; thanks.

-- 
Thanks,
Maxim
