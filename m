Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6BCC77B7C
	for <git@archiver.kernel.org>; Fri,  5 May 2023 17:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjEERde (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 13:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjEERd2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 13:33:28 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEFB2705
        for <git@vger.kernel.org>; Fri,  5 May 2023 10:33:28 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5144a9c11c7so1847899a12.2
        for <git@vger.kernel.org>; Fri, 05 May 2023 10:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683308008; x=1685900008;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y1VvgTLkUWMi+ERjhnGDEDsi60jPYSmKoz2V+r9H9xQ=;
        b=Sz725yfcCooeJyx67xFORktdz9TDvya0IieSUKoRooTsHj7U6nafBLlRMkRUPKCDt7
         aLzFngujiuzs/DjM+/LS9yriTK5WCCTQp+/d2DP6qCrfyVi8q3Fth4Q7R/wmmNO9+XzE
         CsVhe3TfUJA7KnZ5zDwNjL1ZSFAukv4sdQf1eJOopXqgujECoqCq0Z1IMI1iGBlNYo7b
         wqYN83QOLgRX58rTwoAZAl4AzqyhnK9uqaIOYp0Ej+F0b98F9JpxGfUN6fTAP1SSCsOP
         sh6iZ2Qz9yb67ZNTGQ9TW/xfh130hVimNCRklLTpHSwxRyGtRFyhKx0b9prcNSeCRrke
         jo3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683308008; x=1685900008;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y1VvgTLkUWMi+ERjhnGDEDsi60jPYSmKoz2V+r9H9xQ=;
        b=Dq2U1J5jiBRVEfflauV00G6tL70xsveF978qtFMWybFQErcgAqlfpLYnNWf5T/j5Rh
         cLHs/D5ktVElYMVnaZByNNDkd6VGLhiGVl/tAiMnWucIbFeUmksaGQhJ3KbG4xMcSTzY
         NdJ6NuMN20C+ydotxmnyVEhIqHwg4H4L7VSCHhWstyxeZhzpO/g+fg8PzCsWYtrSVDWu
         jWhQkMUSlk+z4n1sEsT01uPobLz+fU0rXOyvNQkMzItgI7Qc8tlfl+N9YNRQeCUAZzfW
         rDEXXQ5TtYU0/1dbAz3K569tqZ7UodViIBS42NIfZxX+y9MND6XJjfUM//CwO4uimEFS
         D3oQ==
X-Gm-Message-State: AC+VfDyVXEMWDdOpBFQ+hhH7cfnr54JAEFDuFundvtTnfXqHU7F8BYJW
        +1W56XXJa6KJbXKGJgyQKLFs/mkMfeo=
X-Google-Smtp-Source: ACHHUZ5Z5x5RO0CHrER9nAuU4zcLfcwT0w9vBWvslxzWSqKUR1CsQzPIDbvDJ/M6QILwztpNf/GXKQ==
X-Received: by 2002:a05:6a20:a11a:b0:f0:d50c:4ac5 with SMTP id q26-20020a056a20a11a00b000f0d50c4ac5mr2758442pzk.51.1683308007686;
        Fri, 05 May 2023 10:33:27 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id e19-20020aa78253000000b0063b96574b8bsm1864160pfn.220.2023.05.05.10.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 10:33:27 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 0/2] pack-bitmap: boundary-based bitmap traversal
References: <cover.1682380788.git.me@ttaylorr.com>
        <cover.1683307620.git.me@ttaylorr.com>
Date:   Fri, 05 May 2023 10:33:27 -0700
In-Reply-To: <cover.1683307620.git.me@ttaylorr.com> (Taylor Blau's message of
        "Fri, 5 May 2023 13:27:30 -0400")
Message-ID: <xmqq1qjuel94.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Instead of hackily trying to write down all of the UNINTERESTING commits
> between the tips and boundary within limit_list(), we can just perform a
> commit-only walk, which will give us the set of commits that we need.

That does make a lot of sense.

