From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] builtin/checkout: DWIM with -f -b
Date: Sun, 20 Jun 2010 14:10:32 -0700
Message-ID: <7vpqzltnp3.fsf@alter.siamese.dyndns.org>
References: <1277051592-4552-1-git-send-email-rctay89@gmail.com>
 <1277051592-4552-2-git-send-email-rctay89@gmail.com>
 <1277051592-4552-3-git-send-email-rctay89@gmail.com>
 <1277051592-4552-4-git-send-email-rctay89@gmail.com>
 <7vvd9dtt54.fsf@alter.siamese.dyndns.org>
 <20100620201137.GA8502@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jun 20 23:10:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQRmy-00076u-EI
	for gcvg-git-2@lo.gmane.org; Sun, 20 Jun 2010 23:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873Ab0FTVKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jun 2010 17:10:43 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35437 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534Ab0FTVKn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jun 2010 17:10:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A0B22BD6DE;
	Sun, 20 Jun 2010 17:10:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T5GSCSSgCxU2IwxZl6BkbVux3pY=; b=xp5j9I
	PN8/EDzXyl/FP4v6vBw3XBuJNlXjwZROMr2Nd72Lml1HW0gu23c+e81EYK78PGWB
	EHcSy9OzMCy6uRp3FvvVLlCE5sRahFSEOlT2iRgquaahDHpcFdd9EJ9u4zhbapgF
	E3I+UZmw4aB2DuaceTPjka7WlGoNbsgi1jbYc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ia8aRHM28yUPH1zqg8dWC0HyeTz4dj42
	FoDqt4mLKf82mnAwmIHIrWR+2mDg1JwuVp3zMWumSCK+0voof7d2ezgiQ+qPjAaI
	9SMpnw8sm2aBnIQDioCUH9bBlOwWCjKIZAc1ntuwbwUJGSUdCa+7agAaC/KnvdhS
	EAuVxBseWV0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F024BD6DC;
	Sun, 20 Jun 2010 17:10:38 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A31A8BD6DB; Sun, 20 Jun
 2010 17:10:34 -0400 (EDT)
In-Reply-To: <20100620201137.GA8502@coredump.intra.peff.net> (Jeff King's
 message of "Sun\, 20 Jun 2010 16\:11\:38 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 468ECC32-7CB0-11DF-A29A-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149405>

Jeff King <peff@peff.net> writes:

> I am not sure it is fixing a bug. There are really two possible things
> to be forced during checkout:
>
>   1. throw away local changes
>
>   2. overwrite an existing branch
>
> Right now, "checkout -f" means just (1). This patch makes it _also_ mean
> (2). Do we want to conflate those two cases?
>
> In some sense, it is reasonable for "-f" to mean "force anything that
> might be questionable". But I wonder if it pays to be a little more
> conservative given that this is a safety valve we are talking about. The
> user can of course still split their compound action into:
>
>   git branch [-f] new_branch old_branch
>   git checkout [-f] new_branch
>
> Less convenient, but there is no ambiguity.
>
> I dunno. I don't have a strong feeling on how it should be, but I think
> it is more than a simple bug fix.

Ok, fair enough.

FWIW, I often end up doing this when rebuilding 'pu' (and 'jch' that is
used internally that keeps a version of 'next' with cleaner history).

    ... a script to regenerate jch on top of master (and pu on jch)
    $ Meta/Reintegrate master..jch >Meta/redo-jch.sh
    $ Meta/Reintegrate jch..pu >Meta/redo-pu.sh

    ... rewind and rebuild jch on top of updated master
    $ git checkout -f -b jch master
    ... error ... oops
    $ git branch -f jch master
    $ git checkout jch
    $ Meta/redo-jch.sh
    $ git diff next
    ... no output---good.

    $ git checkout -f -b pu jch
    ... error ... oops
    $ git branch -f pu jch
    $ git checkout pu
    $ Meta/redo-pu.sh
