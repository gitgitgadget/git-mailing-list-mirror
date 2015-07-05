From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 02/12] t4150: am fails if index is dirty
Date: Sun, 05 Jul 2015 17:38:25 +0200
Organization: gmx
Message-ID: <eb790f13314192dcf4787c54d4cd3cfb@www.dscho.org>
References: <1435861000-25278-1-git-send-email-pyokagan@gmail.com>
 <1435861000-25278-3-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 05 17:38:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBm06-0000YP-9C
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jul 2015 17:38:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751569AbbGEPid (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jul 2015 11:38:33 -0400
Received: from mout.gmx.net ([212.227.17.22]:59663 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751325AbbGEPic (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jul 2015 11:38:32 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LnxVE-1YW7eU1Vo8-00fxSW; Sun, 05 Jul 2015 17:38:26
 +0200
In-Reply-To: <1435861000-25278-3-git-send-email-pyokagan@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:XYMu81+r04K9cuYGB8Tsqxug5DPGkgOs/UsEjVDWR/Z8ogrpOzz
 Hs5NhjnnT07TmULtUMonpEhW5zFnPEF4VucmZeFwC+DRnUh70ZMVfLR3J9cw6mdJibpMYXI
 WzaF/HX/bNEKABdO20ZB9mLE/5ltUhzoCQnRos+VDnei1fxDc8Tb6urxdXy7AoczZX9t24V
 i7KQQp8jvmvm3Q33PPZnA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0HN5zC656sk=:cV/CsDJpQ0ym1b61wAnN+N
 FncOsNQ9DpxlgikNwX2BhF0PvbIm2pjf4t7wJmlUbdIUTpvdaZXDvRGMrgqS8T8/XgXI0beEB
 9+eSR0z2+mXrgtMJ2sliOcn14hfMYvaIN4IoAQ6F3OtfHKiE7pVtziri8jZdl5aZCgdNq6CO9
 wJ7pXalqS6SBXwsOWxvKVP4iTYFkp9HwKM0q9OriCRS3WCOrUaipVcU0VWhByiHgtlytxkQBX
 qLXyPby0BGLOagf3wI4RqWS99i0EbDFtgc95ZcHxSQNN4/fJ+/1+gXiLLwQ0fs4ygtpKNi8Ny
 /vq4Y4Fw/gQF3OV0NbP/dKU3xy7B1rokI3HpwyhCyfzaNgSgPNmW3K6v+fnNo2jmAzc6jDs7a
 yCfy1Z67jBaO+Xjv5Hv7tV9yBXoM1LxekCwChXWD8aRRO+EDwOXQuzuKW7SFmVxkzd3SAxCd3
 Vez/K9UceUpUrGxrD8EAxFJul+vIZR0QSjHO/iFZT7iLIWXxHrRVJGqOGWYgqnrGARIECk0rl
 S2w9x93YPIrBDgY/dirRIBKNuhNWz26axULY9SsQOUPzOiBXTobUwpYtNaFQLLhR57kIBEdEC
 34wpq8EsZAfQj44ZtIyrgMbp+FcEWsAbMQ4CIKefnUeYRHLLjYRA1uFRlidDHjbYfe9OeWxpC
 +wb0ezwynJCbeHYQPtJBSghXY4qcDymla3XJKusizAT15fCcXyvwaka0Z9ATFZtRMCKI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273366>

Hi Paul,

On 2015-07-02 20:16, Paul Tan wrote:

> diff --git a/t/t4150-am.sh b/t/t4150-am.sh
> index 3f54bdf..0a19136 100755
> --- a/t/t4150-am.sh
> +++ b/t/t4150-am.sh
> @@ -154,6 +154,17 @@ test_expect_success 'am applies patch correctly' '
>  	test "$(git rev-parse second^)" = "$(git rev-parse HEAD^)"
>  '
>  
> +test_expect_success 'am fails if index is dirty' '
> +	test_when_finished "rm -fr dirtyfile" &&

Seeing as you `git add` that file further down, how about `git rm -f dirtfile` here?

> +	rm -fr .git/rebase-apply &&
> +	git checkout -f first &&
> +	echo dirtyfile >dirtyfile &&
> +	git add dirtyfile &&
> +	test_must_fail git am patch1 &&
> +	test_path_is_dir .git/rebase-apply &&
> +	test_cmp_rev first HEAD

Ciao,
Dscho
