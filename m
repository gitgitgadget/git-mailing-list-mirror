Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468CCC7EE22
	for <git@archiver.kernel.org>; Thu, 11 May 2023 05:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236961AbjEKFE6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 01:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236953AbjEKFEz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 01:04:55 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A33F40EE
        for <git@vger.kernel.org>; Wed, 10 May 2023 22:04:54 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1aad5245632so58451635ad.3
        for <git@vger.kernel.org>; Wed, 10 May 2023 22:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683781493; x=1686373493;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z0+WXGj/Ppc5haWMI0isdYIWecJ1BHzwbMK9TbkAaLw=;
        b=JKuBJux/KdY2rMa/71IousR06qm/5HDXDIx/hFcK16cGZUVc/7SnEcskr3YVPE+NUj
         fxH5YDvOvMcFsFq3Qvxer+R82TDHjIt8bbL6aShVxiKwz5PyYQJOiJTSSqyQ1V4lHsD4
         8raqQGeARadG8vlSWeJNr4oA2HKdtnIOepZ6EgOFSj5u+yeeki3kQiarpf7fj/6MLBxw
         MPYUn22FQlorwiV+fCC+Zam7cFgCmI0mBq24atIkijnePc+ogqXDZCQm5zudsKA9jZIb
         bgvABAuxDnJ0bFH+YlT3/oWjruTtj8dSSaKOyluKnUxArceQjXJuSgogR9J9K8wpO/Zx
         iLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683781493; x=1686373493;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z0+WXGj/Ppc5haWMI0isdYIWecJ1BHzwbMK9TbkAaLw=;
        b=On9C5Z65yQRxzTzVjKR6GqkWTWvWUDajroJcY++RNj3Ib4Ly1L0+Gs2qXPTyV3iJwc
         +Ws4mKKf3kI82bpn6bzRfSNdHprCMQIYbc/4X9GIRERqd65Q6SxoQl7pe1a9Qs+Zycvv
         P2Q35v4u//HLJxwT33ng0gTEkFjch0GJnwLmuEuieJ3Kt8VkA5PvRZGbXXJCRmAbk0p+
         GVU8wWZ7NqmFdHtcWoBwbZxvpzwAZfWPyCR8A4F/NpJnL7Tn+x9PhNW8WXYllpX2fI2u
         SzcEHMcwSMsYM5DW/ZuOC41pFTSGWAzmGr0eeghnjiNnHNMdvjXsYjJKzf3hnOvciDjG
         ra9A==
X-Gm-Message-State: AC+VfDwyVIyYafRSw9b0j34bVDO7UIiudvdiJIYD9O1BHkYJccOTYnkr
        1Hpa4HUaQcQoDBur6Ynwces=
X-Google-Smtp-Source: ACHHUZ5Qfy+OmVz7LLpaDi01nhTf2maEM5LII6Jw1kuEUdhTNYFsIE2CwTHyoEODquBAktTeapdUwA==
X-Received: by 2002:a17:902:ecc4:b0:1ad:8c8f:afb1 with SMTP id a4-20020a170902ecc400b001ad8c8fafb1mr4681229plh.39.1683781493362;
        Wed, 10 May 2023 22:04:53 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id p22-20020a17090adf9600b00246774a9addsm14303627pjv.48.2023.05.10.22.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 22:04:52 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, git@vger.kernel.org,
        derrickstolee@github.com
Subject: Re: [PATCH v12 0/2] diff-files: integrate with sparse index
References: <20230508184652.4283-1-cheskaqiqi@gmail.com>
        <20230509194241.469477-1-cheskaqiqi@gmail.com>
        <f51a8d77-c480-f021-38c4-78a9d75cdd11@github.com>
Date:   Wed, 10 May 2023 22:04:52 -0700
In-Reply-To: <f51a8d77-c480-f021-38c4-78a9d75cdd11@github.com> (Victoria Dye's
        message of "Wed, 10 May 2023 20:41:52 -0700")
Message-ID: <xmqqbkirzcej.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> This iteration looks good to me. Thanks for keeping up with the reviews and
> getting this to a polished state!

Thanks, both.  Let's merge the topic to 'next'.

