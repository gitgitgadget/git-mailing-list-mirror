Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4BCC6FD1D
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 22:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjC3WQ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 18:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjC3WQX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 18:16:23 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F8F9754
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 15:16:22 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id z19so19510495plo.2
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 15:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680214582;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I6SbOngwy4hG2x7H81S6Ytz4UXZdPAH8XQ86Om+E1rI=;
        b=FZ1GQEu6KBl58Tw5eb+5u9aqNOPQYZpgQZpLZUhdVSB8vIzu6/vJ6eGx3ZDgSSRrV+
         3z6/FriQ8oh9gHiCNVZ4nFOMnv4XLQAI68cDNG07URT7IuuI5rJAk2Actqe790dQKn++
         31ZsA2DigZKKe3Sz7Q6RW7Hb93cZDwT5Mig1z642S9BremUEzKJH7iifNj1CqQxmwhl+
         aAevI5dBKhBfeVKzVpM9Lyz0PLxQC6uztVTJF20Hp2yRcRGcODKYiLl/J3e4pTRX/zIo
         5BdWlzgsIY+HVD6ABGmmn9ShcXP7Uw4hvb6mEg36FhH1mpMVWbZ5NlO7fvie7znexBnD
         Sawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680214582;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I6SbOngwy4hG2x7H81S6Ytz4UXZdPAH8XQ86Om+E1rI=;
        b=Y/dOBnByD8XLIEuvn2GM1c3Po/Jer3XJxV5ggrCTtpiDktvCWQ2CGQKJqzBQ6vSq+i
         BMum7fxr61FKAmDPn5ilVcuTeErNw0E8eLg67bsMt5A+gx0+8A+9xFikhzJN24S7Mq+m
         qb+c298Sk84Aq4Ize9cxt6agIreEcdNPXrM9410VbNTcl7RHDfGc6oK5PvoDDZiQ2pHA
         1Xg/xXt+Ck9t4eUtcSRAS/KTjatouAyv4kEx05EeHeffUdVLn3uebJhuvV+xLsWJLVvf
         +12lZOi9pV9713LIbfcjUQNjLegsllof7z7qA+LeR1APF1nI3ut2Q/AExVml2ZP2onem
         8r5A==
X-Gm-Message-State: AO0yUKVzxixygEYkHttE+ixgT17nEt733dD80QyGEfGRmN8RNDFMnwzs
        Yv/Z13JP7IbBXiIp4ER34j8H+jq/hqs=
X-Google-Smtp-Source: AK7set9SVOftDwnB8oYhd6WRyvji+E6rVijTv3qXTHIvQnJ7mc9qo4Qqn70CMGfox2784W84RoQiRg==
X-Received: by 2002:a05:6a20:4e1a:b0:db:c54a:bf53 with SMTP id gk26-20020a056a204e1a00b000dbc54abf53mr20248430pzb.7.1680214581772;
        Thu, 30 Mar 2023 15:16:21 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id d21-20020aa78695000000b00580e3917af7sm343309pfo.117.2023.03.30.15.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 15:16:21 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH 0/4] some chainlint fixes and performance improvements
References: <20230328202043.GA1241391@coredump.intra.peff.net>
        <20230328210814.GA1754178@coredump.intra.peff.net>
        <20230330220823.GA130426@coredump.intra.peff.net>
Date:   Thu, 30 Mar 2023 15:16:21 -0700
In-Reply-To: <20230330220823.GA130426@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 30 Mar 2023 18:08:23 -0400")
Message-ID: <xmqqcz4pj362.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> When the output is going to the terminal, then the terminal is consuming
> CPU, and the frequency scales up. So it's faster when we show the
> output, even though we're doing more work, because the CPU clock is
> faster.

That's disgustingly sick and crazy ;-).  But it does explain the symptom
and it sounds like that "powersave" is a poor match for measurement.

> Switching to the "performance" governor makes the problem go
> away.
> ...
> So no effect on the series (good), but I didn't want to leave the
> mystery unsolved on the list. :)

Thanks.
