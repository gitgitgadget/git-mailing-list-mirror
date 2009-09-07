From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-rebase-interactive: avoid breaking when
 GREP_OPTIONS="-H"
Date: Mon, 07 Sep 2009 12:37:30 -0700
Message-ID: <7v7hwar1fp.fsf@alter.siamese.dyndns.org>
References: <1252328160-4359-1-git-send-email-carenas@sajinet.com.pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe>
X-From: git-owner@vger.kernel.org Mon Sep 07 21:37:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mkk24-0005Q0-Iu
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 21:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbZIGThf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 15:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbZIGThf
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 15:37:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34089 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbZIGThe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 15:37:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1071723968;
	Mon,  7 Sep 2009 15:37:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YjqHzzyGtih525rcxZuyIvqN1p4=; b=p21xC/
	xZLlWKRnehNj5TSOUObppmyt9x5W4KHCRx4kri4x9wmBJuoZ/vLc2INNRokq3KND
	tzB6KlZXHGxhk6tTiadfb1A6rt46vzRaVvi+Dtnxu1LOY54hIZaCJ1MK44+RVRRN
	OjrVB4wk9J8Y3Orun7woYHYCewoegf6JOfmLE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u7467mIHsJHRlJeBv+l/hSi05OpKDMxC
	wb3f563Zd26BGzrISVkYAsVLfsC0lYDQz550RXGOAZu4kx90poC6/rGbEYg/3bTe
	IcWVa0kmJzeRb35+JugBjrs7cu59Gx7eX1Vf3dsSZ4t+G7XKx6FOFN8FR/IT43kl
	3hvdLnq7T+E=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D5D9A23967;
	Mon,  7 Sep 2009 15:37:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3E87823961; Mon,  7 Sep
 2009 15:37:32 -0400 (EDT)
In-Reply-To: <1252328160-4359-1-git-send-email-carenas@sajinet.com.pe> (Carlo
 Marcelo Arenas Belon's message of "Mon\,  7 Sep 2009 05\:56\:00 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E45581D8-9BE5-11DE-B394-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127944>

Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe> writes:

> if GREP_OPTIONS is set and includes -H, using `grep -c` will fail
> to generate a numeric count and result in the following error :
>
>   /usr/libexec/git-core/git-rebase--interactive: line 110: (standard
>   input):1+(standard input):0: missing `)' (error token is
>   "input):1+(standard input):0")
>
> instead of grep counting use `wc -l` to return the line count.

Thanks.

How does your patch help when the user has GREP_OPTIONS=-C3 in the
environment?

I think a saner workaround for this user environment bug (or GNU grep
misfeature) is to unset GREP_OPTIONS at the beginning of the script, or
even in git-sh-setup.
