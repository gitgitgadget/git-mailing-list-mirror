From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Interested in helping open source friends on HP-UX?
Date: Wed, 18 Feb 2015 18:46:04 +0100
Message-ID: <54E4CFDC.40401@drmicha.warpmail.net>
References: <xmqq4mt2fx2m.fsf@gitster.dls.corp.google.com> <20150218170007.784be6aa@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 18:46:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YO8hU-0001Uw-9q
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 18:46:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754429AbbBRRqJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Feb 2015 12:46:09 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:53021 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752598AbbBRRqH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Feb 2015 12:46:07 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 583BC21F58
	for <git@vger.kernel.org>; Wed, 18 Feb 2015 12:46:06 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Wed, 18 Feb 2015 12:46:06 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=/+bJGIWG6m2ARQy656zgSz
	90CT8=; b=WLB8+27cdByBgEAr3YnqdC3v6b4T1wJVtdS3OGpRAShSr1rhhYVbw+
	0ql57Gx7v3Vp199jElKab0ir+uLJzpo3Oa1YPhPgAEtv6yhUv7f/j1n6z6/6qOZ1
	xI9GpoyDVCy5/PsdKoPB++imOA8qSWPd9ZtyauPqNnqqZlFND+3p8=
X-Sasl-enc: +T0/9mTaD/+Ki8kXIZGhFItGQ+EL0q0ZPw+HCmxIKNmd 1424281565
Received: from localhost.localdomain (unknown [88.70.121.210])
	by mail.messagingengine.com (Postfix) with ESMTPA id 8890EC002A2;
	Wed, 18 Feb 2015 12:46:05 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <20150218170007.784be6aa@pc09.procura.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264034>

H.Merijn Brand venit, vidit, dixit 18.02.2015 17:00:
> On Wed, 10 Dec 2014 23:46:25 -0800, Junio C Hamano <gitster@pobox.com=
>
> wrote:
>=20
>> Hello, all.
>>
>> H. Merijn Brand runs a few HP-UX boxes to help perl5 and other open
>> source communities, wants help porting more recent Git on these
>> boxes, running HP-UX 10.20, 11.00, and 11.23, and looking for a
>> volunteer.  Please contact him directly if you are interested.
>=20
> No-one. Disappointing :(

Well, how can we help if we don't even know the limitations of that
platform?

In short, you are putting additional restrictions in by not having GNU
tools around.

> Did *anyone* ever test with NO_ICONV?
> Too many tests fail without iconv

There is iconv the library and iconv the command. With NO_ICONV, many
tests fail for me even on my standard Linux distro. But our tests keep
using iconv the command. The subtests which pass in t3900, for example,
mostly test that certain things fail, for one reason or another...

But we should guard a few tests in case of NO_ICONV, of course, and
probably not use iconv the command in this case either.

>=20
> It is *very* hard to decide from the current status if all
> remaining failures are related to (Asian) locale failures and (thus)
> can be safely ignored (in my environment).
>=20
>=20
> Specifics at the end
>=20
>=20
> FAILures from scratch with no iconv:
> ---------------------------------------------------------------------=
-----------
> t3513-revert-submodule.sh       Tests: 14 Failed:  5 Failed tests: 1-=
2, 4, 6-7                   TODO passed:   10-11
> t3900-i18n-commit.sh            Tests: 34 Failed:  8 Failed tests: 15=
-17, 23-25, 27-28
> t3901-i18n-patch.sh             Tests: 15 Failed:  8 Failed tests: 2-=
3, 6-7, 9, 11, 14-15
> t4041-diff-submodule-option.sh  Tests: 44 Failed:  5 Failed tests: 5-=
7, 9-10
> t4201-shortlog.sh               Tests: 11 Failed:  1 Failed tests: 9
> t4204-patch-id.sh               Tests: 15 Failed:  3 Failed tests: 7,=
 10, 13
> t4205-log-pretty-formats.sh     Tests: 46 Failed: 20 Failed tests: 12=
-14, 17, 19, 21, 23-29, 31, 33, 35, 37 39, 41-42
> t4210-log-i18n.sh               Tests:  5 Failed:  4 Failed tests: 2-=
5
> t5100-mailinfo.sh               Tests: 35 Failed: 11 Failed tests: 20=
-30
> t5570-git-daemon.sh             Tests: 12 Failed:  2 Failed tests: 4-=
5      Parse errors: No plan found in TAP output
> t6006-rev-list-format.sh        Tests: 54 Failed: 11 Failed tests: 9-=
10, 12, 25-27, 30-34
> t6041-bisect-submodule.sh       Tests: 14 Failed:  9 Failed tests: 1-=
2, 4-7, 12-14               TODO passed:   10-11
> t7001-mv.sh                     Tests: 46 Failed:  2 Failed tests: 38=
-39
> t7102-reset.sh                  Tests: 30 Failed:  1 Failed tests: 2
> t7610-mergetool.sh              Tests: 18 Failed:  1 Failed tests: 18
> t7800-difftool.sh               Tests: 56 Failed:  1 Failed tests: 49
> t8005-blame-i18n.sh             Tests:  5 Failed:  3 Failed tests: 2-=
4
> t9350-fast-export.sh            Tests: 34 Failed:  1 Failed tests: 4
> Files=3D687, Tests=3D12091
>=20
> FAILures from scratch with iconv:
> ---------------------------------------------------------------------=
-----------
> t3513-revert-submodule.sh       Tests: 14 Failed:  5 Failed tests: 1-=
2, 4, 6-7                   TODO passed:   10-11
> t3900-i18n-commit.sh            Tests: 34 Failed:  6 Failed tests: 16=
-17, 24-25, 27-28
> t4204-patch-id.sh               Tests: 15 Failed:  3 Failed tests: 7,=
 10, 13
> t4210-log-i18n.sh               Tests:  5 Failed:  4 Failed tests: 2-=
5
> t5100-mailinfo.sh               Tests: 35 Failed:  2 Failed tests: 20=
, 23
> t5536-fetch-conflicts.sh        Tests:  7 Failed:  3 Failed tests: 3,=
 6-7
> t5570-git-daemon.sh             Tests: 12 Failed:  2 Failed tests: 4-=
5      Parse errors: No plan found in TAP output
> t6041-bisect-submodule.sh       Tests: 14 Failed:  9 Failed tests: 1-=
2, 4-7, 12-14               TODO passed:   10-11
> t7001-mv.sh                     Tests: 46 Failed:  2 Failed tests: 38=
-39
> t7610-mergetool.sh              Tests: 18 Failed:  1 Failed tests: 18
> t7800-difftool.sh               Tests: 56 Failed:  1 Failed tests: 49
> t8005-blame-i18n.sh             Tests:  5 Failed:  3 Failed tests: 2-=
4
> Files=3D687, Tests=3D12091
> Result: FAIL
>=20
> running =C2=ABsh t****.sh -x -i=C2=BB
>=20
>=20
> t/t7001-mv.t
> ------------
> cp uses -P flag, which is unknown to HP's (non-GNU) version of cp
>=20
> Changing the two occurrences from
>=20
> 		cp -R -P -p ../.git/modules/sub .git &&
> to
> 		rsync -aHl ../.git/modules/sub/ .git/ &&
>=20
> make the tests pass (on those systems that have a working rsync)

"rsync -r -l -o -p -t" would be the proper equivalent. -aH does more fo=
r
my rsync. I don't know what HP-UX rsync understands, though.

> t/t3513-revert-submodule.sh
> ---------------------------
> tar uses z flag, which is unknown to HP's (non-GNU) version of tar
> config.mak.uname defines TAR =3D gtar, but that obviously does not he=
lp
>=20
> putting GNU-tar temporary in from of my $PATH makes the test pass
> /me thinks the z in not required in that test at all
>=20
> 	tar cf "$TRASH_DIRECTORY/tmp.tar" * &&
> and
> 	tar xf "$TRASH_DIRECTORY/tmp.tar" &&
>=20
> work just as well and prevent the breakage

We can do without z.

> t/t3900-i18n-commit.sh
> ----------------------
> As my HP boxes have *NO* JP or other space eating asian locale stuff
> installed, it is highly likely that *anything* dealing with asian
> locales will fail. On modern Linux hardware, disk space is cheap. On
> most HP-UX boxes disk space is expensive and when having nothing to d=
o
> with Asian languages, removing all Asian-related packages is a fast a=
nd
> cheap way to regain disk space.
>=20
> Changing compare_with to
>=20
> compare_with () {
>     case "$1$2$3" in
> 	*eucJP*|*ISO-2022-JP*) true ;;
> 	*)
> 	    git show -s $1 | sed -e '1,/^$/d' -e 's/^    //' >current &&
> 	    case "$3" in
> 		'')
> 		    test_cmp "$2" current ;;
> 		?*)
> 		    iconv -f "$3" -t UTF-8 >current.utf8 <current &&
> 		    iconv -f "$3" -t UTF-8 >expect.utf8 <"$2" &&
> 		    test_cmp expect.utf8 current.utf8
> 		    ;;
> 		esac
> 	    ;;
> 	esac
>     }
>=20
> makes all my tests pass

So you do have iconv the command, but don't want to link with the libra=
ry?

Availability of the locales should be covered by a prerequisite, like w=
e
do in t9129.

> t/t4204-patch-id.sh
> -------------------
>=20
> No idea yet
>=20
> + test_patch_id_file_order irrelevant --stable --stable
> Already on 'same'
> cmp: patch-id_ordered-ordered-order---stable-irrelevant: No such file=
 or directory
>=20
> $ find * | grep 4204 | grep stable
> trash directory.t4204-patch-id/patch-id_order---stable-irrelevant
> trash directory.t4204-patch-id/patch-id_ordered-order---stable-irrele=
vant

The "Already"-part is normal output. The rest looks a bit crazy - and
shell related?

> t/t4210-log-i18n
> ----------------
>=20
> $ dump "trash directory.t4210-log-i18n/actual"
> 00000000  75 74 66 38 0A                                      utf8.
> $ dump "trash directory.t4210-log-i18n/expect"
> 00000000  6C 61 74 69 6E 31 0A 75  74 66 38 0A                latin1.=
utf8.
> $ dump "trash directory.t4210-log-i18n/msg"
> 00000000  6C 61 74 69 6E 31 0A 0A  74 E9 73 74 0A             latin1.=
=2Et.st.
>=20
> t/t5100-mailinfo.sh
> -------------------
> + git mailinfo -u rfc2047/0001-msg rfc2047/0001-patch
> + 0< rfc2047/0001 1> rfc2047/0001-info
> fatal: cannot convert from US-ASCII to UTF-8
> error: last command exited with $?=3D128

Is that mailinfo erroring out? Do you have those locales?

OK, I'll have to stop fishing in the dark here.

> t/t5536-fetch-conflicts.sh
> --------------------------
> + setup_repository ccc +refs/heads/branch1:refs/remotes/origin/branch=
1 +refs/heads/branch2:refs/remotes/origin/branch1
> Initialized empty Git repository in /pro/3gl/LINUX/git-2.3.0p/t/trash=
 directory.t5536-fetch-conflicts/ccc/.git/
> + cd ccc
> + test_must_fail git fetch origin
> + 2> error
> + verify_stderr
> + 0< /var/tmp/sh6096.2
> cmp: EOF on actual
> error: last command exited with $?=3D1
> not ok 3 - fetch conflict: config vs. config
>=20
> t/t5570-git-daemon.sh
> ---------------------
> I will ignore this myself, as I have no intention of using HP-UX as a
> git server. We already have a dedicated Linux box doing so.
>=20
> + test_cmp file clone/file
> ok 3 - clone git repository
>=20
> expecting success:
>         echo content >>file &&
>         git commit -a -m two &&
>         git push public &&
>         (cd clone && git pull) &&
>         test_cmp file clone/file
>=20
> + echo content
> + 1>> file
> + git commit -a -m two
>=20
> arg sulong failed. 0, 0x9fffffffbffff058
>=20
>  Setup args failed.
>=20
> Pid 6238 was killed due to failure in writing to user register stack =
- possible stack overflow.
> [master bca99f0] two
>  Author: A U Thor <author@example.com>
>  1 file changed, 1 insertion(+)
> + git push public
>=20
> t/t6041-bisect-submodule.sh
> ---------------------------
> config.mak.uname defines TAR =3D gtar, but that obviously does not he=
lp
>=20
> + git_bisect add_sub1
> tar: z: unknown option
> tar: usage  tar [-]{txruc}[eONvVwAfblhm{op}][0-7[lmh]] [tapefile] [bl=
ocksize] [[-C directory] file] ...
>=20
> changing my $PATH to have a GNU tar in front makes all tests pass
>=20
>=20
> t/t7610-mergetool.sh
> --------------------
> HP-UX' mktemp obviously is not compatible with GNU mktemp (which I ha=
ve
> not installed/available on HP-UX)
>=20
>  SYNOPSIS
>       mktemp [-c] [-d directory_name] [-p prefix]
>=20
> Resolved 'subdir/file3' using previous resolution.
> Automatic merge failed; fix conflicts and then commit the result.
> + git mergetool --no-prompt --tool myecho -- both
> + 1> actual
> error: mktemp is needed when 'mergetool.writeToTemp' is true
> error: last command exited with $?=3D1
> not ok 18 - temporary filenames are used with mergetool.writeToTemp
>=20
>=20
> t/t7800-difftool.sh
> -------------------
> HP-UX doesn't have readlink
>=20
> + git difftool --dir-diff --symlink --extcmd ./.git/CHECK_SYMLINKS br=
anch HEAD
> ./.git/CHECK_SYMLINKS: line 5: readlink: command not found
> ./.git/CHECK_SYMLINKS: line 5: readlink: command not found
> ./.git/CHECK_SYMLINKS: line 5: readlink: command not found
> /pro/3gl/LINUX/git-2.3.0p/git-difftool line 472: No such file or dire=
ctory
> fatal: 'difftool' appears to be a git command, but we were not
> able to execute it. Maybe git-difftool is broken?
> error: last command exited with $?=3D128
> not ok 49 - difftool --dir-diff --symlink without unstaged changes
>=20
>=20
> t/t8005-blame-i18n.sh
> ---------------------
> SJIS again, I DO NOT CARE!
>=20
> + 1> actual
> + test_cmp actual expected
> actual expected differ: char 56, line 3
> error: last command exited with $?=3D1
> not ok 2 - blame respects i18n.commitencoding
>=20
