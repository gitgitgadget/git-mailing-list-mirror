Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DA6D1FCC7
	for <e@80x24.org>; Thu, 22 Dec 2016 23:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941858AbcLVXQN (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 18:16:13 -0500
Received: from mout.gmx.net ([212.227.15.19]:64127 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756760AbcLVXQM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 18:16:12 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MWT8s-1c5I5v2Yna-00XfBV; Fri, 23
 Dec 2016 00:16:05 +0100
Date:   Fri, 23 Dec 2016 00:16:03 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v3 0/3] Really fix the isatty() problem on Windows
In-Reply-To: <cover.1482426497.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1482448531.git.johannes.schindelin@gmx.de>
References: <cover.1482426497.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:l+31Giz3q/JcZc+EiQIZ9bhK7vrEsEptWL4muUYA3tO7Vyhzlwj
 Pp28+GtFqIxa5Z5TpURWWWrrZAwsgTjjBj9fUuAS9Ntx9x4c9BjGXwVw36e5ipBrKngGVB9
 98P07stFnSfMDuKktE0oB802JNvhBvdJ3tUDzdcjWmVbfeDsUX3kl2b2WuzoeAnBT7aDWpX
 pwxs37XoPPwQWZEw2YLSA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HjBlukRWRn0=:QX/21ZWIMUTVCbjkAU/7bU
 +gqqCgqxxH/96WbE3v5Y0wkErQvE7b5+iZUIRqb06JFAuCyCWwFpRpaQV6JzefLscIRmxyyes
 OjXDUYkVqEHXsd042Qspsf/+CHTcUAItP7VOa1zzESlNiSN2Nr2bsvsHLp9v82hWbGypxUIL8
 sZHekQrhEaB19jv+p5NP473JxanOU1CsgkaKWbLgss+gIM6aWZ4Vfm7NP9g9loBAF+Jttez9c
 JGCwnZUvw5PTmvI2NP5lQejwcN1wtMDtB+MzR1VK2PqwvQpU0bWQFKM3x5/LU+3I3zq12Sz5w
 Xd3Kesdi2w6NloNDdwm6D4enKlhsWrI7th5b1rYWNbWx1ssjsxi05spKFWw/ecARen0HRY3H2
 RXMdr18HZ/tFs+oMM67c8YqhvvBQBXM7RneffC0aLYx9nmnRdnM84T43VrPgItedikqJIkvqG
 fU0VMt4PfF+uHQHGeFt9BjSoUSDRLb/kWXxkykYjwNbaVIAq/yyU5Dt0etLoypq92fawztEGM
 ilmlQHZGE/srMxJheWO2RuKLTJlsxv3U6mVADrFp9/eNYDZ8U1fetp9IhNDR7yA1mCilkdK7/
 K5Z/Lwh3Lq7MQkgxb2zeo6CKAy16aqZqKBuyIVAEBhVl6wc7x8ogUtv9Gx8g32ZOKFUo1kWQh
 RMYbzg6eVn013SJ0N/6HOa65vnlJvMLmwshAAoNVfDnFdp7+0Shoio2DiG2kYErFZUgIM1Wt9
 Q9JI10skQ5iEA7NQRicuE/yIUqKy7N4RYtlXUOMEGAGNBMJ0Y+6VXoGjmVhuDorF0xdeBATTA
 7HB7yPD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My previous fix may have fixed running the new
t/t6030-bisect-porcelain.sh script that tested the new bisect--helper,
which in turn used isatty() to determine whether it was running
interactively and was fooled by being redirected to /dev/null.

But it not only broke paging when running in a CMD window, due to
testing in the wrong worktree I also missed that it broke paging in Git
for Windows 2.x' Git Bash (i.e. a MinTTY terminal emulator).

Let's use this opportunity to actually clean up the entire isatty() mess
once and for all, as part of the problem was introduced by a clever hack
that messes with internals of the Microsoft C runtime, and which changed
recently, so it was not such a clever hack to begin with.

Happily, one of my colleagues had to address that latter problem
recently when he was tasked to make Git compile with Microsoft Visual C
(the rationale: debugging facilities of Visual Studio are really
outstanding, try them if you get a chance).

And incidentally, replacing the previous hack with the clean, new
solution, which specifies explicitly for the file descriptors 0, 1 and 2
whether we detected an MSYS2 pseudo-tty, whether we detected a real
Win32 Console, and whether we had to swap out a real Win32 Console for a
pipe to allow child processes to inherit it.

While at it (or, actually, more like: as I already made this part of v1
by mistake), upstream the patch carried in Git for Windows that supports
color when running Git for Windows in Cygwin terminals.

Changes since v2:

- reworded the comment about "recycling handles"

- moved the reassignment of the `console` variable before the dup2()
  call so that it is valid at all times

- removed the "handle = INVALID_HANDLE_VALUE" assignment, as the local
  variable `handle` is not used afterwards anyway

- generated the patches with --patience in the hope to improve
  readability


Alan Davies (1):
  mingw: fix colourization on Cygwin pseudo terminals

Jeff Hostetler (1):
  mingw: replace isatty() hack

Johannes Schindelin (1):
  mingw: adjust is_console() to work with stdin

 compat/winansi.c | 195 +++++++++++++++++++++++--------------------------------
 1 file changed, 81 insertions(+), 114 deletions(-)


base-commit: 1d1bdafd64266e5ee3bd46c6965228f32e4022ea
Published-As: https://github.com/dscho/git/releases/tag/mingw-isatty-fixup-v3
Fetch-It-Via: git fetch https://github.com/dscho/git mingw-isatty-fixup-v3

Interdiff vs v2:

 diff --git a/compat/winansi.c b/compat/winansi.c
 index 477209fce7..56658ec4f8 100644
 --- a/compat/winansi.c
 +++ b/compat/winansi.c
 @@ -494,19 +494,16 @@ static HANDLE swap_osfhnd(int fd, HANDLE new_handle)
  	 * It is because of this implicit close() that we created the
  	 * copy of the original.
  	 *
 -	 * Note that the OS can recycle HANDLE (numbers) just like it
 -	 * recycles fd (numbers), so we must update the cached value
 -	 * of "console".  You can use GetFileType() to see that
 -	 * handle and _get_osfhandle(fd) may have the same number
 -	 * value, but they refer to different actual files now.
 +	 * Note that we need to update the cached console handle to the
 +	 * duplicated one because the dup2() call will implicitly close
 +	 * the original one.
  	 *
  	 * Note that dup2() when given target := {0,1,2} will also
  	 * call SetStdHandle(), so we don't need to worry about that.
  	 */
 -	dup2(new_fd, fd);
  	if (console == handle)
  		console = duplicate;
 -	handle = INVALID_HANDLE_VALUE;
 +	dup2(new_fd, fd);
  
  	/* Close the temp fd.  This explicitly closes "new_handle"
  	 * (because it has been associated with it).

-- 
2.11.0.rc3.windows.1

