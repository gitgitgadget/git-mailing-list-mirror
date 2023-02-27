Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEFEC64ED6
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 16:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjB0QH3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 11:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjB0QH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 11:07:28 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFF620699
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 08:07:23 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id y11so3068745plg.1
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 08:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VVhEzHzK5v/uZURHJachBNUZbhViGRFVztBKa4u9Jrk=;
        b=WnZIk8O1OStZoxL31lYIrCMoHGGPakRBYGH1N1F8B2liD44v1RTUDCn53I8X4IMBf5
         gdw0MsjzeTJAQn+B2FhmMQEHkYvaGygVd8b489JIH4DAO6+igxi8M0ZBBGM08Ogl8Aaf
         VK3IK4Boa6zROH2I5B4G6fjZcujI6R8l5GGnCjrUEAuEcNHDAt5sFymlJOy65WqAyoPh
         1d+w/roxqqXYJazMIcuZzaJMNVwMX/K99sjitgt6XPKKpck+Cr4zRTyZ1AwQg48rbIlK
         MJN9N4Vmcd/ywTkjMTai6EqyTEwvFw46jXEv8g8fmN7gsk0knQn/pP8UyVx5+f62Phuw
         dl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VVhEzHzK5v/uZURHJachBNUZbhViGRFVztBKa4u9Jrk=;
        b=hI/AVyPaN8CDwm0D6DQnevjOMt354E8IgWm4SUMWI/ht/NZ3QAIlKPvPCRzQcvmgMt
         SkT16TrduQFHZMgK7z2HFmQShvOLIkVm7NwZaolqBg3yI7Wr2NvRko0ThodQQHCBanfH
         51S0vmUjkIL8ytV0bEhBCsS2lWHahUJ3J6doK7Y7WUddHGHMuE4zDV0nYjTVDd9y3RSU
         HQr8p1/JvbIma8m8TfmgdGlo5Xx5zuU9tZtd9Y4XdieYjCw0Pz4TAZQILAOEufLSdh52
         +VPzdQZXPS8tKCjhRVMoyQjHRryqiw3+5t50uWJK7KKRpwKaa+DsH/GmXqaxC6qYu4hX
         iaAA==
X-Gm-Message-State: AO0yUKVTbLenwUTCKjuvlQZUGu1YFBjyDbv/DBrOA9N5IQ/gq5T+5UxQ
        3+AAxrHfDvQJLJPIq92bouI=
X-Google-Smtp-Source: AK7set9rpOWLX7iCG/pts23BfUZNU3RRTMaTekuZsg4vGDa/CydDtDpbHEyv5vOSqmdoawQchTl18A==
X-Received: by 2002:a17:903:290f:b0:19c:f888:ad52 with SMTP id lh15-20020a170903290f00b0019cf888ad52mr6153043plb.49.1677514042868;
        Mon, 27 Feb 2023 08:07:22 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id g12-20020a1709026b4c00b0019abb539cddsm4828283plt.10.2023.02.27.08.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 08:07:22 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v3 1/2] receive-pack: fix funny ref error messsage
References: <pull.1465.v2.git.1675529298.gitgitgadget@gmail.com>
        <pull.1465.v3.git.1677463022.gitgitgadget@gmail.com>
        <857d2435caf6211cd5a1baa6c9d77311ce7ba745.1677463022.git.gitgitgadget@gmail.com>
Date:   Mon, 27 Feb 2023 08:07:22 -0800
In-Reply-To: <857d2435caf6211cd5a1baa6c9d77311ce7ba745.1677463022.git.gitgitgadget@gmail.com>
        (ZheNing Hu via GitGitGadget's message of "Mon, 27 Feb 2023 01:57:01
        +0000")
Message-ID: <xmqqlekjt7lx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> When the user deletes the remote one level branch through
> "git push origin -d refs/foo", remote will return an error:
> "refusing to create funny ref 'refs/foo' remotely", here we
> are not creating "refs/foo" instead wants to delete it, so a
> better error description here would be: "refusing to update
> funny ref 'refs/foo' remotely".

OK, update() works on each ref affected, not just the ones that are
updated, but also created and deleted.  The updated wording may
probably be better.


>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>  builtin/receive-pack.c | 2 +-
>  t/t5516-fetch-push.sh  | 5 +++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> ...
> +test_expect_success 'push with onelevel ref' '
> +	mk_test testrepo heads/main &&
> +	test_must_fail git push testrepo HEAD:refs/onelevel
> +'
> +

I am not sure what relevance this new test has to the proposed
update to the message, though.

Thanks.
