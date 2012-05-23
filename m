From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v4 1/2] submodule: document handling of relative superproject
 origin URLs
Date: Wed, 23 May 2012 22:58:16 +0200
Message-ID: <4FBD4F68.90305@web.de>
References: <1337791554-31294-1-git-send-email-jon.seymour@gmail.com> <1337791554-31294-2-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 23 22:58:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXIde-00077Y-AR
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 22:58:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760602Ab2EWU63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 16:58:29 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:46647 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759791Ab2EWU63 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 16:58:29 -0400
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate01.web.de (Postfix) with ESMTP id 75D7A1AE9B5FB
	for <git@vger.kernel.org>; Wed, 23 May 2012 22:58:27 +0200 (CEST)
Received: from [192.168.178.48] ([91.3.160.4]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0LeLmv-1RhVH20AZR-00q8uu; Wed, 23 May 2012 22:58:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <1337791554-31294-2-git-send-email-jon.seymour@gmail.com>
X-Provags-ID: V02:K0:0dbahl16Bd1ZyQjZ7E/Jh9SjBmAP0YdM54q7/EGxexR
 /h8aD9GGzUfiQjsvyavZpexi+d18RaN38+xEpgY2fbd6W7C6my
 fkDej1NRioJYLYglENovWipbWROg/EGlJdRavyFfgR80vzMbkL
 U2zUiTvKqX5VsgxGNUzsNdRWKLQyfG2+MhjPrs7KXxTWJsq7MU
 Xaif/PRmKjehhs7ixolOw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198323>

Maybe the subject should rather be:
"submodule: document failures handling relative superproject origin URLs"

Am 23.05.2012 18:45, schrieb Jon Seymour:
> These tests document how submodule sync and init handle various
> kinds of relative super project origin URLs.  The submodule URL
> path is ../subrepo.
> 
> 6 cases are documented:
>   foo
>   foo/bar
>   ./foo
>   ./foo/bar
>   ../foo
>   ../foo/bar

Nice test coverage!

> Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
> ---
>  t/t7400-submodule-basic.sh | 62 +++++++++++++++++++++++++++++++++++++++++++++
>  t/t7403-submodule-sync.sh  | 63 +++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 124 insertions(+), 1 deletion(-)
> 
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index 81827e6..97e7a73 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -507,6 +507,68 @@ test_expect_success 'relative path works with user@host:path' '
>  	)
>  '

But please use test_expect_failure for all tests that fail due to
current bugs and document what should succeed in the commands used
inside the test case (just like you did in v3). The only change
needed when the bug is fixed should be changing each
test_expect_failure to test_expect_success.

> +test_expect_success 'relative path works with foo' "
> +	(
> +		cd reltest &&
> +		cp pristine-.git-config .git/config &&
> +		git config remote.origin.url foo &&
> +		echo \"cannot strip one component off url 'foo'\" >expect &&
> +		test_must_fail git submodule init 2>actual &&
> +		cat actual &&
> +		test_cmp expect actual
> +	)
> +"
> +
> +test_expect_success 'relative path works with foo/bar' '
> +	(
> +		cd reltest &&
> +		cp pristine-.git-config .git/config &&
> +		git config remote.origin.url foo/bar &&
> +		git submodule init &&
> +		test "$(git config submodule.sub.url)" = foo/subrepo
> +	)
> +'
> +
> +test_expect_success 'relative path works with ./foo' '
> +	(
> +		cd reltest &&
> +		cp pristine-.git-config .git/config &&
> +		git config remote.origin.url ./foo &&
> +		git submodule init &&
> +		test "$(git config submodule.sub.url)" = ./subrepo
> +	)
> +'
> +
> +test_expect_success 'relative path works with ./foo/bar' '
> +	(
> +		cd reltest &&
> +		cp pristine-.git-config .git/config &&
> +		git config remote.origin.url ./foo/bar &&
> +		git submodule init &&
> +		test "$(git config submodule.sub.url)" = ./foo/subrepo
> +	)
> +'
> +
> +test_expect_success 'relative path works with ../foo' '
> +	(
> +		cd reltest &&
> +		cp pristine-.git-config .git/config &&
> +		git config remote.origin.url ../foo &&
> +		git submodule init &&
> +		test "$(git config submodule.sub.url)" = ../subrepo
> +	)
> +'
> +
> +test_expect_success 'relative path works with ../foo/bar' '
> +	(
> +		cd reltest &&
> +		cp pristine-.git-config .git/config &&
> +		git config remote.origin.url ../foo/bar &&
> +		git submodule init &&
> +		test "$(git config submodule.sub.url)" = ../foo/subrepo
> +	)
> +'
> +
>  test_expect_success 'moving the superproject does not break submodules' '
>  	(
>  		cd addtest &&
> diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
> index 3620215..3784c9b 100755
> --- a/t/t7403-submodule-sync.sh
> +++ b/t/t7403-submodule-sync.sh
> @@ -26,7 +26,9 @@ test_expect_success setup '
>  	(cd super-clone && git submodule update --init) &&
>  	git clone super empty-clone &&
>  	(cd empty-clone && git submodule init) &&
> -	git clone super top-only-clone
> +	git clone super top-only-clone &&
> +	git clone super relative-clone &&
> +	(cd relative-clone && git submodule update --init)
>  '
>  
>  test_expect_success 'change submodule' '
> @@ -86,4 +88,63 @@ test_expect_success '"git submodule sync" should not vivify uninteresting submod
>  	)
>  '
>  
> +test_expect_success '"git submodule sync" handles origin URL of the form foo' "
> +	(cd relative-clone &&
> +	 git remote set-url origin foo
> +	 echo \"cannot strip one component off url 'foo'\" > expect &&
> +	 test_must_fail git submodule sync 2> actual &&
> +	 test_cmp expect actual
> +	)
> +"
> +
> +test_expect_success '"git submodule sync" handles origin URL of the form foo/bar' '
> +	(cd relative-clone &&
> +	 git remote set-url origin foo/bar
> +	 git submodule sync &&
> +	(cd submodule &&
> +	 test "$(git config remote.origin.url)" == "foo/submodule"
> +	)
> +	)
> +'
> +
> +test_expect_success '"git submodule sync" handles origin URL of the form ./foo' '
> +	(cd relative-clone &&
> +	 git remote set-url origin ./foo
> +	 git submodule sync &&
> +	(cd submodule &&
> +	 test "$(git config remote.origin.url)" == "./submodule"
> +	)
> +	)
> +'
> +
> +test_expect_success '"git submodule sync" handles origin URL of the form ./foo/bar' '
> +	(cd relative-clone &&
> +	 git remote set-url origin ./foo/bar
> +	 git submodule sync &&
> +	(cd submodule &&
> +	 test "$(git config remote.origin.url)" == "./foo/submodule"
> +	)
> +	)
> +'
> +
> +test_expect_success '"git submodule sync" handles origin URL of the form ../foo' '
> +	(cd relative-clone &&
> +	 git remote set-url origin ../foo
> +	 git submodule sync &&
> +	(cd submodule &&
> +	 test "$(git config remote.origin.url)" == "../submodule"
> +	)
> +	)
> +'
> +
> +test_expect_success '"git submodule sync" handles origin URL of the form ../foo/bar' '
> +	(cd relative-clone &&
> +	 git remote set-url origin ../foo/bar
> +	 git submodule sync &&
> +	(cd submodule &&
> +	 test "$(git config remote.origin.url)" == "../foo/submodule"
> +	)
> +	)
> +'
> +
>  test_done
