From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Interesting git-format-patch bug
Date: Mon, 26 Nov 2012 14:56:34 -0800
Message-ID: <7vobikotwd.fsf@alter.siamese.dyndns.org>
References: <4B2793BF110AAB47AB0EE7B9089703854CA7BA61@fmsmsx110.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: "Olsen\, Alan R" <alan.r.olsen@intel.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 23:56:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td7bg-0000rh-JQ
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 23:56:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362Ab2KZW4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 17:56:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64617 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932222Ab2KZW4h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 17:56:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 502C1A02A;
	Mon, 26 Nov 2012 17:56:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UGnH5x3HcIghBpP5rAKgZO3BBMQ=; b=DkL3jk
	B3ushVqJhrgxqbUuLM1nNpETvH4AJFtS+HabcGMjgLfXJhm7kPkUdukUyaqUN3RT
	JZ7Kjl4VxrejWE6j4g8lJBy4LlaRkzig+4ax/0oYZwgEDDEZCekRy4luw8KiTrHO
	PDbedRMqerdWJ/tGkn09ptGz8NVBIIwImD4wQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KZmlKSkvI25dV29c4bnvFSHDi/nXreoz
	l41eQIkrN4lEq+XYuKBHPKi56Kxg09xdeRlnRdTuRI6CetHB4etM04B3XwFTxMSg
	mNqqsksxAJ6wGbeZ06eNJw57PPhQCO1rBQFG1tYVfSKsfJfVhqJ5jLb83i0JDcnV
	T46lOTAsQYE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B3ADA029;
	Mon, 26 Nov 2012 17:56:36 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A917BA023; Mon, 26 Nov 2012
 17:56:35 -0500 (EST)
In-Reply-To: <4B2793BF110AAB47AB0EE7B9089703854CA7BA61@fmsmsx110.amr.corp.intel.com> (Alan
 R. Olsen's message of "Mon, 26 Nov 2012 21:33:01 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 876F80C8-381C-11E2-9E32-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210507>

"Olsen, Alan R" <alan.r.olsen@intel.com> writes:

> I found an interesting bug in git-format-patch.
>
> Say you have a branch A.  You create branch B and add a patch to
> it. You then merge that patch into branch A. After the merge, some
> other process (we will call it 'gerrit') uses annotate and changes
> the comment on the patch that exists on branch B.
>
> Now someone runs git-format-patch for the last n patches on branch
> A.  You should just get the original patch that was merged over to
> branch A.  What you get is the patch that was merged to branch A
> *and* the patch with the modified commit comment on branch
> B. (Double the patches, double the clean-up...)

As you literally have patches that do essentially the same or
similar things on two branches that was merged, you cannot expect to
export each individual commit into a patch and not have conflicts
among them.  So I do not think there is no answer than "don't do
that".

I think you could make your "some other process" that rewrites
commits to cull the duplicates out of the format-patch output,
though.  Each output file identifies what commit object the patch
came from, and your "some other process" that rewrote the commits
ought to know which commit updated which other commit did, which is
the piece of information needed to remove duplicates that format-patch
does not have.
