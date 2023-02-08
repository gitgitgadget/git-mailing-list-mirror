Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91085C05027
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 21:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjBHVXP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 16:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjBHVXO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 16:23:14 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE4C3EC61
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 13:23:13 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id o13so70829pjg.2
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 13:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fjmrrZvQztuVcRWZbqBtQAr6jVJ0QAaKbmDtl2ewjMc=;
        b=Ub9qdT9e3XkICPJ9K5OHOYKHOMnJXigblZFSFwIlUWgXJbUKEhXpYIE+7Z8pRiBbBG
         JEYK4Z5sRTmJUqm6YUzPwV7KJOFHDYyft9ULD/MGlWBoc4yIMpKK0kcUW6BSAS0DRs6K
         rp+BpUnYFy7qeo+50BV7IH8jaZQjs/IbUpszqXHCUCz/pzIgl9fxWZvEH+tdwwLut8WO
         /UF3ggQ4Ld06zIg+ywciz4Tad+KKolaFQvoRT3p3PL320GhMzeV4uowWi5ZbOtHlZySf
         pr+IglRufK5bJVqPUjUYl59lXN9XzBPhoE9zKo1ndT+uk2xFbaVq9bowoYSQtZ9mWam7
         herg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fjmrrZvQztuVcRWZbqBtQAr6jVJ0QAaKbmDtl2ewjMc=;
        b=BxGFXdP9XCjWNYmSsTeYE/TvpDl/gUGLyGJCAziAGKfY6Eb6bPpUDf1nui7rdkEcI2
         dvDBrjRf0OKi+OUpXbTigiB4Q7XNFv/yctTRWNUkYHkxh10FckeupF8NIbi0lOU3yXh3
         mjimR/CWCcwumSGm9H9MX8FiADX7KRxJ6BF+GE362O3lrdzl4L+G8C6bCgLZXnoj8bJu
         XxeA4eq7vdAgZhxiRcxpN4kfOmat2iu1IncmfbodgHV6JiTpt2c06BrGq9mECuTSqsTy
         /sS8Hb+9Sba226cEv/wbmj3yLftfgtVme5/ZnpNTPyCzMS/fvRJ5r6nYDxUcGxH8TOTR
         SrnA==
X-Gm-Message-State: AO0yUKWZygDx72zsaUoVsBSASLzlNftBRyd9tT7Wbb6sYJV+hDSqIeCM
        fIcvme0NyTC5lK+pUZLNoCSmONt3lv4=
X-Google-Smtp-Source: AK7set/WaPkjgh2Hq+9vervsxopSiJGDGNstTIrURUW64ApUE/tME7o/gu0UwGK5sk9x8uCe1Xf4pg==
X-Received: by 2002:a17:902:c111:b0:194:91eb:5b84 with SMTP id 17-20020a170902c11100b0019491eb5b84mr7608676pli.22.1675891392636;
        Wed, 08 Feb 2023 13:23:12 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id f9-20020a170902ab8900b00198e599f23bsm10715352plr.212.2023.02.08.13.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 13:23:12 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Michael Strawbridge <michael.strawbridge@amd.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 0/5] hook API: support stdin, convert post-rewrite
References: <cover-0.5-00000000000-20230123T170550Z-avarab@gmail.com>
        <cover-v2-0.5-00000000000-20230208T191924Z-avarab@gmail.com>
Date:   Wed, 08 Feb 2023 13:23:12 -0800
In-Reply-To: <cover-v2-0.5-00000000000-20230208T191924Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 8 Feb
 2023 20:21:10
        +0100")
Message-ID: <xmqqlel7q2bj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> As noted in the v1[1] this is the initial part of the greater
> "config-based hooks" topic. I believe this iteration addresses all
> comments on v1. Changes since then:
>
> * Remove a couple of paragraphs in 1/4 that aren't relevant anymore,
>   an already-landed topic addressed those.
>
> * Don't needlessly change "cp->no_stdin = 1" and introduce an
>   "else". This refactoring was there because that code eventually
>   changes in the full "config-based hooks" topic, but going through
>   those future changes I found that it wasn't for a good reason there
>   either. We can just keep the "no_stdin = 1" by default, and have
>   specific cases override that.
>
> * Elaborate on why we're not converting the last "post-rewrite" hook
>   here.
>
> * Mention the future expected use for sendemail-validate in 5/5

All read well.  Will queue.  Thanks.
