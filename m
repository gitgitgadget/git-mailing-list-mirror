Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C9EC43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 11:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE142073E
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 11:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=smile-fr.20150623.gappssmtp.com header.i=@smile-fr.20150623.gappssmtp.com header.b="xSAW3N9P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgCZLII (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 07:08:08 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:32908 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgCZLII (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 07:08:08 -0400
Received: by mail-ed1-f44.google.com with SMTP id z65so6363925ede.0
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 04:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=LYlxd2tLKweD26THqxwsZLU6SuJy6TlxVst4TefzZtI=;
        b=xSAW3N9PJ5RH2ATIwEbVy8EbsHLeAxNx4m4E31TvhvY7gH5JINqI/u4RGEfnUmlmwf
         xkSlHnNcJsnM2jV919vQlr08oHQv/TbOa/SfdR2KyKjs4o6MJM6xXJxGlYqSnVbGUw5q
         jJg8nhui2GD3k5NO5y6vGregyeoSIAzEhIXaiIdTqRUzwj/Sh33G4ljjhxWytZpESEac
         pLyRaol2SgUo4v1g9D06jvYyzrQO89iiHVkBd9mx10IuF5VPzusvWKGDrHSnBHXhcR74
         1CkN4gaCHLnEZGM1GlKUtDmio18P8o8cm9LZDYAmHKpRflAr2bHL1lNLXB1z1x5EGPl4
         2z0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=LYlxd2tLKweD26THqxwsZLU6SuJy6TlxVst4TefzZtI=;
        b=Vp/WoNSnf2cNTOL+CoGRsxMwNqFQD939ZeOWs7GOUi/+jwICU3UHLg9RO5LyRCq4fs
         YCuW0+chojlvO+J4tlEYvew8B3cXFGncfJit1hdeOYk6hqyHUjiKkWouv0YVmM58cCRx
         1SLAe2JN2+9nX2B2YI7IpAojOv0bcN644MEjPZNRN5ClpXii4VwKhflUtPh4/ZOzsfXh
         a4Le9/P8qEcIJR+yy0UxemfWPFwrZEAgdN3tOo80X6Q1KRTXTVIG3D3AqOqoVztOD2Bh
         t//TggH4LHPwV+tRMsNZf5bJe69C7FkRTJD3VuwzMurq5Y2MXowSlH3+BJaR7u4zEZ0A
         x4UQ==
X-Gm-Message-State: ANhLgQ2xxECIcxxVTvoepHs6Vr4lHVS4MV/dItOJ5wcwKJ3xxS/CBbc/
        OToYORSVEXiYCYyasoDHMlezBQP12t7JcuiSlBXTLVBZbEw=
X-Google-Smtp-Source: ADFU+vsZtdV5CjQjXYmC0fZshnJh414VlOl1FAl4W6Jz1YBek39J03nqbWvW9nyyYtzQ64EX7/GRV2LOiCGZ/0Ria5Y=
X-Received: by 2002:aa7:cf91:: with SMTP id z17mr1395990edx.29.1585220886178;
 Thu, 26 Mar 2020 04:08:06 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?S=C3=A9bastien_BRUCKERT?= <sebastien.bruckert@smile.fr>
Date:   Thu, 26 Mar 2020 12:07:55 +0100
Message-ID: <CABt=S26FB1zkwDCdmXeyVvFYvpvuGSX_y1Fg5N3K=yq0ZMyR7A@mail.gmail.com>
Subject: [RFC] Representation of diff with trailing spaces
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone,

This is my first RFC, I hope it is correct. Do not hesitate to correct me.

# Problem
Trailing spaces are represented only when added in the diff, and not
when removed.


# Abstract
Something that always bothered me with git diff was how trailing
spaces are represented. If I add spaces, then diff, they are
represented in the terminal by a red background. If I then remove
them, they are not represented. That's how I can have a diff with two
exact lines, and I'm looking for the diff in it, but can't find it.
Because it is the non-represented spaces.

# Reproducibility
One picture is worth a thousand words, here is a little snippet of
shell to see this by yourself:
```
mkdir test
cd test

git init

cat << EOF > file
This file contains line at the end before fix.
EOF

git add file
git diff --staged

sed -i 's/[[:blank:]]*$//' file

git add -p
```

# Solution proposed
Show the trailing spaces in a diff when removed.
No performance impact expected,

# Open point
Maybe we could argue on which color for added trailing spaces, and
removed ones, to differentiate them quickly in a big diff. For the
moment, added spaces are red. Maybe they should be green, and removed
should be red. Or the opposite. Or everything in red.


Thank you for taking the time to review my proposal!
