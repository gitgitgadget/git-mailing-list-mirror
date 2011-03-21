From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 2/2] Fix sparse warnings
Date: Mon, 21 Mar 2011 12:29:13 -0700
Message-ID: <7vzkoop912.fsf@alter.siamese.dyndns.org>
References: <7voc54sb41.fsf@alter.siamese.dyndns.org>
 <1300730506-6582-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 20:29:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1knD-000712-Cc
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 20:29:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753564Ab1CUT31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 15:29:27 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39127 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803Ab1CUT30 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 15:29:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 26471400A;
	Mon, 21 Mar 2011 15:31:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RdZ9rcQJO/xvS16xyNuoFneTLzk=; b=rUZxx6
	oU9YyFc4Lepe26F/ef9QOkqR/VAU2kqrYZzSudTCpwZU/n9WNBNZw7dgNbB8WNZu
	LFZ6f5s2BmAZ6bZaJkywbNIy5r6cMyTVvqqG1fvCIW0KPTb2cPCzznxLxjS5OfQR
	fLZnHIuLqZUDle4sstTK6tJ2lRiwPFzYKFzRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nVfKIaT67w6/1tN7HR+GaYXkzAaM5ANu
	Ij+NNcB7xJj6wY+tuck5y2+edzgnU4tPqA9AXXGQVAV61m2aeZ/kDlq9+cM440A1
	nVxkj3YC+bBvD0LIz0t6N8ITpHZyPRF79d0t327++QSR1u6WZiTpyQ2w9VKQhRVl
	Hd/XZttV1NA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E2F254009;
	Mon, 21 Mar 2011 15:30:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 69E654008; Mon, 21 Mar 2011
 15:30:54 -0400 (EDT)
In-Reply-To: <1300730506-6582-1-git-send-email-bebarino@gmail.com> (Stephen
 Boyd's message of "Mon, 21 Mar 2011 11:01:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C0383AC8-53F1-11E0-8D10-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169645>

Stephen Boyd <bebarino@gmail.com> writes:

> Fix warnings from 'make check'.
> ...
> Signed-off-by: Stephen Boyd <bebarino@gmail.com>
> ---
>
> On 03/21/11 09:15, Junio C Hamano wrote:
>> 
>> Yuck.  Could you summarize the errors by grouping them by type or
>> something in the log?  One mega-patch we can swallow, but the log is
>> unreadble.
>
> Sure. Both comments addressed.

Still yeek...

What I meant was more like at the minimum:

 - "warning: symbol 'x' was not declared. Should it be static?"
   builtin/clone.c:365, builtin/fetch-pack.c:797, ...

 - "error: symbol 'x' redeclared with different type'
   parse-options.c:564, ...

or much more preferably:

 - These files use symbols without declaring, because they do not include
   "builtin.h":

    builtin/clone.c (cmd_clone), builtin/fetch-pack.c (cmd_fetch_pack), ...

 - These files define extern symbols without declaring, and they can be
   file scope static:

    builtin/fmt-merge-msg.c (init_src_data), ...

 - These callsites pass literal integer 0 where they mean to pass a NULL
   pointer:

   builtin/notes.c (resolve_ref), ...

The patch text itself look more or less Ok, but I see you have builtin.h
not as the first include in builtin/pack-redundant.c.

Thanks.
