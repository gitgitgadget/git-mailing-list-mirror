From: Junio C Hamano <gitster@pobox.com>
Subject: Re: receive.denyNonNonFastForwards not denying force update
Date: Tue, 21 Aug 2012 09:43:18 -0700
Message-ID: <7v628cfb6h.fsf@alter.siamese.dyndns.org>
References: <CAHgXSop42qWcAEGn6=og8Pistv_Jrwhgcnv3B_ORVtSMi1fCHA@mail.gmail.com>
 <CAHgXSooFj2PJtcOWqsVNHUzMBQnH0cYzPjfs1CkzVuufwRVrog@mail.gmail.com>
 <7vzk5pjxy3.fsf@alter.siamese.dyndns.org>
 <CAMK1S_hMTGhiKDow3x-UZ7eNnTtpLd2=QUf6-YoQF1-O1ywi2w@mail.gmail.com>
 <7v628dght9.fsf@alter.siamese.dyndns.org>
 <20120821015738.GA20271@sigill.intra.peff.net>
 <7vpq6kgazt.fsf@alter.siamese.dyndns.org>
 <20120821061059.GA26516@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	John Arthorne <arthorne.eclipse@gmail.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 21 18:43:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3rYR-00062A-5A
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 18:43:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163Ab2HUQnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 12:43:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35640 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758135Ab2HUQnU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 12:43:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A00B6760;
	Tue, 21 Aug 2012 12:43:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9tKw3q2mX7hTLe0j6ZUxfbP60Vg=; b=NyH7EX
	v3XVXKWCNLg18UOKsaBx2rxHcZuigt1fZcPkuEfTIMIvrDDCeA5JiWJEDO1SH/Cl
	ruvZvhVr5GwUvpq/sEFPqAMmw6OYXOId0oNvmdyfRQyodRqJpxIqh2urJpSBf/VK
	8ML78Chj+PDpKym2YsdYE9pQ1Vqyfsg1YyEv4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KCQWWBI+TBHasmzvksKodxPRjX1SCMYb
	lIJYb5srJh7+WokyDSaRW/wnRiBV1AyZ12fmtPRENiVxrnh1zTmhfHZBCyCEIU5h
	WS9c2suGGbwtie9TXZFJoWrKdDokqNEIy8nNqQGKqDbtcJjU3DiGnshmeaL/9mNl
	X3sHiGh3+1o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 17EF6675F;
	Tue, 21 Aug 2012 12:43:20 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 75BCD675D; Tue, 21 Aug 2012
 12:43:19 -0400 (EDT)
In-Reply-To: <20120821061059.GA26516@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 21 Aug 2012 02:10:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 502F2AA0-EBAF-11E1-8ED5-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203970>

Jeff King <peff@peff.net> writes:

> You can get multiple warnings from this, as some programs read the
> config multiple times. I don't think it's really worth caring about, as
> you would want to fix such a misconfiguration quickly anyway.

I agree that we wouldn't care too much about the multiple warnings,
and even if we did, it would be easy to correct. Instead of having a
call to warning(_("unable to access..."), path, strerror(errno))
directly in acceess_or_warn(), make that a helper function that is
called from there and other places you warn in your other patches,
and maintain a small table of already-warned-for paths in the helper,
and we are done.

> A bigger question is whether people are stuck living with such a
> misconfiguration (e.g., inaccessible directories made by a clueless
> admin), and would be annoyed at having no way to turn this feature off.

Yes, /etc/gitconfig would certainly have that issue; exclude and
attr you deal with your other patches are safe, though.

Modulo the above "you might want to turn the call to warn() to
another helper that can be used from elsewhere", this patch looks
perfect to me.

Thanks.
