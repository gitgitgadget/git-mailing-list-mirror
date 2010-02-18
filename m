From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] (reverse) combined diff conflict style
Date: Thu, 18 Feb 2010 12:34:31 -0800
Message-ID: <7v1vgi8eqw.fsf@alter.siamese.dyndns.org>
References: <1266521789-3617-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 21:35:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiD5R-0002uA-6G
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 21:35:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753489Ab0BRUes (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 15:34:48 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36607 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383Ab0BRUer (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 15:34:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CEFF49BA48;
	Thu, 18 Feb 2010 15:34:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=ukhIQ4TIyJksz15ZpYz79AWIGNE=; b=qPvUVPkvte77vLS1Zrr2XNB
	OTxYYCaJEYP1WYYEvshanLBoG3fDTNr4QPfYdK8abJ54+4zM7OL0dT4k5oJInCwv
	oFh030q7Ed11HZCEtNqF2Ha86WqWTj1QPnyNNUn02JFjmfroCYLjLrJwrsBxuFY6
	bwjm7R30R9emZ6u6IJ9o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=EhQ0EIunDG+x+2H+O0XNTK9qjr7wR874mnH9k3RsGFRyuqWbs
	xD7wfmNQAQD+OV0Nj0oElGJ4+xZCQkWbqzyGccaZk1UFf1k+Z1cQmTBYE9gNnhjt
	u696ngpBzwoHSPzKzgXbCxmW1REJNfGbBYX3bEuNphPxeZ9TZy8E3EVqeg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 867959BA45;
	Thu, 18 Feb 2010 15:34:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 419A19BA3A; Thu, 18 Feb
 2010 15:34:32 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 09E05BF4-1CCD-11DF-94BA-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140376>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> ----- output ----
>
> 1
> <<<<<<<
>  -2
> - 3
> >>>>>>>
> 4
>
> ------ end ------
>
> As you can see, the conflict region is way smaller as the diff3 one, but
> keeps all information.
>
> I'm not doing much merges myself, so there are probably people out there who
> can better judge the usefulness of this style.

As a format to review conflicted regions in a pager, this might be a good
alternative representation.

But I doubt I would want to use this as a way for "git merge", "git am -3"
and their friends to write a half-merged result out to the work tree for
me to resolve.  With either --conflict=merge or --conflict=diff3, it is
easy to pick lines from either side (you remove what is not needed in the
final result), but with this format you always have to not just pick but
remove the change marker at the beginning from the "these are good, I'd
use them" lines.  And you have to do so for every single line you reuse
from either side.
