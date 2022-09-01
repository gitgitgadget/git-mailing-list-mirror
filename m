Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99385ECAAD3
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 17:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiIAR1K (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 13:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbiIAR1I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 13:27:08 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42ECA8688C
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 10:27:08 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id h13-20020a17090a648d00b001fdb9003787so3351444pjj.4
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 10:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=i5kf6iosy3+1gP76xKqhL1GDjkVXDhFs3cWTOQda7Bo=;
        b=oGg+K76iY/PBzoueig68PV8/xFprla689XP7xuaGMfMu8XPURApqyFLU3n2tN0owP5
         q5aHyJHlzZ9LmlnUGARqD+pF4ubX+wcIDdhuvJhB1eq7c92B+hTDtGTkQdzyr9bUJ63X
         WPwR9bw62ULFq0I2IHn7RLh69t1VYAQIvQWhC+mk8OVJQHliMU1+U0P1lvWDnX1E26y2
         sjoK05zefdCQre650P/BVcLXXvSTn+WsDGlNEixulU4zs3ddWSZmfhL8PIgLBy2DE4LN
         8lnYHYbU3ikYPVdkla0mr9jhUDPzfnPa4azQvlBx2xZ9p36ZEoquNUIF/IhUyYtP+2+a
         H29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=i5kf6iosy3+1gP76xKqhL1GDjkVXDhFs3cWTOQda7Bo=;
        b=n1aTWTyPVs96U9VDcio9KLzsGrWLU8o9jnXHZjT9GcDGU4zJnn9YYceu7JR+qa525C
         b+W4HezKYwK1+8uZlzEgFI6f1+VfHAfSO67+Cx/K1n4FaqmXwRlbCpuLLgf1P10WtrPd
         CH6sNEQpKh6t6hbpPZO2pkz/FzSnnfB0huf0vq54aBe/dHenpjuzFkc4JJznWHpEUeRU
         Puu96cgieqVV4KhoAP+hdu3HbrtcUEyUlPewRbZW3K/kX1s7Bjn0743boVEjGGTTYCPJ
         5XOQszZEeVzuIiWGNOhzsTRbZg8zCdJuLFJpw7kGkYCJP1Uc8HUkB4YUJRYQWqJ4pmkh
         BZtQ==
X-Gm-Message-State: ACgBeo2/Zq3V+bDjmBmhlyqecUe3pA4+pD9mJS8agDYzvEPTTNx6N3jg
        rLHETk2nqMauWdj1oyeGfiw=
X-Google-Smtp-Source: AA6agR6g0xLGFOSegQ3PW7yxenfZCKQrF9eaZLeUO2eWfBQ0Zkc8YqGZqiAYP3nTnUAUVYbnn8lS1g==
X-Received: by 2002:a17:90a:62cc:b0:1fa:c17d:de02 with SMTP id k12-20020a17090a62cc00b001fac17dde02mr249774pjs.26.1662053227669;
        Thu, 01 Sep 2022 10:27:07 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id u66-20020a626045000000b0052da33fe7d2sm11846534pfb.95.2022.09.01.10.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 10:27:07 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, vdye@github.com
Subject: Re: [PATCH v3 3/3] builtin/grep.c: walking tree instead of
 expanding index with --sparse
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
        <20220901045736.523371-1-shaoxuan.yuan02@gmail.com>
        <20220901045736.523371-4-shaoxuan.yuan02@gmail.com>
        <xmqqpmgf9fpr.fsf@gitster.g>
Date:   Thu, 01 Sep 2022 10:27:06 -0700
In-Reply-To: <xmqqpmgf9fpr.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        01 Sep 2022 10:17:36 -0700")
Message-ID: <xmqqler39f9x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> writes:
>
>> Before this patch, whenever --sparse is used, `git-grep` utilizes the
>> ensure_full_index() method to expand the index and search all the
>> entries. Because this method requires walking all the trees and
>> constructing the index, it is the slow part within the whole command.
>>
>> To achieve better performance, this patch uses grep_tree() to search the
>> sparse directory entries and get rid of the ensure_full_index() method.
>
> When you encounter a "sparsedir" (i.e. a tree recorded in index),
> you should know the path leading to that directory. Even though I no
> longer remember the details of the implementations of grep_$where()
> which I did long time ago, I think grep_tree() should know how to
> pass the leading path down, as that is the most natural way to
> implement the recursive behaviour.  This patch should be able to
> piggyback on that.

To avoid unnecessary scare, the above is just me "thinking aloud",
after reading the proposed log message, and agreeing with the
direction taken by this patch.  Not giving a suggestion to go
different route or anything like that.  I should have said "OK" or
something at the end of the paragraph.

Thanks for working on this topic.
