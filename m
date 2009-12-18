From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] read-tree: at least one tree-ish argument is
 required
Date: Fri, 18 Dec 2009 11:32:08 -0800
Message-ID: <7voclwxemf.fsf@alter.siamese.dyndns.org>
References: <4B274BDE.8000504@viscovery.net> <4B2B5085.1050906@viscovery.net>
 <7v4onoywws.fsf@alter.siamese.dyndns.org>
 <200912182004.25520.j.sixt@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Dec 18 20:32:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLiYq-0001n4-Au
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 20:32:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbZLRTcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 14:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbZLRTcS
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 14:32:18 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51652 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbZLRTcR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 14:32:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EDF6D8904F;
	Fri, 18 Dec 2009 14:32:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/TW6vHLO6j7TIsVDquMxQJfITKc=; b=C74GkX
	WzvdTHRk9nMBfutJ1PcpIFuOSvzm5sMYlp1J77kmhBEc7hmmhQKecEu8BZv3R8Wr
	+x6GBb4TR7zKRz7GP3O6AiR5k6xuYfBQHWA4qAsThtiV5bMnegYUEymsjbAQ/P4U
	pJ4otbSCcdqLVZc3pnkirSjUTdhK1zbq9dT+k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IJJoorhVXnvjXc51MfvmCD7FGefzeVx8
	mUZ1kYR1ErTymHxWPfsh/tl4zJ0Lkb5I+0NmhZQqzVOmugLvsEHMDqtD0KtjwL9Q
	JgRgl9XFyyEsFWAB92XG8/dpjpCqGXB2hJbLgAjW/g5YvnSL6n+RRynKislhrLJE
	nG2Cz8Exqy0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C60178904E;
	Fri, 18 Dec 2009 14:32:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 193BD8904D; Fri, 18 Dec
 2009 14:32:09 -0500 (EST)
In-Reply-To: <200912182004.25520.j.sixt@viscovery.net> (Johannes Sixt's
 message of "Fri\, 18 Dec 2009 20\:04\:25 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0A81189C-EC0C-11DE-ACD5-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135431>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Sorry to drag you into this discussion, but I felt this change is
> maint-worthy (because the behavior is not only risky, but dangerous).
>
> -- Hannes

In short, that is where we differ, as I don't think it is dangerous at
all in the "maint-worthy" sense.  

"read-tree" without -m is to "populate the index from emptiness with given
trees".  Unless you are hit by the bug in the auto-correction (whose fix
was maint-worthy), nobody would say read-tree without parameter and expect
that it wouldn't touch the index.

Sure, it will empty the index, so it is dangerous in the same sense that
"reset --hard" is dangerous because it will wipe all your local changes,
or "rm -rf it" will remove everything underneath it.  But these are all
features that are "dangerous if you didn't mean to do so but wanted to do
something else."

Removal of such features might turn out to be maint-worthy but 

    Previously, it was possible to run read-tree without any arguments,
    whereupon it purged the index!

doesn't justify it well enough.
