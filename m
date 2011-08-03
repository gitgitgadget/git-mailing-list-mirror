From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add technical documentation about ref iteration
Date: Wed, 03 Aug 2011 12:10:37 -0700
Message-ID: <7vei12b9aq.fsf@alter.siamese.dyndns.org>
References: <20110803180319.GA13057@sandbox-rc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Aug 03 21:10:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qogq6-00023r-BR
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 21:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755375Ab1HCTKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 15:10:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53588 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754568Ab1HCTKk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 15:10:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AE01475E;
	Wed,  3 Aug 2011 15:10:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+mrYFyD0Fak1DAL3DJZeCDxwHD8=; b=gsUc3e
	py/Wv6+XpHpBh+6EM75lOgUR2uOi+D+gpCxMthb3Q2Ei7QDnJR7q4F1CYMrSI+o2
	PlE0KJU0qX15uZyGY4qAlyIPOkCvHaE8EDAy9aaLdQS5T+E5ozJXOGsEirzUOgvf
	33u4xJ+/avUdKfufLoxODwwjgNDVPn5RMtHiw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GwCPoTUaFE4Im2S3OUnQnlAgjXtA8ga3
	s0qdP2C+m7izGfvGtQs7ISncrPKgreVdOwhkXbfJf0wvf/eFZyD/F29S6fAJ1bvE
	9no+4GE1Jra3dp+0QMUsvjs39xSj3BQVi8+GKbjTuR9b9Ydt3yi0Mr4BfFAmmzMo
	UVmRoogp0Zw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4063A475D;
	Wed,  3 Aug 2011 15:10:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 96A31475B; Wed,  3 Aug 2011
 15:10:38 -0400 (EDT)
In-Reply-To: <20110803180319.GA13057@sandbox-rc> (Heiko Voigt's message of
 "Wed, 3 Aug 2011 20:03:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 461899F4-BE04-11E0-B406-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178610>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> ---
>  Documentation/technical/api-ref-iteration.txt |   73 +++++++++++++++++++++++++
>  1 files changed, 73 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/technical/api-ref-iteration.txt

> +Submodules
> +----------
> +
> +If you want to iterate the refs of a submodule you first need to call
> +
> +	add_submodule_odb(submodule)
> +
> +and test whether that succeeds.

Hmm, this should probably be explained a bit deeper or not at all. For
example, what is "submodule" here? A path to the submodule directory? The
name of submodule? What is the unwanted consequence of adding this extra
object database into your process (e.g. you can no longer tell if an
object exists in the superproject, as it may now come from the submodule's
object database)? Can you get rid of it? How does this function signal
failures? What is the symptom if you forget this call and used the
iteration in the submodule (e.g. "we do not see any ref"; "we see only
some ref but not all"; "the call crashes the process")?

> +
> +(Heiko Voigt)

Please drop this line for two reasons.

Initially I added these parenthesized names at the end for placeholder
pages to name people who are responsible for the _code_ the document
describes, so that the ones who help documentation would know who to nag
to get the necessary information. With your description, people who are
interested in documenting this API more would know that for_each_ref() and
friends are the topic and can find out whom to harrass.

Besides, with only two commits to refs.c, I doubt you would want to be the
primary source of information for other people to bug in order to enhance
the API description in this file.

Thanks.
