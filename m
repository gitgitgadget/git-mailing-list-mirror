Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBFFC433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F0E820768
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pv0ilbkT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgHNUWS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 16:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbgHNUWP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 16:22:15 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAAEC061385
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 13:22:15 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id m20so7751898eds.2
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 13:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ruzzq4D+pxYW26hhXBl72kjHu6cYnxDnOWeGML/dRAM=;
        b=Pv0ilbkTjf7xhlxgicaSRLmY6rlTFyJH+v+H8xMXi7nH9U9GM+8U135pi/pzqFTwei
         4z8dnE4nI4MwZM7IzE+zRA7PjtaP59Fg8+z3Q6KRp6jAIgA6hCy1AvmSt6HKnno79NDR
         QRYRYtGn4eRONFca1XmlsE4dx9FR912e1OhaaGp4M5BEOMepvAl89sOwI9TICQ8oaI31
         xiznmS02xiYS28/cM81qnF4c3Y0jIRYHm9di6QS2gvEm6iK18T+3/V9fYDHKVpJCrPbs
         c9t0UC81zGyo8DBr5iKIFVPDjEHY7jcu0KOJOjDxjmMG3WOEdkECKjMG2Z+ZwPsCnaSq
         6J9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ruzzq4D+pxYW26hhXBl72kjHu6cYnxDnOWeGML/dRAM=;
        b=BHcoagnCzE8C78VZ5vJYBNUwaBUfMzITxQ0VYwm+N4Oh+/vX3HrKprvpwFjhEiiKvm
         odOESBz1RT/Aq+jevXV0dXfBsSbgpuBzZWGiEPXHGv8uRyFJNc0llARREIZ9iwWNblKk
         Fcw5jRxs3l9t6ymGjIqE9Kfq0rkSLj0lzfVVsHeAagvxI18n/eRZdk9MJLUx+euyr7oR
         7Ybsc6sqOx6ZDrXCJMBgY2D0H7pqZ9fgwSrpKlq87bZqjpx7zRTawDSyN9YtMp5ppBIR
         BsEGzUxh8tGlhwl8UxVusDApBdSkNK1Y0PReVKoUBgkapxTs8YjFGsT/JfQ/8GEaNFeH
         +kow==
X-Gm-Message-State: AOAM530j2q+3O7qsbdG1LdwmGHIFI8YuLJ23Y0GZXWS+tH9tdvkpdEjc
        rV/lIUrEK4ruOZfWl9JZ9pX3b7RhJmoEO+0jz9B754zMSsvbyM8N
X-Google-Smtp-Source: ABdhPJwRMFQxhzWfFHBLYxlwplk+FGL+Lu6m71J1AMR9FP4YfBIYGb7f9Jmkr2D4yyakZ+3a5uyxqctHkTbXnV/dzHc=
X-Received: by 2002:aa7:c88f:: with SMTP id p15mr4065801eds.33.1597436533350;
 Fri, 14 Aug 2020 13:22:13 -0700 (PDT)
MIME-Version: 1.0
From:   Carmen Andoh <candoh@google.com>
Date:   Fri, 14 Aug 2020 16:22:02 -0400
Message-ID: <CA+Twho+nyERK1Ljdy6MnXA=iK6SiU85v4yLQc+fRmW83JVa+hQ@mail.gmail.com>
Subject: Git Inclusion Contributor Summit Registration
To:     git@vger.kernel.org, git-inclusion@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Registration is now open for the Git contributor summit dedicated to
inclusion. The summit will take place online over two half days on
Monday, September 14th, 16:00-19:30 UTC (9am-12:30pm PDT) and Tuesday,
September 15th, 17:00-21:00 UTC (10am-2pm PDT).

This is a free event.  We encourage anyone interested to register by
Tuesday, September 7th.  Registration does not guarantee attendance.
If you might want to lead a break-out discussion and attend a
moderator training session in advance, please respond by September
1st.

The contributor summit is an opportunity for members of the Git
community to gather, discuss issues of inclusion, and get face time
with some of the Git development team and other contributors.

Please fill out the registration form [1] and organizers will be in
touch with more information in the coming weeks. If you have any
questions, contact git-inclusion@googlegroups.com.


[1] https://forms.gle/ryhQRv6yXiy2Y9MK6

Thanks,
Carmen Andoh
