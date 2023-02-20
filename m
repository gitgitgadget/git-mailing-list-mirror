Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2239EC05027
	for <git@archiver.kernel.org>; Mon, 20 Feb 2023 17:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjBTRDf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Feb 2023 12:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjBTRDe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2023 12:03:34 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824B810D3
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 09:03:33 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id bq17so1924685oib.8
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 09:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CvRjOSOyuLhYqbJ36yASZwc0fTUdn/aNqrtI9ppum+8=;
        b=LWqERvvHCQkuEKQeFs+O8/osBrzOyzHK3gFkPsTvu6rhf9ziYQEVubzHNhiknDhDvd
         mDnyEDRp6bpWXHnHyZciY2kJUfjunwjEpuZOunfNX4NE6rDCv0fxdPdAliY8DOtt12LB
         oELDGquYcUmpMrU/a72qYDK1lEUqDk+adOvclEhdj5UZ+aNYx9s3s81CjwjkeoBe886r
         krZPLuY3jMklw6EQ5wPuVDxkdBvHX/9rZI/FzqgItl87AgmkjZTfsBU5rlPf8z9PTtXt
         LPOLyZt57RnzdEvTVKNzbOgqyd3xKVLI/kmIfcyvfUwyyh9stFgLWva2Hl3tuaE46huJ
         crPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CvRjOSOyuLhYqbJ36yASZwc0fTUdn/aNqrtI9ppum+8=;
        b=syCZbV/wjQVkMPF4UMFRIgrfBTezSfLz1wriaWT90G+8Wmc3MA4R9fEEGzsOHEUCkv
         PNgXj4/Drxn6akt0UnAv2m3b5aSagQ35QqjxB39C8bCxhvnviod5mTpQEv6oX9PTJWII
         DMlzoaH5I4cB0xra39PQ8sFXRzXe1StmVf6ulli91dMRwmD00ynDQ7Mw160k0w9SkMyb
         ylOaNJsGXZX15Z68fyUL2xJgd91Er2MNGeKXGmFmQWt+RziioSIgqTI8OdSLj96+ovJ/
         58a2JhrIM8xhAGJ1Jk8Z26Jw2oKIaCgeZmcvpTA9xETB5sNLWUQfF1ZMH4JVI0fHsYlX
         VEmg==
X-Gm-Message-State: AO0yUKWnNgHRZPBA6jYCPMZ9o1r7dJfC8181lIkt39kOM0QO4QGaJWky
        F9+/0Xu91Ta31MfJ4gf04ZkQtme+SGVAcmc/lkc=
X-Google-Smtp-Source: AK7set8rX2VRSuHB4/UDp/lbB6Ai4mfoU/KTos5o1OYOMIy2A6IaNDVxPp2vfnQ++d2yj+lQbM6X8tZHY3Kd4K2L2A4=
X-Received: by 2002:a05:6808:11cd:b0:37d:7489:8b4 with SMTP id
 p13-20020a05680811cd00b0037d748908b4mr704201oiv.154.1676912612820; Mon, 20
 Feb 2023 09:03:32 -0800 (PST)
MIME-Version: 1.0
References: <20230220033224.10400-1-alexhenrie24@gmail.com> <8857003a-f33d-00c5-5e1e-bfbcd60924ae@dunelm.org.uk>
In-Reply-To: <8857003a-f33d-00c5-5e1e-bfbcd60924ae@dunelm.org.uk>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Mon, 20 Feb 2023 10:03:21 -0700
Message-ID: <CAMMLpeSAspkSf3KDpoH_WFwGV4z8+4ag=kzqgHPypvXp9yiGyA@mail.gmail.com>
Subject: Re: [PATCH 1/2] rebase: add a --rebase-merges=drop option
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 20, 2023 at 2:31 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> On 20/02/2023 03:32, Alex Henrie wrote:
> > Name the new option "drop" intead of "no" or "false" to avoid confusion > in the future if --rebase-merges grows the ability to truly "rebase"
> > merge commits by reusing the conflict resolution information from the
> > original merge commit, and we want to add an option to ignore the
> > conflict resolution information.
> >
> > This option can be used to countermand a previous --rebase-merges
> > option.
>
> I'm a bit confused as to the reason for this change - what's the
> advantage over just saying --no-rebase-merges which already exists?

I didn't know that there was a --no-rebase-merges option because there
is no documentation about it and no tests for it. I will replace this
patch with patches that add the missing documentation and tests.

-Alex
