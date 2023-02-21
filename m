Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD811C64EC7
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 18:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjBUSmT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 13:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjBUSmR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 13:42:17 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290F02DE6B
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 10:42:17 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id nw10-20020a17090b254a00b00233d7314c1cso6051595pjb.5
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 10:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jISBx6TxEUV9AJToOgmqDUXPHwz+v1W3VLpIvlTrCeI=;
        b=RIxJ35yu3NhrC6zAbDT6twHzOqgojoQTWxiBa02J9YgM+1UKRWcW2RjSMEAEmqDTy9
         RJcUISYwM0y46bCHmr5G06v384aQiXvIvNIgeL66ptG4nz/OybtS/rFFOlq+MWoatD5t
         Nu/W1KxC5Ma0BCSoT1F8e49b23xjOtSgAvGOfpz1odY31smFRX6cnjaYX+qJnz55U0v9
         HWimCAvy18SdnJvBBoYkGVHWBFMBzytYgrHX9EgX36GhL/4x1AMByq5KrbVZTI5tosi4
         TylmBIOoXevQv/HETKlAYM81yGCLyxsm5+C1EXnVr6VJKaBC7dbn5pDYw3XCKmuWepMG
         MeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jISBx6TxEUV9AJToOgmqDUXPHwz+v1W3VLpIvlTrCeI=;
        b=C73fw/hs1z+JvubEDij2h/QTolL6Srlhy4c9cSHwF77xKJx1o8nj34Es5Ox/8DMdTC
         /n8uxdaOBrYtCWCtWl9xmDW2eJhiFAp0dUwaqu3JK0LREc0FQWus8TJQs3Z7wfqiIilo
         EHWW0Wdk6Fvf+F6fgXBpihr81ySlPcDucYz6mKE7nUBr4rKwQ22MVDphGnukf6RMyWZ1
         Kv244g8SKRS6vS9eMvj1HBGJzA1Jz5HSFRTZOocyJkNihpYVkdjoSUAJ+TjRYGw3fqaY
         ulzA2U+Vtf38lxA2fSlzdtpx5wIkZz4NaNaT9Qbd0ATlJ0QxgydMIQcDDTMxcrpMSTsi
         mklA==
X-Gm-Message-State: AO0yUKXhcmSncXHCnmSvZNOR/AcJwx6vI3H4MvC9WSBFZDQ8KvCjhiNC
        t0wNZD9L4BjffBen/DAclIY=
X-Google-Smtp-Source: AK7set8GjIK0B0zNx5HoDplZp0lVNPnxq7ZEdMvA7JrEAfwUKZmz7fVxHCK5U2QZDvBi8jpIKvmJng==
X-Received: by 2002:a17:902:ecc1:b0:19a:b67a:5bd8 with SMTP id a1-20020a170902ecc100b0019ab67a5bd8mr6623914plh.55.1677004936482;
        Tue, 21 Feb 2023 10:42:16 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id c14-20020a170902b68e00b0019c912c19d3sm1943144pls.62.2023.02.21.10.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 10:42:15 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        tao@klerks.biz, newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH 1/2] rebase: add a --rebase-merges=drop option
References: <20230220033224.10400-1-alexhenrie24@gmail.com>
        <xmqqr0ukggk5.fsf@gitster.g>
        <a856dd16-9876-509b-6a99-11ea0020633c@iee.email>
Date:   Tue, 21 Feb 2023 10:42:15 -0800
In-Reply-To: <a856dd16-9876-509b-6a99-11ea0020633c@iee.email> (Philip Oakley's
        message of "Tue, 21 Feb 2023 16:08:19 +0000")
Message-ID: <xmqq5ybug8s8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> Maybe it's something that could be included in the Glossary to
> supplement the not well known how-to discussion in
> keep-canonical-history-correct.txt

Yeah, "linearizing the history" may be much easier to understand
than "flattening".  In any case, a canonical reference would be a
good first step.

