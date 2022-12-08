Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E910DC4708D
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 00:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiLHAFK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 19:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiLHAFI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 19:05:08 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98995654D
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 16:05:07 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id o12so38663pjo.4
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 16:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XAiMsp+jqGIoTqTovQsapgyncVbMYhrFfsEsmJfMxGM=;
        b=Sar9/x3ahlhII512CngY/9UVXTsQsKjUwWgWDzki+RlBc7tPmXsaqnYB8ZTxshouEg
         JjaNL+NZ3WjI4ma2tOtyPmCHYShzNBXcez/dtCQkPtT95xDdF32SnLE8YrsHemLgXmIK
         IOUz3x0XRpjHHuPNMPEbDtCbIS4PZate7PbMJIxm0on0109X4x9F2WR44/Y7BgIhco8K
         GuBMHX/9dvy8OXBhg2VWPQQj/JMBAvkDEtHKxcQ6dwvbgDQU4QfHo83NdTODEi/kNwXQ
         jQLo7Z+1+QWh/pOqJrjXUD09dr/jCAmQe1E7xvuIAdDWspUQ3KGekzWEOHuUIpy9Ip4O
         g62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XAiMsp+jqGIoTqTovQsapgyncVbMYhrFfsEsmJfMxGM=;
        b=MvsVC2evO9YcqQpXtTI9hp+iyf8ggQuc0SbRUyeqPjlrv5rbudxA/7NVdAm14rULOy
         WLL6qgUbNuRSIDniCH7KIoksqwEdJ+4mlWCn/QLw7plUuUtf9Vt5k7vey91VbRpvml3E
         WmttNhZr5NJi300PzJRCNxQX8g9bubLU2sX5D/DkjYdGSCj5Kp1ErV//ofuX0TPAB2i+
         1OAKmI0Z4K/K+pxd/ttITT+6vUnQlGGWiegNQv+vf1XcFWkOc8aYuPGzxrTZ/zxTxJ7a
         unaQbBsBN8vXqm8RX0PjqGBorrq9jkVdYhhsM0GCk+1uPspxTuX31YTuiL8o6qBuBLKI
         Uupw==
X-Gm-Message-State: ANoB5pnYAaYD3muIZEia9tx1n/MsOvzY/jw2CNvwqH7kZuO4yaMoM9XG
        ppPYrCteKHJ+w4gqaEjoTksbRmrXaxdYww==
X-Google-Smtp-Source: AA0mqf6OYkPr2fpNbkz9f9UttQBY4xhlFJynoWwomatUSzKVSKVHgMeUjEJafOw+qENenFjhF88ZHQ==
X-Received: by 2002:a17:902:c14c:b0:189:9733:59d3 with SMTP id 12-20020a170902c14c00b00189973359d3mr1079122plj.29.1670457906991;
        Wed, 07 Dec 2022 16:05:06 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id cp6-20020a170902e78600b0018986ba1db9sm15075343plb.284.2022.12.07.16.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 16:05:06 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, vdye@github.com, newren@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/4] read-cache: add index.skipHash config option
References: <pull.1439.git.1670433958.gitgitgadget@gmail.com>
        <5fb4b5a36ac806f3ee07a614bcb93df2c430507c.1670433958.git.gitgitgadget@gmail.com>
        <221208.86mt7y946t.gmgdl@evledraar.gmail.com>
Date:   Thu, 08 Dec 2022 09:05:06 +0900
In-Reply-To: <221208.86mt7y946t.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 08 Dec 2022 00:06:49 +0100")
Message-ID: <xmqqr0xa4v65.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Is there an implied claim here that versions before v2.13.0 don't count
> as "older versions"?
>
> I.e. doesn't v2.12.0 hard fail the verification for all index writing?
> It's only after v2.13.0 that we do it only for the fsck.
>
> That seems like a rather significant caveat that we should be noting
> prominently in the docs added in 4/4.

True enough.

It seems that we only did security releases from 2.30.x track and
upwards for the past year or so, and anything older may not matter
anymore.  Documenting it should be sufficient.

I actually was wondering what impact it would have if we made this
change unconditionally.

Thanks.
