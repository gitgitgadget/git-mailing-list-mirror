Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1B1C77B7C
	for <git@archiver.kernel.org>; Fri,  5 May 2023 17:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjEERab (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 13:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjEERa3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 13:30:29 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB40517FDB
        for <git@vger.kernel.org>; Fri,  5 May 2023 10:30:28 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-52c690f7fa4so1340072a12.0
        for <git@vger.kernel.org>; Fri, 05 May 2023 10:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683307828; x=1685899828;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CAyHjIVXFDM23Y8ncQOiQ/RiQmgxws3e2FQPUMuUXbg=;
        b=bGWHybsyXjWAh9QUs0ewGj29Twuq8pbp1+dRxq977eawwZ4atxvPoevAmcEpPIPrTn
         smVhXDoVQaRmqQWnlbX98W4u6zsHkhvUZdNJb3YiD2g47BmP+nE+IV7TnYZs2ACsu9EU
         Gq/MZuguotuqTyfhpknA27qrS8n0w1fqNcjmMYSIV9b1xtAbJoAsntEmGuI7eNkyxAhp
         uXmeqwuZxq61DcI3uBUv9shpDOBDcPUhaXpi2naRYXH8udNfSt225/qSzte/IDUmVAO8
         LXd/apYCV/lc8G33i/zSW1KBt8Y0YFNeaPr17R0FDQ+T0czrBQ/hVfpIZFr/haBu670i
         AjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683307828; x=1685899828;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CAyHjIVXFDM23Y8ncQOiQ/RiQmgxws3e2FQPUMuUXbg=;
        b=PMQbWrekWFSMF5QzC/IkvTcCAo7Wy8TLHrTGP/Tgo1Xhy+z36hL0RSqb0JWp9mwY1j
         FNgKbDFLRZLRCqAJxc7AHd7colaVvAIFNR2sm52rzM7J68TKRbfOephAGMcZBn3BhM2J
         wVe2zOwYMB6EshnSwpO/AEkSYzrVfgZ+jH08QTCy2n9tt/ePOJnpsnW2bvoUdWfPpJ7v
         XxMyG+OxapMwsWKLYSMHp0cE9S1mymKbmbazBTRhXaM4NZT8nTmJpXdB3dSrC7ut1rZT
         Q3iV+QM42LOSTFFfwYi9S5tfrZQOTp1YiGTRy+rT2+/5Uv1KBv30/Iq8Jf5TEn3rj0fV
         ceYw==
X-Gm-Message-State: AC+VfDyLwwFWfRcWiWUbAEIADKEMLVCAuQgE0XDsKEOD1ibfeumfqYZ2
        WAPYrw+UHX4gY2elnTl5ko4=
X-Google-Smtp-Source: ACHHUZ4NfQOS6U/6g1Sgcn+ljWwf1sOPpvxWfGFkDIvb1rxGN2IdPB/6gtu3hr3VwEDTsBBO4RxqJw==
X-Received: by 2002:a17:90b:19d4:b0:24e:46f8:492a with SMTP id nm20-20020a17090b19d400b0024e46f8492amr2095288pjb.46.1683307828172;
        Fri, 05 May 2023 10:30:28 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id i1-20020a63e901000000b00528db73ed70sm1953535pgh.3.2023.05.05.10.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 10:30:27 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <nasamuffin@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] usage: clarify --recurse-submodules as a boolean
References: <ZDSTFwMFO7vbj/du@google.com> <xmqqfs97cozz.fsf@gitster.g>
Date:   Fri, 05 May 2023 10:30:27 -0700
In-Reply-To: <xmqqfs97cozz.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        10 Apr 2023 16:10:40 -0700")
Message-ID: <xmqq5y96ele4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Emily Shaffer <nasamuffin@google.com> writes:
>
>> `git switch` `git checkout`, `git reset`, and `git read-tree` allow a
>
> Missing comma?
>
>> user to choose to recurse into submodules. All four of these commands'
>> short usage seems to indicate that `--recurse-submodules` should take an
>> argument. In practice, though, all four of these commands parse through
>> the same callback path:
>>
>>   option_parse_recurse_submodules_worktree_updater(...) checks for
>>   set/unset, or passes off to...
>>   parse_update_recurse_submodules_arg(...), which is a straight handoff
>>   to...
>>   parse_update_recurse(...), which only accepts true or false.
>
> "true or false" -> "various forms of 'true' (e.g. on/1/yes) or 'false'"
>
>> So ultimately, it can only be true or false, unlike `git push
>
> Likewise.  Here is a minimally touched up version I queued.
>
> Thanks.
> ...

Any updates on this topic?
