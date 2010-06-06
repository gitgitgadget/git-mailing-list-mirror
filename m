From: Junio C Hamano <gitster@pobox.com>
Subject: Re: permissions
Date: Sun, 06 Jun 2010 12:54:05 -0700
Message-ID: <7vvd9wvswy.fsf@alter.siamese.dyndns.org>
References: <4C0A19FE.1020802@wpursell.net> <m27hmdn704.fsf@igel.home>
 <4C0A9615.4090307@wpursell.net>
 <AANLkTileRHwUuJpvKJbivRiM9Prn9wJ0zH6abExBgcq0@mail.gmail.com>
 <4C0B6C32.1090700@wpursell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: William Pursell <bill.pursell@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 06 21:54:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLLvN-0004rv-MW
	for gcvg-git-2@lo.gmane.org; Sun, 06 Jun 2010 21:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754015Ab0FFTyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jun 2010 15:54:20 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46613 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579Ab0FFTyU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 15:54:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B4ED7B9BF7;
	Sun,  6 Jun 2010 15:54:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zmjpg+t6BBEJcZYWbXRR1+Vm/7w=; b=rskLWM
	Dzlx4UbXT3en0kzlnfU1Xj1GONdWhrnBKqUjIz+e9E1hbSrGJs+0vBZs7+b734Oa
	qbKYsRI8OE6VLLsD4yqNOUY9cl140MLJIkV7hrWh/8htd/XUlcgWZl+aL2/FCO8f
	/rBuPLj8c8ZS4/y0mAry2sGD1hpZUJIe83YXE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gNxQ1bY1oKzGtX+zn9U9gHnSelXI1p2L
	nJYTBYtnkFdocABry/xfHg2iLNdmmwiBC24pO2Kqu9NXFbWamLwJG4gSK/ueEpl1
	SmCEh66Yi574m8hfza16HptTM9dB2LC5nFBFaLtQNR3JAk21W3eQQebmASxlB1Nz
	pYilTXbLH+8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 71C91B9BEF;
	Sun,  6 Jun 2010 15:54:13 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9CB81B9BEE; Sun,  6 Jun
 2010 15:54:07 -0400 (EDT)
In-Reply-To: <4C0B6C32.1090700@wpursell.net> (William Pursell's message of
 "Sat\, 05 Jun 2010 23\:36\:50 -1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 47E89D1C-71A5-11DF-B7ED-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148537>

William Pursell <bill.pursell@gmail.com> writes:

> The problem is permissions, not that it's "not a git repository".
> The error message should be "permission denied".  The easy solution
> is to abort with "permission denied" whenever that is encountered,
> but the trouble with that is that it breaks the current work flow
> in which a broken dir (or one for which the user lacks
> priveleges) is bypassed and a valid object directory higher
> up in the filesystem tree is used.

I think it is sane to abort with "permission denied", as it is "not a git
repository" but it is "we cannot even determine if that .git we see is a
git repository, and if it is, then we cannot do any git operation here as
we cannot read it".  As to what you call "the current work flow", I think
it is not like we _support_ such usage, but more like it _happens to_ work
that way.

> A related question is: does anyone actually prefer (or rely on) the
> current model in which ../.git is used in the event that .git is borked
> or the user lacks permission?

So my answer to this is "nobody _should_", as it is not even "the current
model", but "it happens to behave like that by accident".  That doesn't
mean there isn't anybody who already does, though...
