Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD4C61F859
	for <e@80x24.org>; Mon, 29 Aug 2016 04:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750860AbcH2Eft (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 00:35:49 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:38399 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbcH2Efs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 00:35:48 -0400
Received: by mail-it0-f41.google.com with SMTP id g62so79684269ith.1
        for <git@vger.kernel.org>; Sun, 28 Aug 2016 21:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=Twa4KlxEmsgx5q+3wI2/RhBGKWLXGVYETpItploE5rQ=;
        b=OL9ccZkPKA2YJJWtZeeDgECuZ1hfUHsN8ZG8JxhHufr/enLVFRFLgB/ppR9jw90o5R
         YEoNM5frQYyxXvL6V9ORSalm8EHIi/DFB+ypWwsyciCXeYC5btBSe8rVgRgFzKu809C/
         AohNDlgLh0RTSmjGTcnLbcd/OMCpW6uXUwmpnkeuq61dDWcJfaNsX0OBg3BLR3M/eGA2
         Bx8wBZddA2dmWIpoyQhfgAh6b35BS8e5q351wzb0L33AA4pleWZlWu9q4aB7iEnSrG4k
         ys7dmImgiUd5wWrJ0ysweP1WE6S27jWAhlr3ZDaIIV4ptQx5/V5irfmUW3xu41Bu+PB9
         vbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Twa4KlxEmsgx5q+3wI2/RhBGKWLXGVYETpItploE5rQ=;
        b=dcE5g8Aas09+E5onxJ+weh8pSmzp/kcwAdm32NPXGNgpumBB37/bdxhUmPReiuSjb1
         VJFz3VYZHys8q2PoQEa2YwkJSHuq54KLk9pcZT3ejr8ls/4KRuPxTq37p8CEUQg82yzP
         nrmKxA4EjDhE4i1BjETx5WWp6xdMRbGPZH15kiGtQIbVMMGrj8Li8Yg37rRuVqt580OJ
         4Ytt18cDTyEv3l1L30vbhJ4Qcr8r0v8ibM7siM4cdxqrnLKcuoMVY+hPmrPVpFIkN1Vq
         AjpIstDp1TqB0Eai8PYoGutec7qaCaS4OjYy88jfk8/DZGkbIdWewdgUPgsX4pZPMDG7
         OGMg==
X-Gm-Message-State: AE9vXwOSNKLtR80TAYBxQoDRvnoczP7vLPH97L0O0c9K6QOUyIZrNMz7P/CnWKqDla+j6nPBRHwHhjiiFjcQeg==
X-Received: by 10.36.104.73 with SMTP id v70mr13137573itb.12.1472444964441;
 Sun, 28 Aug 2016 21:29:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.168.71 with HTTP; Sun, 28 Aug 2016 21:29:04 -0700 (PDT)
From:   "Jean-Marc B. van Schendel" <jeanmarc.vanschendel@gmail.com>
Date:   Mon, 29 Aug 2016 06:29:04 +0200
Message-ID: <CAKUcBEDwbZ7aLsa2w4dqNCRg3QQMo_2hm7-O-6o0Fg58ANYv=A@mail.gmail.com>
Subject: Suspected Bug in git install procedure [ git-daemon-run (version
 1:2.9.3-1) ]
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Not really a bad bug, apparently just one little detail...

Symptoms:
On a fresh new install of Debian "Stretch" (8.5 alpha7, dated 2016-06-30),
Trying to install a subset of Git packages (roughly, all those listed
in git-all, except CVS-related packages)
Install of package git-daemon-run (version 1:2.9.3-1) fails, dpkg
reporting error

Assumed cause:
The directory /etc/service does not exist, and the install procedure
does not create it, subsequently fails to create a symlink (git-daemon
--> /etc/sv/git-daemon)

Workaround used:
Manually created, directory /etc/service and ... it seems to work fine...

Dunno's...
It seems like the location for the newly created symlink may be
hard-coded as /etc/service/. I cannot substantiate whether this
location is a "universal invariant", or something platform-specific,
which ought to be documented in one way or another.
The "real'' cause of the problem might as well be that the install of
Debian silently failed to create /etc/service/ (either as a folder or
as a symlink to anwhere else)...
The git daemon is the first standalone daemon I am installing on this
system. From my point of view, it sounds possible that another
standalone daemon (eg. ProFTPd) might have reported the same problem
if I had installed it before git...


Kind regards


--jmbvs
Jean-Marc B. van Schendel
email: jeanmarc.vanschendel@gmail.com
voice: +32.(0)474.70.3885
msn: jmbvs@hotmail.com
