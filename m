Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8170EC7618E
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 18:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbjDXS06 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 14:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjDXS04 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 14:26:56 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5FE5596
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 11:26:55 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b5c48ea09so4132757b3a.1
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 11:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682360815; x=1684952815;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WQpFEFtymWnhUEHaoXKuA3MkE9z2vC+Us6Y5zsIkOzo=;
        b=LucUm3TFbwiuxb/WoAw7Q2NcScyoxRQCP/DMDsRMt2OsYLvHge9Aan8pHvYXdCWDGp
         BK+eWTq2gUpVUOCSL3iVGGjTJaaFAWUlLze0Oixi13aLkf0GSFBbYxhsI5ylC0YmLtka
         lgHiLxKrRjqhahetzYc1Gh9GDc0IXckEJE9f0pkhSBHaxhsZkUdjDsKff8X+Rxu0UfYM
         /Yvqkx5PY0pWOVopJ5GdMA+N1LyBhKFWOc9UWQwlM46KorjzdvLqKaBkQpONEHIRz8B/
         9gD7dFd7osBW6is9JvbY6QQdNee7rSNs1W9YnS0gR/KL1NiBz2yAuRCE2ZB56geL4Zaf
         ZLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682360815; x=1684952815;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WQpFEFtymWnhUEHaoXKuA3MkE9z2vC+Us6Y5zsIkOzo=;
        b=L+lkWfj1M9ePQau8x9zDCt9VLu88NeMj9XP/lunFzOTdFOuc6w+h0WQBdv+iqUrv9j
         45Msc03eVTbCQL7LJ8iTKIpYXhD8J88YPJuVnHYE4eBDHHnV3w730W0M4fJQs/bd9ErI
         2Vvm39a/Sbuph5lxt8vnjxyS5bY0jCH+ak/FSArUurrdU7zfhcticfG/6zNnazU+se7s
         GoUiOkUV9qTa+6DL3988BhyyBmT141QUf/2WAsVIDwIL4nQNAMYc5h7UOayhI/oNIcpI
         IRcXwRCQJAv2mnzWMYJxICF1xja9EatvevfrziT0CjsG7v5Yr3NMBTLcjIMCQ8PgHRKX
         l16A==
X-Gm-Message-State: AAQBX9ejqUjl+SlxIK8y4J0OvcroGYjh3B1LhFF+Jur9VX4FRyTJb/rD
        gnX44JiouYzLzAiuo/H3WwHynfjY59g=
X-Google-Smtp-Source: AKy350YlaWFeEcLBai2kUFK3vBKzjENWq/TeUsw6MOF22iMWGICVjeqT5+kVrp/m2F2Kn67ezIDkzw==
X-Received: by 2002:a05:6a00:14cf:b0:63d:408a:e14 with SMTP id w15-20020a056a0014cf00b0063d408a0e14mr21059328pfu.4.1682360815329;
        Mon, 24 Apr 2023 11:26:55 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id g9-20020a056a001a0900b0063b642c5230sm7953991pfv.177.2023.04.24.11.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 11:26:54 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeremy Morton <admin@game-point.net>
Cc:     git@vger.kernel.org
Subject: Re: Proposal: tell git a file has been renamed
References: <8fe188a9-c01f-9fb5-5877-8ff508094b22@game-point.net>
Date:   Mon, 24 Apr 2023 11:26:54 -0700
In-Reply-To: <8fe188a9-c01f-9fb5-5877-8ff508094b22@game-point.net> (Jeremy
        Morton's message of "Sat, 22 Apr 2023 19:01:45 +0100")
Message-ID: <xmqqfs8pdtld.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeremy Morton <admin@game-point.net> writes:

> Could a command be added to git that means you tell Git that counts as
> a file rename?

Telling Git is the easy part.  How to make it honor what it was told
earlier is harder.

I recall that there was an idea about recording similarity index
between two blobs precomputed so that the same pair of blobs do not
have to be computed over and over again, when you do "git log -M"?

An obvious way to implement this "I know HEAD^:path1 and HEAD:path2
are similar enough that they deserve to be called a rename" can be
to invalidate and then contaminate such a similarity cache with
end-user supplied data.


