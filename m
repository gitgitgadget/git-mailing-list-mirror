Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD8DC433F5
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 17:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiJFRCi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 13:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiJFRCg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 13:02:36 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F2711A08
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 10:02:35 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id l1-20020a17090a72c100b0020a6949a66aso2373715pjk.1
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 10:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DlobVms0VAkvMVew+nfuYiyZWcVIAgRLwtkxMJjFGr8=;
        b=mFMIZFffdtI2NLWIMhK+9wVr/U5pdOtYYmZcNw/UVgWF1EtqiEvRnaI6XOr8/yX4pZ
         nJ1gBSXJi4N3b7kiVxYi+UpDBw7+9eAg6Mf+3A4zfx6Zvgbl79Yzj6jziU/MH6Du1kt9
         HU7La4MCyfevyeL4XFGobyLs5J4DQtLtas5x1JZlQNhRqqd2DY9uQrO9yXIdkVcGWlXa
         aRYPtza690d1bCb92sem2yq3/VnMk9z5fmzqGkxADFpFgPVTs0t8Pjiy3Kk3wAYDV+Ag
         /jwcWV+iGw6FJf5pOnoN5sMKZddha5DMuap9/izSWUPieeIfQq6NlgAzKdjWLfnyQFCV
         tTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DlobVms0VAkvMVew+nfuYiyZWcVIAgRLwtkxMJjFGr8=;
        b=wxNYAzSBe7ktggosXcnG8JIiUi/YP4ppLgLUYzgrisOEh7Mea2JZYNaAFdn3nS60SI
         f0HbFT8B8MQs7Dvms542EuWWCgOm8SbeH4m8fqMqHrw6DaH468FhgjUgBHf1MaxKX8DM
         k0cztlaOiMt2wOB8MznXDu/2PYuX28VQY+WDrjJepgnM6NNNsT4LhtoMGXbQniOXT8A1
         OlP/UL+wcJjfq1AsX7Kfb0SoqBwIbI4LIgyrRjOEQIXvpXhUhoCxu/lyEP1R3gacci91
         EKh1C4gkI62slrVYzQS0SdpFSpfy27gpZZx695boYtDSNuvf6RxBwNh+9znaYCdeTA2G
         VaFw==
X-Gm-Message-State: ACrzQf308AXZRWLukzdCmHzjYoMmozJvHWRemxH6aUIn8nzH11xCPozJ
        jReQuw5gwvniOrlDHcC9Y9C7SmdBSkU=
X-Google-Smtp-Source: AMsMyM4+AHmBkWvI/9x7+wYV/oCubiFkzc0kJ3tpn69wjlR5yQByy7j2WlIO5RCuZdC0vRtyijozxw==
X-Received: by 2002:a17:90b:3842:b0:20b:258c:19d5 with SMTP id nl2-20020a17090b384200b0020b258c19d5mr568033pjb.130.1665075754591;
        Thu, 06 Oct 2022 10:02:34 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id ik13-20020a170902ab0d00b0017f74cab9eesm4823491plb.128.2022.10.06.10.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 10:02:33 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4alt/4] attr: drop DEBUG_ATTR code
References: <Yz7Tjy7Rh8cXVxYQ@coredump.intra.peff.net>
        <Yz7UhYXvNl6+1GbZ@coredump.intra.peff.net>
        <Yz7Wx4kVbrZFfm0s@coredump.intra.peff.net>
Date:   Thu, 06 Oct 2022 10:02:33 -0700
In-Reply-To: <Yz7Wx4kVbrZFfm0s@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 6 Oct 2022 09:23:19 -0400")
Message-ID: <xmqqwn9clwba.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Oct 06, 2022 at 09:13:41AM -0400, Jeff King wrote:
>
>> The other obvious option is to just delete this debug code, and remove
>> the unused parameter. I'm not sure if the trace would ever be useful or
>> not, and I am mostly retaining it out of the logic of "well, somebody
>> bothered to write it". I think the const issue has been there since
>> e810e06357 (attr: tighten const correctness with git_attr and
>> match_attr, 2017-01-27).
>
> And here's what that would look like.

I highly suspect that I was the one who bothered, and while I admit
it was useful while developing the attribute subsystem, I haven't
needed it for the past 10 or so years.

So unless there are some folks who want to throw everything into the
trace2 floodstream, I would prefer this alternative over the other
one.

Thanks.  All four patches look good.
