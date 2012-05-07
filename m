From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v4 1/6] completion: add new __git_complete helper
Date: Mon, 07 May 2012 11:51:33 -0700
Message-ID: <7vfwbb6czu.fsf@alter.siamese.dyndns.org>
References: <1336353800-17323-1-git-send-email-felipe.contreras@gmail.com>
 <1336353800-17323-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 07 20:51:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRT25-0000QV-OA
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 20:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757382Ab2EGSvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 14:51:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35000 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751486Ab2EGSvg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 14:51:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6358D768C;
	Mon,  7 May 2012 14:51:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YOnXywRzbcDrd3LcpfJT7vWiqwc=; b=m3nVlV
	SjkzlJC5GNJ9e6rMc1C1Rdr9NoRjrp6diVZtvuACQ+L3L/POhr9n6La/4cIhC6MK
	1Mh/FNxI34iUZS42WxNIfjrLdT80ChwslZvAIdpQVwpn7tLgtvctNta9lBvRiuwg
	6P4lzRqza01G2OlOo+VsBMcxkzhiWYRmV2CAM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DZyQlo0A9M0YQ5RgjSa4m+LzzGMxy+tY
	2fgvqIJcc3t65rMvfJkLtRtzXdS9s4jgs9uV3sJ/XsH/ar9w5JAyeTFKpOHPcZR2
	JhvNWviGIUcLDxZo6ruTfiSEYHkgoa18tzR404MoZKf8s3p2n6sfQC00u3/7N84P
	91cGhgAJ0q4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A3A6768B;
	Mon,  7 May 2012 14:51:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AFC86768A; Mon,  7 May 2012
 14:51:34 -0400 (EDT)
In-Reply-To: <1336353800-17323-2-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Mon, 7 May 2012 03:23:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AB1E5A86-9875-11E1-B08F-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197294>

Felipe Contreras <felipe.contreras@gmail.com> writes:


> +# this is NOT a public function; use at your own risk
> +__git_complete ()

The comment is enough to scare away people who might use it and then come
back to complain when this changes its implementation detail, but saying
"This is not X" without saying "This does Y" does not help those who want
to contribute updates to git-completion script.  Is there a short and
sweet description of what this is for and/or what this does?

> +{
> +	local name="${2-$1}"
> +	local wrapper="_${name}_wrap"
> +	eval "$wrapper () { __git_func_wrap $name ; }"
> +	complete -o bashdefault -o default -o nospace -F $wrapper $1 2>/dev/null \
> +		|| complete -o default -o nospace -F $wrapper $1
> +}
> +
> +__git_complete git
> +__git_complete gitk
>  
>  # The following are necessary only for Cygwin, and only are needed
>  # when the user has tab-completed the executable name and consequently
>  # included the '.exe' suffix.
>  #
>  if [ Cygwin = "$(uname -o 2>/dev/null)" ]; then
> -complete -o bashdefault -o default -o nospace -F _git git.exe 2>/dev/null \
> -	|| complete -o default -o nospace -F _git git.exe
> +__git_complete git.exe git
>  fi
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 5bda6b6..331a5b9 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -63,7 +63,7 @@ run_completion ()
>  	local _cword
>  	_words=( $1 )
>  	(( _cword = ${#_words[@]} - 1 ))
> -	_git && print_comp
> +	_git_wrap && print_comp
>  }
>  
>  test_completion ()
