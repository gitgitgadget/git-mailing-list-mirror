Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A366C77B71
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 18:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjDNSeK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 14:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDNSeJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 14:34:09 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75058559E
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 11:34:08 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id n17so3210017pln.8
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 11:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681497248; x=1684089248;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BOFQf/DAXsqlim3QmiLL1DND9NV+vjusCRljIHnhEhU=;
        b=GfeuB+UDVKjL+elU9RDcCRnX8iOxQMVpcj4ZePxGPklfTRStzfvRXAhqiGw+qGIg5E
         slUHN7845X+9wHalKni1YhgfEQLTUi5agDS53cTR6Jhn+o3SCqMIIWFGNlRhjy5BXW5M
         3nU1MsRvRP6zyiKnQvD/+NNlcTJ8gzuLCJdiO8gcJWbKNMN24BJ3rDtxJTvD0eojDkmu
         hQaorGt63vaHz/1sPCWCJshdeBmktjhOFbwN5gYzikCaksVlbO/aHpn5B0FRneBrjiGd
         6+ha2psftgjwOtM5EZ2kjZQ7HAO0rEFFPPpvzc/1tGX7he/qLd7KYV3SRYlxKPckryWI
         D90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681497248; x=1684089248;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BOFQf/DAXsqlim3QmiLL1DND9NV+vjusCRljIHnhEhU=;
        b=Yd4UvXcyMK8H0yCBHcB1do6N8l1UclEnoDqZtrd1XvrheoZInuw9X4y4MSxbBh7g97
         uB03Sgf/MgtTyT17x6CGfRhahpowz4DdLD/qU8yZNaApphjDX++f+JYGDKFYBdTSgUf6
         06gQYMnBcbTstVfFJv7gKcRXLxC3sRUvAboV8llnT8hfXXlE/hFAtVlsRUSoTcoFVwcQ
         pFcRUCPqBGshsivsOhV2EUrs43jfsCOBdZi9xeWz0eGZnD60YdXlvW3DvvwN6zAweuAW
         qgcwJ7oSSZXdikkYxtWwEXWUOT/pwNNOAu7povd6pDuZof0g4801QZDZmwtOpEN+RUIH
         Jz3Q==
X-Gm-Message-State: AAQBX9dKzFH2yFxxoY8OlQpvRj/A8YBQJXXrWUmwf+zRaDqzVOLSJI8E
        jBJBKcqD79qMRmeVxgF3qaGChcxd/QA=
X-Google-Smtp-Source: AKy350bOny2Vp/R6PzQV9bjQhJlzX/A84d/QUPlR6lFwNTdb5ZdU8fPFoK65JGJBTceVShVD24N30A==
X-Received: by 2002:a17:902:8c8f:b0:1a6:6f42:f5c0 with SMTP id t15-20020a1709028c8f00b001a66f42f5c0mr3500724plo.61.1681497247959;
        Fri, 14 Apr 2023 11:34:07 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id ba5-20020a170902720500b001a6454116c7sm3346044plb.166.2023.04.14.11.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 11:34:07 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 0/5] Document 'AUTO_MERGE' and more special refs
References: <pull.1515.git.1681495119.gitgitgadget@gmail.com>
Date:   Fri, 14 Apr 2023 11:34:07 -0700
In-Reply-To: <pull.1515.git.1681495119.gitgitgadget@gmail.com> (Philippe Blain
        via GitGitGadget's message of "Fri, 14 Apr 2023 17:58:33 +0000")
Message-ID: <xmqqpm86qpnk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series adds documentation (and completion!) for AUTO_MERGE.

Nice.  It indeed is one of the hard-to-discover gems.
