Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF2AC1F453
	for <e@80x24.org>; Sat, 16 Feb 2019 02:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391712AbfBPCpy (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 21:45:54 -0500
Received: from mail-it1-f173.google.com ([209.85.166.173]:36498 "EHLO
        mail-it1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730404AbfBPCpx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 21:45:53 -0500
Received: by mail-it1-f173.google.com with SMTP id h6so26972309itl.1
        for <git@vger.kernel.org>; Fri, 15 Feb 2019 18:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=/zdY2VRqkDH+EM+VBGoqyu1/com18UqjYOnEYWX5BNs=;
        b=X3Beuty/M/ZBJZcuU1FvOfY8SEBX3C55zXKEahQkkHTB052v9eLQH4B069m9kQSTYN
         PR/weeFFuRs+xNDI1JDhIwlaPQ2nJ+L0y1OpYGuJBanSHgMWgqv12K7alJF/sYVQqBvl
         5FkxSA7VznhYTLQctr3+PeqmyC3YC3QgDdAyrsSfYhjCXcB2dFCAVuyOaaVjT+f4lLVg
         GKci92IQfOHzUlhiRR8wKX8PrQUoX8l6hNjD+Hp9dYr947tBPcbFkI7CCl+Y2ubM0KIa
         dmALkcsdjt9EAa1whVg8BV5QVeIxpa8M2Ubub9zCL18+yI0RVVDTsiRxJ5cOrtAOSFWI
         p9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=/zdY2VRqkDH+EM+VBGoqyu1/com18UqjYOnEYWX5BNs=;
        b=Kdp9ZBrvmxddXyuLRs1RVoJHWEKA/oY4Xm8vb5gg/VS8GvKzTYMi0bqIAlgT2NAbLA
         dO7x51tTP+Ze3inSU+0IB4VNso1XV3bF7LaDheU8pe0nkm1/MbTlIENTcX/vhNe7bYOb
         mSCsRgpwapVWoFqimv+2SLmglE6HRQ46r4LmEVLyC86qaP4JtUeVmE/K0Zay+RwepkEu
         308x2wksdWe1Ed7KE3OwyMci3eEpWj+J+hAfMtGqHF2Zuatc5VMmCjZ/7oWCMhfZyfTN
         8DgpWE50V3+CN80fP5NHf1FMYv5Qgcmuc0u/p1EVqYYKonwhKGDNPdIr9Hyg4QXrnpS+
         Ljow==
X-Gm-Message-State: AHQUAuZIwTWeZSSBdrcdNM1t6ISatVsA/y/rtTscUn3hafKA0JQlYCrj
        2n83IaoP9mHYw9gRGdXkJSMHemIxVX8FcHwuwhknfDI537go0A==
X-Google-Smtp-Source: AHgI3Ib+ILO3ZaG6dLEDECWV2uSIdpojvc5Tiy8nI/D7w6/m9hk9p/a9fcoUNtEsBiODvsejbHHMI5H/6psD5fW5k+Y=
X-Received: by 2002:a24:2711:: with SMTP id g17mr6004133ita.72.1550285152656;
 Fri, 15 Feb 2019 18:45:52 -0800 (PST)
MIME-Version: 1.0
From:   Bryan Turner <bturner@atlassian.com>
Date:   Fri, 15 Feb 2019 18:45:42 -0800
Message-ID: <CAGyf7-FC1q1f4F36_hS53sdP3wCxd7fTgbegSj+tPS4idvF+Hg@mail.gmail.com>
Subject: 2.21: Change in ref advertisement handling?
To:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In Bitbucket Server's Git test suite, we have some lazy tests that use
a stub HTTP server with mocked payloads to feed a Git client, to test
its behavior.

For some of those tests, we have the server configured to send a
response body like this for a ref advertisement:
76d28b849be7fb3301e4bd14fb28328947b4f5a1<tab>HEAD<newline>
76d28b849be7fb3301e4bd14fb28328947b4f5a1<tab>refs/heads/master<newline>

There are headers we set, like "Content-Type:
application/x-git-upload-pack-advertisement", but that's the response.
It's not packeted or anything.

If I use (for example) Git 2.17.1 and run "git ls-remote <url>" with
that response, Git happily displays essentially identical output, HEAD
and master at 76d28b849be7fb3301e4bd14fb28328947b4f5a1.

If I run that "git ls-remote" with 2.21.0-rc1, Git displays "fatal:
the remote end hung up unexpectedly" and dies.

If I change the mocked response to:
001e# service=git-upload-pack<newline>
0000<no newline; wrapping just for display>
003276d28b849be7fb3301e4bd14fb28328947b4f5a1<sp>HEAD<newline>
003f76d28b849be7fb3301e4bd14fb28328947b4f5a1<sp>refs/heads/master<newline>
0000

This works in both 2.17.1 and 2.21.0-rc1. (I was a little surprised
Git didn't care about the lack of a NUL byte after "HEAD" with the
capabilities after it, before the newline, but even 2.21 doesn't seem
to mind.)

First let me say, I had no idea these tests of ours existed, and I'm
surprised that they worked on Git 2.20 and older, given that the
response isn't in proper pkt-line format.

I'm not looking for anything to change here, let me hasten to add; I'm
just interested in some clarification. Why did our invalid ref
advertisement response work in older Git versions? Why has it stopped
working in 2.21?

Best regards,
Bryan Turner
