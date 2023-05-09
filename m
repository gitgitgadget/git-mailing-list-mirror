Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C2BC7EE22
	for <git@archiver.kernel.org>; Tue,  9 May 2023 16:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjEIQga (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 12:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjEIQg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 12:36:28 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCC7271E
        for <git@vger.kernel.org>; Tue,  9 May 2023 09:36:27 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-643bb9cdd6eso3659426b3a.1
        for <git@vger.kernel.org>; Tue, 09 May 2023 09:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683650186; x=1686242186;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QkA/pi8KlAO9UEn9idPV6TS+UbJ0UGUv2n4mkqlJeYs=;
        b=YfKtVKyR+u9VytuYai7tjj3j1aHI2Tz4sXtnu5FOoPL5I9h0h/8lQ79nQbLzS2vjyU
         UovK9QYUTP6iBYGYCuPE0wWhE0Rw4OysllmM62IvJ2cV8UItA8E/qAYKbSNL/HjO8tTG
         GjFw7BEKhYCfTrTOkvKyJt0LwQ9eWVU+pf4InH8r2fYKyDW3aPaDIxvePSARi2lyxyMR
         oQkbOWREeCjM18oHe/cj120UEO9BnnBb3iXVv8XBGt7QO3dJ+ZBYQUhV1Q7FcqYYYYRJ
         jc3g3xSAFupm8UYLhaQxMgL48VPsKfrGiNeTzV0dBFpJyic7RkEkuVR4DmZLgbfoKxQ/
         pH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683650186; x=1686242186;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QkA/pi8KlAO9UEn9idPV6TS+UbJ0UGUv2n4mkqlJeYs=;
        b=B1FGTdA9fkjo6odg8BzUbptChswT6V9U0eSXVKQocvotqMXVRk+AwTsDzyptYwQ2z/
         dBvesjVlBVcoeXhmCOQLAkmKwYOXWtoa6jlC/BWPTsTFl6rWX//m+HdNaFhxwmJoit1d
         +SH8wsnXK7nu7TWM2IEmsFXShjPWeKPXkZvIw6UpDFrfw9Unl2POoJCCgZwbnhPtbjId
         M3OhO5ZKb2dzMtwVIvTGtezEGRBTZU85FfPmt/vPy8zMQOgyZmFFrML5L3O/3oPNZm+M
         162+unETboinhbJA7NJJasXl/V/EuczhXoi7isBZY+KlU0527/N2TKF0oEHKdeP64Ijl
         WFfQ==
X-Gm-Message-State: AC+VfDzJLM7r9YNNjEzDqdTkp4pVenHEHYjyiP4itSWyBl1MvNyrJxcz
        71Z0itaBZQMh6iKTkylF7MY=
X-Google-Smtp-Source: ACHHUZ5C/XZRlj+pUlLey/rxW9/P6G0wBevP9pXzOmnCwyoM/IGa2fst3r65d3qhdXdbELthuJiL5w==
X-Received: by 2002:a05:6a00:1794:b0:645:b13e:e674 with SMTP id s20-20020a056a00179400b00645b13ee674mr10725074pfg.26.1683650186603;
        Tue, 09 May 2023 09:36:26 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id 17-20020aa79151000000b0063b8ddcdde9sm1721572pfi.65.2023.05.09.09.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 09:36:26 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Soref <jsoref@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Instead of "Revert "Revert "original"", give "Replay "original""
References: <CACZqfqDL7EUGGxHAsKmU6Y67FupHGog3PD-P-g_O0atG4NG23A@mail.gmail.com>
Date:   Tue, 09 May 2023 09:36:25 -0700
In-Reply-To: <CACZqfqDL7EUGGxHAsKmU6Y67FupHGog3PD-P-g_O0atG4NG23A@mail.gmail.com>
        (Josh Soref's message of "Tue, 9 May 2023 01:18:39 -0400")
Message-ID: <xmqqwn1h1mye.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Soref <jsoref@gmail.com> writes:

> https://github.com/git/git/commit/42e073b5ff5f9e8bc2356151dbab0c95321d2454
>
> The commit message says:
> ---
> Merge branch 'ob/revert-of-revert' into seen
>
> Instead of "Revert "Revert "original"", give "Replay "original""
> as the title for a revert of a revert.
>
> * ob/revert-of-revert:
>   sequencer: beautify subject of reverts of reverts

Thanks for spotting.

This comes from my working draft of the "What's cooking" report and
every time I merge the topic to any integration branch it is
extracted from there and used to annotate the merge commit.  I'll
update it there so that it will say "Reapply" when the final reroll
comes and it is merged to 'next' and down to 'master'.

