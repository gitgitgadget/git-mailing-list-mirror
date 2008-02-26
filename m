From: Johan Herland <johan@herland.net>
Subject: Re: [RFC] Build in clone
Date: Tue, 26 Feb 2008 13:58:33 +0100
Message-ID: <200802261358.33357.johan@herland.net>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org> <alpine.LSU.1.00.0802261111460.17164@racer.site> <200802261319.41862.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Kristian =?utf-8?q?H=C3=B8gsberg?= <krh@redhat.com>,
	Santi =?utf-8?q?B=C3=A9jar?= <sbejar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 26 14:00:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTzPd-000578-U9
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 14:00:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753171AbYBZM7Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Feb 2008 07:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753095AbYBZM7Y
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 07:59:24 -0500
Received: from sam.opera.com ([213.236.208.81]:34204 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752597AbYBZM7X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 07:59:23 -0500
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id m1QCwXnG027503
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 26 Feb 2008 12:58:33 GMT
User-Agent: KMail/1.9.7
In-Reply-To: <200802261319.41862.johan@herland.net>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.91.1/6003/Tue Feb 26 11:34:31 2008 on smtp.opera.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75135>

On Tuesday 26 February 2008, Johan Herland wrote:
> [1] Verbose output from t5700-clone-reference.sh:
>=20
> $ ./t5700-clone-reference.sh --verbose
> * expecting success: test_create_repo A && cd A &&
> echo first > file1 &&
> git add file1 &&
> git commit -m initial
> Created initial commit 8c40535: initial
>  1 files changed, 1 insertions(+), 0 deletions(-)
>  create mode 100644 file1
> *   ok 1: preparing first repository
>=20
> * expecting success: git clone A B && cd B &&
> echo second > file2 &&
> git add file2 &&
> git commit -m addition &&
> git repack -a -d &&
> git prune
> Initialize B/.git
> Initialized empty Git repository in B/.git/
> Okay
> Get for /home/johanh/git-test/git/t/trash/A/.git
> 0x714f50
> HEAD
> refs/heads/master
> work tree now /home/johanh/git-test/git/t/trash/B
> Created commit 4f5d964: addition
>  1 files changed, 1 insertions(+), 0 deletions(-)
>  create mode 100644 file2
> Counting objects: 6, done.
> Compressing objects: 100% (3/3), done.
> Writing objects: 100% (6/6), done.
> Total 6 (delta 0), reused 0 (delta 0)
> *   ok 2: preparing second repository
>=20
> * expecting success: git clone -l -s --reference B A C
> Initialize C/.git
> Initialized empty Git repository in C/.git/
> Okay
> Wrote /home/johanh/git-test/git/t/trash/B/.git/objects
>  to C/.git/objects/info/alternates
> 4f5d96490c0371a2814efb3203ed699ef4814fda -> C/.git/refs/reference-tmp=
/4f5d96490c0371a2814efb3203ed699ef4814fda
> error: refs/remotes/origin/HEAD does not point to a valid object!
> error: Z;n=EF=BF=BD+ does not point to a valid object!
> error: Z;n=EF=BF=BD+ does not point to a valid object!
> error: =EF=BF=BDp does not point to a valid object!
> error: Z;n=EF=BF=BD+ does not point to a valid object!
> error: Z;n=EF=BF=BD+ does not point to a valid object!
> error: Y;n=EF=BF=BD+ does not point to a valid object!
> error: q does not point to a valid object!
> ./test-lib.sh: line 193: 32376 Segmentation fault      git clone -l -=
s --reference B A C
> * FAIL 3: cloning with reference (-l -s)
>         git clone -l -s --reference B A C

Running this test with GDB, I get the following backtrace:

#0  0x0000000000474b87 in is_null_sha1 (sha1=3D0x100000008 <Address 0x1=
00000008 out of bounds>) at cache.h:464
#1  0x0000000000474ad3 in do_one_ref (base=3D0x4dc8ff "refs/", fn=3D0x4=
19471 <setup_tmp_ref>, trim=3D0, cb_data=3D0x7498d0, entry=3D0xffffffff=
) at refs.c:474
#2  0x0000000000474e28 in do_for_each_ref (base=3D0x4dc8ff "refs/", fn=3D=
0x419471 <setup_tmp_ref>, trim=3D0, cb_data=3D0x7498d0) at refs.c:558
#3  0x0000000000474ecd in for_each_ref (fn=3D0x419471 <setup_tmp_ref>, =
cb_data=3D0x7498d0) at refs.c:580
#4  0x0000000000419706 in setup_reference (repo=3D0x745070 "C/.git") at=
 builtin-clone.c:211
#5  0x0000000000419fce in cmd_clone (argc=3D2, argv=3D0x7fff7a282fa0, p=
refix=3D0x0) at builtin-clone.c:422
#6  0x0000000000404ba3 in run_command (p=3D0x6ff710, argc=3D7, argv=3D0=
x7fff7a282fa0) at git.c:248
#7  0x0000000000404d55 in handle_internal_command (argc=3D7, argv=3D0x7=
fff7a282fa0) at git.c:378
#8  0x0000000000404ebe in main (argc=3D7, argv=3D0x7fff7a282fa0) at git=
=2Ec:442

Seems the "loose" ref_list in do_for_each_ref() becomes corrupted.

Will investigate more later.


=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
