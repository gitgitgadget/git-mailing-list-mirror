Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B383C77B6F
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 21:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjDJVFu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 17:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjDJVFt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 17:05:49 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16821BD8
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 14:05:46 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id v9so11067081pjk.0
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 14:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681160746; x=1683752746;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNn+fqP7AbH09R5goJ76XuTqmfsUrL5QCglYTfi7nrY=;
        b=k0m9Dkkr90eyVR8RSzDMRMu7Kd6uL00zOSpVrjwM7kn3hBt+y9UuDkheUkOPEH0jY9
         G3/6meEbpotN35oCEBtCZIgAJjZAZ4aqfd/CHC5QlBgj4Ef9jueuiDp9IG1IArukNtUI
         PdvNY+eQaEwLQ0RqYTCJ0CBMAFmtcMW38gxD7sCRB4y1ec7r7XrLXaSjuALSN8/CngfI
         iLC/4x5fB9N9fF9V/YqMO6L8e8sH4NuwvmcaP+HKLKghvbr7GaNEGhYhNXBViqt/xK9u
         mySXhqjG4XPTh03TdSLK64OHm4Cf4DpAv7SX04sJf5h+nOUGHAjW94ma5gcabFpBP4TE
         ef7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681160746; x=1683752746;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TNn+fqP7AbH09R5goJ76XuTqmfsUrL5QCglYTfi7nrY=;
        b=79hryEyfZaw3P/fulVCMZdGlhrUGQ35CqaD3dcDhbjDf3bNI0XDV4+ATzs8NOdgLRO
         JzXl1ins2BAh0tIsBo1pRHvgQEp/o6VGytzfMAs/tV3I4CdPhH+JdYoyPpT1Cw4ZIa5D
         ZPytA9vkae+dgGAHV4m6pnCzdfmro2WQ3/cMBDwBZT+DTPd5etftegxvs2S1dbB8OJ2e
         2H1dPKHbryBQycCwoICx8jvW8WjLeIYVoZ2BzFfjAeCPCIqFB8iCc2WI2bq7k5K66mvJ
         /BmAXwgqsvUvSDKfBpFfI9llcnXu+6M1tdW7ahtC4BPVfKmQsuD4K0e/32NJfBbVAjFr
         vlEA==
X-Gm-Message-State: AAQBX9c4yY+uVWFswU5JmQkf6inbR/z8IWnvv6om94QMHfw2pioOvS6M
        3Mp7Hc+LI/xhzVJtaJV2eKw=
X-Google-Smtp-Source: AKy350aNa5oMIxSPmvidAnyc0LOrmK1ECvAv43gRZTgjrh/bT4PhXvo6As+eLpwiPrqvoU7c4bTimA==
X-Received: by 2002:a17:902:cec4:b0:1a1:c8b3:3fe1 with SMTP id d4-20020a170902cec400b001a1c8b33fe1mr9951528plg.31.1681160746133;
        Mon, 10 Apr 2023 14:05:46 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id l14-20020a63ea4e000000b004fab4455748sm7517236pgk.75.2023.04.10.14.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 14:05:45 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] date: remove approxidate_relative()
References: <f5b9a290-7cec-7a83-660b-e15494d2cdc8@web.de>
        <xmqqjzyjemji.fsf@gitster.g>
        <20230410202536.GE104097@coredump.intra.peff.net>
Date:   Mon, 10 Apr 2023 14:05:45 -0700
In-Reply-To: <20230410202536.GE104097@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 10 Apr 2023 16:25:36 -0400")
Message-ID: <xmqqy1mzcus6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Cute. It feels like this only goes half-way, though. You really want
> per-hunk configurable context. This particular patch was just lucky that
> there was only one hunk in the date.c file.

"-U16" extends the context lines in both directions by the same
number of lines, but most likely you need to extend asymmetrically.
In René's patch, for example, much of the body of approxidate_str()
is visible in the precontext of the hunk to remove
approxidate_relative(), but the body of that function is irrelevant.
What he wanted to show was the body of approxidate_careful() and the
size of that function is where the -U16 came from.

Instead, imagine --extra-context='<range>:<path>' were the way to
tell Git to include the specified range of lines in the post context
even though they may not have been modified.  Then René's patch
could have been produced with

    $ git format-patch -1 \
      --extra-context='/^timestamp_t approxidate_careful/,/^}$/:date.c'

and would have shown 3 lines of precontext before the removed
approxidate_relative(), plus the unchanged approxidate_careful()
function in full in the postcontext.
