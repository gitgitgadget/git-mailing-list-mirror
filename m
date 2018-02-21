Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2466B1F576
	for <e@80x24.org>; Wed, 21 Feb 2018 07:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751438AbeBUHxa (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 02:53:30 -0500
Received: from mout.web.de ([212.227.15.4]:37333 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751384AbeBUHx3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 02:53:29 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lp7Lg-1eIetU1Rg4-00euAX; Wed, 21
 Feb 2018 08:53:24 +0100
Date:   Wed, 21 Feb 2018 08:53:23 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Matt McCutchen <matt@mattmccutchen.net>
Cc:     git <git@vger.kernel.org>
Subject: Re: Duplicate safecrlf warning for racily clean index entry
Message-ID: <20180221075323.GA18213@tor.lan>
References: <1519134146.6055.23.camel@mattmccutchen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519134146.6055.23.camel@mattmccutchen.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:RC1CJO9Gka1jSLECrZlzYGC2QZL72fNBF+PnUUnOtyTfPK0em3a
 IDKjPe6NauVVoef+Tg0rRyDzcSBYMxPBHDlx+cargJ2B3I6NTMZ737INnzmTShN5jvpuQPP
 DN6ws0pESf10EqMtb+rncMj3HfAJp2RFeG6i3O2Q5y8uzSHAsgpahs3tiQ8Pd0pQGuDMBx4
 hTf9/GnzMYVcufN42AAFg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HPSSFYOM9T0=:ABj8N7R05ihLMxXNzmb/PY
 A6DnBJx78IMY/R9j2HE6gBhQayAYDN8Ew1rmpUOaoUk0FzUEvxsYRfHYYSJrQg5sulm7S8uMs
 VR6RdIWjsVDvKavV5kGtwlEMYDEDHFbPcJlxKBeXorDe917knokodzipyKvNHUhkrpG7cchFz
 IUQXEOWCy2qGwvKffxt2r+ZqOfPYSgKr/2gWU3heGYclrST7v/3J7Y7Jbp7t3/STpK+lulGtu
 YGj24KMMRoGeUx5BakHw4ZcpYA8Ik63hU0pwwHfqiCt11YYZ43ts/ZgNu0P6343yaovtKuKpv
 2Q3IrBLg4tR4EVJRuiLMompKUekjc52jAvrD/YPT7f9WaYy3fwpMPzlQ0tShg38t24an6+/Em
 AI2Hk792gN98jxvXCYvNwwMQF2faUFxMlo3C44I93pQiuGUMmoHVdZguEIjLSz/wgXTdiEtsH
 DKplb8CarY5Ne7Di43/mUDBBoTmXtg9fD/HA4WVz+4w4lT2rE11S6dq9FxthssDvFENFnoYl7
 Q1wXeVWk2PDM20ByNgEwYQuO/mgPc5GfQa+iZQHNWQSnNY1DEvTSkM29b0CEsmo+2j6Y0bpBy
 5u6NeSU4iDuAWIIfFRIXgoRAxfhrKLE23WScKWf44gY8UxjGYOAWvU+Qp0P/UUfjlOFnSOS1H
 PnLZs8WMm9SMfzZ/+wnQf7FwWk7JIWmeImbHb72OCtvzkoiU4zWPeTLjFVtDtcSOAmGQKHx+m
 HcW564uAgt+FcaU8MH74lTTuilu/JaFGjnmGlW+3TQko6X8UVK4MJRm83psUdEO0LWq08/y4o
 s7LkEZvJ6JO6SPv06O/KXfeZr4cFQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 20, 2018 at 08:42:26AM -0500, Matt McCutchen wrote:
> I noticed that if a file subject to a safecrlf warning is added to the
> index in the same second that it is created, resulting in a "racily
> clean" index entry, then a subsequent "git add" command prints another
> safecrlf warning.  I reproduced this on the current "next"
> (499d7c4f91).  The procedure:
> 
> $ git init
> $ git config core.autocrlf true
> $ echo foo >file1 && git add file1 && git add file1
> warning: LF will be replaced by CRLF in file1.
> The file will have its original line endings in your working directory.
> warning: LF will be replaced by CRLF in file1.
> The file will have its original line endings in your working directory.
> $ echo bar >file2 && sleep 1 && git add file2 && git add file2
> warning: LF will be replaced by CRLF in file2.
> The file will have its original line endings in your working directory.
> 
> This came up when I ran the test suite for Braid on Windows
> (https://github.com/cristibalan/braid/issues/77).

I think a .gitattributes file could/should be used. I'll answer
there seperatly.

> 
> The phenomenon actually seems to be more general: touching the file
> causes the next "git add" to print a safecrlf warning, suggesting that
> the warning occurs whenever the index entry is dirty.  One could argue
> that a new warning is reasonable after touching the file, but it seems
> clear that "racy cleanliness" is an implementation detail that
> shouldn't have user-visible nondeterministic effects.
> 
> In either case, if "git update-index --refresh" (or "git status") is
> run before "git add", then "git add" does not print the warning.  On
> the other hand, if line endings in the working tree file are changed,
> then git shows the file as having an unstaged change, even though the
> content that would be added to the index after CRLF conversion is
> identical.  So it seems that git remembers the pre-conversion file
> content and uses it for "git update-index --refresh" and would just
> need to use it for "git add" as well.
> 
> Thoughts about the proposed change?  Does someone want to work on it or
> give me a pointer to where to get started?

Good analyzes, thanks for that.

I don't hava a pointer, but what should happen ?
2 warnings for 2 "git add" should be OK, I think.

1 warning is part of the optimization, that Git does to handle
hundrets and thousands of files efficciently.

Is the 1/2 warning  real live problem  ?

> 
> Thanks,
> Matt
