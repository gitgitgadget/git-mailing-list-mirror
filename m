Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF88C77B75
	for <git@archiver.kernel.org>; Wed,  3 May 2023 16:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjECQtX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 12:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjECQs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 12:48:58 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227A355AD
        for <git@vger.kernel.org>; Wed,  3 May 2023 09:48:57 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b5c830d5eso3836666b3a.2
        for <git@vger.kernel.org>; Wed, 03 May 2023 09:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683132536; x=1685724536;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mqmgM4iTHzeaDqmOmqE2NYIoxf5/xtbFBEL3U/qVJWo=;
        b=UB2InJjmGwed/3tpNIV0Zqh+4yxeIT7PNUw2Q7ADv8ZAlzwG8BMPHlylzGK5AmhIz7
         rLNy19OJBW2XfL7TwcFthHN4mrPQjQYiu98783drVwPJGqynqF2S9spzPNaxbxWeLsak
         skTcg7FZ/NwyB9XKkh32itKRJ6E90VfAg/DC5KdQDr87gjg8vMrrQbA7EuuBc9Gpkq9F
         GjOQ6QFi22yJhYWbhhouiZp/X4Nyr5+wqxhdHobIPtgL6KizJXTeKmiVqqA9CQlu7aoV
         Vl+VVCsqlEvxEHXf3Kp5chaR8+OwbHd87kzzhgF3ZEWEWLApBFMwEy7vELBczJOYVBHQ
         4Isw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683132536; x=1685724536;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mqmgM4iTHzeaDqmOmqE2NYIoxf5/xtbFBEL3U/qVJWo=;
        b=hfppneCyEwoihTu6/R6ec8ozETBESJtyIgX+ACdcciPu1hCUxrRztWHVEzumabJHgr
         9Ky2rREBKlmfpHpu8OFG9DirmbWkOt0jThN/I8GjCeyDWqUE0Z5OevaUuQrkTXPl/U3h
         r4dHkSQYt143g6hqZCATCr/riHLeevSr5sREX5nPmP9XdWRejIuxcUFIXSZRvFfK9yvs
         7OYibP8yYsl80d+kQoIyrfB0Dll9W08eA/nWPGLZLXXU5fZITlsfPtG1Am3y/O611WGt
         FtGdJv0sdx7dZbMo9g3Q4J3KcN7x36NPXVpIktJJgJFLYpQ6oBdguPLUTTofmyGAQP4y
         lhMA==
X-Gm-Message-State: AC+VfDxZGrZeD8XAhrE7NGSzatlCsNe2VyZ/XIw6LSmP4ZLdnOJoZ84I
        76Sp83rVeQ4rB3Z890YUbbo=
X-Google-Smtp-Source: ACHHUZ69NkFzNhsx/+178iwrTp8gKjw+gQmYH8WqgiAi1bseOG2s/pFjzWXiy8bGr96YUtpgQIyOxw==
X-Received: by 2002:a05:6a00:24d3:b0:643:4d69:efe0 with SMTP id d19-20020a056a0024d300b006434d69efe0mr2675109pfv.4.1683132536553;
        Wed, 03 May 2023 09:48:56 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id a22-20020aa78656000000b0063d318699f9sm177305pfo.48.2023.05.03.09.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 09:48:55 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v3 0/8] fetch: introduce machine-parseable output
References: <cover.1681906948.git.ps@pks.im> <cover.1683113177.git.ps@pks.im>
Date:   Wed, 03 May 2023 09:48:55 -0700
In-Reply-To: <cover.1683113177.git.ps@pks.im> (Patrick Steinhardt's message of
        "Wed, 3 May 2023 13:34:14 +0200")
Message-ID: <xmqq1qjxuzrc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> this is the third version of my patch series to introduce a
> machine-parseable output for git-fetch(1).

Which base did you pick to build these 8 patches?  It seems that 6/8
is not happy when the series is attempted to be applied on top of
many recent tips of 'master' that I tried (including 667fcf4e15 that
the previous iteration was queued on top of in my tree).

Thanks.
