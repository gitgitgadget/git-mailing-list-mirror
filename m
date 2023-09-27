Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24015E81815
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 04:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjI0Ec2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 00:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjI0Ebj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 00:31:39 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD521BCF
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 20:30:44 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-405621baba7so73173295e9.0
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 20:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695785443; x=1696390243; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZE/A4oP/Sq28WRvO6QziP0u1srqfJiMQqQOEEnaMn4=;
        b=ZhgCiY+arrEsfSq+vsDJtQ2IZbAPKK56T72+VybBL5nqmqv0XmmZJmRFr7qr4GfQmS
         Gf3sJAUC2Mikiq1Y7MR6UC03nuqrgg92wHGWtysHRdLiNSg0W21qH3zDk0T68qHiJ+3L
         7sjD8xE1mUo/sAsH5xC82Mm1S1gWiCm1/JlrPflUAjmSdc2gAz1jNFOkWh33sIrmBFPQ
         1Fj8Rw8dXJRL0NvUuLnaZeVF66hbxd65kQiVhp2KtZpG+xNwuRm9KG4CEburPAbP9idR
         oG5dUI5/3M/QCl7w4ehy9/XICNrDOqgopQngLFOSrKc/MDojoVuR+Xbg/MYwuaH9lRNi
         eXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695785443; x=1696390243;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZE/A4oP/Sq28WRvO6QziP0u1srqfJiMQqQOEEnaMn4=;
        b=LrScm/hFrofXdg3+LDKIzLj98FKQbypDOkBwGgPOmDkOXTG77pTeA8+/s/qlP1bFjg
         CQa1I1WWjh5JbscltJ8pN9d4TaENdywSzCSLU5UaWAOiy4vChldKxbc8V+P1HJqjGA/t
         UxxgBSeDmJY/9MuJZCu8GzGQcVusngao/MpAzZNOe5vlGo3MvS9XUjdCJhpzSdVB7utp
         ohwPPO4xyxS8hTptaLLq7PKVKK9zgRK2vRn7sJhhuY1i87nW3r41tDxvCBqWiUGAmcFj
         jiFbTeTj1fCEo1gDt3wSNh7PmGALXzAI1Q3995BfhJIkX+IGjIbFovMRyYoTHmvsWQtR
         BYDA==
X-Gm-Message-State: AOJu0YwzInVPwmFB5TpmvFQh3khnks00WlWa12EsNli87jPMFq0MwUVi
        xL67kPpsipRC/a84IyDMEl8DO8wFDdSB52SPTBek4uaQs59D5w==
X-Google-Smtp-Source: AGHT+IFF/zlT2R24skrDM3002vNGTwE4lx70mUIqtMcn6N2EiHpjcZjL0+V9bZKWfVXQofsem0wYKiJUoNpLuB68WCQ=
X-Received: by 2002:a05:6000:1d96:b0:324:7bdd:678e with SMTP id
 bk22-20020a0560001d9600b003247bdd678emr470829wrb.60.1695785442998; Tue, 26
 Sep 2023 20:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8UFD1bsez-eMis5yH7Esds+LkhMnj0qTUMFPL1tRuDv2fiPw@mail.gmail.com>
In-Reply-To: <CAP8UFD1bsez-eMis5yH7Esds+LkhMnj0qTUMFPL1tRuDv2fiPw@mail.gmail.com>
From:   Shuqi Liang <cheskaqiqi@gmail.com>
Date:   Tue, 26 Sep 2023 23:30:30 -0400
Message-ID: <CAMO4yUEws6CmBH+rYynnGGsX067iJRgyQwVxa2b4mkYwnV_u+A@mail.gmail.com>
Subject: Re: Projects for the next Outreachy round
To:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Victoria Dye <vdye@github.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Hariom verma <hariom18599@gmail.com>, nasamuffin@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 26, 2023 at 10:48=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> So Shuqi and Kousik, please tell us if you would like to continue
> working on your projects or if it's Ok if we propose them for
> Outreachy.

Hi  Christian,

I'm afraid I won't have sufficient time to take on the remaining
commands in the upcoming school year. I'd like to leave those for other
contributors who are interested.

>It would be nice though if I got an idea about what
> should be done next and how much work is left in general in this area.
> (Shuqi's GSoC final report at
> https://cheskaqiqi.github.io/2023/08/22/Final/ doesn't talk much about
> this.) Perhaps even if Shuqi is continuing to work on the project,
> there is still work that could be done in parallel on other commands
> than the ones he is working on.

Sorry for not providing more details in my final report. In 2023 ideas[1]
git write-tree, git diff-files, git diff-tree, git worktree have all
been successfully
implemented with sparse index integration.There are some remaining
issues in git check-attr related to diffs.[2][3]

Two other commands on the list are being worked on by Raghul:
'git describe' has been successfully integrated, 'git diff-index'
still need more work. The remaining commands on the list have not been
started on.

[1]https://git.github.io/SoC-2023-Ideas/
[2]https://lore.kernel.org/git/20230811142211.4547-3-cheskaqiqi@gmail.com/
[3]https://cheskaqiqi.github.io/2023/08/20/Week9-10/

hope that helps!
Shuqi
