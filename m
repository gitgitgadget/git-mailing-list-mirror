From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Disallow creating ambiguous branch names by default
Date: Fri, 19 Aug 2011 13:49:23 -0700
Message-ID: <7v1uwh2kks.fsf@alter.siamese.dyndns.org>
References: <1313569298-3879-1-git-send-email-conrad.irwin@gmail.com>
 <7vhb5fev8a.fsf@alter.siamese.dyndns.org>
 <CAOTq_ptU2QmPMMZYQLd2MFQ_=_RnADdBnoN5+v4rXh_nmpOcjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Conrad Irwin <conrad.irwin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 19 22:49:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuW0R-0008Ta-Cn
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 22:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756114Ab1HSUt0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 16:49:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36656 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754710Ab1HSUt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 16:49:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33A90493F;
	Fri, 19 Aug 2011 16:49:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ObfKm5M/7+LsvhlYML+xI/hrCts=; b=vn/N9y
	QdW6Q2S8fAcPGFQatC0Z4gy2QV9oe8EUhGh6OWqoE/w+HCNmReSffhjir4FB3NXU
	j1WIEeHwuo0LuAFG2whq+8oYC5SkxFvQbjJzJ2MuGQK2UIDhOl1Ja3wiIZJP4vBr
	CLynGG/SDonTl/rcmv27CLOHuV8druCgOlxb4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fxl2Y9sd+F6v2eG26KPCkdNY3nuQ/ryN
	nT97nr83X+SAdiXLvCFD8dfYqwZLplaYiIEvbkB3F7kYwU2Ob/O4xv/xlHYbDkZG
	VMO3h4IpvAJdHpaoBIgjJEgXUR9un4TdzPNBwlz+LlsJG7tL/jS4LYkTY6qBYrlK
	bBXxUWF3cd8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AEA9493E;
	Fri, 19 Aug 2011 16:49:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B2AD6493D; Fri, 19 Aug 2011
 16:49:24 -0400 (EDT)
In-Reply-To: <CAOTq_ptU2QmPMMZYQLd2MFQ_=_RnADdBnoN5+v4rXh_nmpOcjw@mail.gmail.com> (Conrad
 Irwin's message of "Fri, 19 Aug 2011 11:14:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B8F1F522-CAA4-11E0-859D-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179724>

Conrad Irwin <conrad.irwin@gmail.com> writes:

> In the process of changing things around to do this, I noticed that
>
> git checkout -M <foo> <current-branch>
>
> surprisingly works,...

What is "-M" supposed to do???

If you meant "-B", that should work. When I want to rewrite a topic in a
non-trivial way, I would often do:

	$ git checkout HEAD^^^
        work to redo what the few commits at the tip should have done,
        creating commits.
        $ git diff @{-1} HEAD
        $ git checkout -B @{-1}

which often happens to be simpler and more flexible than the canned
rewriting options "rebase -i" can offer me.

> ... in that you will get a:
>
> $ git rev-parse HEAD@{1}
> warning: Log .git/logs/HEAD has gap after Fri, 19 Aug 2011 02:00:09 -0700

If that is the case, then the codepath to update the reflog is
broken. That is not a reason to forbid -B, though.

But because I do not know what you meant by "checkout -M", ...
