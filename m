Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8EFC48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 03:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77AD161351
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 03:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhFRDtj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 23:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbhFRDte (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 23:49:34 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D6AC061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 20:47:24 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso8321502otl.13
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 20:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=0br4OPg4yrc1lsf6IH/tz1pPvwvVT0RsuG/LJUN/Sjo=;
        b=a25uLqyITckQDcDLtKGQwRr9si/BU1PhnPNXwKHB4+Rz1d9y/p4+KGxBTELU29KWZk
         +J3KHmTID9a9N3542eXHNlbqWStgWQwjdJ21hkiHSq7PIIeY3Cs/cYnfuH4csOvrsZZK
         HnxOBhYZfDMMmgGwTS4n7b2yfCSjXX1ubmCdIMJd4C7tQ9Nt8X1ippkBHU77of/7D+zu
         YOuPZ2HgH4RpUyxga6OSObq8lOiOOPeCBSJt1mN0aEcP5++2OBOvH2m9e4ZOANt3Ydf8
         pe5Cf77xGbcbd3vF0w3XJ9LsfqFRGTiE0bguSHpRdRnQ0uf2PJuVYkKOgECpi51vbk8J
         ML6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=0br4OPg4yrc1lsf6IH/tz1pPvwvVT0RsuG/LJUN/Sjo=;
        b=H4xuNtjDTRQgtwtF8k/sHErDhuqxIdq3Ka7RzEs+CJcJM5YniZU144v3pirbit+uCx
         3tlAnsTp1EaxvazxaXhE7vrKIuD3+bn7S2W7Oh4I5xctu3Uy6NsU4GJ2IRvvNQJwtNP7
         Z/H1Ipay/wnAcFuQuO1b5P0mwO9uqMWiXCDx4N+aFTr1bMgZJ8enDQI+kh/It9Rdmdmd
         3G+aJyeqS5g4YfxZ6ll7Afzu8K3x4cgg1PLKrQG18XlU0h3K4wjEW3j3l7nAd2EocTz6
         rNuHkt+oLFANk4nj4FR1QPrbDFulpB+qAqpxy8RODbDLbQbMglX4Nk03zfsqPBjiKXi0
         0r2g==
X-Gm-Message-State: AOAM533AOSk2U4JryIH3dnV2VPlpPgd/5MAGr6z/ovktI9moZkTTfNh8
        akMFBv6nx4HtU3LOlAOoiZOtySMsitTPpw==
X-Google-Smtp-Source: ABdhPJxlXZSctLNlfzb922DC/Blm1C/OeFQ4MbMs8qZ64QbrSDY2TpwB3N2sYVz3ynLgbwx7VP4KeQ==
X-Received: by 2002:a9d:491:: with SMTP id 17mr7551798otm.184.1623988043711;
        Thu, 17 Jun 2021 20:47:23 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id p17sm1736396otp.73.2021.06.17.20.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 20:47:23 -0700 (PDT)
Date:   Thu, 17 Jun 2021 22:47:21 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Message-ID: <60cc1749b1c4d_5d12520825@natae.notmuch>
Subject: Only 27% of reviewed-by tags are explicit, and much more
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

This is what SubmittingPatches says about the Reviewed-by commit
message trailers:

 `Reviewed-by:`, unlike the other tags, can only be offered by the
  reviewer and means that she is completely satisfied that the patch
  is ready for application.  It is usually offered only after a
  detailed review.

However, a quick look at the recently given Reviewed-by trailers shows
that isn't always the case: sometimes the patch submitter adds the
trailer [1], and sometimes it's the maintainer himself [2].

Any generous reading of the relevant mails would conclude that the label
was meant to be given, albeit it was not expressly so and thus strictly
speaking not following the guidelines to a T:

  1. 3127ff90ea (packfile-uri.txt: fix blobPackfileUri description)

  This looks good - it's exactly the same as the change I approved
  previously [3]

  2. 4e689d8171 (dir: update stale description of treat_directory())

  Looks good to me [4]

  3. 5f03e5126d (refs: cleanup directories when deleting packed ref)

  this v2 patch looks good to me [5]

These are just the last three, but a cursory look at others show a
similar pattern.

This prompted me to write a script [6] to programmatically find statistic=
s
about these trailers. Obviously it isn't perfect (as all software); it
tries to avoid human fuzziness (like people pasting other patches with
scissors [-- >8 --], or just straight put pasting the patch [^From: ]), b=
ut
even so there are instances I manually had to skip [7].

Over the past 10 years my script found 1604 commits with a Reviewed-by
label, of those only 434 were expressly given.

That's merely a 27%.

This means what's written in the guidelines is not a widespread
practice.


Not content with this finding I went further and extracted statistics
specific about every reviewer.

Doing so I found this interesting piece of information:

  Jonathan Nieder: 67% (211/314)
  Jeff King: 6% (15/248)

Jonathan Nieder is by far the person with most reviews, followed by Jeff
King, but they could not be more different. While Jonathan often offers
his Reviewed-by tag explicitly, Jeff rarely does so. That's why Jonathan
has 211 explicit Reviewed-bys, while Jeff only 15.

You can see the histogram of frequency of attributed Reviewed-by
trailers vs. percentage of explicit trailers here [8]. With the
exception of Jonathan Nieder, almost *everyone* gets their Reviewed-by
trailers in an implicit way.

Some heavyweights in the 20%-30% bracket are Stefan Beller (46/190),
Elijah Newren (12/47), Jonathan Tan (7/32), =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason
(2/9). Other than that most reviewers are below 10% (40/673).


So where did this guideline come from?

Looking back at history, the patch comes from Ramkumar Ramachandra, who
while trying to improve something completely unrelated, stumbled upon
the following advice:

 - Again from Documentation/SubmittingPatches, I learned a while ago
   that Reviewed-by, unlike Acked-by, can only be offered by the
   reviewer and means that she is satisfied that the patch is ready
   for application.

Do you care to guess who gave that advice? Our top explicit
reviewed-byer: Jonathan Nieder [10]. And this comes straight up from the
Linux project; it's not a Git thing.

So, is it fair to say the explicit Reviewed-by trailer rule in
Documentation/SubmittingPatches is accurate? I would say unequivocally
*no*. Only one person follows it religiously, everyone else seems to be
relying on either the reviewer or the maintainer to apply their best
judgement.

And that includes our second most prolific reviewer: Jeff King, who over
the past 10 years has only given his explicit Reviewed-by 15 times (6%
of the time).

I think it's fair to say our Documentation/SubmittingPatches needs to be
updated.

Here are the top 20 reviewers over the past 10 years with their
corresponding explicit over total Reviewed-by count:

  1. Jonathan Nieder: 67% (211/314)
  2. Jeff King: 6% (15/248)
  3. Stefan Beller: 24% (46/190)
  4. Matthieu Moy: 9% (13/131)
  5. Eric Sunshine: 14% (17/116)
  6. Derrick Stolee: 6% (7/102)
  7. Taylor Blau: 32% (27/83)
  8. Michael Haggerty: 45% (25/55)
  9. Elijah Newren: 25% (12/47)
  10. Johannes Schindelin: 5% (2/35)
  11. Jonathan Tan: 21% (7/32)
  12. Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy: 20% (6/30)
  13. Ronnie Sahlberg: 31% (5/16)
  14. SZEDER G=C3=A1bor: 0% (0/14)
  15. Luke Diamand: 0% (0/13)
  16. Felipe Contreras: 8% (1/12)
  17. Johannes Sixt: 40% (4/10)
  18. =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason: 22% (2/9)
  19. Stefano Lattarini: 37% (3/8)
  20. Torsten B=C3=B6gershausen: 0% (0/7)

Only *two* reviewers are above 40%.

If that's not clear enough, I don't know what is.

Cheers.

[1] https://lore.kernel.org/git/1d825dfdc70b8c658c4b6317310706bb6386f468.=
1620432501.git.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/20210511064554.59924-1-dyroneteng@gmail.c=
om/
[3] https://lore.kernel.org/git/20210524154354.268200-1-jonathantanmy@goo=
gle.com/
[4] https://lore.kernel.org/git/CABPp-BFudyBP8c_ROmxDEeuu5AfdoyVW8hNPYqVd=
FPFNofJnCQ@mail.gmail.com/
[5] https://lore.kernel.org/git/YJnfV7op4yhyLqdg@coredump.intra.peff.net/=

[6] https://gist.github.com/felipec/f1289a48e31195ee1f36c28ca6e482db
[7] https://lore.kernel.org/git/xmqqsgg7u3js.fsf@gitster.c.googlers.com/
[8] https://i.imgur.com/NuvePpZ.png
[9] https://lore.kernel.org/git/1285994263-31154-1-git-send-email-artagno=
n@gmail.com/
[10] https://lore.kernel.org/git/20101001053721.GB6184@burratino/

-- =

Felipe Contreras=
