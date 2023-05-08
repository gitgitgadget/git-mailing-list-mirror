Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29522C77B7F
	for <git@archiver.kernel.org>; Mon,  8 May 2023 20:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbjEHUx2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 16:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbjEHUxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 16:53:25 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AB66A7F
        for <git@vger.kernel.org>; Mon,  8 May 2023 13:53:24 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-517c01edaaaso3250630a12.3
        for <git@vger.kernel.org>; Mon, 08 May 2023 13:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683579204; x=1686171204;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5fYfYU9c+l1IuNfqUrc/bCzKkQNLq2O4grZofoFemZ0=;
        b=eAGJJOBVeQmtOg2RkA1D0gd6Q3SWWb2Ez2b3TuuRN8ztqwIlty0B8cOcGdfZpMrPnQ
         LG6sdVI//vXJJXO6B+oGEJ8zDYhNmSmEO6NCvJ9fuWu3NOayPjj5qbKg9qYxbjDKTxAb
         WIM9x45RFjiHuqwW2rJuzswcnLy4Tz3+qxe8FmaQ+dJd8YM+ejWjUQyA31xw8bQY0lYk
         M4LEGcoFDLRz+IrLqTOoul+lLMJjmBUzUO+2sp3xwHBEJrOlpV5aPGFWGWafIPXQF3Sj
         wrOJXucdyj2dG1xWeXXG+IFNYZ0/Y68yjdkY+GS1PLHAGc00rLy5+uORQXDP81Vp37FC
         I3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683579204; x=1686171204;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5fYfYU9c+l1IuNfqUrc/bCzKkQNLq2O4grZofoFemZ0=;
        b=gnDlEDtw5zh25986YWwsE1hYZYzW60N9k0dN8wDlSQ8z15Mz/irOxEORjwwfeh57F2
         BHckwytvT9HLyBROqJVpfwkVixXmYuS9QHNZLBQc1pTOC/IRkzR28pk8sa7N0Yir/nML
         CcH4PUcLKZozbJ+BrvVeNVev7hcb+mG3mF/XyACryBpkV6LPfK1eqqLTk21tF00HTkva
         GW/K1HZxY8VYMpAy98piSRZUkreSJ2VYUVm/h/I+lE3mWHZT5GbPcZik9AR69wCk4e2t
         xpgTsc5GJwCCfRYUQGs2yynFUFC5sIdFrAKUki7t55HL1ginmfMq08OAzqOTJYHyvbwc
         JfSw==
X-Gm-Message-State: AC+VfDwplR0ZSB6GOLCjDdV3FZEinUxAFjzZsTc8lSPTHFHYx9+cFn4x
        GJiFzJdoG60x5CUc5ZsQ7B4wxtudC9E=
X-Google-Smtp-Source: ACHHUZ5GrGskG8H1sQ/5Vf1KVi/vN3wbZafUEnyOg31P4CIVDwoOsg/cuYmEvpg7WIVuINNqKf8iyQ==
X-Received: by 2002:a05:6a20:2591:b0:f2:8c89:cd30 with SMTP id k17-20020a056a20259100b000f28c89cd30mr15785700pzd.13.1683579203588;
        Mon, 08 May 2023 13:53:23 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id n22-20020aa79056000000b0063d24fcc2b7sm420077pfo.1.2023.05.08.13.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 13:53:23 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t9800: correct misuse of 'show -s --raw' in a test
References: <xmqqild5rvvw.fsf@gitster.g>
        <20230508185545.GA1893355@coredump.intra.peff.net>
Date:   Mon, 08 May 2023 13:53:22 -0700
In-Reply-To: <20230508185545.GA1893355@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 8 May 2023 14:55:45 -0400")
Message-ID: <xmqqild2mtod.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> * It appears pretty obvious that the original wanted to just grab
>>   the %at timestamp of the HEAD, and with the fix to allow output
>>   format options to take effect after "-s" is given, the existing
>>   misuse of "--raw" after "-s" that ought to be a no-op breaks the
>>   test.
>
> Yes, I think this is matching what the original code was trying to do.
> The patch looks good to me.

Thanks.

This still can be a cause for backward compatibility worry, though.
I do not think anybody would have lifted $(git show -s --raw --format=%ad)
as a way to get the author timestamp from this test script, but it
is entirely possible that this was written by the author who saw it
done (incorrectly) that way elsewhere, and who knows how many others
copied that (incorrect) way of using "-s --raw" from that original
source we have no control over.

Anyway.


