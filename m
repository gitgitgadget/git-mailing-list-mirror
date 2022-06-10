Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFADC433EF
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 02:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241846AbiFJCwz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 22:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238394AbiFJCwy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 22:52:54 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7025725EB1
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 19:52:53 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id k11so34078687oia.12
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 19:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=g42SYdREDID3NePxsyq+4ieEH6wxBXtOo6LpmI4EQVo=;
        b=R3rHp7rgrWOgIi/PUrKa6GDYp3lJZ5VximykLbA5TSs/9pcSKe2S6syTqGDCXwLvBh
         acq3wQjS+Sc+UW+IJBmw+HqNmGAb3HkB2BXmh/uFm9k1KR9zGldSarLhe5Fhk/UP82Ap
         C6p5JD+1mC3dJK8b5Lj1wZYKlUJFDjzG4A8MTE1pdpWHkWbHBREoaMWSVuSex2vPdCS7
         dNqLRQj1TH3CsNIfhcJbx0Tp3llNSSQvmq0ILcQk8AnOkIyxxkrBrqQDyCNwJPryG9wO
         b9NOKBEOM3oe2PfjKPl3mDxNDZOm9TFaqLHcctCVI5AzdcrTqkqi2jr5M3zWQOsPRUbQ
         JHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=g42SYdREDID3NePxsyq+4ieEH6wxBXtOo6LpmI4EQVo=;
        b=aDETisTVx6lJcLIEVYykDvMfSVo1DutZY3O2zr65N9hjrB3TbccC4ClrSKlkEaPqb5
         hq8pNAgTURGb22CAg8VIsYEPS/KXUa5hipV/Xl5MkmkRtBdi+2OigQn1owNfsjFm4cQz
         44+4N2Fxob57ew/qNoIGw0849dUkDO9O97SzAEDtN1aINVnVs4LiPRaz3lJpJ9kar8S4
         xvYmpOb5TBsjylXmEHO4A5WugDIBMmgfFX811kY8VdjQyA774+ZuGox2draEOwM8UQof
         TdAYUZroR+p9Mjz/Rq6BwGYn+V6ba+DysGVsE3/RjKenqg1mOKTO+p2B79wNcJyy6FlN
         +A0A==
X-Gm-Message-State: AOAM533ioKqlaqhcHL7POlrHZto0r8U3Z3O1k58bnb+h7nL/dCqfhlzf
        OMxBi8w0qUfBFlXbp8wTB8oxpOMJn4dnBSu+OEe4giacB/tVyg==
X-Google-Smtp-Source: ABdhPJxRzF/ECuxNirAt3gKfFxI+QmpUx+Ds+p0P1bQlAppo+9CHESjwwTNSvG+s36vFyamudqLOZ9ypZVJKd8N4Qnw=
X-Received: by 2002:aca:b354:0:b0:32e:fc24:bea6 with SMTP id
 c81-20020acab354000000b0032efc24bea6mr1181568oif.295.1654829572638; Thu, 09
 Jun 2022 19:52:52 -0700 (PDT)
MIME-Version: 1.0
From:   Piyush Gaikwad <piyushgaikwad321@gmail.com>
Date:   Thu, 9 Jun 2022 19:52:41 -0700
Message-ID: <CABsvAmr0-1eLQeCR-hhz_CObOS2bgjRf7v+YG5BOY8h5nn+2kQ@mail.gmail.com>
Subject: behaviour of untracked files cache in git stable 2.36.1 verison on mac
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

I am currently on Mac.
In Git 2.35.1, when I cloned my repository, it took 7 seconds to
enumerate the untracked files and when I did time git status, it took
approximately 2 seconds. And, when I checkout to another branch it
took approximately 15 seconds and when I checkout back to my main repo
git status took 15 seconds (which should not take this much time).
Work-around for this in (2.35.1) was: I set core.untrackedcache=true
and GIT_FORCE_UNTRACKEDCACHE=1 which helped to update the
untrackedcache and improve the performance of git status of
(approximately 4 seconds).

But now in Git 2.36.1, this work-around doesn't seem to work. It takes
approximately 20 seconds on all branches.

Possible changes in the code:
In Git 2.35.1, code in dir.c: GIT_FORCE_UNTRACKED_CACHE,0
and the same in Git 2.36.1, code in dir.c:GIT_FORCE_UNTRACKED_CACHE, -1

Is this code change which made the git config variables unfit for the
current stable version or is it something else?
How can I solve this untracked files cache performance issue; is there
any workaround?
