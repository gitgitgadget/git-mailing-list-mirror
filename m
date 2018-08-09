Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 119A91F405
	for <e@80x24.org>; Thu,  9 Aug 2018 17:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732564AbeHIUCk (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 16:02:40 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37162 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731115AbeHIUCk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 16:02:40 -0400
Received: by mail-wm0-f46.google.com with SMTP id n11-v6so1102237wmc.2
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 10:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rn75AwWR6q2NsRGLnL0P0cNxDYisxP2A5R+UtAJdrDM=;
        b=b7eeZS45fRd9t57bfqkC03l3eZumib+E9aGKv0AsRtGqg5k3m5WoKLvFiJO18Dbjlj
         G0XRGn900020PTb6orKfP/IeRXXKMJbIJ03srIg1GOfhtyniOHJ6gZI7AWUadp8wQ4nJ
         q/NGG80T+VyozJKEd8ej74vymLEMpAQyyw/wYX3YI++pWHX2VLP6GdRrRNdG/th2a4mY
         SeJHLhHuM14ubud1nDbnhqOfp7/UePiQJ4nzqZPL5q6epUY7iiMqLkj0OCaL+O3eo0tU
         63Lg8poP3rCHkmwoGMdBx2vSIdN8E3J1NmtE4iundFW3uk3dcKE2sqRCWI00s72GuhSG
         5TUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rn75AwWR6q2NsRGLnL0P0cNxDYisxP2A5R+UtAJdrDM=;
        b=JyuPB9b5teRzTrGxUUu8WNryAylRJ4xZ9DJ79lMWQxCsF+IKDr23Y5vyNyWZ8k2j5l
         SfIfnXrmaoX1m9MNmjn+ZtgR3sp90+B8FB+mty0t1aEMYd4yugKSw51G9Bdt+A7TT6cz
         iLnEVLM/AZh582IJ9uIubUBwQjG/kuBUB8o1M7OICXyQP8mQvnxyInqCVLg7eCL8eb2I
         Mg3YNxX0Nk2NkKtNwPQCZ67FElBjYIf+xl9Y4OEpl8V89YyQ4RqOENKCUIPic7wRAYNI
         ly2+ZYJ9Jk3eF/9Tb4jez0GjnqfsaH80Wi7ADYBJG57YJ259Ylv2YWbt4PCSj6i00XLq
         O22A==
X-Gm-Message-State: AOUpUlEuk2zMv5mTXdg1VEx42CqCA231725cEfVJSOfOwwHpl6tSU7vG
        uZ80uY8mVJ7LubR2KIqU0Dg=
X-Google-Smtp-Source: AA+uWPyT5+5SWstoE211BwOX+pKUZGPINGk9oW2VxgUXZRh6e9RFTF/XpPZX5arWDCkmbxqQoICOIw==
X-Received: by 2002:a1c:20cb:: with SMTP id g194-v6mr2334982wmg.102.1533836205778;
        Thu, 09 Aug 2018 10:36:45 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y184-v6sm7819504wmg.17.2018.08.09.10.36.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 10:36:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC/WIP PATCH 1/1] merge-recursive: make file/directory conflicts easier to resolve
References: <CABPp-BHxJyWsAQ3FkfdC-5Vqe3d7wWZm-hVYd0-afNY9dEgMeQ@mail.gmail.com>
        <20180806224547.8619-1-newren@gmail.com>
        <20180806224547.8619-2-newren@gmail.com>
Date:   Thu, 09 Aug 2018 10:36:44 -0700
In-Reply-To: <20180806224547.8619-2-newren@gmail.com> (Elijah Newren's message
        of "Mon, 6 Aug 2018 15:45:47 -0700")
Message-ID: <xmqqbmabcuhf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> File/directory conflicts are somewhat difficult to resolve; by way of
> contrast, renames are much easier to handle.  For file/directory
> conflicts, we already have to record the file under a different name in
> the working copy due to the directory being in the way; if we also record
> the file under a different name in the index then it simplifies matters
> for the user, and ensures that 'git reset --hard' and 'git merge --abort'
> will clean up files created by the merge operation.

Yeah, and then our file "path" renamed to "path~2" to make room for
directory "path" they introduced, can be relocated to its final
place in the merge resolution, e.g. "git mv path~2 path/ours" or
"git mv path path.theirs && git mv path~2 path".

Of course, "git rm" and "git mv" must work sensibly, if we want this
change to be truly helpful--but if not, they need to be fixed ;-)

