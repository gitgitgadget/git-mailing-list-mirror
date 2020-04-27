Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DDAC54FD0
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 12:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 779D5206CD
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 12:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=atos.net header.i=@atos.net header.b="w6pBFwgv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgD0M20 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 08:28:26 -0400
Received: from smtppost.atos.net ([193.56.114.176]:9814 "EHLO
        smarthost3.atos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726260AbgD0M2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 08:28:24 -0400
X-Greylist: delayed 443 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Apr 2020 08:28:24 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=atos.net; i=@atos.net; q=dns/txt; s=mail;
  t=1587990504; x=1619526504;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=ws2YqlFWzUP/daI5ahjMcdaWRmy9+jPhbs1jDF/GXK0=;
  b=w6pBFwgvGgNfNpkOB77OyemG37b/64qp8/R93N7zTKPeN4Y0W0hFPr/d
   xvKNsfxUkbNrj2L9ldDZNaNfKwMe94e8ZcCFS1ZEPV55hXVYgI+5eJDgm
   N08fnsLhiBujuB3c6aipxJKGIjXk6vOcgBUHwOBd2lvcb84z5ywP7lksu
   k=;
IronPort-SDR: I7I3dgsWmuHtcvTEJ8JWVi5D+iFIpBGIk+iNYU88mB1qDpK+yPKu9rUQbc76K8DIh4RxQO3plQ
 Uzxcy0WtGHu1Hotm8lpwGarg1sW5mGh74ZAKw+p4KLnToKcmAFlSZStnim8+YLvy62tP4bzcad
 IxYTAx6GyjNoSZLhlUXKwOgm3BBoFnPNCZ0zwQn/6vTA8CxY/jqH5+en2huVggXrl7KUJHxiKS
 5TWSAgVMo8k6RXhqgjlBehZh/Ihh/SJ6SGx4GlZWf6kQMrFCf2hu06joWPemFm5Gebh/3kbvq8
 VqtNpryS3PymMvh5m5J3S2N6
X-IronPort-AV: E=Sophos;i="5.73,324,1583190000"; 
   d="scan'208";a="49035404"
X-MGA-submission: =?us-ascii?q?MDH5/UL6NQoDHC4r6MsUCuEXSyJiEZY6Be1raC?=
 =?us-ascii?q?Qffm49JkK9KFzEPXaq6YB/rTweP/EU0BM/h5ncltDjgEF/iqXmN8BiSS?=
 =?us-ascii?q?FtH7lKP3IQNn0RYF1uQLKy54reI4n0GWhDH1230G75f0G6TrA6t46E3J?=
 =?us-ascii?q?1W?=
Received: from unknown (HELO GITEXCPRDMB11.ww931.my-it-solutions.net) ([10.89.28.141])
  by smarthost3.atos.net with ESMTP/TLS/AES256-GCM-SHA384; 27 Apr 2020 14:20:53 +0200
Received: from GITEXCPRDMB12.ww931.my-it-solutions.net (10.89.28.142) by
 GITEXCPRDMB11.ww931.my-it-solutions.net (10.89.28.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 27 Apr 2020 14:20:52 +0200
Received: from GITEXCPRDMB12.ww931.my-it-solutions.net ([10.89.28.142]) by
 GITEXCPRDMB12.ww931.my-it-solutions.net ([10.89.28.142]) with mapi id
 15.01.1913.007; Mon, 27 Apr 2020 14:20:52 +0200
From:   "Berg, Alexander" <alexander.berg@atos.net>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Weiss, Karsten" <karsten.weiss@atos.net>
Subject: git-rebase v2.26.2 - "--root --empty drop" doesn't work and "--root
 --fork-point $somegibberish" gets SIGSEGV
Thread-Topic: git-rebase v2.26.2 - "--root --empty drop" doesn't work and
 "--root --fork-point $somegibberish" gets SIGSEGV
Thread-Index: AdYcjjVQ7ifZpw31RhKdCUl9cuDLmA==
Date:   Mon, 27 Apr 2020 12:20:52 +0000
Message-ID: <3910b39cf7c7419eb5b87c7aeb871e11@atos.net>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [160.92.209.239]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear *,

AFAIS there are (at least) two bugs in git-rebase at the moment.
Those findings below occured on a simple branch, without an upstream.

If you wish to rebase history and drop all empty commits, e.g.
    git rebase --root --empty drop
those empty commits are still in place after the operation comletes.
With git v2.14.xx this operation ("--drop-empty") drops those empty
commits as expected.
Is there a new option to be used here or something?
Or is it just broken?


As I've experimented with some new options for the above command,
it seems that user input checking isn't done properly for "--fork-point".
I've tried
    git rebase --root --empty drop --fork-point --rebase-merges
(yes, --fork-point usage is wrong here) and got
    Segmentation fault (core dumped)

A colleague of mine looked into this:
    $ gdb /bin/git                                                         =
                                                                           =
    =20
    (gdb) set args rebase --root --empty drop --fork-point --rebase-merges
    (gdb) run                                                              =
                                                                           =
    =20
    Starting program: /bin/git rebase --root --empty drop --fork-point --re=
base-merges                                                                =
    =20
    [Thread debugging using libthread_db enabled]                          =
                                                                           =
    =20
    Using host libthread_db library "/lib64/libthread_db.so.1".            =
                                                                           =
    =20
                                                                           =
                                                                           =
    =20
    Program received signal SIGSEGV, Segmentation fault.                   =
                                                                           =
    =20
    is_per_worktree_ref (refname=3D0x0) at refs.c:725                      =
                                                                           =
      =20
    725                     starts_with(refname, "refs/bisect/") ||        =
                                                                           =
    =20
    Missing separate debuginfos, use: debuginfo-install glibc-2.17-292.el7.=
x86_64 pcre-8.32-17.el7.x86_64 zlib-1.2.7-18.el7.x86_64                    =
    =20
    (gdb) bt                                                               =
                                                                           =
    =20
    #0  is_per_worktree_ref (refname=3D0x0) at refs.c:725                  =
                                                                           =
      =20
    #1  ref_type (refname=3Drefname@entry=3D0x0) at refs.c:760             =
                                                                           =
        =20
    #2  0x00000000005739c9 in files_reflog_path (refs=3D0x90ce30, sb=3D0x7f=
ffffffc5e0, refname=3D0x0) at refs/files-backend.c:176                     =
          =20
    #3  0x000000000057402a in files_for_each_reflog_ent (ref_store=3D<optim=
ized out>, refname=3D0x0, fn=3D0x4d4d20 <collect_one_reflog_ent>, cb_data=
=3D0x7fffffffc640)
        at refs/files-backend.c:2060                                       =
                                                                           =
    =20
    #4  0x00000000004d4f4b in get_fork_point (refname=3D0x0, commit=3D0x91c=
ff0) at commit.c:933                                                       =
        =20
    #5  0x0000000000475e69 in cmd_rebase (argc=3D0, argv=3D0x7fffffffdd20, =
prefix=3D<optimized out>) at builtin/rebase.c:2082                         =
          =20
    #6  0x0000000000406cd0 in run_builtin (argv=3D0x7fffffffdd20, argc=3D6,=
 p=3D0x8b3f40 <commands+2016>) at git.c:444                                =
          =20
    #7  handle_builtin (argc=3D6, argv=3Dargv@entry=3D0x7fffffffdd20) at gi=
t.c:674                                                                    =
          =20
    #8  0x0000000000407bee in run_argv (argv=3D0x7fffffffda80, argcp=3D0x7f=
ffffffda8c) at git.c:741                                                   =
        =20
    #9  cmd_main (argc=3D6, argc@entry=3D7, argv=3D0x7fffffffdd20, argv@ent=
ry=3D0x7fffffffdd18) at git.c:872                                          =
            =20
    #10 0x0000000000406910 in main (argc=3D7, argv=3D0x7fffffffdd18) at com=
mon-main.c:52                                                              =
        =20
    (gdb) list                                                             =
                                                                           =
    =20
    720                                                                    =
                                                                           =
    =20
    721     static int is_per_worktree_ref(const char *refname)            =
                                                                           =
    =20
    722     {                                                              =
                                                                           =
    =20
    723             return !strcmp(refname, "HEAD") ||                     =
                                                                           =
    =20
    724                     starts_with(refname, "refs/worktree/") ||      =
                                                                           =
    =20
    725                     starts_with(refname, "refs/bisect/") ||        =
                                                                           =
    =20
    726                     starts_with(refname, "refs/rewritten/");       =
                                                                           =
    =20
    727     }                                                              =
                                                                           =
    =20
    728                                                                    =
                                                                           =
    =20
    729     static int is_pseudoref_syntax(const char *refname)            =
                                                                           =
    =20
    (gdb)


With kind regards,
    Alex
