Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A379C61DA3
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 17:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbjBURPs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 12:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234449AbjBURPq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 12:15:46 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B6B2C676
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 09:15:31 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id i1-20020a17090ad34100b00234463de251so5545663pjx.3
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 09:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jwlga+VFoSLxBluATLh5nwLCuSCL8WB0PuXUV1QL3U0=;
        b=p4+dJXXvRAY25BKeH36Hs6jdSlfPgvBjXw692RxktzXkPIDzAWGuTmHkWAi2ORm7gS
         ghQcBc/3YMllX1mzY/0WItM+VS+U/mAnwtticBdoEs7FPHu7htDQxeSkmL7B8MIi7cHg
         cL14fUKLv7hVCWvCiVLhqcNPNSuXyOVhveHEUbFtY6dE3XduCSyIe9NVc1l4HPgcBcab
         G8CGyE2RRadhsrTe464y48aMWUrBb3bVUyTvSbYXXYFCcuXhwVNR5IIkIu1FftUHoUnx
         mbFjP0XD/W8p8S7rvEQydhV21gYa+O4XZpxS3/m7jjTAD4kdFR+YUTqWsIydqX3M/XfM
         dbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jwlga+VFoSLxBluATLh5nwLCuSCL8WB0PuXUV1QL3U0=;
        b=K5oI7CITCXXzw8FkSmj8vXu11jZly+n9hBR/ekRnVmcJiYpkvCR5zamcnEsNx4u12S
         gFEFJz/YkIL432TMpQNkA6OJeT3F+SVBFY4hzjLTfQ5POEZN6YB5Svc1LW/FicM6JWfg
         lBN8RSqhACiAskrsfmXHoZZfTJeVAZR9sxHs0BisLpBkasj+l+Q8uvt7sa6wPPXbeiSy
         sSvi6ZrDE0S2tD3Et+pIgC+VyrY7Dtl3bIYGJI/vBGQM0i42ZVxZ1fZI+xZLcp2AbD0B
         pJcqgU2NxvaKYYZpG4aVSxRpiIKxGxX/hrPiUicl18f8HBGlhOpk7vz0mtXnDlkJhsWf
         yKyg==
X-Gm-Message-State: AO0yUKU19lE414GnE6MkYguRs0DRAT3+FpLJCEqOoEM5EwgRf10vMzlc
        uR2fezgCPFcopPGeU+Rc81k=
X-Google-Smtp-Source: AK7set84oW5QfyL6yC41VFGGc092yCOZqcUuDXXqvBPngKCJ2X1UmjFoQBWCz94eLemfc/kRa59sNg==
X-Received: by 2002:a17:902:f908:b0:19a:a2e7:64cf with SMTP id kw8-20020a170902f90800b0019aa2e764cfmr4303938plb.69.1676999730613;
        Tue, 21 Feb 2023 09:15:30 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id n20-20020a170902d0d400b0019aa8149cb7sm10062757pln.306.2023.02.21.09.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 09:15:30 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] delta-islands: fix segfault when freeing island marks
References: <61e490595b80b34c55fd640e093e021ff6fa9591.1676542973.git.ps@pks.im>
        <xmqqfsb5qzqj.fsf@gitster.g> <Y/MjdRq2dTbqh0a/@ncase>
Date:   Tue, 21 Feb 2023 09:15:29 -0800
In-Reply-To: <Y/MjdRq2dTbqh0a/@ncase> (Patrick Steinhardt's message of "Mon,
        20 Feb 2023 08:38:29 +0100")
Message-ID: <xmqqedqjgcsu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> Oops, right. Please feel free to add it when pulling:
>
>     Signed-off-by: Patrick Steinhardt <ps@pks.im>

I'll add that to the copy I already have.

> If you prefer I'd also be happy to send another iteration of this patch,
> potentially including a direct test for git-pack-objects(1). I'm still
> not sure whether it'd be worth it though given that it's implicitly
> covered by the higher-level test that checks for the segfault by using
> git-multi-pack-index(1).

The existing test probably is sufficient.

Thanks.
