From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: git show loop
Date: Sat, 24 Mar 2012 13:42:57 +0100
Message-ID: <4F6DC151.9040707@in.waw.pl>
References: <alpine.DEB.2.02.1203241101390.2046@localhost6.localdomain6> <4F6DB4E9.3090402@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 24 13:43:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBQJu-0006xY-Ty
	for gcvg-git-2@plane.gmane.org; Sat, 24 Mar 2012 13:43:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754849Ab2CXMnK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Mar 2012 08:43:10 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:56163 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753534Ab2CXMnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2012 08:43:09 -0400
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=[192.168.0.12])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SBQJD-00038a-00; Sat, 24 Mar 2012 13:43:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20120104 Icedove/8.0
In-Reply-To: <4F6DB4E9.3090402@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193825>

On 03/24/2012 12:50 PM, Zbigniew J=C4=99drzejewski-Szmek wrote:
> On 03/24/2012 11:05 AM, Julia Lawall wrote:
>> In linux, git show 60d9aa7 -U0 goes into an infinite loop.

Bisect points to
commit b810cbbde9232cbe9a3841edccc5b606bbd3a82e (refs/bisect/bad)
Author: Junio C Hamano <gitster@pobox.com>
Date:   Wed Jul 22 14:48:29 2009 -0700

     diff --cc: a lost line at the beginning of the file is shown=20
incorrectly

Zbyszek

> Yeah, I can confirm that with git version 1.7.10.rc1.225.gba57e.
>
> This doesn't happen everytime, some there's some race condition.
>
> unsigned long la; /* lookahead */
> is either 49 (works fine) or 18446744073709551615 (seems to hang).
I don't know the code enough to understand this, but obviously la is se=
t=20
to 0, and then decremented in the loop.

> Zbyszek
>
> (gdb) bt
> #0  make_hunks (sline=3D0xb20360, cnt=3D161, num_parent=3D2, dense=3D=
1) at combine-diff.c:426
> #1  0x000000000049295a in show_patch_diff (elem=3D0x8d0020, num_paren=
t=3D2, dense=3D1, working_tree_file=3D0, rev=3D0x7fffffffd7a0) at combi=
ne-diff.c:961
> #2  0x00000000004933cd in diff_tree_combined (sha1=3D0x82fc74 "`=D9=AA=
u\214", parents=3D0x7fffffffd620, dense=3D1, rev=3D0x7fffffffd7a0)
>      at combine-diff.c:1185
> #3  0x000000000049348f in diff_tree_combined_merge (commit=3D0x82fc70=
, dense=3D1, rev=3D0x7fffffffd7a0) at combine-diff.c:1209
> #4  0x00000000004c6913 in do_diff_combined (opt=3D0x7fffffffd7a0, com=
mit=3D0x82fc70) at log-tree.c:731
> #5  0x00000000004c6a2f in log_tree_diff (opt=3D0x7fffffffd7a0, commit=
=3D0x82fc70, log=3D0x7fffffffd6d0) at log-tree.c:764
> #6  0x00000000004c6b7f in log_tree_commit (opt=3D0x7fffffffd7a0, comm=
it=3D0x82fc70) at log-tree.c:808
> #7  0x0000000000444aa3 in cmd_log_walk (rev=3D0x7fffffffd7a0) at buil=
tin/log.c:300
> #8  0x00000000004455ca in cmd_show (argc=3D3, argv=3D0x7fffffffe050, =
prefix=3D0x0) at builtin/log.c:510
> #9  0x0000000000405762 in run_builtin (p=3D0x795140, argc=3D3, argv=3D=
0x7fffffffe050) at git.c:308
> #10 0x00000000004058f5 in handle_internal_command (argc=3D3, argv=3D0=
x7fffffffe050) at git.c:467
> #11 0x0000000000405a0f in run_argv (argcp=3D0x7fffffffdf3c, argv=3D0x=
7fffffffdf30) at git.c:513
> #12 0x0000000000405b9c in main (argc=3D3, argv=3D0x7fffffffe050) at g=
it.c:588
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
