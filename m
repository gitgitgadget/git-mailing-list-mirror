Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA229C433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 18:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239660AbiBWSCY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 13:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239363AbiBWSCX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 13:02:23 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B51B84C
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:01:54 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id p9so54131464ejd.6
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MMGtqAcuhG2g5HRXRvHfNJdF/Tg98+bEXhlThdDqiyE=;
        b=SXAWd3pAEgBC7n5RkKMZZ99llgByleObfrYAhLCkJUu/7f9cxgqeEIcu0J4AYZbR/c
         g4o/idvTBX+rGqD68QlsmpI3seieXicaOq42dYlSvBuNGnmcla38j13MZDon/Y9BFlf8
         nTCeMoyLx4ywIVmnuy8AVUss4Nm10Oq3HtlGtkCogSDU/B8LlCpkwbT139Njkvg6Q75h
         A9/7uQoELVMcYcW3dq6hmi49tMTiSymqZfRyS4PNRNXH8DjF5btHtuJ2k+CLbBob2Wd2
         DTXUsQHZbPowPF2IJMOl34jxUc+ecPMxhuefF86xHX9uQHNt+AFPLkq9UIcLTXMfPTlI
         OYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MMGtqAcuhG2g5HRXRvHfNJdF/Tg98+bEXhlThdDqiyE=;
        b=6oyC15cnz+VKQLuG54x8ehhrSDbIvmZ+oYZ0hEC9dKwz6bwEfM0PyxsAM8DT3p6WYs
         TJUWF/ab2GQnlYkHYm8K4XrCIdVY7mWgyv8+dS+2aqGRLfjiXrJpYTH/V/1n/qTF87+2
         0V0Y7BdtxcoUlHddPYwv/LFyLQCAHnhOyXiGCEBBZPWBZsnixfsWGJdFQGaME6pxY3sk
         GSoAtQ9EA290jVcQPI6egxeMpd02lRRHwmVftzG3lZIaGmcR2ZrViyf0G9ScOpv4/DOl
         DbCfd246AFy8of+2Z+lr/DnW29iPFwSAjIbR2Kxz/gOGdECdtII9arLK8L7+rYS/qAvv
         rp/g==
X-Gm-Message-State: AOAM530zAnMAxSRdn+pO4OvDHWPP+qicvQFV+k9EFQVyQMlYUJWzr88P
        HPllmm+W4gFpzxrBFmDRa5jWIgEvJlD/54qJ60DOI1EbLZEznniZ
X-Google-Smtp-Source: ABdhPJziQvoBERyQoCBvAH1zX1qGwnglv0MKXi0mi6v4a8BDrhWro7lUqilVzBUqNIjTDdGPYPg6KfeIcGfBbpARvDc=
X-Received: by 2002:a17:906:3e4b:b0:6cf:7f02:9332 with SMTP id
 t11-20020a1709063e4b00b006cf7f029332mr679113eji.404.1645639313115; Wed, 23
 Feb 2022 10:01:53 -0800 (PST)
MIME-Version: 1.0
References: <20220222114313.14921-1-shivam828787@gmail.com>
 <20220223115347.3083-1-shivam828787@gmail.com> <20220223115347.3083-2-shivam828787@gmail.com>
 <YhZ0qOwtY1vUVTiN@nand.local>
In-Reply-To: <YhZ0qOwtY1vUVTiN@nand.local>
From:   Shubham Mishra <shivam828787@gmail.com>
Date:   Wed, 23 Feb 2022 23:31:41 +0530
Message-ID: <CAC316V5nWB8_ctk6Wz9j_xPMogomktuDdXZkPz2TodqRVXZPhQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] t0001: avoid pipes with Git on LHS
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ah, It's dumb, I'm sorry. This was unintended. The regex I used gave
me all Git on LHS of pipe including this.
I understand it's not a Git command so we don't need to fix this. I
would say We shouldn't merge it.
I will take care to have a final eye on my patch before sending.
Sorry Again.

Thanks,
Shubham

On Wed, Feb 23, 2022 at 11:23 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Wed, Feb 23, 2022 at 05:23:46PM +0530, Shubham Mishra wrote:
> > Pipes ignore error codes of LHS command and thu`s we should not use
> > them with Git in tests. As an alternative, use a 'tmp' file to write
> > the Git output so we can test the exit code.
>
> This patch does preserve the existing behavior. But I'm hesitant to
> recommend that we apply this patch, since our test suite assumes that
> commands like find will work, and so we aren't concerned about squashing
> any potential error codes when it's on the left-hand side of the pipe,
> since we assume that it won't fail in general.
>
> (That's notably different from the second patch in this series, where
> the thing on the left-hand side of the pipe is a git invocation. In that
> case, we really _do_ want to avoid having it on the left-hand side of
> the pipe, because we don't have the same error-free expectation there,
> and want to know when it fails).
>
> I think that =C3=86var gave a nice summary of the above in [1]
>
> Thanks,
> Taylor
>
> [1]: https://lore.kernel.org/git/220222.86pmnf6ket.gmgdl@evledraar.gmail.=
com/
