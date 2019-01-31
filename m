Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FF531F453
	for <e@80x24.org>; Thu, 31 Jan 2019 16:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732819AbfAaQss (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 11:48:48 -0500
Received: from mail-it1-f178.google.com ([209.85.166.178]:52407 "EHLO
        mail-it1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728813AbfAaQsr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 11:48:47 -0500
Received: by mail-it1-f178.google.com with SMTP id d11so4641645itf.2
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 08:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=fmtuyPqKq6N3EhEC0QYCgNyxtcASKytwJJCB3Eobg6w=;
        b=Ev0Ie2KeTUAA5srHPIW1CKWvA8vDAWzkepLR+jbu/hkRqrJqM1syU26jPm/6TvHsD6
         +5OS6yAyVejamab1koq8YoUZppLxCVUHHhxEv4nZm5Z2LbeDhq0GcCIX6ncZoT5kJS9a
         WAjuLhmtUYSD+cTKN/OFBogCGtQu+A4rsnD3uDX3hPxQ+9YQBQyG8qu01R4WVv2va4SA
         E0nP6qmW3VLFbVaAF9bQDSbMBfc8uBGnLD/BrIYiGtcny6ZIpSzA5dzZJn9xulcXKz0M
         WgeWmOzSyXtR9/kO78+93LGrxCINt3K8JldilrGjkOvhZ8bR/r/7RuC0c+U/iVbCwoaN
         N+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=fmtuyPqKq6N3EhEC0QYCgNyxtcASKytwJJCB3Eobg6w=;
        b=fyflOO61ExIhB4O0Jd31fKTuG88IDhgu2awjt9DKMoncCkoIq3dur/P91aKBsgKPO1
         OnnP6KLPQ0j/HseyNjaO0jthDOVba1UAiBnnYKVGZkyfzSGNRSOYEAYxNxkqXKP2n/Th
         S1LSSyJEGVQZys2BhcHxtoxCwxcmsMQOm2BsHfoG27Hn312QM7t3jHCybG/QrylPcQ9O
         WLYGFT6tVagA7MO74jugdDUxe34PfDbBf5FBne7jjOFpIHefGg96/aZA+4Qf29l2e2Ym
         KCVie9dbmu6OYtLqrWCpTWJHzj2gHHQf6nhMymTjmApQIPwvChlxUAg6ANfTkpAJPBiC
         wuGQ==
X-Gm-Message-State: AHQUAuY718FvaDHEbfwxaZ0G4Ap7pyQdL6OMbVxXeIkczmsrr1kZoBj1
        ACSW85AX5aae441TLQmbfBmC6eb4yfkHVQozicUXkQ==
X-Google-Smtp-Source: AHgI3IYNARe+AhWxuIIczhnDs54oJ8SBEa9bYntkz8APW/MgpOPD6mRscuPf1kEfvf+9FKFa9VFY80zTKczG7g+Plnc=
X-Received: by 2002:a24:d587:: with SMTP id a129mr6459351itg.111.1548953326760;
 Thu, 31 Jan 2019 08:48:46 -0800 (PST)
MIME-Version: 1.0
From:   Robert Cathles <rjc.live@gmail.com>
Date:   Thu, 31 Jan 2019 16:48:11 +0000
Message-ID: <CANny=+C+yj6J0P-W91kR2ehxLcT44pMOCzg=u+gpEiiCpQLaHg@mail.gmail.com>
Subject: Git annex possible bug
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We use git annex and found an issue where one machine that had run
'git annex sync' and 'git annex sync --content' was not reporting any
issues, but any other machines were report 99 issues when running 'git
annex get'.

The message for each file was that it was not known to exist on any
repo. doing some searching I found 'git annex fsck' so ran that in the
following fashion on the 'broken' machines: 'git annex fsck
--from=LocalMirrorName --fast'. During this we saw git was updating
the location log for nearly all the missing files. Running 'git annex
get' afterwards resolved the issue and got the files. We found we had
to repeat this on all affected machines.

The machine that did the original sync was running git 2.7.4 and other
machines were either running the same, or 2.17.1.

A test I also tried: I copied one annex file from inside the .git
folder of the original machine that ran the sync, and added it to the
same location on a broken machine, then ran sync and get, and it
reported 98 issues instead.

Does this seem like a bug with git annex? Is there a possible gap in
the way that git annex reports that all is fine - perhaps to do with
the index? Or does this seem to be more likely an issue we created
ourselves? Would there have been any other commands we could have run
to resolve this issue or should have tried out first? (Apart from just
deleting each of our clones and starting again)

Robert
