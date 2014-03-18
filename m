From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] git-rebase: Teach rebase "-" shorthand.
Date: Tue, 18 Mar 2014 20:26:32 +0100
Message-ID: <53289DE8.2070104@web.de>
References: <1395132268-69488-1-git-send-email-modocache@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Brian Gesiak <modocache@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 20:26:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPzew-0007QF-Q4
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 20:26:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757852AbaCRT0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 15:26:44 -0400
Received: from mout.web.de ([212.227.15.3]:57326 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757845AbaCRT0l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 15:26:41 -0400
Received: from [10.0.2.15] ([217.41.18.1]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0LdF0f-1WqYtt0hSj-00iRwj; Tue, 18 Mar 2014 20:26:40
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20131104 Icedove/17.0.10
In-Reply-To: <1395132268-69488-1-git-send-email-modocache@gmail.com>
X-Provags-ID: V03:K0:c2BJLxOFY++Q0XP3FuY3FLuyyvq4cohilznvxXrQ7iE/9OPcw8D
 zvEldWJvyZZn1r1YDbbak2qK9AkbXPCdm+ErLIusKLTgWSoBcWPyh34UQOHrgdob23voAfh
 XFwLHv8aDP5XpZgtgNjnzTkeghSIY2cZWDfdx2XywysO7sQKRQGmZ8Syj4jmxbBlycrQm7K
 dk77EkOmX9SCO8/DZ9+ww==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244371>

On 03/18/2014 09:44 AM, Brian Gesiak wrote:
> Teach rebase the same shorthand as checkout and merge; that is, that "-"
> means "the branch we were previously on".
>
> Reported-by: Tim Chase <git@tim.thechases.com>
> Signed-off-by: Brian Gesiak <modocache@gmail.com>
> ---
>   git-rebase.sh     | 4 ++++
>   t/t3400-rebase.sh | 6 ++++++
>   2 files changed, 10 insertions(+)
>
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 5f6732b..2c75e9f 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -453,6 +453,10 @@ then
>   		test "$fork_point" = auto && fork_point=t
>   		;;
>   	*)	upstream_name="$1"
> +		if test "$upstream_name" = "-"
> +		then
> +			upstream_name="@{-1}"
> +		fi
>   		shift
>   		;;
>   	esac
> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index 6d94b1f..00aba9f 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -88,6 +88,12 @@ test_expect_success 'rebase from ambiguous branch name' '
>   	git rebase master
>   '
>
> +test_expect_success 'rebase using shorthand' '
> +	git checkout master
we schould have the "&&"   ^^
> +	git checkout -b shorthand HEAD^
               we schould have the "&&"  ^^
> +	GIT_TRACE=1 git rebase -
And why the GIT_TRACE ?
> +'
> +
>   test_expect_success 'rebase a single mode change' '
>   	git checkout master &&
>   	git branch -D topic &&
>
