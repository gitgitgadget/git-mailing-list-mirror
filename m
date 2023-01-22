Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F8CC25B4E
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 17:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjAVROq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Jan 2023 12:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjAVROp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2023 12:14:45 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E811816C
        for <git@vger.kernel.org>; Sun, 22 Jan 2023 09:14:44 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 7so7421617pga.1
        for <git@vger.kernel.org>; Sun, 22 Jan 2023 09:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iexi5o4XgQamAGbPfgpraznJvl7nGAF/s66w6L7r0SA=;
        b=LGreeiUIW+yzxAZDS7ENd7kvAHjS5X7O15WZV45u/bOt//94MNzDzpk3pqqYtaDx6I
         VuchwCSttp9NwHjO+kdpGD8E0OnNfKT6zFZiWNEl5fJJzmmab3Zh8jNFsPuPR9rTGyDB
         sgFDXQX+NWa2Hd4meqMrqBEC7cSIsvDSfatDkKB1UYx+yejF787D4uaXjh7mst1PMRPw
         qbcstG6dkIEg3LuUc3gX1GaXZElx2mlHu/jO5HRNEFDAW7mEWnNirSuTJzI0Cv5jQxKQ
         N8TA9Kk9HNEzO0tXCYt4eLuXn7kIbFF5Ek8V5etLY+A1UkQbBCZ5SE8I/Lz8yjbkpJ6s
         AtnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iexi5o4XgQamAGbPfgpraznJvl7nGAF/s66w6L7r0SA=;
        b=WgktkmsPAXs0oPUlzErL9cWSFSWlgl5BH/ZZhm2o/v/qtpy44o+qu1kjooWmSQCQTu
         v5xre2TKZQZR6gl37F+o2KmFbuBeNnO38FMxgf9LUJBiVXOKZVkt3ZZH0EDTunnKa6F9
         AaFMHOlp+XtflBbVrIuHfUB+JoH+Ypl5aiFLVD/U4mSiHrbb9/7e/F87JK9tgeZpiTDy
         jrUJb8Upnq0RGFH1k07p0quz3n1oKRv/dKmW7RB2rvr+HKCbDOL/dNJDpO7xLuACsmAq
         rtKI7Zgy5VecOr9rp9XVUEeeXS1z7t/9gp2fQAgJQqmZ2JKXwNy/jLh5t7jLuxJKPLTQ
         SqYA==
X-Gm-Message-State: AFqh2kqN+X33OQ0JPGxA2uGOWB3zC20k9J1gUKZf+nbWe3jY82qqbpoj
        /VjhEBOyxz6EnXGpgg0TZOAy4suLoP8=
X-Google-Smtp-Source: AMrXdXtZjD39XTFtwe094qQrcC0KwbJy3lNiT1GbzPUpXTLdfIRNLLhbM80J05zRoEPYf2EgzpNGhQ==
X-Received: by 2002:aa7:8f11:0:b0:58e:2112:bc2d with SMTP id x17-20020aa78f11000000b0058e2112bc2dmr8503019pfr.6.1674407683474;
        Sun, 22 Jan 2023 09:14:43 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id v15-20020aa799cf000000b0056bc5ad4862sm21189831pfi.28.2023.01.22.09.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 09:14:43 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] MyFirstContribution: refrain from self-iterating too much
References: <xmqq3583uyk0.fsf@gitster.g>
        <20230122071156.367jwwt3d5txvkl4@tb-raspi4>
        <xmqqcz76tv6d.fsf@gitster.g>
Date:   Sun, 22 Jan 2023 09:14:42 -0800
In-Reply-To: <xmqqcz76tv6d.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
        22 Jan 2023 08:01:46 -0800")
Message-ID: <xmqqsfg2qynx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Torsten Bögershausen <tboegi@web.de> writes:
>
>> Or:
>> Re-reading my own stuff, I think that things could have been done
>> in a way like this....
>> Lets wait for more comments before I send out a new version.
>
> Again, very good.

The latter one (different course) needs spearate treatment from the
former (typofix).  Small corrections without changing course is
better communicated with "will fix when I reroll" while a drastic
change should warn the readers not to waste their time on the
premature initial version, i.e. "I came up with a drastically
different and better idea; please ignore the one I just posted and
wait for an updated one".

I'll sleep on what I rewrote to see if I or other people find better
phrasing.

Thanks.


