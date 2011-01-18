From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gitk "find commit adding/removing string"/possible pickaxe bug?
Date: Tue, 18 Jan 2011 13:26:15 -0800
Message-ID: <7vsjwpkio8.fsf@alter.siamese.dyndns.org>
References: <514EB3AA-CD31-4BDB-B777-B7AAEEDF5663@sebastianhahn.net>
 <201101181744.18139.trast@student.ethz.ch>
 <20110118185027.GA10562@sigill.intra.peff.net>
 <201101182139.28808.trast@student.ethz.ch>
 <20110118205040.GA20970@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Sebastian Hahn <mail@sebastianhahn.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 18 22:26:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfJ4h-0000iy-QL
	for gcvg-git-2@lo.gmane.org; Tue, 18 Jan 2011 22:26:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110Ab1ARV0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jan 2011 16:26:30 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53994 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069Ab1ARV02 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jan 2011 16:26:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 10E3820E3;
	Tue, 18 Jan 2011 16:27:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4BbA1xwD+OWPe/qUUsVUZE+b4C4=; b=k/0WaZ
	vpclIuOwLfqGWzBdSwCWEoF1B+T+ywCJep84VN4C1wINd91aCfDCH22R4mh5V62W
	kdfZ82KU0hUo0uDZKkQlWqp0XM0IjCjSEzZaw1Ud1/ckYSHPkGdZnixXAogMkIzW
	LTygRWZkJHlbMCCo0TOw6uvmMdURa30leITw4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mYQLT7SACZzFH61MQAaDjhCvD7b7+hEw
	Oad3dgOUyByTxEzNx4K+Sy/04kf8LKs3IYoNaCvkYRhYZertQVMGUriGptcmazGJ
	Iw/j3x1wsqEJ/X56Ls8wrWGVVHKaUpO8vonRpFu3VwCOsdB46c5JIONyuwvRq7TW
	sTUlYPitRPY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BEA7920DF;
	Tue, 18 Jan 2011 16:27:08 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5FEE820DC; Tue, 18 Jan 2011
 16:27:03 -0500 (EST)
In-Reply-To: <20110118205040.GA20970@sigill.intra.peff.net> (Jeff King's
 message of "Tue\, 18 Jan 2011 15\:50\:40 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B4683DE8-2349-11E0-987F-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165220>

Jeff King <peff@peff.net> writes:

> [1] That's what I expect, but not necessarily what I want. I think what
> I would want is for it to do a token count of the merge commit, and if
> it fails to match _every_ parent, then it it interesting. Otherwise, the
> content presumably came from that parent.

Honestly, my guess is that the interaction of -S with a merge commit is
"whatever the code happens to do", as I didn't think nor design how they
should interact with each other when I wrote -c/--cc nor when I wrote -S.
If I recall correctly -S codepath predates -c/--cc by a wide margin, and I
wouldn't be surprised at all if pickaxe doesn't work as expected (by
anybody's definition of "expectation"), unless you are looking at "-p -m"
output, not a combined one.

Having said that, I tend to agree with your latter expectation ("what I
want").

By the way, you guys should really not be looking at the disused
plumbing-helper -S but instead be advocating its newer and more human
friendly cousin -G.  1.7.4 is coming ;-).
