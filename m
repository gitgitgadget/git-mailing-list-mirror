From: Junio C Hamano <gitster@pobox.com>
Subject: Re: default behaviour for `gitmerge` (no arguments)
Date: Wed, 13 Jan 2010 01:47:07 -0800
Message-ID: <7v6376pc9w.fsf@alter.siamese.dyndns.org>
References: <loom.20100111T185144-655@post.gmane.org>
 <7v7hrojukz.fsf@alter.siamese.dyndns.org>
 <20100112162355.GB25092@coredump.intra.peff.net>
 <7vhbqr2nxt.fsf@alter.siamese.dyndns.org>
 <20100112182550.GA15696@coredump.intra.peff.net>
 <7vwrzmqypn.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1001131024420.3043@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Gareth Adams <gareth.adams@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 13 10:47:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUzp4-0002KO-RN
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 10:47:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755270Ab0AMJrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 04:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755268Ab0AMJrU
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 04:47:20 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57598 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755188Ab0AMJrT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 04:47:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D078F90E29;
	Wed, 13 Jan 2010 04:47:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ULwc/fJGUqIJwV9iTGIYIlSJJdw=; b=MZvQnu
	vTzMT9/qAVBLlEoSnTY6U1qWEQNbYMPccOhy5VrSRKgfwfXcSLPeCF5xWIgzga+J
	HkRhIAyhop/lJ+7xobW0VQjYbeOD5PNH4IbR2BzP1o8/T+M+4i6JcAsQI5o++7ep
	gKuo4Hns7MJlnj6KnCZkdKWX/rWTq2cb352b8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u14iiSlaqZrutUzKZoqg14hGaagTt2Ld
	c5mlSU3+VUMBs6dNpMsnX80MTaN2lu7lLuAxfR2s5r5h5cs61ushboDXDSMDFC/+
	Vyu8Nfhh3YfPuFkXSyiofp0AlOpwZHng2AqUN+I6GgnS+XGzcHiBSpSbtSekzRwv
	l1nTlgm5+lQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E69690E25;
	Wed, 13 Jan 2010 04:47:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F5BE90E24; Wed, 13 Jan
 2010 04:47:08 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1001131024420.3043@intel-tinevez-2-302>
 (Johannes Schindelin's message of "Wed\, 13 Jan 2010 10\:26\:05 +0100
 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A06FE6A0-0028-11DF-AAD8-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136804>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I wondered why it doesn't hook into interpret_branch_name(), and instead 
>> adds itself to the static substitute_branch_name(); it forbids the use 
>> of the syntax from by callers of strbuf_branchname().
>
> I _think_ it was to allow something like
>
> 	git log -g @{u}
>
> but frankly, this is so long ago, I do not remember, I reconstructed this 
> reasoning as being the most likely.

That is not the question I was asking.

If you compare substitute_branch_name() and interpret_branch_name() before
your patch, you will notice that they are _meant_ to do the same thing,
with different external API, only because many callers in sha1_name.c do
not use strbuf to hold their names.  The primary API is the latter (which
is extern), and the former (which is static) is merely a helping wrapper
that is internal to sha1_name.c

But with your patch, they suddenly have different semantics, and the
function that implements the primary API doesn't know anything about
this new @{upstream} syntax.

This discrepancy will affect callers of strbuf_branchname(), e.g.
merge_name() in builtin-merge.c that prepares the "Merge branch nitfol of
remote frotz" message, or delete_branches() in builtin-branch.c.

Note that I am not saying "branch -d @{upstream}" should or should not
work (at least not yet---I haven't thought the issues through).  But I
wanted to know if this subtle change in the semantics was a deliberate
choice, and if so wanted to see the reason behind it described clearly.
