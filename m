From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Resend PATCH] t3903 (stash): add failing test for ref of form
 ^{/message}
Date: Tue, 16 Apr 2013 12:11:41 -0700
Message-ID: <7veheal28i.fsf@alter.siamese.dyndns.org>
References: <1366135765-18437-1-git-send-email-artagnon@gmail.com>
 <CA+sFfMfkoBcoPvJSYBGUe46EbMfiC7q6tVZs6db2NHrEb2gb7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 21:11:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USBIE-0001uS-BC
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 21:11:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754109Ab3DPTLp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 15:11:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41880 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753837Ab3DPTLo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 15:11:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF2291476E;
	Tue, 16 Apr 2013 19:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NNJOcnKXqlboalO36jAr5htQWv4=; b=YCDy9j
	5prkgC18Wl5uCBHQ41luSUxkWb81v+9wIB2EkM3fD3htci4JYcuyfX1h9NoGk2/O
	oWpNHUmI8nExKgjt3qz83K/M16ZRudlOcPB8bTIgHZ5Zwot5ujD/rRVv/U2wQ2E7
	6HjNIVzM8+eSukJc5DpKfLR7SdX55wkzgjOvc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DYRikCZqE8nf8amWkPGqNWT9nC6vvGxo
	9+NZXMy0CLXsbQkJr+lRURdjYsQsMrCA3vgkF1hHgAiqMCiw4t0+TEaRBssqZPqp
	bxTq26Cv0htqJuW46n/8rVyj2qRNi1TPymhCH1T5FSf3s6tJ/AGrgbPqQZEYwrbw
	7539pndxPbg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF7EB1476D;
	Tue, 16 Apr 2013 19:11:43 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 226A71476B; Tue, 16 Apr
 2013 19:11:43 +0000 (UTC)
In-Reply-To: <CA+sFfMfkoBcoPvJSYBGUe46EbMfiC7q6tVZs6db2NHrEb2gb7Q@mail.gmail.com> (Brandon
 Casey's message of "Tue, 16 Apr 2013 11:57:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 797E6B5C-A6C9-11E2-A67A-CC48E7F0ECB6-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221453>

Brandon Casey <drafnel@gmail.com> writes:

> The stash is implemented using the reflog.  The ^{/<text>} notation
> searches the commit history, not the reflog.  So I think it will be
> able to match the first entry in your stash stack, but not any of the
> other ones.

Good point, together with...

> An extension to the reflog dwimery that implements @{/<text>} could be
> interesting though.

"log -g --grep=<text>" gives you a way to eyeball, but with
@{/<text>} you _might_ have a good way to name the revision.

I am not however so sure if it is useful outside the context of the
stash, because the ones you would want to recover from a normal
reflog is most likely the older version of what you already amended,
so the latest hit will likely be the post-amend version, not the one
closer to the original.  You would end up eyeballing the output of
"log --oneline -g -grep=<text>" and cutting from it.

> Just a bit of advice, maybe you should think about softening your tone
> a bit hmm?  I find this last sentence to be somewhat repelling and
> tend to refrain from responding to such.

Oh, so it wasn't just me.  I was about to say something similar,
along the lines of "people whom you just called myopic, because you
did not understand the rationale behind their past work, are less
likely to be inclined to help you. you would have more luck if you
ask them nicely.", but I've long given up on helping him be a better
community member and deleted that part.
