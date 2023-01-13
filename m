Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF7BC3DA78
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 20:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjAMU34 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 15:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjAMU3y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 15:29:54 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6AFF580
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 12:29:52 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id y18so20081895ljk.11
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 12:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wRJ9AEuZ1XNt9/tePk1DWpPC9YNOxQEWsHMfQ5PMPZs=;
        b=mALbCMzGyQyNNUc2ho01mhMqhFSZP3Uq9/7xq6+S1JBvSUA25Ua6VtY8QsH5VO6efs
         lqbXN3Hp2gO9YRo0rSt+Tf+g3R3QAe/wQ/mJrfY4S4YM4C8YFYB7ESyuL9aQCu9D4Vwj
         kA3rc7C4eQCrzyCT4qsMOXU9L3xlKRLfjiQYLWXJ9qh1JwRz8xAQRkQjzvX0M5Yt+Dup
         bhq5vRCZlm7iW3KTIkWAdBoHrILlNvFM4wZuUG6oWS3YdZNNmN3TY5gpZfd5n5CC1Dgg
         BItqJI+qJFcOVsxZNUv6wf+ERjtUOVl4ujqjMtQLKndMLvwbximfhyFm7IJ2sij3TNJg
         pG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRJ9AEuZ1XNt9/tePk1DWpPC9YNOxQEWsHMfQ5PMPZs=;
        b=4DEZ0VOh7lskDzznJrRBePd1YlhEeh75fqKdulc5FnYb6CqF9UkLeT0V7OtFgI7EEs
         4/lPoHwlsM7gFkuS4eE6XDcxCeMrn86YEDP9L4isr6NdJ1+DG5kjx8tLvbsv1yb6GzxQ
         dxjIwTN2gVAid7rHLT2vHBEelZa2JRWpQOtLzRDQcQ+bCoasUKBsGV9PE8Z+xsXxElRS
         gFkMAd0DLTXvn1f/ayt8PdOUcEHfj/jC0WbLZRwnlm7udVyBR+ZYfGOjxbMlNEa8KkiA
         E0qkKW/es+i+oC5D6Y87D8QKTl9Abyxf1t5QezUwIJpRrVZL15s+ilJj+nvU1lUPMCiz
         ABVg==
X-Gm-Message-State: AFqh2kpjhhUoBWUBvX5fIdFcM7Pmxqo0RWcwiNonJ1muVjTuINNe2X2f
        PKo9lJ8NQBbsH+GTb5MMfOG11299B+0=
X-Google-Smtp-Source: AMrXdXvwXtN54Hlh4n74XJQzl58fAJm1hVCHWspnjQqpW3wOUvj5IEbx/LG3nqpH3itMV58lNM618Q==
X-Received: by 2002:a2e:92d5:0:b0:27f:b5be:66b5 with SMTP id k21-20020a2e92d5000000b0027fb5be66b5mr24083643ljh.50.1673641790657;
        Fri, 13 Jan 2023 12:29:50 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 17-20020a2eb951000000b0027fb4086834sm2682329ljs.15.2023.01.13.12.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 12:29:49 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Olliver Schinagl <oliver@schinagl.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] rebase -i: allow a comment after a "break" command
References: <pull.1460.git.1673519809510.gitgitgadget@gmail.com>
        <xmqq358fu4vr.fsf@gitster.g>
        <Y8A5X0kHE31kSH3z@coredump.intra.peff.net>
        <xmqqilha18yd.fsf@gitster.g>
Date:   Fri, 13 Jan 2023 23:29:48 +0300
In-Reply-To: <xmqqilha18yd.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        13 Jan 2023 12:22:02 -0800")
Message-ID: <87sfge18lf.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> I had somewhat the opposite thought. The "break" command is special in
>> that it is not doing anything useful except returning control to the
>> user. And hence producing a message is a useful add-on. So I expected
>> the patch to just allow:
>>
>>   break this is a message the user will see
>>
>> without any "#" at all.
>
> Ah, I am OK with that, too.

Then how about this:

  break this is a message the user will see # and this they won't

I'm definitely with Elijah in favor of consistent # usage for comments
that go nowhere.

-- Sergey Organov
