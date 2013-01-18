From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: t9902 fails (Was:  [PATCH] attr: fix off-by-one directory component
 length calculation)
Date: Fri, 18 Jan 2013 06:20:59 +0100
Message-ID: <50F8DBBB.7040005@web.de>
References: <1358256924-31578-1-git-send-email-pclouds@gmail.com> <20130115232400.GA16147@sigill.intra.peff.net> <50F64597.2070100@web.de> <201301172347.50157.avila.jn@gmail.com> <20130118000454.GI13449@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?SmVhbi1Ob8OrbCBBVklMQQ==?= <avila.jn@gmail.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org,
	=?UTF-8?B?Tmd1eQ==?= =?UTF-8?B?4buFbiBUaMOhaSBOZ+G7jWMgRHV5?= 
	<pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 06:21:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tw4OZ-0004hl-0m
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 06:21:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782Ab3ARFVS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jan 2013 00:21:18 -0500
Received: from mout.web.de ([212.227.17.11]:61641 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750720Ab3ARFVR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2013 00:21:17 -0500
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0MMn1H-1TrN111X6l-008BqV; Fri, 18 Jan 2013 06:21:00
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <20130118000454.GI13449@google.com>
X-Provags-ID: V02:K0:mAZZJD4geMKYgoiWaSadtkS4xlrbr6j6rHmjGndBLru
 i9bh5zuxMtpUFrPBpk8/T2xxB22FOwo4lhgYpDq8CTeXJy+TNc
 5YHPGdR3ja3VFJ0zk7AsVAtSKaFWtK7YhnQWBdBwpNnaVt8xfw
 te4rnMq/M+7oO+aLv6JZp2K/b7mPZ2pRKuKxcRvxdGAFwQeJK0
 BGVW6hg86gmoHglzBeKjg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213904>

On 18.01.13 01:04, Jonathan Nieder wrote:
> Jean-No=C3=ABl AVILA wrote:
>
>> OK. I have installed practically everything related to git from the =
package=20
>> manager and there is a git-checkout-branches utility available.
>>
>> That result defeats the purpose of the test. This needs a tighter en=
vironment=20
>> to work whatever the configuration of the user may be.
> Presumably 'git checkout-branches' is from git-stuff.
>
> Here's a patch to make the tested command a little less likely to
> conflict with commands from the user's $PATH.  I'm not thrilled with
> it because the contents of $PATH are still not tightly controlled, an=
d
> this does nothing to avoid problems due to existence of, for example,
> a "git cherry-pick-branches" command.
>
> Thoughts?  Maybe it would be enough to check that the intended get
> commands are present in the completion list and other git commands ar=
e
> not, ignoring binaries that might live elsewhere on the $PATH?
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  t/t9902-completion.sh | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 3cd53f8..06dcfb2 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -192,19 +192,19 @@ test_expect_success 'general options' '
>  '
> =20
>  test_expect_success 'general options plus command' '
> -	test_completion "git --version check" "checkout " &&
> -	test_completion "git --paginate check" "checkout " &&
> -	test_completion "git --git-dir=3Dfoo check" "checkout " &&
> -	test_completion "git --bare check" "checkout " &&
> -	test_completion "git --help des" "describe " &&
> -	test_completion "git --exec-path=3Dfoo check" "checkout " &&
> -	test_completion "git --html-path check" "checkout " &&
> -	test_completion "git --no-pager check" "checkout " &&
> -	test_completion "git --work-tree=3Dfoo check" "checkout " &&
> -	test_completion "git --namespace=3Dfoo check" "checkout " &&
> -	test_completion "git --paginate check" "checkout " &&
> -	test_completion "git --info-path check" "checkout " &&
> -	test_completion "git --no-replace-objects check" "checkout "
> +	test_completion "git --version cherry-p" "cherry-pick " &&
> +	test_completion "git --paginate cherry-p" "cherry-pick " &&
> +	test_completion "git --git-dir=3Dfoo cherry-p" "cherry-pick " &&
> +	test_completion "git --bare cherry-p" "cherry-pick " &&
> +	test_completion "git --help cherry-p" "cherry-pick " &&
> +	test_completion "git --exec-path=3Dfoo cherry-p" "cherry-pick " &&
> +	test_completion "git --html-path cherry-p" "cherry-pick " &&
> +	test_completion "git --no-pager cherry-p" "cherry-pick " &&
> +	test_completion "git --work-tree=3Dfoo cherry-p" "cherry-pick " &&
> +	test_completion "git --namespace=3Dfoo cherry-p" "cherry-pick " &&
> +	test_completion "git --paginate cherry-p" "cherry-pick " &&
> +	test_completion "git --info-path cherry-p" "cherry-pick " &&
> +	test_completion "git --no-replace-objects cherry-p" "cherry-pick "
>  '
> =20
>  test_expect_success 'setup for ref completion' '
That looks good to me, thanks.
