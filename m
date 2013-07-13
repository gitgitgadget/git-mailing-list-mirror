From: =?UTF-8?B?TWFudGFzIE1pa3VsxJduYXM=?= <grawity@gmail.com>
Subject: Segfault in `git describe`
Date: Sat, 13 Jul 2013 16:27:33 +0300
Message-ID: <krrkk0$kri$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 13 15:28:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uxzrp-0006nP-7Q
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jul 2013 15:28:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757919Ab3GMN1s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Jul 2013 09:27:48 -0400
Received: from plane.gmane.org ([80.91.229.3]:39154 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751201Ab3GMN1r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jul 2013 09:27:47 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UxzrV-0006b9-AA
	for git@vger.kernel.org; Sat, 13 Jul 2013 15:27:45 +0200
Received: from 78-60-211-195.static.zebra.lt ([78.60.211.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 13 Jul 2013 15:27:45 +0200
Received: from grawity by 78-60-211-195.static.zebra.lt with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 13 Jul 2013 15:27:45 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 78-60-211-195.static.zebra.lt
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230281>

I have a clone of linux.git with various stuff added to it (remotes for
'stable' and 'next', a bunch of local tags, and historical repositories
imported using `git replace`).

Yesterday, I noticed that `git describe`, built from git.git master
(v1.8.3.2-804-g0da7a53, gcc 4.8) would simply crash when run in that
repository, with the following backtrace:

> Program terminated with signal 11, Segmentation fault.
> #0  0x00000000004c39dc in hashcpy (sha_src=3D0x1c <Address 0x1c out o=
f bounds>,=20
>     sha_dst=3D0x7fffc0b4d610 "\242\271\301\366 \201&\346\337l\002B\21=
4P\037\210ShX\022")
>     at cache.h:694
> 694		memcpy(sha_dst, sha_src, 20);
> (gdb) bt
> #0  0x00000000004c39dc in hashcpy (sha_src=3D0x1c <Address 0x1c out o=
f bounds>,=20
>     sha_dst=3D0x7fffc0b4d610 "\242\271\301\366 \201&\346\337l\002B\21=
4P\037\210ShX\022")
>     at cache.h:694
> #1  peel_ref (refname=3Drefname@entry=3D0x1fe2d10 "refs/tags/next-201=
30607",=20
>     sha1=3Dsha1@entry=3D0x7fffc0b4d610 "\242\271\301\366 \201&\346\33=
7l\002B\214P\037\210ShX\022") at refs.c:1586
> #2  0x0000000000424194 in get_name (path=3D0x1fe2d10 "refs/tags/next-=
20130607",=20
>     sha1=3D0x1fe2ce8 "\222V\356\276S5\tk\231Hi\264\r=3D\336\315\302\2=
25\347\257\300N\376\327\064@\237ZDq[T\246\312\033T\260\314\362\025refs/=
tags/next-20130607", flag=3D<optimized out>,=20
>     cb_data=3D<optimized out>) at builtin/describe.c:156
> #3  0x00000000004c1c21 in do_one_ref (entry=3D0x1fe2ce0, cb_data=3D0x=
7fffc0b4d7c0)
>     at refs.c:646
> #4  0x00000000004c318d in do_for_each_entry_in_dir (dir=3D0x1fe1728,=20
>     offset=3D<optimized out>, fn=3D0x4c1bc0 <do_one_ref>, cb_data=3D0=
x7fffc0b4d7c0)
>     at refs.c:672
> #5  0x00000000004c33d1 in do_for_each_entry_in_dirs (dir1=3D0x1fdf4d8=
, dir2=3D0x1fd6318,=20
>     cb_data=3D0x7fffc0b4d7c0, fn=3D0x4c1bc0 <do_one_ref>) at refs.c:7=
16
> #6  0x00000000004c33d1 in do_for_each_entry_in_dirs (dir1=3D0x1fdf1f8=
, dir2=3D0x1fd62d8,=20
>     cb_data=3D0x7fffc0b4d7c0, fn=3D0x4c1bc0 <do_one_ref>) at refs.c:7=
16
> #7  0x00000000004c3540 in do_for_each_entry (refs=3Drefs@entry=3D0x7a=
2800 <ref_cache>,=20
>     base=3Dbase@entry=3D0x509cc6 "", cb_data=3Dcb_data@entry=3D0x7fff=
c0b4d7c0,=20
>     fn=3D0x4c1bc0 <do_one_ref>) at refs.c:1689
> #8  0x00000000004c3ff8 in do_for_each_ref (cb_data=3Dcb_data@entry=3D=
0x0, flags=3D1, trim=3D0,=20
>     fn=3Dfn@entry=3D0x424120 <get_name>, base=3D0x509cc6 "", refs=3D0=
x7a2800 <ref_cache>)
>     at refs.c:1724
> #9  for_each_rawref (fn=3Dfn@entry=3D0x424120 <get_name>, cb_data=3Dc=
b_data@entry=3D0x0)
>     at refs.c:1873
> #10 0x0000000000424f5b in cmd_describe (argc=3D0, argv=3D0x7fffc0b4dd=
c0, prefix=3D0x0)
>     at builtin/describe.c:466
> #11 0x000000000040596d in run_builtin (argv=3D0x7fffc0b4ddc0, argc=3D=
1,=20
>     p=3D0x760b40 <commands.21352+576>) at git.c:291
> #12 handle_internal_command (argc=3D1, argv=3D0x7fffc0b4ddc0) at git.=
c:453
> #13 0x0000000000404d6e in run_argv (argv=3D0x7fffc0b4dc78, argcp=3D0x=
7fffc0b4dc5c)
>     at git.c:499
> #14 main (argc=3D1, av=3D<optimized out>) at git.c:575
> (gdb)=20

According to `git bisect`, the first bad commit is:

commit 9a489f3c17d6c974b18c47cf406404ca2a721c87
Author: Michael Haggerty <mhagger@alum.mit.edu>
Date:   Mon Apr 22 21:52:22 2013 +0200

    refs: extract a function peel_entry()

The crash happens only in repositories that have at least one replaced
object in the branch's history. Running `git --no-replace-objects
describe` avoids the crash.

The crash happens only if there are any tags under .git/refs/tags/ that
do not exist in .git/packed-refs, or if I remove all "peeled" lines fro=
m
=2Egit/packed-refs (including the '#' line; /^[#^]/d).

A quick way to reproduce this with git.git master is:

git tag -f test-tag HEAD~10
git replace -f HEAD $(git --no-replace-objects cat-file commit HEAD \
  | sed 's/@/@test/' | git hash-object --stdin -t commit -w)
=2E/git describe

--=20
Mantas Mikul=C4=97nas <grawity@gmail.com>
