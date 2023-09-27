Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B41AE80A93
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 06:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjI0Gdk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 02:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjI0Gdg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 02:33:36 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC86D121
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 23:33:28 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c17d8745b6so30084871fa.1
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 23:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695796407; x=1696401207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQQMXlDIpme0mReUHAG2elCUbq35jax/j5Jkuayug4k=;
        b=PXqbbINgKF8SJSiKuKqBJkwQLrnKWAqzNf+MVmhJQOP616xQ08jG+Cck7aau0r+zVh
         ZhzxVHkZCFp4EapSX9M4mr7GjJF7yOwVw1UlR8lNqYQelOCWQoY92+1bFk3JO14D11rM
         3OXmtWLhOkhNtvF87nREKE141cqQkYzr4lqgA1jNLf05rrzljV8/7WNEvbtiwxCfhPNd
         ygd41Eo8Z5rtumXj04OEr2AF7bh4cVCWxZdRuz1uj5H3csCYF6dt4AhVYMtwSM2CzEYS
         4vVhg1vCXQaQFXFoUtMJXZ/pP/N5AgEdK4w26d/pl10eMS1x/gyZb5/7FWhOC4s6RR3w
         2aVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695796407; x=1696401207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQQMXlDIpme0mReUHAG2elCUbq35jax/j5Jkuayug4k=;
        b=ck+cggWrNe+0ixmdswaFPYxXuUStamaIBajbEsUDKs5eXM+x7AUIwlwJ4iAZ47eVj2
         IXNtKJebisYWhtaJAk+Rb1+tRkFNfUmzL2H2Sq7W+Lx2dLA4zjO9TOmWn891NfRAjLsn
         kHpmSOsR3+eE92dj0w3U8vquryEkqAdfI83wPKDHmYzXXy0dXac6GsHp3OPD8BngjjYp
         j3rieNv8wCz4oQl+7IdeGyNWYXslV4B0pU4hQxj6311z7B1GnMMzuT5KSKjY1lQ1iHMu
         ccGcdWYMOCGxbR7zFbXBA9u59Ds2hdZdPZYwEgIDsjzT3Q3bEy3kgRp9ywkq0GG7JToc
         /FCA==
X-Gm-Message-State: AOJu0Ywn7w84njnO/63H2cW58gXlanp9y/IRP+YhMGIcZs7snvxIleDL
        M5OTQK4sl90EhKTIF5hf1PK+DK88MEF58ON1cmya315ds80=
X-Google-Smtp-Source: AGHT+IEwU3+l9CSQ4LRA+8P2oGw5OSsFtdq1jscIcURpX0y6/FpFvk2rIuud7lrq+delCLyYv9AR/TLJ6CKJV++QXk4=
X-Received: by 2002:ac2:5236:0:b0:4f8:75cf:fdd7 with SMTP id
 i22-20020ac25236000000b004f875cffdd7mr877939lfl.22.1695796406579; Tue, 26 Sep
 2023 23:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8UFD1bsez-eMis5yH7Esds+LkhMnj0qTUMFPL1tRuDv2fiPw@mail.gmail.com>
 <CAMO4yUEws6CmBH+rYynnGGsX067iJRgyQwVxa2b4mkYwnV_u+A@mail.gmail.com>
In-Reply-To: <CAMO4yUEws6CmBH+rYynnGGsX067iJRgyQwVxa2b4mkYwnV_u+A@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 27 Sep 2023 08:33:13 +0200
Message-ID: <CAP8UFD1fZk8qMHWfavBpnywQ2LHqJZEz7MuZOXsF37tPifdsQQ@mail.gmail.com>
Subject: Re: Projects for the next Outreachy round
To:     Shuqi Liang <cheskaqiqi@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Hariom verma <hariom18599@gmail.com>, nasamuffin@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shuqi,

On Wed, Sep 27, 2023 at 5:30=E2=80=AFAM Shuqi Liang <cheskaqiqi@gmail.com> =
wrote:

> Hi  Christian,
>
> I'm afraid I won't have sufficient time to take on the remaining
> commands in the upcoming school year. I'd like to leave those for other
> contributors who are interested.

Sure, no worries. As per Victoria's suggestion, I will not propose
this as a project for the upcoming Outreachy round though.

> Sorry for not providing more details in my final report. In 2023 ideas[1]
> git write-tree, git diff-files, git diff-tree, git worktree have all
> been successfully
> implemented with sparse index integration.There are some remaining
> issues in git check-attr related to diffs.[2][3]
>
> Two other commands on the list are being worked on by Raghul:
> 'git describe' has been successfully integrated, 'git diff-index'
> still need more work. The remaining commands on the list have not been
> started on.
>
> [1]https://git.github.io/SoC-2023-Ideas/
> [2]https://lore.kernel.org/git/20230811142211.4547-3-cheskaqiqi@gmail.com=
/
> [3]https://cheskaqiqi.github.io/2023/08/20/Week9-10/

Thanks for this information! The details will be useful to
contributors interested in this.

Best,
Christian.
