From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 5/7] completion: get rid of compgen
Date: Fri, 12 Apr 2013 11:06:31 -0700
Message-ID: <7vhajbei8o.fsf@alter.siamese.dyndns.org>
References: <1365577077-12648-1-git-send-email-felipe.contreras@gmail.com>
 <1365577077-12648-6-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 20:06:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQiMx-0003JJ-Rj
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 20:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756585Ab3DLSGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 14:06:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52909 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756562Ab3DLSGe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 14:06:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB27815123;
	Fri, 12 Apr 2013 18:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4UR4AWhtLFdFZOoUH9OBOFvpLH4=; b=RDL8T0
	h9YuiRldpD8hA89b0/j1wmV4SuoOv0CShkgGSV+I6f5zIgYMdhI6/XtTJa+DXhib
	Fv/t5MVeAVuwKb3yX3jwmvpE4Q6C77UaKBMEkv0kJ75LYiNPxb3uXWCgGkUXWtNs
	4FPYqxwF/4f91XFraWzYSxzOM2McY2Tt3R3iM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kwkJWZ1eikXqTozIN92Gi6ibHcVpnEl0
	xBXZ1kOzLk8Fy2zwvr3T6Y84p9vCR+nURAuWO0Bh4tiimahw/pivizr5JOeTpJTW
	q0yDJKiSEOzbl0EvlJjmPp8fevZw5hAnLMYp+jivxD89Eux76fmRuTd6TxRc1/p2
	QBXDYcJfWH4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F8BD15122;
	Fri, 12 Apr 2013 18:06:33 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0166A1511F; Fri, 12 Apr
 2013 18:06:32 +0000 (UTC)
In-Reply-To: <1365577077-12648-6-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Wed, 10 Apr 2013 01:57:55 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B53831B8-A39B-11E2-807E-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221008>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Here are some numbers filtering N amount of words:

Nice table.  "N amount of words" sounded somewhat funny to me, but I
am not a native.

> ...
>   == 1000 ==
>   original: 0.012s
>   new: 0.011s
>   == 10000 ==
>   original: 0.056s
>   new: 0.066s
>   == 100000 ==
>   original: 2.669s
>   new: 0.622s
>
> If the results are not narrowed:
> ...
>   == 1000 ==
>   original: 0.020s
>   new: 0.015s
>   == 10000 ==
>   original: 0.101s
>   new: 0.355s
>   == 100000 ==
>   original: 2.850s
>   new: 31.941s
>
> So, unless 'git checkout <tab>' usually gives you more than 100000
> results, you'll get an improvement :)

Nice numbers.  I think you meant 10000 not 100000 here.

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 90b54ab..d8009f5 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -197,11 +197,16 @@ fi
>  
>  __gitcompadd ()
>  {
> -	COMPREPLY=($(compgen -W "$1" -P "$2" -S "$4" -- "$3"))
> +	local i=0
> +	for x in $1; do
> +		if [[ "$x" == "$3"* ]]; then
> +			COMPREPLY[i++]="$2$x$4"
> +		fi
> +	done
>  }

Nice; can't be simpler than that ;-)
