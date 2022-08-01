Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C467C00144
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 14:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbiHAODK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 10:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbiHAODJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 10:03:09 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D062D1C3
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 07:03:08 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id u9so13098374oiv.12
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 07:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc;
        bh=rSPbLeN4wX9un5DvBMicZgLR27oSa6YRPnQ64lhAXIE=;
        b=ME6Xp8MrqOvY/zG4nwGezNbggrcjr8AIicgtJr1fB95+2ZDoZJoWUuAwMoeHpuzTUZ
         5ariKbyE00buFOI0Fq1lubEC/1F2sZ1HQxEhWmNfzKwxjTKsq4/ROUboQ04/kmdteRQm
         yudV4C6BGSLnsOvAR+QYHpNB8JJngYiTMLf7EG8JI3R+Zo1iSefoU0wmsJjSEIXW4KJu
         47NMr1O2WHRWv1v72ot5AD/2xcSXHSghFK88gKt4VqcF7/SkyDSXbw5O3T9AEdCz4pRJ
         CqkpFnB18+9b9hyb7IvaA8cfDntir1RNpHlqCZw/GXou3GXGHeUXRj36cKW0KUV5Dr3l
         25yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc;
        bh=rSPbLeN4wX9un5DvBMicZgLR27oSa6YRPnQ64lhAXIE=;
        b=220ahvmfLokM+Qj9zfC6V9oKQEMbtPmOWMCl2q5ITkiBal4fIReXFlLBaBudrCfssL
         zWJLxTdXq+JOFDZQ1SklRbtpwUrcZwb7p1j1FGqetbyL1NhO0Okrms+9vbPONTqKQXS/
         vQdu983aIyxlvkuRCdOoIeLihk244qIJQtUrAMBu7DSQG2vH2kplR7I1N3DxhhPN4rO2
         mN9zHrdGvaNM2nsO1HGdGYCtn3DhbEE4oiHeZRerOg0rTd/0i1sZyOJPsPtXRPloJVJN
         Tl6zvPw4KHpB7+euQjgXKtaIhHRZo1pvu/EBqJibRDDedLiQDYzv4NpySvhgamSx+JjE
         v6cg==
X-Gm-Message-State: AJIora8orEOsn+Es5Nk5foLOGjHJ7ZA0b0cuWHmbD/cYAqtqqLSnro3n
        ctjLMkT+Tf4QX9/lthG25LzFo+qqjTfw16iHZTfVU+tV7mQ=
X-Google-Smtp-Source: AGRyM1tCWHZ/BK+XS1VtywubjyqGQZGwXY/mxLXlk/481Os8fSmffRa9rY+rIugZo6gsMQuCFkxdDBmSt8t0G15Mq8U=
X-Received: by 2002:a05:6808:1b85:b0:33a:7a2b:3ff7 with SMTP id
 cj5-20020a0568081b8500b0033a7a2b3ff7mr6206210oib.152.1659362587562; Mon, 01
 Aug 2022 07:03:07 -0700 (PDT)
MIME-Version: 1.0
From:   Ignat Insarov <kindaro@gmail.com>
Date:   Mon, 1 Aug 2022 17:03:58 +0300
Message-ID: <CAB-2Q0_WmRue1gtaJGDGFoPwKdyyHf7dpuLoyZMDCXouxyP+BA@mail.gmail.com>
Subject: Reveal by history that several commits are independent from each other?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

# Reveal by history that several commits are independent from each other?

Suppose I am working on a feature `Search` for which I need to add some
configuration and some types first.=E2=80=82So, I have three patches:

1. Add some configuration.=E2=80=82To be more descriptive, I have to add so=
me fields to
   the structure that holds the configuration of my program, like say what =
URL
   the search service is found at, and a way to parse these fields from the
   configuration files.

2. Add some types.=E2=80=82To be more descriptive, I have to add a structur=
e with fields
   like _=C2=ABsearch string=C2=BB_, _=C2=ABcase sensitivity=C2=BB_ and so =
on, and a way to convert
   this structure to JSON so that it can be sent to the search service.

3. Add the logic that looks into the configuration structure, sends a searc=
h
   request to the appropriate search service and returns the results.

See that there is a partial but not total order of dependency on these patc=
hes:
_{3 > 2; 3 > 1}_.=E2=80=82I want to wire this information into the reposito=
ry.

One way to go about it is as follows: make a branch with patch 1, another b=
ranch
with patch 2, merge 1 into 2, then add patch 3 on top.=E2=80=82This would c=
reate the
desired lozenge structure for me, showing to everyone that I believe patche=
s 1
and 2 to be independent prerequisites for patch 3.

Is this a reasonable practice?=E2=80=82Is there any prior art?=E2=80=82What=
 are the troubles to
look forward to?

There are some other version control systems, say `darcs` and `pijul`, that=
 work
with a partial order of patches, but I do not have any experience working w=
ith
them.

One problem I foresee is that `git` will mess up my carefully crafted branc=
hing
structure when I try to rebase the patches 1, 2 and 3 together.
