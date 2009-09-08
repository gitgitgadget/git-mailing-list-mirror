From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] post-receive-email: do not call sendmail if no mail was
 generated
Date: Tue, 08 Sep 2009 14:49:47 -0700
Message-ID: <7v4ordw1hg.fsf@alter.siamese.dyndns.org>
References: <20090908185555.GA3858@lars.home.noschinski.de>
 <1252436418-7660-1-git-send-email-lars@public.noschinski.de>
 <7v4ord19da.fsf@alter.siamese.dyndns.org>
 <20090908205935.GB3858@lars.home.noschinski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	andyparkins@gmail.com, pape@smarden.org
To: Lars Noschinski <lars-2008-2@usenet.noschinski.de>
X-From: git-owner@vger.kernel.org Tue Sep 08 23:50:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml8Zq-0002u6-Ie
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 23:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941AbZIHVuC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 17:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbZIHVuB
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 17:50:01 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60622 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089AbZIHVuA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 17:50:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 63F0D2A119;
	Tue,  8 Sep 2009 17:50:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cG8TjhnF/9v4+ogXVbsc+R8xSec=; b=c2l+MW
	iuXjhyK//PiLhYkS5ucjHlFtLKaohnrMYcmxeCiXrhQzrIFATMUPp16Y7V1QCPtX
	Aok9ij88pIbb7unSwCcnfm8rU82u2YnQuJGKwZKRKrd38aR60TPSwqSECI9ZOxCV
	vOmIS5ONj+ybheR1qbbgMwU0UfKDL3Ch952EE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XlqDQqI9w1f+WvYjyic+EVsNsZfdIe6t
	4xzy8m7RweIIjyQas8zyp4sFLt04BNZG8BzweMDjEpOJMq1C2ElqsF6lMd/+QHDg
	MQx8MVv8YMeJqesxHTcM+QCzJ69YqedLaPZOks/0opJH+3y+6jWcRqY2Ur2BYMiT
	uYjDWZpo8Kw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D9072A113;
	Tue,  8 Sep 2009 17:49:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C6CF2A10A; Tue,  8 Sep
 2009 17:49:49 -0400 (EDT)
In-Reply-To: <20090908205935.GB3858@lars.home.noschinski.de> (Lars
 Noschinski's message of "Tue\, 8 Sep 2009 22\:59\:35 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8D557974-9CC1-11DE-ACD2-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128043>

Lars Noschinski <lars-2008-2@usenet.noschinski.de> writes:

> Actually, there are a two cases in the case statement before, where
> generate_email would return:
>
>     refs/remotes/*,commit)
>         # tracking branch
>         refname_type="tracking branch"
>         short_refname=${refname##refs/remotes/}
>         echo >&2 "*** Push-update of tracking branch, $refname"
>         echo >&2 "***  - no email generated."
>         exit 0
>         ;;
>     *)
>         # Anything else (is there anything else?)
>         echo >&2 "*** Unknown type of update to $refname ($rev_type)"
>         echo >&2 "***  - no email generated"
>         exit 1
>         ;;

Ok, that justifies the existence of the patch.
