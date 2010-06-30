From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] rerere: fix overeager gc
Date: Wed, 30 Jun 2010 08:22:25 -0700
Message-ID: <7v7hlg8s0e.fsf@alter.siamese.dyndns.org>
References: <1277811498-17288-1-git-send-email-szeder@ira.uka.de>
 <7vy6dx90uk.fsf@alter.siamese.dyndns.org> <4C2AE04E.9090901@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jun 30 17:22:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTz7a-0003oL-JH
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 17:22:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756701Ab0F3PWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jun 2010 11:22:37 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49820 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756673Ab0F3PWg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 11:22:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C61A9C07F7;
	Wed, 30 Jun 2010 11:22:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VqnuhaK3pWrbt8/0cyR3XsY7bc8=; b=oR+FQl
	YV9e5EsJ/JngkxAfsdfWFuQUcXS4j9/0vRj0fuS7EoLrNMho3lKZTRUKCpUNsO0M
	iannjlxmxtuINwhW9ThioNglqEhHLGzQ/61Z6pfvJBkekRu78eXYpn0LaCd687wX
	3/kGINo98lM54baUv7YqnS2eHTOFDanNiehFw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i+QG3ibVKsrWPY9ZHxqi8yxjUhiFw5Rw
	dW5fEprb3B855f4KNr89g/xmfYPdm7aYfp9K3R7o4wm8dS40Me6mp/6pBlZ4SOUI
	8RgOfWc9qsErB+sHK1f30MUv7yyykajjYBeNvOUTbnPu2vx0rdC769OWDNXA4pOr
	+tKZS0O8j+Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D05FC07F5;
	Wed, 30 Jun 2010 11:22:31 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3412DC07EC; Wed, 30 Jun
 2010 11:22:27 -0400 (EDT)
In-Reply-To: <4C2AE04E.9090901@viscovery.net> (Johannes Sixt's message of
 "Wed\, 30 Jun 2010 08\:12\:30 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4CCBE974-845B-11DF-A9C5-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149963>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 6/29/2010 19:59, schrieb Junio C Hamano:
>> One possibility is to look at the timestamp of the directory itself
>> instead.  Then we can safely gc otherwise-unused "thisimage" file when
>> rerere is not in use.  I wonder if directory m_time timestamps are usable
>> for this purpose on non-POSIX platforms?
>
> I don't think that will work at all: We only use fopen() to write
> thisimage, which only truncates the file, but doesn't modify mtime of the
> directory. Nor do we create any other (temporary) directory entries that
> would modify the mtime.

Ah, I see; I don't mind a patch that fixes the creation of thisimage to
follow the "create into temporary and then commit by renaming" pattern.

Would that solve this issue?
