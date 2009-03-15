From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] Tests: use test_cmp instead of diff where possible
Date: Sun, 15 Mar 2009 19:42:48 +0100
Message-ID: <49BD4C28.4030303@lsrfire.ath.cx>
References: <1237124036-1348-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Mar 15 19:44:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LivJz-0004fy-UU
	for gcvg-git-2@gmane.org; Sun, 15 Mar 2009 19:44:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654AbZCOSm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2009 14:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbZCOSm6
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Mar 2009 14:42:58 -0400
Received: from india601.server4you.de ([85.25.151.105]:50292 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476AbZCOSm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2009 14:42:57 -0400
Received: from [10.0.1.101] (p57B7C9F4.dip.t-dialin.net [87.183.201.244])
	by india601.server4you.de (Postfix) with ESMTPSA id 43DB42F8050;
	Sun, 15 Mar 2009 19:42:54 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <1237124036-1348-1-git-send-email-vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113293>

Miklos Vajna schrieb:
> Several old tests were written before test_cmp was introduced, convert
> these to test_cmp.
> 
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
> 
> I intentionally did not touch t5000 - using test_cmp -r works for me,
> since the default is diff -u, but that would break the setup of users
> where GIT_TEST_CMP is set to cmp.
> 
>  t/t0000-basic.sh                    |    8 ++++----
>  t/t1100-commit-tree-options.sh      |    2 +-
>  t/t1400-update-ref.sh               |    6 +++---
>  t/t3000-ls-files-others.sh          |    4 ++--
>  t/t3010-ls-files-killed-modified.sh |    4 ++--
>  t/t5000-tar-tree.sh                 |    2 +-
>  t/t9001-send-email.sh               |    2 +-
>  7 files changed, 14 insertions(+), 14 deletions(-)

You _did_ touch t5000, and converted one of the diff calls.  I agree
that the ones using the option -r should stay, but the rest could be
switched to test_cmp, too.

>
> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index 70df15c..4837300 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -127,7 +127,7 @@ cat >expected <<\EOF
>  EOF
>  test_expect_success \
>      'validate git ls-files output for a known tree.' \
> -    'diff current expected'
> +    'test_cmp current expected'

While you're changing this, you could switch the order of the two files,
for consistency.  If expected comes first, the command shows how the
test result deviates from the correct output.

>  
>  test_expect_success \
>      'writing tree out with git write-tree.' \
> @@ -147,7 +147,7 @@ cat >expected <<\EOF
>  EOF
>  test_expect_success \
>      'git ls-tree output for a known tree.' \
> -    'diff current expected'
> +    'test_cmp current expected'

Same here.

>  
>  # This changed in ls-tree pathspec change -- recursive does
>  # not show tree nodes anymore.
> @@ -166,7 +166,7 @@ cat >expected <<\EOF
>  EOF
>  test_expect_success \
>      'git ls-tree -r output for a known tree.' \
> -    'diff current expected'
> +    'test_cmp current expected'

Same here.

>  
>  # But with -r -t we can have both.
>  test_expect_success \
> @@ -187,7 +187,7 @@ cat >expected <<\EOF
>  EOF
>  test_expect_success \
>      'git ls-tree -r output for a known tree.' \
> -    'diff current expected'
> +    'test_cmp current expected'

Same here.

>  
>  test_expect_success \
>      'writing partial tree out with git write-tree --prefix.' \
> diff --git a/t/t1100-commit-tree-options.sh b/t/t1100-commit-tree-options.sh
> index 7f7fc36..c4414ff 100755
> --- a/t/t1100-commit-tree-options.sh
> +++ b/t/t1100-commit-tree-options.sh
> @@ -40,6 +40,6 @@ test_expect_success \
>  
>  test_expect_success \
>      'compare commit' \
> -    'diff expected commit'
> +    'test_cmp expected commit'
>  
>  test_done
> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index bd58926..54ba3df 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -137,7 +137,7 @@ $B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150860 +0000
>  EOF
>  test_expect_success \
>  	"verifying $m's log" \
> -	"diff expect .git/logs/$m"
> +	"test_cmp expect .git/logs/$m"
>  rm -rf .git/$m .git/logs expect
>  
>  test_expect_success \
> @@ -168,7 +168,7 @@ $B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150980 +0000
>  EOF
>  test_expect_success \
>  	"verifying $m's log" \
> -	'diff expect .git/logs/$m'
> +	'test_cmp expect .git/logs/$m'
>  rm -f .git/$m .git/logs/$m expect
>  
>  git update-ref $m $D
> @@ -272,7 +272,7 @@ $h_FIXED $h_MERGED $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117151100 +0000	c
>  EOF
>  test_expect_success \
>  	'git commit logged updates' \
> -	"diff expect .git/logs/$m"
> +	"test_cmp expect .git/logs/$m"
>  unset h_TEST h_OTHER h_FIXED h_MERGED
>  
>  test_expect_success \
> diff --git a/t/t3000-ls-files-others.sh b/t/t3000-ls-files-others.sh
> index bc0a351..304dd02 100755
> --- a/t/t3000-ls-files-others.sh
> +++ b/t/t3000-ls-files-others.sh
> @@ -42,7 +42,7 @@ test_expect_success \
>  
>  test_expect_success \
>      'git ls-files --others should pick up symlinks.' \
> -    'diff output expected1'
> +    'test_cmp output expected1'

Same here.

>  
>  test_expect_success \
>      'git ls-files --others --directory to show output.' \
> @@ -51,6 +51,6 @@ test_expect_success \
>  
>  test_expect_success \
>      'git ls-files --others --directory should not get confused.' \
> -    'diff output expected2'
> +    'test_cmp output expected2'

Same here.

>  
>  test_done
> diff --git a/t/t3010-ls-files-killed-modified.sh b/t/t3010-ls-files-killed-modified.sh
> index ec14040..4f5375e 100755
> --- a/t/t3010-ls-files-killed-modified.sh
> +++ b/t/t3010-ls-files-killed-modified.sh
> @@ -75,7 +75,7 @@ EOF
>  
>  test_expect_success \
>      'validate git ls-files -k output.' \
> -    'diff .output .expected'
> +    'test_cmp .output .expected'

Same here.

>  
>  test_expect_success \
>      'git ls-files -m to show modified files.' \
> @@ -91,6 +91,6 @@ EOF
>  
>  test_expect_success \
>      'validate git ls-files -m output.' \
> -    'diff .output .expected'
> +    'test_cmp .output .expected'

And here.

>  
>  test_done
> diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
> index b7e3628..bfd593c 100755
> --- a/t/t5000-tar-tree.sh
> +++ b/t/t5000-tar-tree.sh
> @@ -76,7 +76,7 @@ test_expect_success \
>  
>  test_expect_success \
>      'git archive vs. git tar-tree' \
> -    'diff b.tar b2.tar'
> +    'test_cmp b.tar b2.tar'
>  
>  test_expect_success \
>      'git archive in a bare repo' \
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 08d5b91..4fcc2e1 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -88,7 +88,7 @@ cat >expected <<\EOF
>  EOF
>  test_expect_success \
>      'Verify commandline' \
> -    'diff commandline1 expected'
> +    'test_cmp commandline1 expected'

And here, too.

>  
>  cat >expected-show-all-headers <<\EOF
>  0001-Second.patch
