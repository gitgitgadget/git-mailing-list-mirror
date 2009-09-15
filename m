From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Bug?] "diff -B --color" output doesn't show space errors
Date: Mon, 14 Sep 2009 21:44:37 -0700
Message-ID: <7vvdjk95qi.fsf@alter.siamese.dyndns.org>
References: <wavexx-2ECE7F.13171313092009@ger.gmane.org>
 <7viqfmsoej.fsf@alter.siamese.dyndns.org>
 <20090915123456.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Yuri D'Elia" <wavexx@users.sf.net>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Sep 15 06:44:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnPuR-0003YF-0s
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 06:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbZIOEoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 00:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbZIOEop
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 00:44:45 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59716 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbZIOEoo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 00:44:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D0C1D32158;
	Tue, 15 Sep 2009 00:44:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=0AUtf6lchkkuC1tBa/Da/rOkeXU=; b=kohR6a
	iwi36rRvDohlcrkR01sLoyuijaoVa2XkzrjZrVBLq4ywK3XvkmXcSDn6LyRz1yos
	ua+fTFpadQwFr0cOfe3cdk97/LrFXoUd9rmEGr48Lod62GUPfFUSiPutpf+Z2PRI
	DNouX2xbPovpR6CTbidPK2h+WjsC9L6FNb5Wc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xEFYUOr6IbX3vY9AAwCCRgrOpoJogwmy
	bx7rSnWP3F8Lj0OEIyW/aOq3E7OhBfjF2japthKfo/Pcb//cFKIje4jYpWOFS9Mx
	ZJp0XTeHZgoQuT3iR+Zerq9JYfo92cfrP19ThyBvRdFBHcn0lEQmS3BVoprJ9Cpm
	1REcgTL6Tzg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A80A932157;
	Tue, 15 Sep 2009 00:44:42 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0716B32156; Tue, 15 Sep
 2009 00:44:38 -0400 (EDT)
In-Reply-To: <20090915123456.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Tue\, 15 Sep 2009 12\:34\:56 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7C2318A0-A1B2-11DE-BBAD-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128508>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> I wanted to try this -B option, and wrote a little test program.
>
> While it shows correctly that the file was rewritten, it doesn't
> point out various whitespace mistakes in the file anymore.

As you included the trailing blank lines, I assume you are running
'next'.

The code to emit complete rewrite patch hasn't changed much since it was
written, and I do not think it is aware of any whitespace error checking,
let alone the "trailing blank lines", which is pretty new for even the
regular diff codepath.

But a more interesting thing about your test program is that it exposes to
a bug in the new code in next.  Let me cook up a patch to fix that issue
first, and then build probably a few more patches on it to add whitespace
error highlighting to the complete-rewrite codepath.
