Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3170C433EF
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 22:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347738AbiBBWBW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 17:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiBBWBO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 17:01:14 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5738FC061714
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 14:01:14 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id s61-20020a17090a69c300b001b4d0427ea2so8114901pjj.4
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 14:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=oCpGIJORd+Gdl6mJ5YldYXd+dJY3jWX1+1gQSlqei4U=;
        b=KUuNUh6ods341bxUkLD24rQcnyYWxkTzV4jlX1YSjSMBjHUrbGkzT3ClZu911ZAaka
         dmUdOBCPHK/N0oIaDDddDPgU8i1SjxZNNm+VAxSAskaXc/6swUpez+IYGApX5ShZixl3
         8EADUjFIW3kimC7y591eqt3xr9hbPiBSH+mBrxFOYKAmWJu6IN8dlmNp7PwzasqwaK76
         Xg7SKsEmWqAvL3DVUq86RZVhDzJ6/MI2ds0lCONnvccw/CXuC7/a656wG2zHBPFHSOmf
         j8FiR4GD2d2sQJmEkB2GWS6mJOTgYNyUcjMdB/Y63fnxXSt0jNSk+W2qMwDw08uoVq+1
         NduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=oCpGIJORd+Gdl6mJ5YldYXd+dJY3jWX1+1gQSlqei4U=;
        b=mVVP/0aRTkYKE+HJm4yHrRypVE16elIx62oB4uhwTKjrTa7jyrMJzPqKY+CledprrN
         GnrVPsuJLFTkbIc/ZQ+10zuqisHz67FaQPB0JiPh/XEmuX6V3oGv++1s269n2jp1pyi2
         DWDIilqypal3cOOCIvvG5bhBWG2UyDVBtSVsDnq+/hNMMh2SM8LrAV85gQnF7/TqZ6ey
         Im/4vgASQwrmJqbF/0s3OcynzInwIAyjFbDW9OiJ+kV5Bu9dCVe1dSfkiBwBKGaIlHJ/
         Wg/IK2n/lwgxeP/PbPtfIcLlEQv+boM+vXyZcO6LwW8V88TuDZFLRMIi+DgcAGhLakPA
         KSqg==
X-Gm-Message-State: AOAM532nC6GxWHvDzNHYy6wCfhMKnpIG7AVXpe48F9hKzDYzicTQfGiD
        3AqC03CJ3P6LcNFyiGNnfW4=
X-Google-Smtp-Source: ABdhPJwFy2vi07qsHrPVPDoZL7cczdfFBeg0SIrZICDMjFcuKIH0tzfHLdXjueh8yoNmRL8On//GoA==
X-Received: by 2002:a17:902:8d81:: with SMTP id v1mr32723436plo.20.1643839273682;
        Wed, 02 Feb 2022 14:01:13 -0800 (PST)
Received: from localhost ([2620:15c:289:200:da7f:76ba:d0d5:da44])
        by smtp.gmail.com with ESMTPSA id d8sm7219844pjz.32.2022.02.02.14.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 14:01:13 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 04/15] merge-tree: implement real merges
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
        <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
        <02c29f920d0d5fde6d85f7b86a69be92e3f0f34d.1643787281.git.gitgitgadget@gmail.com>
        <xmqqy22tx8t1.fsf@gitster.g>
        <CABPp-BGpD6g5QH3=4X_dCuSX0Bs0utHn5hyuU4_UiwNhU0h8sg@mail.gmail.com>
Date:   Wed, 02 Feb 2022 14:01:12 -0800
In-Reply-To: <CABPp-BGpD6g5QH3=4X_dCuSX0Bs0utHn5hyuU4_UiwNhU0h8sg@mail.gmail.com>
        (Elijah Newren's message of "Wed, 2 Feb 2022 13:56:56 -0800")
Message-ID: <xmqqh79hvsgn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Yes, you are reading right.  I think the cherry-pick/rebase
> replacement actually deserves a separate command from what merges
> should use; replaying a sequence of commits just has a number of UI
> differences and abilities that I think pull it in a different
> direction.

I completely disagree.  Each individual step in a sequence of
replaying commits in order (or in reverse order) should be
scriptable as a single merge-tree that takes "apply the change to go
from A^ to A on X".  Sequencing and placing UI around it is a job
for the script that drives merge-tree.
