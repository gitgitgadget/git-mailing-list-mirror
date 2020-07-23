Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753CCC433E4
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 19:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45CE12067D
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 19:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uzo1jKnG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgGWTal (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 15:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgGWTak (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 15:30:40 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8ACC0619DC
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 12:30:40 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id o18so7580891eje.7
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 12:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Bh6FnQhZ5YqJzHjWTc/SKWbclvqoZIqtxQBq2ke8zxw=;
        b=Uzo1jKnGvVLYIStDzylKXosRv25Xg3MhrUT8bTPGptGsguTtDEVvDIyD7eeQsQbXC3
         lo3Gc2DzEwzSnyvwpGePzGWWO6wjZQOIVvIJYUH5mxdDw9QpqBIW9XgM9QHMjmm+mEP7
         DwqP7blK0SlOflNVFnMIU1jRcvChb7zEuPJno9fU2ENePlMl9j0eRqOlOrK0h5FbRc4B
         RjclANs6vniUnXxqKWlgOkrqbmcJknLOS7uvW+bauUg3JG8dXEkbauKctDUqElSIsF29
         0fLbYKrGZkfVERF8OfV7tDZmCar8FAUFavfW78kXPZAiH4251NxnUiP3JPhd6fzZR8BE
         3Yog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Bh6FnQhZ5YqJzHjWTc/SKWbclvqoZIqtxQBq2ke8zxw=;
        b=r9AuuN0JzPnQs6mYaKM4ubGTxcGYD27U3Z5IGA0BDEa1jhQPEhanCLNE/JSI7dAOWE
         wmkV1yVYBiqv/pX4c9GVXqqCbkb9yC89n6azPtu5BmZJt9NOkQAS1dLCxEWr4aD2qPQV
         q2R1dcFp3zOCY/hPj6aWe/qxODv12Dja6DPY03xseyqM2MYGMV5msRVMeM0ICdKXnCex
         0RG2oU+yayCcABzM3qGBY26vrc6PZDEF3Kobeze0BQEdVsx7umU0hrbxL4syMsyjsarB
         MFPFych6E/noxEDcphGbhQ/KbAl5kzdf4dYpfDI9DZN1tBnj6GbpPPO444HeSoP7A7vv
         2uGg==
X-Gm-Message-State: AOAM531pvK9b0jiAKd7IYWHrbnoJQXJ3dawkAt7+SUe1plagzanhPnJ1
        eHaSentY5A9WhzCp2MOBbGIHMn8Q4qadwzvNKwERXhfO3cOS4g==
X-Google-Smtp-Source: ABdhPJyjjJheYUiG2Z+OV31tYNsHux/Gjf0zuVwgpXXzIJ0uFchIYxkOFyXitrihYX7JZDXF3Hp+VzRb4+s/MfT/5Yo=
X-Received: by 2002:a17:906:33ca:: with SMTP id w10mr6093168eja.171.1595532638625;
 Thu, 23 Jul 2020 12:30:38 -0700 (PDT)
MIME-Version: 1.0
From:   Carmen Andoh <candoh@google.com>
Date:   Thu, 23 Jul 2020 15:30:27 -0400
Message-ID: <CA+TwhoKBYwUKmtQTyiocPWJD=KeZQryS+6Q8JKxKgLEy0qJwAw@mail.gmail.com>
Subject: Git Inclusion Summit
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Git community,

There's been some conversation about holding a virtual contributor
summit focused on inclusion [1]. I've volunteered to work with
Jonathan Nieder=E2=80=99s team on organizing this event.

The purpose of this inclusion summit is to engage core Git
contributors as active participants in diversity and inclusion
initiatives for the Git project. As mentioned [2] "to align and
coordinate, to set out goals that we want to agree on." This is part
of a broader goal to make the Git version control system better
support inclusive open source projects. The summit will give
contributors the opportunity to learn about and share perspectives on
inclusive culture, product inclusion, and career development.

This can be run unconference style like previous contributor summits:
we'll use a spreadsheet to choose and vote on topics. This event will
be a success if we walk away with specific recommendations on where
and how Git will make changes to improve the experiences of
underrepresented users in the Git project, and how to make the Git
project better represent the needs of current and potential users.

It was mentioned in [1] that we should have conversations about equity
and inclusion with more diverse voices present.  But we also don=E2=80=99t
want to put a burden on individuals coming to educate us about things
that we should be researching for ourselves. To that end, we are
meeting with Diversity, Equity, Inclusion (DEI) experts for guidance
and will have recommendations to incorporate into the summit. Prior to
the summit, we will send out some resources to look through ahead of
time.

Who all are invited?

Git core contributors on https://lore.kernel.org/git/., anyone
interested in teaching OSS projects about DEI.

If your network includes any groups or individuals who focus on
educating others about DEI, you're welcome to invite them or contact
summit organizers to learn more.  We prefer groups and individuals who
are in the business of educating on inclusion, or if they are
volunteers, already explicitly expressed their interest in
volunteering rather than being asked, as we want to be very mindful of
free emotional labor. A bonus for knowledge of inclusion in open
source.  We can widen our understanding by asking non-Git contributors
to come share their perspectives for some or all of the summit.

When?
Anytime between mid August - mid September.  To get consensus on
preferred dates [3], including summit duration and times, please vote
at the whenisgood link below by Thursday, July 30th. Please specify in
comments if you prefer a .5 day, 1 day, 1.5 days or other for the
event duration.

Next Steps:
Once a reasonable consensus has been reached, we=E2=80=99ll set the date an=
d
time, ask for RSVPs via email, and send a planning spreadsheet to
start proposing topics and crowdsourcing the agenda.

I have questions, who should I contact?

For questions or concerns, please reach out to git-inclusion@googlegroups.c=
om

Interested in helping to plan this event?
Email git-inclusion@googlegroups.com to join


[1] https://lore.kernel.org/git/20200610222719.GE148632@google.com
[2]https://lore.kernel.org/git/nycvar.QRO.7.76.6.2006121525140.56@tvgsbejva=
qbjf.bet/
[3] http://whenisgood.net/9z2diyy

Thanks,
Carmen Andoh
Open Source Programs Office, Google
