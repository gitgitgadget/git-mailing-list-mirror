Return-Path: <SRS0=Mgdg=4W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27B0C3F2D1
	for <git@archiver.kernel.org>; Thu,  5 Mar 2020 07:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B0482073B
	for <git@archiver.kernel.org>; Thu,  5 Mar 2020 07:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwFw965c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgCEHYj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Mar 2020 02:24:39 -0500
Received: from mail-pj1-f44.google.com ([209.85.216.44]:34102 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgCEHYj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Mar 2020 02:24:39 -0500
Received: by mail-pj1-f44.google.com with SMTP id gc16so184001pjb.1
        for <git@vger.kernel.org>; Wed, 04 Mar 2020 23:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=1fPmO+q5giB7R3l5qMb7Zabhg0b9eL/sP8X2rl3ZE6I=;
        b=PwFw965cTjEQ5/fvfiHc+oE0N4NtGNvo6KxgWe41x3icNfrWbWbJHW76HdXg0skyVh
         fQHg3jDdSufUbxJppLa9F5Zeg7sCO0dF0/PUvIrRevhHnuipAndySvkdghBIa0AHtghx
         PtcBgrd35gPD5xYYjgeJP4JwtsLmwDtIUwpG+w3FwukSh+Kg2kbvDZeuNGgpQ5Rkil2c
         H8P321AsVAt74n6+/+qARsO7fozNGeRdsZ75EpEpC0XvmPoGAyByIAuUviGSqqn1FKOW
         IYNp8A+Mqvp7dEyGuTRlNpwqG59n4+ZCr/cmF8epCXWIjVFD4i6SIDJy8c2CN5PR1JcB
         K7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=1fPmO+q5giB7R3l5qMb7Zabhg0b9eL/sP8X2rl3ZE6I=;
        b=sOMVQMpJTNToDPlNOwuCkFdQjyVaSm12YNAkH7n2/kSxJpkVlOtIgMBZ/MG07+t/Gh
         nQSocrqq/Vqviby4UUyvuZN4Giter2HyVmgkpGgr+Jkqs4EJ2ECF0YM1CkGjJsDGyphc
         R1kgTMJKS7D/v4xr3S/5oV6oB2PpJlzxSzUPb+SKcVhLTThRWU2e629vkrvBkANxf6yb
         qAkPo69fS6b519ld5VBO+U7PQNictgDEtG9nXkZ9LhBFOoHv/6GPM66MsfgClhabQKza
         o4jLNl5vP1a2hv9XrdZPGx17fmLfE3O+ljXJ0CETYX5oGDu0GrklOIV8OdS+egLMPBjw
         rIsg==
X-Gm-Message-State: ANhLgQ3//E3HL94eM3VfyZnTwONv8LF/0LIcWZO+eKvgD8D+GKAyY2iy
        oCLPrj7lkSSc38hF3VBGjkYVPyqX6KTU7UP2Cp8mld72kwo=
X-Google-Smtp-Source: ADFU+vv2IyZWq+EY+WVPKTN6oz8qx9c83K2T1aXdXilX784SIoUnpaFPlFEtXT9wBE9XmJznyI/nOHuqbT4ImBn7jWs=
X-Received: by 2002:a17:90a:30c3:: with SMTP id h61mr7122056pjb.50.1583393078293;
 Wed, 04 Mar 2020 23:24:38 -0800 (PST)
MIME-Version: 1.0
From:   clime <clime7@gmail.com>
Date:   Thu, 5 Mar 2020 08:24:27 +0100
Message-ID: <CAGqZTUv=KTtm454mSs47hmLJd-GvXxhkypPqqgkabo3=6moCbg@mail.gmail.com>
Subject: parsing `git cat-file tag <tag-id>`
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, I need to parse output of `git cat-file tag <tag-id>` in bash
to get information from the (annotated) tag like author, email, date,
subject, body. Everyone has ever done something similar?

What would be the recommended tool in bash?

Originally, my problem is that I have tag-id and I would like to
directly from tag-id by calling a git command the individual fields
from the tag content. I don't want any <tag-id> to <tag-name>
translation first and i cannot use for-each-ref --points-at=<tag-id>
because it's not in older versions of git. Thank you very much!

clime
