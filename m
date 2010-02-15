From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] ls-tree: dump full tree if it was named as such
Date: Sun, 14 Feb 2010 17:47:16 -0800
Message-ID: <7vy6iv46e3.fsf@alter.siamese.dyndns.org>
References: <f3e853a9329a68cc9b1d544b204ed6a0469b10a2.1265644609.git.trast@student.ethz.ch> <7vpr4fo85r.fsf@alter.siamese.dyndns.org> <201002141733.53137.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Feb 15 02:47:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngq3c-0006hg-Fq
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 02:47:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832Ab0BOBrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 20:47:23 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63819 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745Ab0BOBrW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 20:47:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 46CAA9AADF;
	Sun, 14 Feb 2010 20:47:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=p2zzi35qX0WmK0C4Ku1fi6jLuNo=; b=E4ZCF9MBCjbjeu9qXHarMjC
	IV9uHWirZki/NGo76TZhi5g+SoBZW1NVWxXZ/Qnx9RFGEPpUJlBCQ7FEeXQCmBSx
	Nmr5FjEcrlLshMJZN9hSwlUU/XbqiDPwmPA5FpUcFsLMinQask24le8aLySqDq2p
	bHbBeuxVY2n1AuorMBEA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=mRrYTt3M2sQrKpGqcYyOMCW8U8diY2NT5EY0ZlTeZirql5vdo
	jK9JPEDuz2a22lVMzJ8s9/z3YQonv2XAjnIjkmpJ6Z3w+fT5JLpHX8LDSqVPFqfC
	TF0eE/GZTh+qTyOt8alMTE493NO1kucNO96QmemSsGkSStriu/3o5hfbJk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2324B9AADE;
	Sun, 14 Feb 2010 20:47:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6AFCF9AADD; Sun, 14 Feb
 2010 20:47:17 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0DE25938-19D4-11DF-8744-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139957>

Thomas Rast <trast@student.ethz.ch> writes:

> I guess in the (very) long run, the scripts should be forced to always
> use --full-tree so that we can eventually make it the default?
>
> I'm just not sure how the existing behaviour could ever be useful,
> though admittedly 'git ls-tree $(git write-tree)' would change
> semantics if you're in a subdirectory.

Hysterical raisins.  I am reasonably sure that it behaves for end-user
convenience and consistency while running these from the command line:

    $ cd t
    $ git ls-files
    $ git ls-tree HEAD

The --full-tree option came as an afterthought much later to help
Porcelain scripts, that had to cd-up-to-top to get to the full tree
contents.

The order of events and historical backstory does not matter.

The Porcelain scripts have learned to either (1) going to top before
running, or (2) giving --full-tree when they want to see a full tree
output, but at the same time they also learned that (3) running the
command without --full-tree will give them the contents of the tree that
corresponds to where the current directory is in the work tree.

All three are documented plumbing interfaces---not just the first two
points.  I haven't seen any good excuse to break the third promise with
Porcelain scripts. I didn't find one myself when I did d4789c6 (ls-tree:
add --full-tree option, 2008-12-25) long time ago.

So even in "(very) long run" nothing will happen.  I was about to write
"except documenting them better, perhaps", but after re-reading the
introductory paragraphs of the manual page, I don't think anything more
needs to be said there.
