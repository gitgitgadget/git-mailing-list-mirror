Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A61DC433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 02:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbiGAC56 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 22:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbiGAC54 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 22:57:56 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DC15C9C8
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 19:57:56 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id e40so1290569eda.2
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 19:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q/DLkd+0P6Akh4ZK4+BskfDYwQUwSnuhyrqBVfmOsX0=;
        b=VgsQCsYxvZzcW3iA9Dihuw/QqqYE3BE0dJKbCUnUpoxDLIq5rVJylRKHzTzgYIRz65
         NlFXs77/Zx3/MICQeLKCRoUn34e4Qmndt0ibZp+89ZiPD/SnW4BTjbpjuglMeqQZr0fD
         TBRHZNdzsu5u4QAPBS74vuglgbdEA6hzWe6C3cnaEFgZI3cfn/PuCJBqknZ6Vy3/4x0N
         7oCMvFl3xlJARy8yFA+5eHpIhavGbZPpWuFPyHZCj9agNpK6k3OZLMnobTPfsQq9Ai93
         paxMdIoaGxmg7CuSuAQmnWNPxXb1ViYz+cIuTQuX9d2sR6X7xnTpzfcfkMIoSkRa7MqJ
         k31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q/DLkd+0P6Akh4ZK4+BskfDYwQUwSnuhyrqBVfmOsX0=;
        b=LMUfuESsJwE8OyaIFrFTgPL9bMK1uK5Sn3Z1MZyTlsTKNA2yOv9g8NAfFghfkBzG5Q
         S0Mm06SOym5D7Zhrj593BMf06lxX4nSIQkFMzY3Cs5SmJL346fHuCq8wBbDI6XlA19vF
         c3MWF/18ibYq7CBBfTZLIkAsMENA3INHMAm1VzDjc8soD26YkoV4WBBy2SjqfIvDMV7i
         +1Nl5fPXN4H48/OHAXDmkJBfywZ3E0tI8EeLo0buKNUyUVYuuJZExw6bQw0twAMpnn9u
         PDqY2jD88VJfdUTtIFv3/lWur77TH2Invaw/g9yZuCVDJBvXrDH/LEJhbexJPJ6mrLEJ
         yWMQ==
X-Gm-Message-State: AJIora+ll2Y2F9Eh5nLXk+r/CpPSfQ2v5qJGLq/LilBcknK+0S2If7dT
        A2VUlnDcw3cgq6KU/AvU+tjvfyzRNhF4U245nPDIK9wUbgY=
X-Google-Smtp-Source: AGRyM1uz/jytBLqI1gOE8aeUSulaltYCsIHVypomJvMgLLEeLCT1pDbXHA6VCdVAbFsdvpJuo7UMF9CgM90TaiaMTyw=
X-Received: by 2002:a05:6402:248d:b0:437:dd4c:e70e with SMTP id
 q13-20020a056402248d00b00437dd4ce70emr14201990eda.75.1656644274505; Thu, 30
 Jun 2022 19:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BGtKQVgaf9ttwRMAE6AvH1QC3TqFcFwiAOpnm-SqKnNCQ@mail.gmail.com>
 <20220630223250.2843332-1-jonathantanmy@google.com>
In-Reply-To: <20220630223250.2843332-1-jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 30 Jun 2022 19:57:43 -0700
Message-ID: <CABPp-BEZqATCZdqO0xzwZnS5TTu=4z_-h9yusJmhvxHs-kHUzA@mail.gmail.com>
Subject: Re: [PATCH 1/3] t6423: add tests of dual directory rename plus
 add/add conflict
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 30, 2022 at 3:32 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
> > Ah, I can see you've looked at this very closely.  Thanks for digging
> > in!   I know it's counter-intuitive at first, but the file is
> > necessary in order to get the sub1/ -> sub3/ rename.  The reasoning is
> > as follows: We don't need to detect a directory rename for a directory
> > where the other side added no new files into that directory...because
> > the whole point of directory renames is to move new files in a
> > directory to the new location.  Therefore, no new files in the
> > directory on one side, means no need to detect a directory rename for
> > it on the other side.  For a deeper discussion of this, see commit
> > c64432aacd (t6423: more involved rules for renaming directories into
> > each other, 2020-10-15).
>
> Thanks! This makes sense. Might be worth including as a comment
> (explaining why "newfile" is there) in the test.

Sure, will do.
