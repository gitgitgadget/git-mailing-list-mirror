Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB26FC64EC4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 17:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjCFRgY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 12:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjCFRgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 12:36:16 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEF76A06F
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 09:35:41 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id b20so6332964pfo.6
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 09:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678124077;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vF0zaCocFOqSQnqExP5OLYYkZTaj2i6Sfbil1IAmTHo=;
        b=LlAgTXncUnoMVY19FPqVX7h/QUo7yhVYh6f26qIw+DD99eXIAxw0UWmJ00ChqJknLR
         TxYEO5p52i9VjX1n4wPplaIHC2xBs5m9++MfB9IiNkJdA0jxdf4RIuWQTKbjC/Bz/zdh
         PV3UUaLGJt4RyBJYJbeB1mC+6m9WtU+SWiHABF3NtF3XcBjmylPAv/ObN7mGwSKiaF6x
         Gy5ozn2GGD1a6azGXYnFz+tDhf0qtHyAwo0LZxw2O9j1yzQXzU+DzZKj4jT0I4VZSkq4
         0xOIMTEkZopebbFrQ5Szhd88QoUZxrJm5H2zzS3+tgHHd1+uHR7cEYw59TMDhhJ31cd3
         dc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678124077;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vF0zaCocFOqSQnqExP5OLYYkZTaj2i6Sfbil1IAmTHo=;
        b=2CsXjLAY9E8A2oGvTgRYXVhyJRfDwwDDa9w8ivpwA3UJBoxjuQC9Bakmj0dALQCDq6
         w3LO3htouhw6WkRloh9SMDvzAmpE64CsMAVk1Uz+Qfg1wB40HMOM57jNBKndj4t+wEjK
         YLUyZuAnqXrnHO+0aPdFLdWCjU6PQSEEvNfe+cMKwhQhnio8dfM7FAxFN6f4P2+Qgiyz
         KMuTi+PSKSuxnJ350erb1DrRVHGks1/R2KRNHo60hGXhISK1DJjbt54ZaliE7ch6rgST
         lOH5KoXjibyB9/x+yiQdrFttS1nzNw9d+WukrCjiC3/4Yu4wUfe96lsQYlJtvgBJpQyk
         bx1w==
X-Gm-Message-State: AO0yUKUwgSE0foeAwzN3DxP2usC5DLkICKbVIHXJI0sGgccqb1mv+7Qi
        5tTg7r6Utp0azLw6CPXsL1Y4sUusSU4=
X-Google-Smtp-Source: AK7set/BScpupKAKCoyNi5kkTOnSp0nP9ZPa1a8+I8+EW+Rt/V3mV8a+r8n3q+RrjxGrK1Zl2VGgcg==
X-Received: by 2002:a62:1c58:0:b0:5e3:16fc:b58e with SMTP id c85-20020a621c58000000b005e316fcb58emr10271801pfc.21.1678124075823;
        Mon, 06 Mar 2023 09:34:35 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id a22-20020a62bd16000000b00592eb6f239fsm6454472pff.40.2023.03.06.09.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 09:34:35 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael Henry <git@drmikehenry.com>, git@vger.kernel.org
Subject: Re: `git bundle create -` may not write to `stdout`
References: <80beb487-cd93-06ed-88cf-87a96a829ff6@drmikehenry.com>
        <Y/voNv1OQ1Cf/N5a@coredump.intra.peff.net>
        <xmqqv8jhcvrq.fsf@gitster.g>
        <ZAJ6oI3clNH2O3R7@coredump.intra.peff.net>
        <xmqqpm9pcu6t.fsf@gitster.g>
        <ZAKexHiit5vOmv7M@coredump.intra.peff.net>
        <ZAKi8MzGWk5PZUJk@coredump.intra.peff.net>
Date:   Mon, 06 Mar 2023 09:34:35 -0800
In-Reply-To: <ZAKi8MzGWk5PZUJk@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 3 Mar 2023 20:46:24 -0500")
Message-ID: <xmqq4jqxbx78.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Oh, hmph. I didn't realize that both my patch and yours are touching a
> shared options-parser that affects both reading and writing. So the
> patch by itself is fixing "git bundle create -" but breaking "git bundle
> verify -". We either need to teach the reading side to handle "-", or we
> have to teach parse_options_cmd_bundle() to handle the two cases
> differently.

Yes.  Teaching that "-" is to read from the standard input to
consumers would be a natural thing to do, with the well-understood
escape hatch to use "./-" if the user really means a file.

Thanks.
