Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACB1C7EE2F
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 20:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236307AbjFLUod (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 16:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238332AbjFLUoS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 16:44:18 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479A2171B
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 13:43:38 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-653fcd58880so3818866b3a.0
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 13:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686602600; x=1689194600;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SrPVsf0YOZWU5Iv5gt/8+HCLZZPLcQYopbFQfXyDkfs=;
        b=eSNDtOlNyekBIh2oFtrPAchKdxoUwHKJ9JN0k+GFi4uNaYt6GzNMBZMnZZfXe4KVrU
         h3XiKlKsUwQttFosHmsSXehPTBHHEL3OwIep+AwLloc3PUszC3zPuLgfRr31Ui2VAlZ2
         S107BYq5+ibtiLVQaBO1rhK0IXMU5jL24eH6QiMbE7tS/lpFUhRKOD4yCZbAYYijMzPi
         I5afp1gUHjUs74JES/Lm2hbcomH2VziJG4zviUIRPnQeO63ZdZn4FGCIt/0GuLc4dqVK
         JkBA4WfbGQ7BdJddSWx8SqqbbeLFQrV0p2t74fQ6pS7E4Q3eKz1mOtSz0rWC1NZVlWOX
         /XHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686602600; x=1689194600;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SrPVsf0YOZWU5Iv5gt/8+HCLZZPLcQYopbFQfXyDkfs=;
        b=h7t/B3bvqs1kZtk39/VCo3jwljxEVmjvDiALVtRxYTY6GlXweyrHIO8T7RPnORV0zi
         7A3NP3HBoXR6r+se7ixtQfT1GgEpJQFToLaHJXOK97Cbl0Pm870xw7nLgs5hAHjq1YQk
         5V1ySsAbcuENYtxooHZiAFtXe89JIpHs+hJW2nJ0z+3+xz8FUvpeYy+r/n21jhGdKAE0
         x7fafbZfigr8aCjIMFEF9Gr6vORNzDzuIeBSHs9zXatc/h90n7K8AC2DdBj3nwET4cu/
         Flk5gqHaAO+967b+xdQaiTdSK0rIgj9o/Zcc/bAN527juEAc3WxIHiLcVQfEgnX7pvs9
         vMuw==
X-Gm-Message-State: AC+VfDylIY9Yp8QHTkdHEr5uTIq00VbDpU4isOU/9aB15PVMIQrjRj4n
        YoWIsJOE6TlufUbA9f1TW7M=
X-Google-Smtp-Source: ACHHUZ6jeebZbDg169WVbryC4pnsug5WyRm/eCRyzqSx4jZVbSbqJ3F7BFjVmiW8jryeQw2UwjjPuw==
X-Received: by 2002:a05:6a20:a987:b0:10f:2abb:c9fd with SMTP id cc7-20020a056a20a98700b0010f2abbc9fdmr8881858pzb.43.1686602600297;
        Mon, 12 Jun 2023 13:43:20 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id u70-20020a638549000000b0052cbd854927sm7909153pgd.18.2023.06.12.13.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 13:43:19 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Toon Claes <toon@iotcl.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 0/5] catfile: introduce NUL-terminated output format
References: <cover.1685710884.git.ps@pks.im> <cover.1686028409.git.ps@pks.im>
Date:   Mon, 12 Jun 2023 13:43:19 -0700
In-Reply-To: <cover.1686028409.git.ps@pks.im> (Patrick Steinhardt's message of
        "Tue, 6 Jun 2023 07:19:24 +0200")
Message-ID: <xmqqilbs9ztk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> this is the second version of my patch series that introduces a new NUL
> terminated output format to git-cat-file(1) in order to make its output
> unambiguously parsable in the case where the input contains newlines.

Will queue.  Thanks.
