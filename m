From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] submodule update: continue when a checkout fails
Date: Thu, 09 Jun 2011 10:21:42 -0700
Message-ID: <7vlixayl7d.fsf@alter.siamese.dyndns.org>
References: <1307605623-2831-1-git-send-email-iveqy@iveqy.com>
 <1307605623-2831-3-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: hvoigt@hvoigt.net, jens.lehmann@web.de, git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 19:22:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUivf-0005eu-FF
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 19:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753791Ab1FIRVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 13:21:54 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56564 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752987Ab1FIRVy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 13:21:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 013CA4A19;
	Thu,  9 Jun 2011 13:24:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=sMZsaJ6OdjUwLFiLRJQhfA2u8XQ=; b=Z46VY3PLQJLJhhz+fSUC
	xidCcebDIaghOUGvqLthnqaFemLahzfy4BTxzzB1priER5xSL8TP6enMZpyvqP6O
	qKGY3GfqlpUwe4j5nbJNujakXK9g4/N1HxQR7Nr7dSmd9uubmptGg5RIvmQcLoEl
	5MR8mSKca/X3eIlvUdk7zqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=wqPE5fIGYzLrHEu2GHQBUBQRdG3hdsALlJFZJUIwlWrfTS
	Y+dV0gsMtUIPKiZnrumdf4HJ683R899Mft4qzW/p2FFGOy/A/f39vltUgttkIJiz
	no+1I6o1UikaqKn3IEBklZhxfff8F2HEzetUEH+zsEeEmo4qs7sH7fE5Vg+4k=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AFC294A18;
	Thu,  9 Jun 2011 13:23:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 424114A17; Thu,  9 Jun 2011
 13:23:52 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 42AD892C-92BD-11E0-9B0E-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175557>

Fredrik Gustafsson <iveqy@iveqy.com> writes:

> +				*)
> +					err="${err} \"Failed to $action in submodule path '$path'\""
> ...
> +					err="${err} \"Failed to recurse into submodule path '$path'\""
> +					continue
> +				else
> +					die_with_status $res "Failed to recurse into submodule path '$path'"
> +				fi
> +			fi
>  		fi
>  	done
> +
> +	if test -n "$err"
> +	then
> +		OIFS=$IFS
> +		IFS=';'
> +		for e in $err

Hmm, I do not see anybody concatenating things with semicolons in between...
Am I reading a right patch?

Also I am puzzled what the double-quotes around each error message are
doing. Are they meant to be shown to the end user?

> +		do
> +			echo $e

Should this go to the standard error output?

> +		done
> +		IFS=$OIFS
> +		die

Do we want to give an extra empty line here with "die"?
