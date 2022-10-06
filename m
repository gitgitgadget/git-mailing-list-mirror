Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B55C433F5
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 18:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiJFSwq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 14:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiJFSwp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 14:52:45 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B623B14D1
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 11:52:44 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id h13so1443366pfr.7
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 11:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f7HtxBlR4bT5FN8YbwY/qKY6iLD5VOdkZdlQzFLqSIM=;
        b=i5qo+MY503obvIpS8FrNFKKt+jlAuVnQHX7iY9pTab0bYImESZLfQpty/Kk+MZIH1j
         MpiMwqVeOt4/nBRHZV9e3CqvlDlV8ymh4oKFwI8QVIYPytERX0CCtDIJdww18NXzjgmL
         dxo5Q2JlsH7q+p5rkXeKPW+0hD1McpBNrRQ6+m4H33/FXSfj0SABzhB0n/bydD4dyuN0
         roRTgRIPuFuIFkWu1+VQibvfhVi58qzPHBYYhk4Xa6oLc0ydRTl1eQ8d2oCiPM24Fxu4
         L71Pt88Z/4U8itF8TYwNZuKh3moDY1zI/pgmpJgPh5SE6jnk1B8qTtQA72WA6/K5Fwg2
         vgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f7HtxBlR4bT5FN8YbwY/qKY6iLD5VOdkZdlQzFLqSIM=;
        b=FScxmsu0tv1ocVaipwIm1pNKtyxUq7X8Py2LpaQKETDHQXRl/tEivewU6ei7RUQBtI
         PCGbQPyrrcxn7QBabtqvC/uROLO2cUGF9d9nOpvGMPsuTVQqhrRGIWbqRAhflOaS6a+M
         mci7YybH1+1qLULz6oZj2yr+0n4NS76G6rSHRxCQjg2mgtr62VTSLQ+1Di7PYQ78dgvZ
         d/qVg0a6ZbyvDMEkAHBsJtnAw+kDIgLTXKw/WxJHmvtLVORgjocn6n95qwzBYGaG8a1+
         6yYdULR0jyBFFwcYeNWluuuMww60BRdwMy9b3xfPky+8U5+xcvwa6wWOv1uwK6GgmV83
         YG3w==
X-Gm-Message-State: ACrzQf2o23HPxc7Aeg3dxxWJNfcvZL6K20OhtYUHudj/Mxz+aRpBtssM
        GYvH+FthOxjMytEL82ZSi8P6Z/m20v4=
X-Google-Smtp-Source: AMsMyM6Dy6dDv0fwBabDfRh3gxHo7eIvOZ0VzvJMHcKFzOmA0hgf5Z3ssY1QEvATe7oloV9RyYnu5Q==
X-Received: by 2002:a05:6a00:1c99:b0:562:6292:9e4e with SMTP id y25-20020a056a001c9900b0056262929e4emr887303pfw.22.1665082363673;
        Thu, 06 Oct 2022 11:52:43 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id c13-20020a634e0d000000b0042c0ffa0e62sm76954pgb.47.2022.10.06.11.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 11:52:43 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 4alt/4] attr: drop DEBUG_ATTR code
References: <Yz7Tjy7Rh8cXVxYQ@coredump.intra.peff.net>
        <Yz7UhYXvNl6+1GbZ@coredump.intra.peff.net>
        <Yz7Wx4kVbrZFfm0s@coredump.intra.peff.net>
        <xmqqwn9clwba.fsf@gitster.g>
        <fb4cfbd3-e738-f1e8-18f7-d4e90050b8b5@github.com>
Date:   Thu, 06 Oct 2022 11:52:42 -0700
In-Reply-To: <fb4cfbd3-e738-f1e8-18f7-d4e90050b8b5@github.com> (Derrick
        Stolee's message of "Thu, 6 Oct 2022 14:33:08 -0400")
Message-ID: <xmqq1qrklr7p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>> I highly suspect that I was the one who bothered, and while I admit
>> it was useful while developing the attribute subsystem, I haven't
>> needed it for the past 10 or so years.
>> 
>> So unless there are some folks who want to throw everything into the
>> trace2 floodstream, I would prefer this alternative over the other
>> one.
>
> Are you implying that you want to use the second version, that
> deletes the information entirely? I'm leaning towards deleting
> it.

Sorry if I were not clear, but I would vote for using 4alt/4 and
remove debugging code.  Unless there are folks who want to keep it,
in which case I think trace2 is fine and I won't insist on removing
what those folks, if any, want to keep.  Between trace and trace2,
I do not have a strong opinion but if we were adding something new,
we would be adding to the latter?

> If not, and we should keep using traces, I do notice that the
> original version of the patch uses trace_printf_key() instead
> of a trace2 method. I think this is fine, too, since it's
> likely only to be used by Git developers, who could look for
> which type of trace to use.
>
> Thanks,
> -Stolee
