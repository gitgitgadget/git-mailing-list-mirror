From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 5/7] add tests for rebasing merged history
Date: Tue, 04 Jun 2013 10:18:01 -0700
Message-ID: <7vk3m994mu.fsf@alter.siamese.dyndns.org>
References: <1369982987-18954-1-git-send-email-martinvonz@gmail.com>
	<1370292135-1236-1-git-send-email-martinvonz@gmail.com>
	<1370292135-1236-6-git-send-email-martinvonz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 19:18:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjusQ-0007Sm-Jm
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 19:18:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754309Ab3FDRSG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 13:18:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50870 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752755Ab3FDRSE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 13:18:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71EBB25129;
	Tue,  4 Jun 2013 17:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ETKq8jsjGke0ISSmgwDtd7OphgA=; b=mIQiwD
	I7TBbgOYBKlurpC1GqwyOxLtBaD/1GQb9WY9qfRV21qnTgnvJwAGC1AzxYM9W+UY
	kFgTKfFDc++QJTsAW43A2vnJMULrFls37pYQf8inoqfXhgLNG88bGeyrNs/zdkGb
	Azkys20Ar7u0zN5gC+vsiISjISEPiXeM1L5xY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XQFBhNdpyLZL/SAr/dA927pcpHq7q3lq
	RVseicVIZdnhbkW6C1pqHkJJ+qtrOkR4IScu6DZGukniiNV1sdx6uBtdhpQGQP+O
	WqUq5ewti4BeWqCmkU8iod7i7yiJ+5PntwkbI68SBbN/LH3/mYZUhnB23hZi8O/w
	itss1Trt4QY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 66EC625126;
	Tue,  4 Jun 2013 17:18:03 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D90AB25124;
	Tue,  4 Jun 2013 17:18:02 +0000 (UTC)
In-Reply-To: <1370292135-1236-6-git-send-email-martinvonz@gmail.com> (Martin
	von Zweigbergk's message of "Mon, 3 Jun 2013 13:42:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B68C30FA-CD3A-11E2-ADB4-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226380>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> ---
> +#TODO: make all flavors of rebase use --topo-order
> +test_run_rebase success 'e n o' ''
> +test_run_rebase success 'e n o' -m
> +test_run_rebase success 'n o e' -i

I do not quite follow this TODO.

While I think it would be nice to update "rebase" so that all
variants consider replaying the commits in the same order, in this
history you have:

+# a---b-----------c
+#      \           \
+#       d-------e   \
+#        \       \   \
+#         n---o---w---v
+#              \
+#               z

as long as o comes after n and e is shown before n or after o, which
all three expected results satisify, it is in --topo-order, isn't it?

The same comment applies to the other TODO that talks about eno/noe
differences.

> +test_expect_success "rebase -p re-creates merge from side branch" "
> +     reset_rebase &&
> +     git rebase -p z w &&
> +     test_cmp_rev z HEAD^ &&
> +     test_cmp_rev w^2 HEAD^2
> +"

Hmm, turning the left one to the right one?

+#       d-------e               d-------e    
+#        \       \               \       \   
+#         n---o---w     ===>      n---o   \
+#              \                       \   \ 
+#               z                       z---W

If w were a merge of o into e (i.e. w^1 were e not o), what should
happen?  Would we get the same topology?

In other words, when asked to replay w on top of z, how would we
decide which parent to keep (in this case, e is kept)?

> +test_expect_success "rebase -p can re-create two branches on onto" "
> +     reset_rebase &&
> +     git rebase -p --onto c d w &&
> +     test_cmp_rev c HEAD~3 &&
> +     test_cmp_rev c HEAD^2^ &&
> +     test_revision_subjects 'n e o w' HEAD~2 HEAD^2 HEAD^ HEAD
> +"

Nice (so are all the rest).
