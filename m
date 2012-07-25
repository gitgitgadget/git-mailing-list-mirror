From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make 'git submodule update --force' always check out
 submodules.
Date: Wed, 25 Jul 2012 11:44:04 -0700
Message-ID: <7vipdbbs0b.fsf@alter.siamese.dyndns.org>
References: <1343239412-26780-1-git-send-email-szager@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stefan Zager <szager@google.com>
To: Jens Lehmann <Jens.Lehmann@web.de>, Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Jul 25 20:44:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su6ZD-0005Xl-0K
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 20:44:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372Ab2GYSoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 14:44:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65337 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750826Ab2GYSoI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 14:44:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09E089B7C;
	Wed, 25 Jul 2012 14:44:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ILv73jCB0aCmpGguPwJTEfnQ4FU=; b=uMYhA4
	K9H3RVxb/7NWkjruNBWk0xtOKi8yrVrVMtLjVj1r6E5L+HgAHiGVycfKPCNfOVhR
	nKaE423h1qn0yAvQIO70fThsS1FQhZ5vtEoI8BmR8tdRNE1FwrjvOHkvgKPkT/eP
	TVLmLZy7SpHsXf0G3VHyL1zNnothz802QRSKY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nxi4ojXXozrovRTF3rcMQ8QCbjhjpZzO
	8bNO5Q7O3NJ8q9X0OnovuC8NG8DwBH1MqhIij1zyGSWwN7xDMuTJ/G8tuyzIySOX
	75H+pCsxNg0YEE3xu1xgAlxhkANWa+iUNDPWFHTyC3vX3IupmPst1UnktQLFHTta
	Xh+2WyIIhpc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB0E09B7B;
	Wed, 25 Jul 2012 14:44:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 520B89B7A; Wed, 25 Jul 2012
 14:44:06 -0400 (EDT)
In-Reply-To: <1343239412-26780-1-git-send-email-szager@google.com> (Stefan
 Zager's message of "Wed, 25 Jul 2012 11:03:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B67E2B58-D688-11E1-B875-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202185>

Stefan Zager <szager@google.com> writes:

> Currently, it will only do a checkout if the sha1 registered in the containing
> repository doesn't match the HEAD of the submodule, regardless of whether the
> submodule is dirty.  As discussed on the mailing list, the '--force' flag is a
> strong indicator that the state of the submodule is suspect, and should be reset
> to HEAD.
>
> Signed-off-by: Stefan Zager <szager@google.com>
> ---

Looks sensible (again -- see http://thread.gmane.org/gmane.comp.version-control.git/197532
for the original discussion).  Can submodule folks Ack it?

Thanks.


>  git-submodule.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index dba4d39..621eff7 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -575,7 +575,7 @@ Maybe you want to use 'update --init'?")"
>  			die "$(eval_gettext "Unable to find current revision in submodule path '\$sm_path'")"
>  		fi
>  
> -		if test "$subsha1" != "$sha1"
> +		if test "$subsha1" != "$sha1" -o -n "$force"
>  		then
>  			subforce=$force
>  			# If we don't already have a -f flag and the submodule has never been checked out
