From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] diff-lib: simplify do_diff_cache()
Date: Tue, 19 Jul 2011 14:28:01 -0700
Message-ID: <7vei1m7yfy.fsf@alter.siamese.dyndns.org>
References: <7vzkkh2yfu.fsf@alter.siamese.dyndns.org>
 <1311099186-16482-1-git-send-email-gitster@pobox.com>
 <1311099186-16482-2-git-send-email-gitster@pobox.com>
 <20110719201400.GA2938@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 19 23:28:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjHpq-0003bB-CB
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 23:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351Ab1GSV2F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 17:28:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54468 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750980Ab1GSV2D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 17:28:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71F1C3EAF;
	Tue, 19 Jul 2011 17:28:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tvwPz3sUd0W2gp0YULZB0hnSyhY=; b=lPFKKv
	7AmyYVkV3m0ZnRhDvu41JZFU9jywWnemp7vxg6Y2Id/AA2pLmeZMKi0Wktl6KbB4
	cMc0b0uNMhCy31Cs3hWisdoKaG1FDzjJxT2BYMIIb+Ra0DNi6qBfYbrROc03GN5e
	qNsC+LkPrQRkM7UnGE3c0rXzWX043T5N11ke8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IHVgLg1J6LeVQvH7WVltKLfG7Rv3B1Oc
	wGnE7hIdlILyPCgymT+PQm/8j3JkpFnTbssppJGaTl7ppEcR/80uI4YND6dEQcqU
	BkdZkDKJ9gZX60HIbIqGCHvUYjO4z+nIPZYeDPHrgfw+mmUoLAqYSHtsQAj0HzIB
	Se/euRHgJ5o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6927C3EAD;
	Tue, 19 Jul 2011 17:28:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C9A4C3EA9; Tue, 19 Jul 2011
 17:28:02 -0400 (EDT)
In-Reply-To: <20110719201400.GA2938@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 19 Jul 2011 16:14:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FBD4DB4E-B24D-11E0-97FC-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177507>

Jeff King <peff@peff.net> writes:

> On Tue, Jul 19, 2011 at 11:13:05AM -0700, Junio C Hamano wrote:
>
>> Since 34110cd (Make 'unpack_trees()' have a separate source and
>> destination index, 2008-03-06), we can run unpack_trees() without munging
>> the index at all, but do_diff_cache() tried ever so carefully to work
>> around the old behaviour of the function.
>> 
>> We can just tell unpack_trees() not to touch the original index and there
>> is no need to clean-up whatever the previous round has done.
>
> Can we drop the calls to discard_cache in reset.c now?

Possibly, along with "index-was-discarded" flag bit.

> $ git grep -B1 discard_cache builtin/reset.c
> builtin/reset.c-        /* do_diff_cache() mangled the index */
> builtin/reset.c:        discard_cache();
> --
> builtin/reset.c-                /* The index is still clobbered from do_diff_cache() */
> builtin/reset.c:                discard_cache();
>
> -Peff
