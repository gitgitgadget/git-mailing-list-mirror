From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 2/5] Not all vendor diffs support GNUisms (resend)
Date: Thu, 11 Mar 2010 20:23:16 +0100
Message-ID: <4B994324.9060400@lsrfire.ath.cx>
References: <20100311163039.GB7877@thor.il.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
X-From: git-owner@vger.kernel.org Thu Mar 11 20:23:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Npnyv-0001gP-BI
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 20:23:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756073Ab0CKTXf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Mar 2010 14:23:35 -0500
Received: from india601.server4you.de ([85.25.151.105]:49618 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755385Ab0CKTXd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 14:23:33 -0500
Received: from [10.0.1.100] (p57B7CAAE.dip.t-dialin.net [87.183.202.174])
	by india601.server4you.de (Postfix) with ESMTPSA id 154B62F8045;
	Thu, 11 Mar 2010 20:23:25 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <20100311163039.GB7877@thor.il.thewrittenword.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141992>

Am 11.03.2010 17:30, schrieb Gary V. Vaughan:
> Some of the flags used with the first diff found in PATH cause the
> vendor diff to choke.
>=20
> This patch allows us to replace the problematic diff calls in our
> build script as follows:
>=20
>   if [ "${SB_VAR_DIFFUTILS+set}" =3D set ]; then
>     ${SB_PATH_SED} -i -e "\
> s|@DIFF@|${SB_VAR_DIFFUTILS}/bin/gnudiff|g;" \
>     $(find . -type f -exec ${SB_PATH_EGREP} -l '@DIFF@' {} \;)
>   else
>     ${SB_PATH_SED} -i -e "\
> s|@DIFF@|diff|g;" \
>     $(find . -type f -exec ${SB_PATH_EGREP} -l '@DIFF@' {} \;)
>   fi
>=20
> This is fine for us, but upstream it would be better to search
> the execution path for a diff that has all the required features at
> configure time, and to do the substitutions at that time.  This is
> what the latest version of quilt does if an example is useful.
> ---
>  Documentation/install-webdoc.sh |    2 +-
>  contrib/examples/git-commit.sh  |    2 +-
>  contrib/hooks/setgitperms.perl  |    2 +-
>  git-cvsserver.perl              |    4 ++--
>  git-merge-one-file.sh           |    4 +++-
>  git-svn.perl                    |    2 +-
>  t/t0000-basic.sh                |    2 +-
>  t/t1002-read-tree-m-u-2way.sh   |    6 +++---
>  t/t3200-branch.sh               |    4 ++--
>  t/t3210-pack-refs.sh            |    8 ++++----
>  t/t3903-stash.sh                |    2 +-
>  t/t4002-diff-basic.sh           |    2 +-
>  t/t4124-apply-ws-rule.sh        |   10 +++++-----
>  t/t4127-apply-same-fn.sh        |    6 +++---
>  t/t5300-pack-object.sh          |    6 +++---
>  t/t5510-fetch.sh                |    2 +-
>  t/t5520-pull.sh                 |    2 +-
>  t/t5700-clone-reference.sh      |    8 ++++----
>  t/t6000lib.sh                   |    2 +-
>  t/t6001-rev-list-graft.sh       |    2 +-
>  t/t6022-merge-rename.sh         |    4 ++--
>  t/t7002-grep.sh                 |   16 ++++++++--------
>  t/t7005-editor.sh               |    6 +++---
>  t/t9200-git-cvsexportcommit.sh  |   26 +++++++++++++-------------
>  t/t9400-git-cvsserver-server.sh |   24 ++++++++++++------------
>  t/test-lib.sh                   |    2 +-
>  26 files changed, 79 insertions(+), 77 deletions(-)

This patch doesn't seem to add this conversion to git's own build scrip=
t
(Makefile).  That means the patched scripts now call a command named
"@DIFF@", which probably doesn't exist on most systems.

> diff --git a/Documentation/install-webdoc.sh b/Documentation/install-=
webdoc.sh
> index 2135a8e..329d052 100755
> --- a/Documentation/install-webdoc.sh
> +++ b/Documentation/install-webdoc.sh
> @@ -12,7 +12,7 @@ do
>  	then
>  		: did not match
>  	elif test -f "$T/$h" &&
> -	   diff -u -I'Last updated [0-9][0-9]-[A-Z][a-z][a-z]-' "$T/$h" "$h=
"
> +	   @DIFF@ -u -I'Last updated [0-9][0-9]-[A-Z][a-z][a-z]-' "$T/$h" "=
$h"
>  	then
>  		:; # up to date
>  	else

=46or build scripts I think it makes sense to do the same for diff as f=
or
tar, namely to define and export it in Makefile (run "git grep -w TAR"
to see what I mean).

> diff --git a/contrib/examples/git-commit.sh b/contrib/examples/git-co=
mmit.sh
> index 5c72f65..726e102 100755
> --- a/contrib/examples/git-commit.sh
> +++ b/contrib/examples/git-commit.sh
> @@ -576,7 +576,7 @@ then
>  		# Test whether this is just the unaltered template.
>  		if cnt=3D`sed -e '/^#/d' < "$templatefile" |
>  			git stripspace |
> -			diff "$GIT_DIR"/COMMIT_BAREMSG - |
> +			@DIFF@ "$GIT_DIR"/COMMIT_BAREMSG - |
>  			wc -l` &&
>  		   test 0 -lt $cnt
>  		then
> diff --git a/contrib/hooks/setgitperms.perl b/contrib/hooks/setgitper=
ms.perl
> index a577ad0..c45ab0d 100644
> --- a/contrib/hooks/setgitperms.perl
> +++ b/contrib/hooks/setgitperms.perl
> @@ -180,7 +180,7 @@ elsif ($read_mode) {
>  	    rename "$gitmeta.tmp", $gitmeta;
>  	}
>  	else {
> -	    my $diff =3D `diff -U 0 $gitmeta $gitmeta.tmp`;
> +	    my $diff =3D `@DIFF@ -U 0 $gitmeta $gitmeta.tmp`;
>  	    if ($diff ne '') {
>  		rename "$gitmeta.tmp", $gitmeta;
>  	    }

I'm not sure the files in contrib/ should be changed at all, as they ar=
e
not touched by Makefile.

> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> index 13751db..3b78497 100755
> --- a/git-cvsserver.perl
> +++ b/git-cvsserver.perl
> @@ -1716,9 +1716,9 @@ sub req_diff
> =20
>          if ( exists $state->{opt}{u} )
>          {
> -            system("diff -u -L '$filename revision 1.$meta1->{revisi=
on}' -L '$filename " . ( defined($meta2->{revision}) ? "revision 1.$met=
a2->{revision}" : "working copy" ) . "' $file1 $file2 > $filediff");
> +            system("@DIFF@ -u -L '$filename revision 1.$meta1->{revi=
sion}' -L '$filename " . ( defined($meta2->{revision}) ? "revision 1.$m=
eta2->{revision}" : "working copy" ) . "' $file1 $file2 > $filediff");
>          } else {
> -            system("diff $file1 $file2 > $filediff");
> +            system("@DIFF@ $file1 $file2 > $filediff");
>          }
> =20
>          while ( <$fh> )
> diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
> index d067894..826b979 100755
> --- a/git-merge-one-file.sh
> +++ b/git-merge-one-file.sh
> @@ -28,6 +28,8 @@ then
>  	exit 1
>  fi
> =20
> +DIFF=3D"@DIFF@"
> +
>  case "${1:-.}${2:-.}${3:-.}" in
>  #
>  # Deleted in both or deleted in one and unchanged in the other
> @@ -107,7 +109,7 @@ case "${1:-.}${2:-.}${3:-.}" in
>  		# remove lines that are unique to ours.
>  		orig=3D`git-unpack-file $2`
>  		sz0=3D`wc -c <"$orig"`
> -		diff -u -La/$orig -Lb/$orig $orig $src2 | git apply --no-add
> +		$DIFF -u -La/$orig -Lb/$orig $orig $src2 | git apply --no-add
>  		sz1=3D`wc -c <"$orig"`
> =20
>  		# If we do not have enough common material, it is not

Why does this one use $DIFF unlike the others?

> diff --git a/git-svn.perl b/git-svn.perl
> index 1a26843..037bc15 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1592,7 +1592,7 @@ sub find_file_type_and_diff_status {
>  	return ('dir', '') if $path eq '';
> =20
>  	my $diff_output =3D
> -	    command_oneline(qw(diff --cached --name-status --), $path) || "=
";
> +	    command_oneline(qw(@DIFF@ --cached --name-status --), $path) ||=
 "";
>  	my $diff_status =3D (split(' ', $diff_output))[0] || "";
> =20
>  	my $ls_tree =3D command_oneline(qw(ls-tree HEAD), $path) || "";

The changed line calls git-diff, not diff; you should keep it as it is.

> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index f4ca4fc..5444527 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -280,7 +280,7 @@ $expectfilter >expected <<\EOF
>  EOF
>  test_expect_success \
>      'validate git diff-files output for a know cache/work tree state=
=2E' \
> -    'git diff-files >current && diff >/dev/null -b current expected'
> +    'git diff-files >current && @DIFF@ >/dev/null -b current expecte=
d'
> =20
>  test_expect_success \
>      'git update-index --refresh should succeed.' \

The earlier comment about exporting a variable named DIFF from Makefile
(and passing it through test-lib.sh) like it's already done with TAR
applies here.

> diff --git a/t/t1002-read-tree-m-u-2way.sh b/t/t1002-read-tree-m-u-2w=
ay.sh
> index 0241329..0330f13 100755
> --- a/t/t1002-read-tree-m-u-2way.sh
> +++ b/t/t1002-read-tree-m-u-2way.sh
> @@ -215,7 +215,7 @@ test_expect_success \
>       if cmp M.sum actual14a.sum; then false; else :; fi &&
>       check_cache_at nitfol clean &&
>       echo nitfol nitfol >nitfol1 &&
> -     diff nitfol nitfol1 &&
> +     @DIFF@ nitfol nitfol1 &&
>       rm -f nitfol1'

Here and for most of the rest of the test scripts using test_cmp
(defined in test-lib.sh) instead of diff directly would be better.

test_cmp calls the command in $GIT_TEST_CMP.  For your OS, you could se=
t
it to "cmp" in Makefile instead of the default "diff -u".

(That also means that test_cmp should only be used in places where the
output is discarded or displayed, not piped into another command which
might expect a certain diff format.)

However, if there are no command line switches given to diff but only
two files, do you need to change anything at all?  Every diff
implementation should be able to handle that, right?

[Lots of test script changes snipped.]

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index a0e396a..cd2c886 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -59,7 +59,7 @@ export GIT_MERGE_VERBOSITY
>  export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
>  export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
>  export EDITOR
> -GIT_TEST_CMP=3D${GIT_TEST_CMP:-diff -u}
> +GIT_TEST_CMP=3D${GIT_TEST_CMP:-@DIFF@}
> =20
>  # Protect ourselves from common misconfiguration to export
>  # CDPATH into the environment

Define GIT_TEST_CMP in Makefile..

(I'd split the introduction of DIFF/$DIFF, the diff -> test_cmp
conversions and the change to set GIT_TEST_CMP=3Dcmp for your platform
into three separate patches.)

Ren=E9
