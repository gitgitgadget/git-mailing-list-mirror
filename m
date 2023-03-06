Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3FDC61DA4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 22:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjCFWYG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 17:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCFWYE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 17:24:04 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD44765070
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 14:24:03 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id x20-20020a17090a8a9400b00233ba727724so227223pjn.1
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 14:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678141443;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KQRef4OPV430cagVz/NCyH+BUY+O8PCxhC119DUuL5c=;
        b=nxK+xEwRJFwmu6axLCruTpxVpbY4jC5cLVYeOcbVDrSFEoHuQpqdayhvwRm9lT6ms0
         Celkis6HbJv7lbSybGIsWae8IBuKgR4RbcX10OYBk6q+0K6xgVdRmWuivN/d25wIIxTS
         WlkAsexiZCKFMWFyiCi6IO55aTt9/r1y+8rf3C0J5Bg5LzOlRokfKdpwfyhf9vuRTyFn
         dtLWVh3dgD9GzV5UkbXOSbfJM+7IktFXEk+ZBlyMgwRsv+sJIrJyutaN20sNeujZwmco
         gSr/2VnMcsiGOKmzGphXvvTTc85JvU553IHJ0TkbWWC8FzQDvNttr8KlcIf0NASz4Oga
         VAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678141443;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KQRef4OPV430cagVz/NCyH+BUY+O8PCxhC119DUuL5c=;
        b=MbrR9wXXTLGbchIVQM/2l7eZNl9WmnDUFD0kl4uvu2RdtacGuwU1yV3qVzxieD5jQF
         6noOxWg1I0K9eN+flKVY7+/qAHveTPH6GoQA5yTvgt0pzDk4wQnRn01kPYWJOitHGEzP
         DIuWk04glRXRprvfSbadteknCNb8s04hQHBi2kCh0iWT09dGzCCHpDPXmp4B7CE821gS
         4k6FOTwkh/tVOW/cMREhkboSO5quDrQbSi7UK+d1/Feeeu4IXfIxBj8RGf6aKsWxwYw3
         PrIDC2qZVnkwvGbbBaqk8YbBtinH+lkLkBgSaCnFenVjPc1aPjRIohBHP6QncRmSWS4/
         6kYg==
X-Gm-Message-State: AO0yUKVdMSeMwbIngm+nr+btn9ppgwmy/AVnyLcaDEMHrd1Uhh3V68TN
        4rW4J3iEtXRklAiSqx65974=
X-Google-Smtp-Source: AK7set8XzlFZl6J0ZXA+gcvJqn//FqPrC/Fr8nI+Y9E0Coz3zCQZYwyJ08oWhAO4hI64XQi24ZM+VQ==
X-Received: by 2002:a17:90b:1d08:b0:238:e9:8994 with SMTP id on8-20020a17090b1d0800b0023800e98994mr13783521pjb.0.1678141443213;
        Mon, 06 Mar 2023 14:24:03 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id g3-20020a635203000000b005035f5e1f9csm6704333pgb.2.2023.03.06.14.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 14:24:02 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, vdye@github.com
Subject: Re: [PATCH 0/8] ahead-behind: new builtin for counting multiple
 commit ranges
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
        <xmqqedq1ag8d.fsf@gitster.g>
        <8be01cb6-8937-faed-0850-4501a2f1ef55@github.com>
Date:   Mon, 06 Mar 2023 14:24:02 -0800
In-Reply-To: <8be01cb6-8937-faed-0850-4501a2f1ef55@github.com> (Derrick
        Stolee's message of "Mon, 6 Mar 2023 15:18:11 -0500")
Message-ID: <xmqqcz5l8qnx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> 'git for-each-ref --merged' is probably sufficient. The only difference
> being that it would be nice to specify the matching refs over stdin
> with --stdin to avoid long argument lists.

Yeah, if you have a list of concrete refs maintained externally
(as opposed to the example I responded to, where you generate the
refs by telling for-each-ref what pattern they should match), having
--stdin would be a good thing.

> So, there is benefit in using this tips_reachable_from_base() method in
> the two existing 'git (branch|for-each-ref) --merged' computations. The
> API boundary selected in this series might not be the most appropriate
> for those builtins, so let's kick out patch 8 from this series for now
> and I'll revisit it separately.

Yup, if the reachability API refactoring in these patches can also
help the "for-each-ref" listing (which "git branch" and "git tag"
bases their listing behaviour), it would be very good.

Thanks.
