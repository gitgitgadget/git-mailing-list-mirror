From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v4] git-am: add option to extract email Message-Id: tag
 into commit log
Date: Wed, 02 Jul 2014 17:03:04 +0200
Message-ID: <53B41F28.8040205@web.de>
References: <1404312673-11836-1-git-send-email-avi@cloudius-systems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Avi Kivity <avi@cloudius-systems.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 02 17:03:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2M4H-0008Dh-T4
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 17:03:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754575AbaGBPDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 11:03:09 -0400
Received: from mout.web.de ([212.227.17.12]:62999 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754535AbaGBPDH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 11:03:07 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0Maamb-1XMUJE3w1x-00K4lj; Wed, 02 Jul 2014 17:03:06
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <1404312673-11836-1-git-send-email-avi@cloudius-systems.com>
X-Provags-ID: V03:K0:wHMTFAD4k6MiCrgV+mOuQTgLWZdtnQ0eop0TO133HOTpFxmF0V6
 ER95J78ndLQnumDwfckOnSDrIOg2EmyuLHO/DHZTw/V/31Drgo4JpDx7e8rRJl/QrpLjDiP
 I6LGB1oFOSY2ireb59+KZkbpfvCa6BFAwanEHZQ5aXL0yUyDb/wRtY8/w7wk4udGvgIw4v/
 Xt7xD9tA+T/D2PGwHam5g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252787>

> diff --git a/git-am.sh b/git-am.sh
> index ee61a77..fd0181f 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -39,6 +39,7 @@ committer-date-is-author-date    lie about committer date
>  ignore-date     use current timestamp for author date
>  rerere-autoupdate update the index with reused conflict resolution if possible
>  S,gpg-sign?     GPG-sign commits
> +m,message-id    copy the Message-Id: header to the commit's tag stanza
>  rebasing*       (internal use for git-rebase)"
>  
>  . git-sh-setup
> @@ -371,7 +372,7 @@ split_patches () {
>  prec=4
>  dotest="$GIT_DIR/rebase-apply"
>  sign= utf8=t keep= keepcr= skip= interactive= resolved= rebasing= abort=
> -resolvemsg= resume= scissors= no_inbody_headers=
> +resolvemsg= resume= scissors= no_inbody_headers= message_id=
>  git_apply_opt=
>  committer_date_is_author_date=
>  ignore_date=
> @@ -442,6 +443,8 @@ it will be removed. Please do not use it anymore."
>  		gpg_sign_opt=-S ;;
>  	--gpg-sign=*)
>  		gpg_sign_opt="-S${1#--gpg-sign=}" ;;
> +	-m|--message-id)
> +		message_id=t ;;
>  	--)
>  		shift; break ;;
>  	*)
> @@ -565,6 +568,7 @@ Use \"git am --abort\" to remove it.")"
>  	echo " $git_apply_opt" >"$dotest/apply-opt"
>  	echo "$threeway" >"$dotest/threeway"
>  	echo "$sign" >"$dotest/sign"
> +	echo "$message_id" >"$dotest/message-id"
>  	echo "$utf8" >"$dotest/utf8"
>  	echo "$keep" >"$dotest/keep"
>  	echo "$scissors" >"$dotest/scissors"
> @@ -651,6 +655,10 @@ then
>  else
>  	SIGNOFF=
>  fi
> +if test "$(cat "$dotest/message-id")" = t
Does the usage of '"' inside of '"' look good, or can we write like this:
if test $(cat "$dotest/message-id") = t
