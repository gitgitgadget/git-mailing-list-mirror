Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89A5C6FD1C
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 16:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjCXQul (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 12:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbjCXQuk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 12:50:40 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248961E1C1
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 09:50:38 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id h14so1438465pgj.7
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 09:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679676637;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k2bINnEbrf3aVQK3l12Wh+Y08fBZhdLX8AOsdXR+Vhs=;
        b=b8GPZgCNRL5lVWJg6MVQniiHNxRWQSL2pPW4P72oABIqogHR2iByALyjNWKFOK0lp1
         jT7X/oq/Hs7/aHnCJI0S/MTlm5rHdMin+dlyHq4MtGYENrCvpvDeOA4dLAXozhj26cnt
         aZuQivNVpzbRr9HG1vAlUFv//VfQCWhiJkOAkZ5ouzjFRXLcjpwkkOLvxz5jROhkaWnZ
         PohEqR1a9OhUbcXiWKu30fzHHatCRtnOo5GemxXR7FYXUhuzKQVD+DscrXe83uy6Wj0P
         g2vjumK1l27mqrH2i4nvAbc6P0G+egNK/sFr4q4MarQT4S+8A+J08di7B/ENkqwT9VSq
         TFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679676637;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k2bINnEbrf3aVQK3l12Wh+Y08fBZhdLX8AOsdXR+Vhs=;
        b=HPZKr8ZRPBUxJ3ayRUa08y8lCv9vNRPCe+V9SZd62QlAElPJJMfoH/nsQx28kCC5hR
         3ujwQQ1KsP2FqFqKSg5RcWNSN6J9uFoWjyZVCVlYuKqbQg6P6iELgLxnlmRd2jKA1B8c
         sTqJjZ1vlB2tl1i3aUD/Z7RNooWGPOe/shdGESj7y7b0lRRM5iKKfH4NPPsgt1ENTKyp
         ZJUg8074psj+G8oF6PVXuHalY+D1xOfEnW244pT1JDSZM13JcVP5PQmebSLfonZx4g5F
         y2DLo3xQZuiEdXrgu4ajDufy8HJvvrSkxoAvTh/FjkQc0l2jl35HBG9fzS/BQ5wrQSQo
         fYDw==
X-Gm-Message-State: AAQBX9ewSiJJSs7HQtcD1zG9MC0fAb6JSNdpuSG8Jl3zIIEwRdahQ7zr
        3+uoGfrz79yloHTgEy68OFeTnPTgeoE=
X-Google-Smtp-Source: AKy350YmetuzUcYcjAeVlTOOgdONVPt8Ox743yqYcGZQNozxxNC/118tm6HrAyw8hMM64FcadVzhPw==
X-Received: by 2002:aa7:9e8f:0:b0:623:e4d2:d13e with SMTP id p15-20020aa79e8f000000b00623e4d2d13emr3325501pfq.34.1679676637380;
        Fri, 24 Mar 2023 09:50:37 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id h4-20020aa786c4000000b00627ed4e23e0sm10803929pfo.101.2023.03.24.09.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 09:50:36 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Baumann, Moritz" <moritz.baumann@sap.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Feature Request: Option to make "git rev-list --objects" output
 duplicate objects
References: <AS1PR02MB8185A45DB63216699AFB2C5494849@AS1PR02MB8185.eurprd02.prod.outlook.com>
Date:   Fri, 24 Mar 2023 09:50:36 -0700
In-Reply-To: <AS1PR02MB8185A45DB63216699AFB2C5494849@AS1PR02MB8185.eurprd02.prod.outlook.com>
        (Moritz Baumann's message of "Fri, 24 Mar 2023 15:51:21 +0000")
Message-ID: <xmqq4jqa3xgj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Baumann, Moritz" <moritz.baumann@sap.com> writes:

> Is there any alternative for my use case that doesn't involve walking the
> commits one-by-one?

I do not think there currently is such an option, and not showing
the same object twice is pretty much fundamental in the operation of
the command, so it is unclear what the new feature should look like.

Should it also show the same commit it encounters during its history
walk (remember, a history can have forks and merges in it) in
duplicates if it encounters it more than once?  Should it show all
the subtrees and blobs in the tree of each commit, even if most of
them do not change from commit to commit?  How does the user control
which ones are duplicated and which ones are to be visited only
once?  How does the command line option used by the user to tell the
command to give such a choice look like?

Once there things are designed well, implementation of such a mode
would not be too hard.

By the way, "rev-list" internally uses walking the commits
one-by-one, anyway ;-).

