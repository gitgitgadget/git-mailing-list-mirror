Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2992C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 17:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 888A82068E
	for <git@archiver.kernel.org>; Mon,  4 May 2020 17:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXTE0fB4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbgEDRR0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 13:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729714AbgEDRRZ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 13:17:25 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81378C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 10:17:24 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id f18so10437032lja.13
        for <git@vger.kernel.org>; Mon, 04 May 2020 10:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=Oh7S9/Rm2SDe7qc8qHC/lODnQCI01XTCjihbz9Ysjzk=;
        b=oXTE0fB4g/U/VivrwIIaYbe3lhnQiA+yYXXLoNAteycDPczIomA9Ign4MlYMaCxi0W
         E+o0Pw+zf4LDFAuoOR2Kzisw9iSO8OZbVqUpT9YqxBWCrShWMYhF/SVkT+XCckIYT9JQ
         7agd+B+Aeb/29VWhF3r+Oi9njka/s6h7zaPJ+YmtteHJBT1uYCFk/2EelcFChVEeo8mZ
         ecUcQdvatGet3HEYXBi1Qb+eb0raWC8U8HWhoSwYZNvcDpYDzwtbe9ODcvr3wh8U3lW0
         NI64wit9s7GMAUA/ACod4UdAyA9oWoV4Lli8KPEfQj79cAiUW4Ik5GZ5kVbbT4+36HAk
         5Y6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Oh7S9/Rm2SDe7qc8qHC/lODnQCI01XTCjihbz9Ysjzk=;
        b=Xx8Nlo6UXjF1VjCDsGFZ9gfNVJyztwb4LcyX1kL41m2pafo81wKn2WqZxHk+GMtYn2
         XN78wIQHhmUtkFXhQngFw+gHziBAmLsbhIJRx0vdZXqVDcCHS6S4y6lWJthEGKOob1y8
         uwQk13IUjj/DOP+bDXc+0LdyISYzDrjLW3sWK7896w5FCVADUF336HZrFJh6GTjiCVdS
         jwJoN5UvPVCZni2RWZTVYISBKFWqY1YXVgwfDtlyEdvwnBCR+xC0MzXsDqjbUHYwef9Y
         YEaJTgNT7jf6bgq81Fq/Nap53Y3Wm+CKt+XUsgPuEtPncTjPeMcI+jQRenYnpx60Nniz
         VO3g==
X-Gm-Message-State: AGi0Pua+PfwDICKSnYkjAAnKPe3nzmFLbDas4yzKXgrvwivBlYMvoXSY
        p5XW4yJbLZ9g6pR/A+lzqJfuunrF
X-Google-Smtp-Source: APiQypIZ6xdRFcndCFtIWKP03PL27TPrRZ8mykX2onJRDM7qa8q7Z/TTP1nAfBoPoKhVPRT0vstM+g==
X-Received: by 2002:a2e:90cd:: with SMTP id o13mr11430956ljg.220.1588612642069;
        Mon, 04 May 2020 10:17:22 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id h84sm10306863lfd.88.2020.05.04.10.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 10:17:21 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Ewa =?utf-8?B?xZpsaXdpxYRza2E=?= <kreska07@gmail.com>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>, git@vger.kernel.org
Subject: Re: file is showing as modified even that it was never commited
References: <CAEoQP9iY-0+=ETA0vrHL0HngccwtNA_3KX4WSSokJpOgJDGUeA@mail.gmail.com>
        <20200504055530.GA13290@konoha>
        <CAEoQP9hyMi=oj18atTJo+dR3ve_zzrLQoOja0CKAAVHei6rA0g@mail.gmail.com>
        <20200504120024.GA3372@konoha>
        <CAEoQP9gs-a1NanNpYiFQgTs0C+CeYhbD8rMjoFVat1ZSijNA2A@mail.gmail.com>
Date:   Mon, 04 May 2020 20:17:20 +0300
Message-ID: <874ksvei1r.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Ewa,

Please see below.

Ewa Śliwińska <kreska07@gmail.com> writes:

>> That actually was a solution to your problem, not a workaround.

> Not really, because I would like to investigate what happened, not
> just fix it. In that case I could as well recreate repository I
> guess...
>
> I agree that I could add those files accidentally. But I'm really
> disappointed in fact that you seem to ignore all the part where I
> described in details how I checked this and why I think this is not
> the case.

Except you didn't give actual details. Please give exact commands you
issued and exact answers you've got.

For example:

$ ls .test
a  x
$ git status
On branch v4.0
Your branch and 'origin/v4.0' have diverged,
and have 2 and 29 different commits each, respectively.
  (use "git pull" to merge the remote branch into yours)

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

	modified:   .test/a

no changes added to commit (use "git add" and/or "git commit -a")
$ git log -- .test
commit e1e7818f4120b5ebc622c8dbf1b257ea8a03530c
Author: Sergey Organov <sorganov@gmail.com>
Date:   Mon May 4 18:55:58 2020 +0300

    Test

$ git log -- .test/a
commit e1e7818f4120b5ebc622c8dbf1b257ea8a03530c
Author: Sergey Organov <sorganov@gmail.com>
Date:   Mon May 4 18:55:58 2020 +0300

    Test
$ git log -- .test/x
$ 

> Could you please answer if there was something wrong with my checking?

Nobody could tell unless you actually show us your checkings.

> I'm asking second time.

Thanks, we've noticed.

-- Sergey
