Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8C0E1F744
	for <e@80x24.org>; Tue, 21 Jun 2016 12:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbcFUMBk (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 08:01:40 -0400
Received: from mout.gmx.net ([212.227.15.19]:49381 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751525AbcFUMBj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 08:01:39 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MNZgw-1bI5WI1ErK-007EFp; Tue, 21 Jun 2016 14:01:32
 +0200
Date:	Tue, 21 Jun 2016 14:01:31 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: [PATCH 1/1] mingw: work around t2300's assuming non-Windows
 paths
In-Reply-To: <xmqqmvmfu17f.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1606211356170.22630@virtualbox>
References: <cover.1466246919.git.johannes.schindelin@gmx.de> <a8bebe126bcd047720a13e90b85b8dccb7231187.1466246919.git.johannes.schindelin@gmx.de> <xmqqmvmfu17f.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:1smwX0cSodb1+Gsi2aTXnEW1EuX3G4iG+bUGafoqA30aPhW8w93
 dP8jDWB6icP5Iq6B0k/aqEr24lQlJcA4CIWPto07U9AiGmGgmo9LfGTLZzvyZdRYz+g3O+F
 Lhw4TVOxf5FQ1o8c/xHY39UZS1FQo/4owqAFr1SMGD3qct+6fdxW24JzPlFsk++VdILMhWg
 WEeuU8mw4ukVZXQa61I9g==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:fzUzuORRX80=:7/2VXJpGpbTBps1OODW5ci
 gbYZwKEwYuAMUl2MymdG4XoZwcJi5uiCD7WFr7pxgvnD8XjRBdeFz3UXzQqHJhbf+15FziBej
 eANTZTwo9ZXlhMACn3UC8REGqz9VtsFccjvBD6tYOPS8Sd1QTNkowlWg23ikYydYi7IJSWz9J
 XMYgZ3vn3utkfeORC2XdogujPO8aik7brId/svuSUOxyGakufHJh9vugI0vcHk1MzPX3aknCf
 m7z4qBN1Q3g1w9T1hUX9Im//APNE+L298SU2Y9hNB14HgiGlpKlel1V37Ww4hhCXKwc7cQyyY
 axQzv+aKMar7gzwoloTXJAqIqIj9qYh46cHCmKXkX2wtNqRRIb/PxMKlbdYCFpCAv9Z0U6ho1
 8WXNBLKZ2cWc3ztgprQ0U57YvOG+ZxwYqVPRjsS9SiCPDZ+N+IJA1NcGq/Sap1skyQUdqr8uq
 hO2FG5S34yWb9+/PcO66lh+fgKJqOEDo59MmM2dGWrphLKCJ2WT6zK0bg9BVQx6WruGmPusrv
 gRVtXR5OePGN50uN6sHYMdy8okqULWDKgOWHQGnKzons+YsqjY103LE+rF+zDPIEqtqBQ5Jkh
 cIL93M0370PMJVhkMmflZci3JDIDEsXL/oL/rMWNNafuYCUKlxNstA+vbjrdPhtayZS1SpZS2
 aM8LgzaYdZ2/6P0YX/sY4Ltk05nCpjbkDx3LQ916DfixABMSRhjG9LWWNCulvtK3zdEP1WY/D
 O9pOFuwUotwMbWk85a+GfgF3Ov26REqf2Ge8/ky3YmMnOyw8ajtvfpipL2GMGQksGVv87Dc4z
 KSMz0UP
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Mon, 20 Jun 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > On Windows, we have to juggle two different schemes of representing
> > paths: the native, Windows paths (the only ones known to the main Git
> > executable) on the one hand, and POSIX-ish ones used by the Bash
> > through MSYS2's POSIX emulation layer on the other hand.
> >
> > A Windows path looks like this: C:\git-sdk-64\usr\src\git. In modern
> > Windows, it is almost always legal to use forward slashes as directory
> > separators, which is the reason why the Git executable itself would
> > use the path C:/git-sdk-64/usr/src/git instead. The equivalent
> > POSIX-ish path would be: /c/git-sdk-64/usr/src/git.
> >
> > This patch works around the assumption of t2300-cd-to-toplevel.sh that
> > `git --exec-path` spits out a POSIX-ish path, by converting the output
> > accordingly.
> 
> Hmm, I am confused.  `git --exec-path` _is_ meant to "spit out" a
> path that is usable when prepended/appended to $PATH [1], and it
> does _not_ have to be POSIX-ish path.  It is totally up to the port
> to adjust it to the platform's convention how the $PATH environment
> variable is understood.

The port does exactly what it is supposed to do: the output of `git
--exec-path` can be prepended/appended to %PATH%. The point here is:
%PATH% is *semicolon*-delimited.

All problems start when we do not use scripting native to Windows, but the
Bash. In the Bash, we *assume* that $PATH is *colon*-delimited. All the
time. And that is part of what makes a POSIX emulation layer on Windows so
challenging.

> If $PATH cannot take C:/git-sdk-64/usr/src/git but does understand
> /c/git-sdk-64/usr/src/git, perhaps "git --exec-path" should be
> emitting the latter in the first place?

Again, %PATH% can take C:/... just fine. But the Bash gets the
POSIX-layer-munged $PATH which has POSIX-ish paths so that it can
colon-delimit its PATH and all shell scripts can continue to work.

So the root cause for the problem which requires this work-around is that
our test suite is written in shell script, which is inherently not as
portable as we think it is.

Does that address your puzzlement? If so, would you kindly advise how to
improve the commit message (or the patch)?

Ciao,
Dscho
