Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF02C433B4
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 20:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48B1D61139
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 20:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbhDXUdv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Apr 2021 16:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbhDXUdu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Apr 2021 16:33:50 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECE4C061574
        for <git@vger.kernel.org>; Sat, 24 Apr 2021 13:33:12 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id j3so25495210qvs.1
        for <git@vger.kernel.org>; Sat, 24 Apr 2021 13:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=npD7MiPC80uv308i1NFFktBKloXp3IIsYPMwOLRAMZI=;
        b=Zho6mziiszIbt+L7hyGXylp2dkjfEAsOHo7IyYvDDHkaS8MPTZ+KBuyS8J6LxYg0Mr
         fJCJQYRknx8XlGnAc11jKOoUmpgzzxyPa9UZOgQMRV4+wURcRXJh1cHflLV4wrIegGFk
         VPBCThUP4cHoYFAZH5FKokNIvB2CDAYyFfcIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=npD7MiPC80uv308i1NFFktBKloXp3IIsYPMwOLRAMZI=;
        b=G0ueDCCWj6Vbo88V+qBU2ydii9Fug2ch7zgN/iUfsyL2oy/h/tvcDdmA208oxdVIg5
         d/9Lt0rbSTBtS7LWKtcZMZaVqrTYEvbAPx4MkNnX7m4ddoc7opvD4bfnlGAxrOaVORcb
         N4WMLGz+EREujwxIINvOuaCY5+FN4Eiw+pD9dlb34c0vxdBC5MFB8Lj0VEdiPq25YSu0
         cpRKiw2TA16pTLeOW4Np1Ki/GYVQs3wP7BMfZR7Tcp0TFZco6jPezzOzypLOoKd12b+h
         NlsFTsjApQLWToH0VCKFev43Y1gNPdF+enQTIBLfoWA0a6mmyRC7aN3VKVlbC9ft6JWf
         2+MQ==
X-Gm-Message-State: AOAM531/Jnl2Gx6a25L2t6vOlqkJ11OyazIm5UQ8K7/Iz0/5yuPMLjnz
        33s9KUB4ALTZdL76xPQF0ve0/pqUQximhP82YwXWLyBF4wY=
X-Google-Smtp-Source: ABdhPJx95xZWZE2+UuDQLZ4P9dGW1EHgoK1gUyX8XdxcsUZNiQr4Yifyvk3dFlknc/kji0dftS14m7sag8Hls8pHeIA=
X-Received: by 2002:ad4:4ee8:: with SMTP id dv8mr10974425qvb.46.1619296390723;
 Sat, 24 Apr 2021 13:33:10 -0700 (PDT)
MIME-Version: 1.0
From:   Adam Dinwoodie <adam@dinwoodie.org>
Date:   Sat, 24 Apr 2021 21:32:35 +0100
Message-ID: <CA+kUOa=juEdBMVr_gyTKjz7PkPt2DZHkXQyzcQmAWCsEHC_ssw@mail.gmail.com>
Subject: Security vulnerability in Git for Cygwin
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

I don't typically announce Cygwin releases of Git on this mailing
list, but this one's for a security vulnerability, and in particular
I'd like to catch the (hopefully very small number of) people who use
Git on Cygwin compiling it themselves.

I've just uploaded version 2.31.1-2 of Git to the Cygwin distribution
server, and it will be being distributed to the Cygwin mirrors over
the next few hours.

This update addresses CVE-2021-29468, which would cause Git to
overwrite arbitrary files with attacker-controlled contents when
checking out content from a malicious repository, and in particular
would allow an attacker to overwrite Git hooks to execute arbitrary
code.

Having discussed with the Git security list, I believe there are very
few people compiling Git on Cygwin themselves, and therefore agreed to
release the patched Cygwin build without yet having a patch in the
main Git source code. However if you do use a version of Git on Cygwin
that isn't from the official Cygwin distribution servers, I'd strongly
recommend either not checking out or cloning from any untrusted
repositories until you've applied at least the functional part of the
patch I'll be submitting shortly.

I'd like to thank RyotaK (https://github.com/Ry0taK /
https://twitter.com/ryotkak) for finding and responsibly disclosing
this vulnerability, and Johannes Schindelin for helping manage the
response.

Kind regards,

Adam
