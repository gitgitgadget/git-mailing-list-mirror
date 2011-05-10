From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git rebase --interactive commits order
Date: Tue, 10 May 2011 16:26:50 -0700
Message-ID: <7vwrhygmrp.fsf@alter.siamese.dyndns.org>
References: <BANLkTimX2tupqV464+Re8u06TT+qRmqPuw@mail.gmail.com>
 <BANLkTi=PyBfMxCbWNfJEXEP6-MphdeE+_Q@mail.gmail.com>
 <m2d3jr1mev.fsf@Spindle.sehlabs.com>
 <BANLkTim1e=+yoyxd1AAThVYMZ_X3nfz=7Q@mail.gmail.com>
 <BANLkTinRcigdQv2GJN6L+nF3X2+F-5Lf5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philippe Vaucher <philippe.vaucher@gmail.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 11 01:27:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJwKa-0002Qi-Gs
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 01:27:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753412Ab1EJX1D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 19:27:03 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61429 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836Ab1EJX1B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 19:27:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DA4814D48;
	Tue, 10 May 2011 19:29:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Wi0lw3VLBkZcWz+utBG5O52EHCQ=; b=HADE09
	UrgSf35CeJ4Rpuaf6+1OZ49KksHqd2A04KPTRiFlX+hmWzc4Ch9hVGhVLgj8tFvx
	BUgZR9iSde/n1l1aYz2zsdiRDKT6I3ILIBKjC1EKl2r/F+uodkyNxuQL9zbaCk61
	sKXlzYVc5QdFlYxfli7NP9/ifwblFxxlPC0vI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JDCJEkWDTscehWupk3MUrvfmMND2+baO
	KTPVZbXiPX9TgWK7NgKAuF5oHaV+3k6O1ROW6IJyK7RMm9W9qv9NCN8nvaO47i8+
	bUEYeqZibzyXtcqUzUbA0HGNyVBI/DRmtNDMK8YME+wz53wQt/FNW2BD3jo4DRN5
	DtzhQbTwPlM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A4D344D47;
	Tue, 10 May 2011 19:29:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 701794D46; Tue, 10 May 2011
 19:28:57 -0400 (EDT)
In-Reply-To: <BANLkTinRcigdQv2GJN6L+nF3X2+F-5Lf5w@mail.gmail.com> (Sverre
 Rabbelier's message of "Wed, 11 May 2011 00:30:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 496EA088-7B5D-11E0-B12C-B44DF9BAD297-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173382>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Yes, write a patch that adds a --reverse flag, off by default, (or
> something like that), possibly with a config flag.

What do you mean by "something like that" exactly?

Devils lie in the details.  For example, should squash/fixup come before
or after the squashed commit when --reverse is in effect, and why?

Should "rebase --reverse --continue" work after it gets interrupted, if
not why not?

After all the insn sheet used by "rebase -i" is not like reading logs at
all.  It is a specification of the steps in the order they should be
carried out.  If you are to pick A and then pick B and squash C into the
result and then reword D on top of the base commit, do you really think it
is sane to list them like this?

	reword D
        squash C
        pick B
        pick A
	# you can reorder and update commands above
        # p is for pick, r is for reword, ...

I don't exactly remember what the help text said, but to me the above
looks totally backwards (and that is understandable because it is
backwards ;-).
