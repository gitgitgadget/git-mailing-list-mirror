From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] difftool: add support for --trust-exit-code
Date: Sun, 26 Oct 2014 08:31:05 +0100
Message-ID: <544CA339.3000401@kdbg.org>
References: <1414286689-62082-1-git-send-email-davvid@gmail.com> <1414287526-80060-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Adri Farr <14farresa@gmail.com>
To: David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 26 08:31:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XiIIa-00081x-9L
	for gcvg-git-2@plane.gmane.org; Sun, 26 Oct 2014 08:31:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbaJZHbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2014 03:31:11 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:57139 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750907AbaJZHbK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2014 03:31:10 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3jQW7J6CGQz5tlB;
	Sun, 26 Oct 2014 08:30:52 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 5B9F719F571;
	Sun, 26 Oct 2014 08:31:06 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.0
In-Reply-To: <1414287526-80060-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.10.2014 um 02:38 schrieb David Aguilar:
> diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
> index 7ef36b9..fdbd768 100755
> --- a/git-difftool--helper.sh
> +++ b/git-difftool--helper.sh
> @@ -62,6 +62,8 @@ launch_merge_tool () {
>  	else
>  		run_merge_tool "$merge_tool"
>  	fi
> +	status=$?
> +	return $status
>  }
>  
>  if ! use_ext_cmd
> @@ -85,5 +87,10 @@ else
>  	do
>  		launch_merge_tool "$1" "$2" "$5"
>  		shift 7
> +		if test "$status" != 0 &&
> +			test "$GIT_DIFFTOOL_TRUST_EXIT_CODE" = true
> +		then
> +			exit $status
> +		fi

If you insert this new code block before the 'shift 7', you can set
status here and do not have to hide it in the helper function.

>  	done
>  fi

-- Hannes
