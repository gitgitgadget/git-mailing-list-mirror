Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2D72202DA
	for <e@80x24.org>; Tue,  7 Mar 2017 21:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755589AbdCGVgJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 16:36:09 -0500
Received: from mail-ua0-f175.google.com ([209.85.217.175]:36328 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751113AbdCGVgI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 16:36:08 -0500
Received: by mail-ua0-f175.google.com with SMTP id 72so23970521uaf.3
        for <git@vger.kernel.org>; Tue, 07 Mar 2017 13:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=SGuy8DrVn3cKdCDRS9AcvLqykl5nZgXkDTvINge4wGs=;
        b=tE0AwdwX7x7bkPE2B24rPrknnEbHIWqVaOoOs48GqX92Zxf8qMlbOYhx8smg+Xi8/w
         DTN0q8GTtLPMPF2WnIz5F1gHNiqogyVQNoOI2613Tqu4SWWrdM5ZvjUAU87Q7O/zyrPu
         adIMcIjpURAnMDDKn7E/EGBr7dF4VSC809yxyssmjaFJbmpWlXTc1qARW0tmEWFtKDWG
         tn5MbXlMOWvF3a0JFHQ0rpqatLuW5V4UFOFY+e3RT+OTgSnWEht6N95k10qoPPAEd09l
         HG/m+N687107zL4ccwqYvymWAV3GFT/xmYbv27LYR/u+gJ3s18nJUgiG0d+Hht4RLjm2
         MGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=SGuy8DrVn3cKdCDRS9AcvLqykl5nZgXkDTvINge4wGs=;
        b=DbqBSRQXiYZy3hGXVUEXGEm3+2l4Eg3xbBVW1AC/qGdnFNEL1ZAAI90sY+G/lsiynP
         9uy+F41WKPhxWc/YUM3AIrD1DVYsi1sdjpn0kcWwg5BRUs0AKUXrqMSArPqb1QOXN1pB
         Rj++CLIll1pq72ZmdsEstHjCs446zBxyPyYSI6sfP0RvhB5llnJnt7+y5ak4S2bxkCuv
         s7AJLv2uTSOADGv8zMUK0m1IRU3NYcdlSLSebT6FzcR9n8O7mjHb/Jv8oYEVfa01EK0v
         wZQefS0HnL5V1LWJcO22ioSy9JKsJq+NRt6elI/9txV+osAxwc83JxN1Yeu8LMnm7JuB
         2uig==
X-Gm-Message-State: AMke39mL2v3v05Sh3ZTje6crYsCgg1KrIjZ2oyE4f3C8SU1AK7RMk/3OsSi5N2hajTmllx3TJs7U0YLhCmx63Q==
X-Received: by 10.31.219.131 with SMTP id s125mr1588592vkg.118.1488922157444;
 Tue, 07 Mar 2017 13:29:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.74.199 with HTTP; Tue, 7 Mar 2017 13:28:57 -0800 (PST)
From:   valtron <valtron2000@gmail.com>
Date:   Tue, 7 Mar 2017 14:28:57 -0700
Message-ID: <CAFKRc7y_kpCGNORENUZ2qw_4qBwjjyaaDFxAEQa52fTryj+w7A@mail.gmail.com>
Subject: Crash on MSYS2 with GIT_WORK_TREE
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git 1.12.0. When GIT_WORK_TREE contains a drive-letter and
forward-slashes, some git commands crash:

C:\repo>set GIT_WORK_TREE=C:/repo
C:\repo>git rev-parse HEAD
     1 [main] git 2332 cygwin_exception::open_stackdumpfile: Dumping
stack trace to git.exe.stackdump
C:\repo>set GIT_WORK_TREE=
C:\repo>git rev-parse HEAD
a394e40861e1012a96f9578a1f0cf0c5a49ede11

On the other hand, "C:\repo" and "/c/repo" don't have this issue.

Stacktrace from GDB (on git-rev-parse) is:

#0  0x000000018019634d in strcmp (s1=0x600062080 "/c/repo", s2=0x0)
   at /msys_scripts/msys2-runtime/src/msys2-runtime/newlib/libc/string/strcmp.c:83
#1  0x00000001005239f1 in ?? ()
#2  0x0000000100523f36 in ?? ()
#3  0x000000010046c6fa in ?? ()
#4  0x0000000100401b6d in ?? ()
#5  0x0000000100401e4b in ?? ()
#6  0x0000000100563593 in ?? ()
#7  0x0000000180047c37 in _cygwin_exit_return ()
   at /msys_scripts/msys2-runtime/src/msys2-runtime/winsup/cygwin/dcrt0.cc:1031
#8  0x0000000180045873 in _cygtls::call2 (this=0xffffce00,
func=0x180046bd0 <dll_crt0_1(void*)>, arg=0x0,
   buf=buf@entry=0xffffcdf0) at
/msys_scripts/msys2-runtime/src/msys2-runtime/winsup/cygwin/cygtls.cc:40
#9  0x0000000180045924 in _cygtls::call (func=<optimized out>,
arg=<optimized out>)
   at /msys_scripts/msys2-runtime/src/msys2-runtime/winsup/cygwin/cygtls.cc:27
#10 0x0000000000000000 in ?? ()
Backtrace stopped: previous frame inner to this frame (corrupt stack?)

It seems "C:/repo" was changed to "/c/repo", but it crashes because it
gets compared to a nullptr.
