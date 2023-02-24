Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB74BC7EE23
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 17:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjBXRUl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 12:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjBXRUk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 12:20:40 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7056C1AC
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 09:20:34 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id z20-20020a17090a8b9400b002372d7f823eso3514285pjn.4
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 09:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZNOQoUhsrQJw4qYGXEKY1R/DCFFMDXJ8PcCeQmcBzLY=;
        b=SUucCTtdgAR4TLWG3NO4st2VAViiKR86Uhik8TOj7G+sJkcgmoCb2V02t2esWquLTq
         ZFp6WgTkFbAqLAomUXo2KLbpP+LztbVTEAyyzuOABKRIhPvaRldcpMhqX8XMqwrKKA9I
         sIyIQmsU8kagUxK2uufadN0acMi2KYxD8rmfjP/xdh0NHAMCzBwUIbmpt6OqEWKbi9Av
         WbmVjL9mhjp5ZKbS6F9n0sOjK3K3Ke5V1gSOA5rsnEba9C2AmuryM64Cl4Yrod/90/3C
         mRtFaVD6mWz9FxrK5HQBazNWmGpvq4kuFuZVtdrvLDnjiu2P7u0FKoFx1vPU3IyrK6Ju
         +Tuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZNOQoUhsrQJw4qYGXEKY1R/DCFFMDXJ8PcCeQmcBzLY=;
        b=p8P8STeJ+Du3i2z0rtfRa8so5otQ1G3eZ5DOtqHXl5iOfIhd0NeIJtBj6qZEiizWIx
         T16yNktDKtc+tMWtSTOKRz0oH4H5bt4sHOVV9V78qW090WeZ10AZr5nrx8Te4wwIvIHv
         nUdYzMP4s6CgoxS+ZQUIHaydkYBO54CktILVoWl9bYgtdYQv3iUXSHJ6J9mX8snFqVrd
         Jq0aQBNfUJBGr3pWKKi0gdg2bEyt7CaI7s72VmxHURyJEnbzpdpKHQM280V+Ge26Bmkh
         vNjxiu7XfoimHtvzZVik0dZWgQ2zYoU5mCg8lu06Q5gPdrhbOSZqsvfjn70MCphnZCin
         DjHw==
X-Gm-Message-State: AO0yUKXCdC5+V8j/w5nbcN+imXX9Emw9zGV9/c8maPpySplpApQhFWMf
        Rh442UjOnj2B+YcOwaev8CDiIIJ8Hjo=
X-Google-Smtp-Source: AK7set8F6nxXuHQBfHWWtgISJ1bjEvt/UgRDrVeisl+GnWe3rOlKYYI2FTl+SqcUDeQtWmg26cKRyw==
X-Received: by 2002:a17:903:22cc:b0:19a:a6ec:6721 with SMTP id y12-20020a17090322cc00b0019aa6ec6721mr19563227plg.16.1677259233987;
        Fri, 24 Feb 2023 09:20:33 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id g2-20020a170902868200b0019896d29197sm8091679plo.46.2023.02.24.09.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 09:20:33 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        tao@klerks.biz, newren@gmail.com, phillip.wood123@gmail.com,
        sorganov@gmail.com
Subject: Re: [PATCH v4 2/3] rebase: stop accepting --rebase-merges=""
References: <20230223053410.644503-1-alexhenrie24@gmail.com>
        <20230223053410.644503-2-alexhenrie24@gmail.com>
        <b4be9cb3-c24b-4377-bab3-5d53035efdf8@gmx.de>
Date:   Fri, 24 Feb 2023 09:20:33 -0800
In-Reply-To: <b4be9cb3-c24b-4377-bab3-5d53035efdf8@gmx.de> (Johannes
        Schindelin's message of "Fri, 24 Feb 2023 14:54:14 +0100 (CET)")
Message-ID: <xmqqy1on0yla.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 22 Feb 2023, Alex Henrie wrote:
>
>> The unusual syntax --rebase-merges="" (that is, --rebase-merges with an
>> empty string argument) has been an undocumented synonym of
>> --rebase-merges=no-rebase-cousins. Stop accepting that syntax to avoid
>> confusion when a rebase.merges config option is introduced, where
>> rebase.merges="" will be equivalent to not passing --rebase-merges.
>
> Being undocumented and obscure might be a good reason for some to consider
> this a bug; I do not. You could deprecate it, but there are probably
> better ideas than to remove it without prior warning.
>
> If all you want to do is to support `rebase.merges=`, you can do that
> without having to change the meaning of `--rebase-merges=`.

Thanks for a doze of sanity.  Let me mark the topic as on hold to
wait for a resolution.


