Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1B7C1F404
	for <e@80x24.org>; Thu, 15 Mar 2018 17:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751889AbeCORDK convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 15 Mar 2018 13:03:10 -0400
Received: from elephants.elehost.com ([216.66.27.132]:19057 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751497AbeCORDJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 13:03:09 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w2FH33Eh081493
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 15 Mar 2018 13:03:04 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Jake Stine'" <jake.stine@gmail.com>
Cc:     <git@vger.kernel.org>
References: <CABWk7R9xNDHJbbsMZbOyhcYXq-bD6Krvbw_mKDBJFALALS3AHA@mail.gmail.com> <xmqq1sgl703v.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq1sgl703v.fsf@gitster-ct.c.googlers.com>
Subject: RE: [bug] git stash push {dir-pathspec} wipes untracked files
Date:   Thu, 15 Mar 2018 13:02:58 -0400
Message-ID: <002f01d3bc7f$7b6261f0$722725d0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE5/m4rQY0gz0SiEjCVsgUQJVY71gGlO7m/pPfXrdA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> -----Original Message-----
> From: git-owner@vger.kernel.org <git-owner@vger.kernel.org> On Behalf
> Of Junio C Hamano
> Sent: March 15, 2018 12:52 PM
> To: Jake Stine <jake.stine@gmail.com>
> Cc: git@vger.kernel.org
> Subject: Re: [bug] git stash push {dir-pathspec} wipes untracked files
> 
> Jake Stine <jake.stine@gmail.com> writes:
> 
> > Hi, I ran into what I believe is a bug today.  I’m using primarily Git
> > for Windows 2.16.2 and also reproduced the behavior on Git for Windows
> > 2.15.1 and Git 2.14.1 on Ubuntu:
> >
> > Given any repository with at least one subdirectory:
> >
> > 1.       Create some untracked files in the subdir
> > 2.       Modify a tracked file in the subdir
> > 3.       Execute `git stash push subdir`
> > 4.       The untracked files will be removed, without warning.
> >
> > `git stash push` behaves as-expcted and does not touch untracked
> > files.  It’s only when a directory tree is specified as [pathspec]
> > that the problem occurs.
> 
> I wonder if this is the same as the topic on this thread.
> 
>   https://public-
> inbox.org/git/CA+HNv10i7AvWXjrQjxxy1LNJTmhr7LE4TwxhHUYBiWtmJCOf_
> A@mail.gmail.com/
> 
> What is curious is that the fix bba067d2 ("stash: don't delete untracked files
> that match pathspec", 2018-01-06) appeared first in 2.16.2, on which
> Windows 2.16.2 is supposed to be built upon.
> 
> > Here's the precise reproduction case executed on a linux box:
> 
> This does not reproduce for me with v2.16.2-17-g38e79b1fda (the tip of
> 'maint'); I do not have an  install of vanilla v2.16.2 handy, but I suspect v2.16.2
> would work just fine, too.

This does not reproduce for me either in v2.16.2.9-g3dbadef9f (which is the NonStop port of 2.16.2)

On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

        modified:   subdir/a

Untracked files:
  (use "git add <file>..." to include in what will be committed)

        subdir/b

no changes added to commit (use "git add" and/or "git commit -a")
/home/randall/foot: git stash push subdir
Saved working directory and index state WIP on master: b772270 i
/home/randall/foot: ls subdir
a  b
/home/randall/foot: git status
On branch master
Untracked files:
  (use "git add <file>..." to include in what will be committed)

        subdir/b

nothing added to commit but untracked files present (use "git add" to track)

