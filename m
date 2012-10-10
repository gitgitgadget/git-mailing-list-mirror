From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Allow __git_ps1 to be used in PROMPT_COMMAND
Date: Wed, 10 Oct 2012 16:00:59 -0700
Message-ID: <7vlife9bkk.fsf@alter.siamese.dyndns.org>
References: <7v7gr0k6jv.fsf@alter.siamese.dyndns.org>
 <20121010193158.GA6454@simaj.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, git@drmicha.warpmail.net, spearce@spearce.org,
	artagnon@gmail.com, schwab@linux-m68k.org, soosthoek@nieuwland.nl
To: Simon Oosthoek <s.oosthoek@xs4all.nl>
X-From: git-owner@vger.kernel.org Thu Oct 11 01:18:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TM5Xr-00037c-FY
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 01:18:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755650Ab2JJXSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 19:18:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53423 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757931Ab2JJXBD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 19:01:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D6A583B6;
	Wed, 10 Oct 2012 19:01:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bWeMJlg/Y6JRWUFgJBbAObMKx8c=; b=lNna+1
	jL4BW2EyJR/SIT7QfgEJBArpDv2ptOLs0aFdjNYPpcslbuEnqBxTaXjQ9u1z8+w6
	Xg/yK9gxVHqDSjLhTKspAtT1z2qaVxFZX2yH8Na5nRHmazRuWJ8YWQLP/m+rJ49+
	8023GbeVtu3VAJ+gXai3Rv8dzfwaQMM3fylz8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pB/Hf5Mbwzl4ftUFdEoXDBwlrJ0iZCP4
	5svm83RXpvcPNfmyh9YbbbGzWMOVXKZ4qkrTDk8MzLKQ942aSialdmnrBLMcGef8
	8kaNr+snvQJrkEH8sN1AO4JAc/1ObcXQUKxtJqbqjl6AtVZ/S1Nsbo2Yk9A7Mn6j
	ki+fshydYpA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A10C83B5;
	Wed, 10 Oct 2012 19:01:02 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8568383B1; Wed, 10 Oct 2012
 19:01:01 -0400 (EDT)
In-Reply-To: <20121010193158.GA6454@simaj.xs4all.nl> (Simon Oosthoek's
 message of "Wed, 10 Oct 2012 21:31:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5C803780-132E-11E2-8F60-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207451>

Simon Oosthoek <s.oosthoek@xs4all.nl> writes:

>  __git_ps1 ()
>  {
> +	local pcmode=no
> +	#defaults/examples:
> +	local ps1pc_start='\u@\h:\w '
> +	local ps1pc_end='\$ '
> +	local printf_format='(%s)'
> + ...

This conversion is wrong, given that ...

> @@ -284,6 +317,12 @@ __git_ps1 ()
>  		fi
>  
>  		local f="$w$i$s$u"
> -		printf -- "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r$p"

... the original has a SP in front.  I've tentatively queued a
fix-up patch on the topic branch before merging it to 'pu'.

> +		if [ $pcmode = yes ]; then
> +			PS1="$ps1pc_start("
> +			PS1="$PS1$c${b##refs/heads/}${f:+ $f}$r$p"
> +			PS1="$PS1)$ps1pc_end"
> +		else
> +			printf -- "$printf_format" "$c${b##refs/heads/}${f:+ $f}$r$p"
> +		fi
>  	fi
>  }
