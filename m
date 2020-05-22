Return-Path: <SRS0=kZBr=7E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC54BC433DF
	for <git@archiver.kernel.org>; Fri, 22 May 2020 03:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A297F20812
	for <git@archiver.kernel.org>; Fri, 22 May 2020 03:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/qbsrf+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgEVD3T (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 23:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbgEVD3T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 23:29:19 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF46FC061A0E
        for <git@vger.kernel.org>; Thu, 21 May 2020 20:29:17 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id z9so3307577oid.2
        for <git@vger.kernel.org>; Thu, 21 May 2020 20:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=VPi3Hne6usxCh/b0tfkdTr7evoRbit2Yd/5m3pnqnjE=;
        b=Y/qbsrf+bKkhojlCg5DdL1zn8oTHOHvK+E/GEfcyLQ8RxCxtBlsmz7YZP5a46E83+m
         U7xztEj+a1dTHSqXYEx3vn0ZN3kSmOf9cnYg+fSshmjvmXav15VakC4isSSiR7r+DUVF
         JU0odxp0Fc4TYuNM1wE10+iQ9Qkhbpcp8I+z+kTmINNXy71VCo4+cKBHNI2G7edCDt2A
         kvEHU/qr0OASpUWFrTkQMfvfd+JRlwVl7WF4t68aacP3h11lY47dtOJuU9Xj7VAsG0oR
         57foL5hZVSv4MP5q2RuRjPjPReBQVQbvX9jhwAV3yuatggHhAMFDay7dP7h3jFtFy+pB
         UNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=VPi3Hne6usxCh/b0tfkdTr7evoRbit2Yd/5m3pnqnjE=;
        b=C+8xmOSx2bWGOSsKX/33qmdaM4tQeXVhWRxlWCC4/bZlp1yA7JW0yUuPYaI6B83viz
         ag6BAa1kVbDIbnagQsvhMuCof9J6/T1yuvcG8cQTCCDNT7uRzDtbOyBy2k7NVslbJgse
         AE3RCaW+5FpAie84K7jdymiNMTosJCUy9w0i63YK55mN9hb0O2NWrd12mvRFi6VxPkc0
         6Py8elYwH0sn6LwJ+J2SmhYjWiInZoTbK6uQoZixfbL6AD8ywFZEZSTufC4hvR56j8E/
         b/gMgKQW7A1vH86c73OvPwnW1S97JeX8MVvJ7EosAA66Qq6yheaNNb48QsLNrFS91xWE
         YFvQ==
X-Gm-Message-State: AOAM530wlRwyweFwqsFNWRLBkV0jQo9um+w3AYJPFEIs2JQ5qVHVRq+x
        2LNiOW/ZMxmC5G5BNFt2/+PFEmILoBtw1YEAmQEANB5fRzE=
X-Google-Smtp-Source: ABdhPJwcCu0uqyH5a5nRNXWkzBzeSVooO+ea2LE05TxGlw4mUj2RIyuxrEtoswawhoSM1OJMywZd6udYxR6c46yQX0A=
X-Received: by 2002:aca:2b04:: with SMTP id i4mr1271882oik.39.1590118156780;
 Thu, 21 May 2020 20:29:16 -0700 (PDT)
MIME-Version: 1.0
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 21 May 2020 20:29:05 -0700
Message-ID: <CABPp-BGHU_XA0K1YnOmKPzmS95e1+saXaUDrMFJqX7tesXC2xA@mail.gmail.com>
Subject: New git-filter-repo resource: Cheat Sheets
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

git-filter-repo now has two cheat sheets:
    filter-branch => filter-repo
    bfg repo cleaner => filter-repo

Each lists all the commands from the manual of the command on the
left, and shows the equivalent commands to solve the same problem
using filter-repo.  Links to both cheat sheets can be found at the end
of each tools' section at

https://github.com/newren/git-filter-repo#why-filter-repo-instead-of-other-alternatives


Each cheat sheet is actually half of a bigger guide that also provides
an overview of high level differences between the tools (design
structure, defaults, etc.); just scroll up from each cheat sheet to
see the additional info in the guide.


I hope folks find these useful,
Elijah
