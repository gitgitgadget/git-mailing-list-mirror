Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BAA71F858
	for <e@80x24.org>; Thu, 28 Jul 2016 16:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbcG1QVJ (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 12:21:09 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37169 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758928AbcG1QVG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2016 12:21:06 -0400
Received: by mail-wm0-f46.google.com with SMTP id i5so115816056wmg.0
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 09:21:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=EMelntoaXtf36ZnE+G9uMOW4aT/qC+ax8OyVBHzj9fc=;
        b=RMpMB+QevSWyYWAVER7FRbb7AO0XAWTOCKEqk04jpTMZiErRRS9qnvkRDaA66X6RX4
         SY8YXtCKXcXLq6ZfF13HJ3DUQPMBzTS25WRgvLKLrOW48A+5StAUNV5aGMjFL9FQu71R
         JC6PKoaePouvc+LVHcY92iImi2uBHkE3ea48CVVinqz1tWjTLKvzckrEuKnIBVtlK7pm
         DNHpJ98HRVpY4X2io0ScVzlPvaBRDnzbxbne/8hJTN0vkMOFSrMpP8MMFnLuWICpQsHA
         JDJmmxv9rdp+Y4hhozp8uaG+lZtjhAq1LJKsN3FrRhYpx/R0YFSRZPDSCR5lm2SrYtdl
         JtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=EMelntoaXtf36ZnE+G9uMOW4aT/qC+ax8OyVBHzj9fc=;
        b=cocZKqn22/FRdnKGz33HOKLef33V+c65v1IMRhP/gh9TnY32OFuHz8OBnfUmfw2dPU
         6sNgvSUSrp1vm2y5BUIdsbhJL9qx97GIvQFaYuiFw7XFIdYIa0zI/2ICC4y2LUO0ZTvC
         I3Y9Uu3HXbrMNv6fHSCmWc6ZHvvdJCqHfwTfmOi8j1ycb4y0l6YXly5tcKAIxcbS4gnH
         IYR1AyXOoGJL83tExZtRHy3sl1I58eMLaW/CEuH53SNBWCFVaH3B9NKi25/3omnv05B0
         ZAmPaBw/CjwnKJNJf+cTTH7A0UV/CcMF8c/NGRcsRgQYjXnuqg8JXgOrEZcoTUHuBYpt
         l/1A==
X-Gm-Message-State: AEkoouseQC6Q+1BIv7xQGPEU7+eEMpDbTu2pymxHnsqsah2Yk1SBZwZLBAAW+2hZOt9cNBw3mfBQNfWVYpcNNw==
X-Received: by 10.194.18.198 with SMTP id y6mr36476851wjd.87.1469722864217;
 Thu, 28 Jul 2016 09:21:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.130.74 with HTTP; Thu, 28 Jul 2016 09:20:34 -0700 (PDT)
From:	=?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Date:	Thu, 28 Jul 2016 18:20:34 +0200
X-Google-Sender-Auth: iTqcqvdn_Spy2yIoSvDQ2s6qlYo
Message-ID: <CAA787r=FH7Sa4qy2A-dy+wug81ZkqOW2KmSuWBE8_3whmNj1pw@mail.gmail.com>
Subject: git-testadd: Execute a command with only the staged changes in Git applied
To:	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This is a script I created some weeks ago, and I've found it to be
immensely useful. Here is a snippet from git-testadd --help:

  If you have lots of unrelated uncommitted changes in the current
  repository and want to split up the commit, how can you easily check
  if the changes passes the test suite? With all the other unrelated
  changes it can be hard to make sure that only relevant changes becomes
  part of the commit, and that they don't result in regressions. This
  script clones the repository to the directory ".testadd.tmp" in the
  current directory and applies the staged chenges there (unless
  -u/--unmodified or -p/--pristine is specified), chdirs to the same
  relative directory in the clone and executes the command specified on
  the command line there.

The script is well-tested, and also have a test suite you can run to
make sure it works on your *nix system. Place git-testadd.t in a
subdirectory one level under the script location, chdir to that
directory and execute "./git-testadd.t". It also works with binary
files.

Available from

  https://gitlab.com/sunny256/utils/raw/master/git-testadd
  https://gitlab.com/sunny256/utils/raw/master/tests/git-testadd.t

It's also on GitHub, just replace "gitlab" with "github" in the URLs.
And of course, ideas and patches for new functionality/fixes are always
welcome.

        Øyvind
