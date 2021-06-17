Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1D5C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 18:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33012613D5
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 18:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbhFQSPg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 14:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbhFQSPe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 14:15:34 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9466C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 11:13:25 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id x22-20020a4a62160000b0290245cf6b7feeso1798873ooc.13
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 11:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=ICImkKHDaNwVIedLKaJ3Rl6FzVRhly0UUOaefZKvktk=;
        b=W2TkxqPNV5cr6E+cANdj/SNiRbJC1BZB5Uor+zT4WMuREUTCdbhcMHIBOv+dh1HD4a
         4x+rF73dG4kXnWAnkTmmG1hU3udA4aN1K3f/gYSuDJT5joHUGOhYwmJEBMmhZ6ZtGEws
         mPTmCwbmNyOzIMJBAGUjYbgcUZpIElgLqvcyws//doQLTH+OivoxXrhEpzI8hx/aQJ4q
         /5abRzpSTJkQ0ETbzRgSdhgA5UYKgauxUVp64vEj86r6YSIbg7DI7u2eTGNCIV9L5uy5
         CmAW5xYEHtJLpJu+R2dt8JnKYVFVdJbJCzxA0V9pTN+sXzrghsdiZEQ9iUfh83arg6oj
         6yFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=ICImkKHDaNwVIedLKaJ3Rl6FzVRhly0UUOaefZKvktk=;
        b=GaA+YoKHacZDeBiYTfgTMdYO8aT4hip4TxvUIbWcpItskwO1u3wXEKzkpkdLBVeJ4k
         fVKgQ+UwU6Vg3xUrcL+y++OWPGXLObkudPR8853/5l0FFeF8BRgyFMT5g1THDo5UskVE
         p66j6bjvYF4nnkmKRhHbC6S/1NEezKU7ys4mNGiX4zbDr3Ts8QasGG4yUC3cAm3YBG+p
         AQEq/EMhWqfUU5caOYN9zYUUQxANSmiCSsxGKj9FkgqnWlZsjcsNyf7AIDeeckhvwjAB
         zsFtROdqhpjGX+9mN2782ylYb9oeto6RAc7bM70NHWwegSHwcGfbrAS0cQJbe2WfbM6I
         QfGg==
X-Gm-Message-State: AOAM532ZkoNw9foESZeXudspRytwTni2If+EOL8Mx3YFfcVp33IgfBSJ
        GVyriyDwkYLT9TvA2QmyzrbbEiBL0p1jxA==
X-Google-Smtp-Source: ABdhPJxbjv3wyW5MdtwolIf+iCp80Y+k9oNkKTLZ+LmqHRF39NikNfM4bZGbCAn/X0EDkw8iiHbC1w==
X-Received: by 2002:a4a:91cb:: with SMTP id e11mr5569772ooh.53.1623953604961;
        Thu, 17 Jun 2021 11:13:24 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id f12sm1407371otc.79.2021.06.17.11.13.24
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 11:13:24 -0700 (PDT)
Date:   Thu, 17 Jun 2021 13:13:17 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Message-ID: <60cb90bd9e027_1502820859@natae.notmuch>
Subject: The top 1% of reviewers
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Last month I sent the top 1% of commit trailers [1], and people did seem
to find the results useful. Now I'm doing the same for reviewers.

The reviewed-by trailer is the second most used, and according to the
documentation must be expressly given.

The top reviewer of all time is Jonathan Nieder with 366 reviews (21% of
all the reviews), but Taylor Blau is the top reviewer of the last year
with 65 reviews (25% of the reviews of the past year).

But from there the next 10% of reviewers have much less.

To be in the top 10% of all time you need more than 33 reviews, but to
be in the top 10% of last year you need 46.

To be in the top 25% all you need is more than 7 reviews, and of last
year only 6.

The median reviewer has only 2 reviews

Once again the distribution follows a power law distribution where a few
people do the vast majority of reviews, and most do only very few.

Also, it's worth noting that not everyone that does a review ends up
with a reviewed-by trailer, so the actual reviewers are likely more.

If anyone is interested in the script let me know, but it's pretty much
the same as the one for 1% of commit trailers.

Cheers.

[1] https://lore.kernel.org/git/60ad75ac7ffca_2ae08208b@natae.notmuch/

All time
=3D=3D=3D=3D=3D=3D=3D=3D

Top 1%
------
  1. Jonathan Nieder (366)

Total wealth: 21%

Top 10%
-------
  2. Jeff King (265)
  3. Stefan Beller (190)
  4. Matthieu Moy (135)
  5. Eric Sunshine (116)
  6. Derrick Stolee (102)
  7. Taylor Blau (83)
  8. Michael Haggerty (55)
  9. Elijah Newren (47)
 10. Johannes Schindelin (35)

Total wealth: 80%

Top 25%
-------
 11. Jonathan Tan (32)
 12. Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (21)
 13. Ronnie Sahlberg (16)
 14. SZEDER G=C3=A1bor (14)
 15. Luke Diamand (13)
 16. Felipe Contreras (12)
 17. =E4=BE=9D=E4=BA=91 (12)
 18. Ralf Thielow (11)
 19. Johannes Sixt (10)
 20. =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (9)
 21. Duy Nguyen (9)
 22. Stefano Lattarini (8)

Total wealth: 90%

One year ago
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Top 1%
------
  1. Taylor Blau (65)

Total wealth: 25%

Top 10%
-------
  2. Eric Sunshine (59)
  3. Derrick Stolee (49)

Total wealth: 66%

Top 25%
-------
  4. Elijah Newren (34)
  5. Jeff King (13)
  6. Johannes Schindelin (8)

Total wealth: 87%

-- =

Felipe Contreras=
