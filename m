Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D4CC433E1
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 21:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD1D8208C7
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 21:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaQ9lWFg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbgFZVLu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgFZVLt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 17:11:49 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC4FC03E979
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 14:11:49 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id t25so9218263oij.7
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 14:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=fZH693yZm+yhzf+dvy5SpY81vMIKg2O9C214GCdbLaw=;
        b=aaQ9lWFguQlnJ33HrvJMNn336F6IHoWfLnMj22JqwGNdwBg7FVV6s5VKJb+tsi/ITS
         alEYi9lK4a0y9mpZa0YeEfjIaWKAbRnoNpOwO8gzAAibS726ZdLOR6174bPD/OsrtUxP
         Y+rYLWPlB5+nROmTC0cF8TaNuZS3IBCEPHBTpknb5zO0b0xIBATKBpHjYVDmF8Kq4tJA
         +LCox9pI1rynmJ68vKs/babbI5Ct4Sewj4Eg6Yk9EBjuPZ2pU/s0KlMGepa20bZQrsT9
         Cc8EKqb/+kXkx3keXJOOZAi66JN+hI5NoM4dgqErGb1amKPa3IQH6mnQlW9rMFoYngbs
         437g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=fZH693yZm+yhzf+dvy5SpY81vMIKg2O9C214GCdbLaw=;
        b=e2eH4+3swAExA1flI+waUQ5PcR7odnD1VBdFMSPGWgsIf2aWw529zeutjPdqhosTZv
         w9Jd/j2C90IPT+pb/Zal8+2vv27LlmaxNAPkIuWaxXj7rkqQCJ7QlA4vAQCHkit9fjmo
         Si4XYHKa4/UTQxCurwFa6G80A36ypVuT4bKbh/o19xXh8HJEWW9sBrUH/wBmU07i331s
         sFcSwrrWUviZGfKniguU7YGFPz5nNrpnXW0QqNRe7/VOkj9+uEEC2QB4sRceQ59DyHrn
         WSgg/xlbY1Nhm1ajHuLTqJQ4UyAzMtLLKK4HxMzfzfOOfMy0ezF6s4R1HE3HmlfzA70T
         aQLQ==
X-Gm-Message-State: AOAM5315lhIZHIBCZJyA5Zgr+sfXaS/626DDZaa3cDD8NLBYUcBMl5GQ
        tzRHjp1uh5WTz/NGAjXzCEVdcg0OJh9F/2Kf4iu3Rzmu
X-Google-Smtp-Source: ABdhPJxWWub04zdYGoU/V0ZWaBnIxq0utKJNDtOP4BZkxRteeDn8PIktmpJrjw3wXnKZhbZggSWmml341GBItpSzV7c=
X-Received: by 2002:a05:6808:687:: with SMTP id k7mr4022401oig.69.1593205908816;
 Fri, 26 Jun 2020 14:11:48 -0700 (PDT)
MIME-Version: 1.0
From:   Luke Knoble <lupeknoble@gmail.com>
Date:   Fri, 26 Jun 2020 17:11:37 -0400
Message-ID: <CA+m5axz6QG5+AH5dB-J1dcD26z8z8uOUYUOgypu9kqoX49z0xA@mail.gmail.com>
Subject: bug
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Howdy,

I've found an issue in which I'm using this command:

git clone --recurse-submodules ssh://git@someurl:9999/someproject/repoX.git

git clones the repo successfully if I dont pass =E2=80=9Cgit clone=E2=80=9D=
 any flags,
but gives me this error when I use =E2=80=9C--recurse-submodules=E2=80=9D a=
nd git
attempts to clone a single submodule:

git@someurl: Permission denied (publickey).
fatal: Could not read from remote repository.
Please make sure you have the correct access rights
and the repository exists.
fatal: clone of
'ssh://git@someurl:9999/someproject/submodule_repo.git' into submodule
path 'C:/someproject/submodule_repo' failed

The obvious answer is that my permissions are bad, but I can clone the
submodule repo directly without issue.. This command succeeds:

git clone --recurse-submodules
ssh://git@someurl:9999/someproject/submodule_repo.git

what gives git?
