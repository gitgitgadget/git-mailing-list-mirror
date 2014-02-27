From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] difftool: support repositories with .git-files
Date: Thu, 27 Feb 2014 21:12:13 +0000
Message-ID: <530FAA2D.8060104@web.de>
References: <1393211555-50270-1-git-send-email-davvid@gmail.com>	<xmqqr46s9yzx.fsf@gitster.dls.corp.google.com>	<530BB548.3050603@web.de>	<xmqq1tyr6pfw.fsf@gitster.dls.corp.google.com>	<530CFE56.6040807@web.de> <xmqqd2ia6dvo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	=?ISO-8859-1?Q?G=E1bor_Lipt=E1k?= <gabor.liptak@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 22:12:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ8Fi-0004rs-3r
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 22:12:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbaB0VMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 16:12:17 -0500
Received: from mout.web.de ([212.227.15.4]:50099 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751072AbaB0VMR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 16:12:17 -0500
Received: from [192.168.1.102] ([90.174.2.86]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0MS290-1WgnvY36tO-00TD56 for <git@vger.kernel.org>; Thu,
 27 Feb 2014 22:12:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <xmqqd2ia6dvo.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:MwrcM+e8ruOKV6I3gptO9vQXKtpCbV/9EiOK9iU1S5Do8lkBV4J
 UvbUcP9wBKJsxyjJiFxjzYnZqjM4maD/Skydk0K1QBCjBD1r6kJlJYWgyn0JlAxfnEv2mV0
 Yz6Vhl7nDWGBQ/i3D7gmMU4QLGFJeygWAPcmu0lRmaUGfCpNOyc79DaiU17D7LUcbaEeetX
 33lWSM1VBFocbNG1JMlXg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242859>

Am 25.02.2014 22:12, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>>>> +test_expect_success PERL 'difftool properly honours gitlink and core.worktree' '
>>>> +	git submodule add ./. submod/ule &&
>>>> +	(
>>>> +		cd submod/ule &&
>>>> +		git difftool --tool=echo  --dir-diff --cached
>>>
>>> In the context of this fix, finishing with 0 exit status may be all
>>> we care about, but do we also care about things like in what
>>> directory the tool is invoked in, what arguments and extra
>>> environment settings (if any) it is given, and stuff like that?
>>
>> Sure. But I just intended to test the fix (and the test can easily
>> be extended by people who know more about difftool than I do).
> 
> Yes, we need to start somewhere and I'd agree that it was a good
> starting point.
> 
>> Right, using echo was not the best choice here. I used it to avoid
>> the dependency to meld...
> 
> Perhaps like this then?  This is an "a monkey sees what
> difftool_test_setup does and then mimics" patch ;-).

Nicely done :-)

>  t/t7800-difftool.sh | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index 2418528..595f808 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -434,4 +434,17 @@ test_expect_success PERL 'difftool --no-symlinks detects conflict ' '
>  	)
>  '
>  
> +test_expect_success PERL 'difftool properly honours gitlink and core.worktree' '
> +	git submodule add ./. submod/ule &&
> +	(
> +		cd submod/ule &&
> +		git config diff.tool checktrees &&
> +		git config difftool.checktrees.cmd '\''
> +			test -d "$LOCAL" && test -d "$REMOTE"
> +		'\'' &&
> +		echo further >>file &&
> +		git difftool --tool=checktrees --dir-diff
> +	)
> +'
> +
>  test_done
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
