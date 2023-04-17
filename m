Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E833FC77B72
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 12:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjDQMuH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 08:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjDQMuF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 08:50:05 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74206CF
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 05:50:01 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 39-20020a9d04aa000000b006a1370e214aso10347303otm.11
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 05:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681735801; x=1684327801;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIVNJZi1BLGHr9ZFi6UBq8Y30JzF1ia4OHkMf7QkIy8=;
        b=L0GRHCUKHLsdJI7wkJDh2s4HK0bsIhksBCurdrHHVXepUwoRXZyUoGAhV0zBqueNBn
         TU5j7kFIETa0VTMS7AsEnSmR5d0RyXKWo+vAAfHpyWPtAMfbiCc2pcmkkJX8dfaJK2/5
         ugg/pkX2WMaSHhcONSpg2fcL1PfOQk5MFcxBjjxGJ9whnyoG+/dZGTbbehUXdc/AA31B
         lqyG6lHfdhi6eqStLo3wDtPIVjsuqoc4P1AGQG8TW1+MJebQ3lhd4XMsE0HOgjkrpGRy
         Iiaj7OAgI2bM3hoQje+WdnAZh2Mvp80BfFYZWzAeCSGfxGc7aQPclTv8kJlEC8Ik0rEo
         nF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681735801; x=1684327801;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cIVNJZi1BLGHr9ZFi6UBq8Y30JzF1ia4OHkMf7QkIy8=;
        b=BdCH3ZL97xC/BL6wjY1PcYOXMxcnWlmuU5ATbC5OrTBw0V6fqEBenzgEv5NH9vudpz
         hcg2HKnIF8JiV7nfnAvyLCDP9jGEzFKowcOHiVKA1/5oZwALD4HPy02LfzumSD1swzKG
         DB2qsA77c5amQQUAsICYGUWINN++pWG9DOHleDWJJxjbHsoW6JolOG8INH8ZFMeTDbYT
         amTwCEJYFDeIQ+mtNVW2NYL4ms7HJ2SFvUZkmQYohEIr/5BO/5tcFP0O8Bbi/UF7SJJI
         mL77TK0OicWrVVd/DtJf9HOXMr58cUXaNsg13VrNuzW9+zYNyLqw74bK+vxLnHBHa+u+
         FgvA==
X-Gm-Message-State: AAQBX9djDrWb3iYq7SMmrEt6F87fmwK06NABeXSHpSEkuF63rLvvsV+3
        TmzHdnm5qptrKiKUvRXIidKHkbZEYA4=
X-Google-Smtp-Source: AKy350at9eCyImNdmMpx9BfCSRyAH5fV5gsHNbHEYVN8GYvBDtJRd508KDeXWCWfRjTybRPcnwNPRA==
X-Received: by 2002:a05:6830:2001:b0:6a5:db64:c9f4 with SMTP id e1-20020a056830200100b006a5db64c9f4mr2748582otp.34.1681735800806;
        Mon, 17 Apr 2023 05:50:00 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id g16-20020a9d6490000000b006a3df644d31sm4407719otl.37.2023.04.17.05.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 05:50:00 -0700 (PDT)
Date:   Mon, 17 Apr 2023 06:49:59 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?QmVyYXQgw5Z6ZGVtaXI=?= <Berat_Oezdemir@deichmann.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <643d407765bc7_751a29453@chronos.notmuch>
In-Reply-To: <AS8P194MB1575B12A6A11E3CBC6537C26E29C9@AS8P194MB1575.EURP194.PROD.OUTLOOK.COM>
References: <AS8P194MB1575B12A6A11E3CBC6537C26E29C9@AS8P194MB1575.EURP194.PROD.OUTLOOK.COM>
Subject: Re: Bug/Weird behaviour with git pull
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Berat =C3=96zdemir wrote:
> I stumbled on a weird behavior in git with the pull operation. =

> Imagine the following scenario:
> =

> We have a local and a remote repository, with the branches master, deve=
lop and f1. We
> =

> - cloned the remote repository. =

> - checked f1 out
> - checked develop out
> - run git merge f1. Merge was successful. =

> - Did not pushed
> - run git reset --hard origin/develop -> to undo the f1 merge into deve=
lop
> - run git pull origin f1
> =

> What did you expect to happen? (Expected behavior)
> I expected that "git pull origin f1" will just update the f1 branch (fe=
tching and merging with origin/f1). In my case I expected nothing to happ=
en since neither local f1 nor origin/f1 did changed while testing. Just d=
evelop changed locally, but it was resetted.

The first sentence of the documentation says:

  Incorporates changes from a remote repository into the current branch.

You are effectively merging origin/f1 into your current.

My recommendation to everyone is simply to not use `git pull`, as a lot o=
f time
(most of the time?) it doesn't do what the user wants. It's much better t=
o just
do `git fetch`+`git merge/rebase`.

Cheers.

-- =

Felipe Contreras=
