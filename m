From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Questions/investigations on git-subtree and tags
Date: Fri, 08 Mar 2013 09:23:13 -0800
Message-ID: <7vboathkla.fsf@alter.siamese.dyndns.org>
References: <1027208424.206728.1362672550530.JavaMail.root@openwide.fr>
 <349468457.245193.1362760197563.JavaMail.root@openwide.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Campbell <pcampbell@kemitix.net>, git@vger.kernel.org
To: Jeremy Rosen <jeremy.rosen@openwide.fr>
X-From: git-owner@vger.kernel.org Fri Mar 08 18:23:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UE11E-0005ix-05
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 18:23:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933621Ab3CHRXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 12:23:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34517 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933174Ab3CHRXR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 12:23:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36C1BB29E;
	Fri,  8 Mar 2013 12:23:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q8R9eMsoVaU5W4wfStLDZWF/FvI=; b=RnnFBK
	y5RBxM5NReUqRVaqyAIXzvhHKqWerTLCz9MhJj4IeFlsxsr4yeLrS/hVStHyntUy
	ieQ4jL0JDkssS51t43K3KK5UrukX7Cox/qpbCpyuT50f5tGBWhbspppEZ/QfBtrW
	8J9h0yr23S4GpuVJMNIXvTukclP8kmshA82+M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UDbGZ25GDaRsVn33jLwCtWZmSFZwL1Fx
	Pp7A3EsP+GmZLlcRIbTq+hzDNaSszku7FMOQ77YPEEEWs6+dv73F4XfiFndXKVaL
	HR5LvlNJvoNMX4dVY3PLpxQwQfe11KycXmetoRE+scNkJ4IfoKqDybJ35IUUV+4W
	/m1mQIEkqT0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29889B29D;
	Fri,  8 Mar 2013 12:23:16 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 89D10B29B; Fri,  8 Mar 2013
 12:23:15 -0500 (EST)
In-Reply-To: <349468457.245193.1362760197563.JavaMail.root@openwide.fr>
 (Jeremy Rosen's message of "Fri, 8 Mar 2013 17:29:57 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DC90922A-8814-11E2-AC67-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217669>

Jeremy Rosen <jeremy.rosen@openwide.fr> writes:

> 506,513c506,507
> < 		case "$2" in
> < 		*\**) # Avoid pulling in multiple branches
> < 			die "'$2' contains a wildcard"
> < 			;;
> < 		*:*) # Don't create a local branch for the subtree
> < 			die "'$2' contains a local branch name"
> < 			;;
> < 		esac
> ---
>> 		git ls-remote --exit-code $1 $2 ||

You would need to quote $1 and $2 properly to prevent the shell from
splitting them into words, no?

>> 		die "'$2' is not a correct reference on '$1'"

> 535c529
> < 	revs=$(git rev-parse $default --revs-only "$@") || exit $?
> ---
>> 	revs=$(git rev-parse $default --revs-only "$1^{commit}") || exit $?

Is it guaranteed that your $# is 1 at this point, or is it something
you would also need to check here, or perhaps in the caller of this
function (I cannot tell offhand in a patch without any context)?
