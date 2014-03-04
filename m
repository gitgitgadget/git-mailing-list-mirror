From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] implemented strbuf_write_or_die()
Date: Tue, 04 Mar 2014 10:45:46 -0800
Message-ID: <xmqq61ntls4l.fsf@gitster.dls.corp.google.com>
References: <1393672871-28281-1-git-send-email-faiz.off93@gmail.com>
	<CAJr59C0e22OuDWU5Xc0A=cc+zY32nfum6SXTDU3wLCPyFPF70A@mail.gmail.com>
	<CAPig+cRgc4UtmJMieS9Mdrz7vjUNiu7QFu1PSBppKo22Ln5G-A@mail.gmail.com>
	<xmqqvbvvqglc.fsf@gitster.dls.corp.google.com>
	<53159A81.4050905@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	He Sun <sunheehnus@gmail.com>,
	Faiz Kothari <faiz.off93@gmail.com>, git <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Mar 04 19:46:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKuLl-0006z1-OT
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 19:45:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754537AbaCDSpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 13:45:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36145 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751908AbaCDSpu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 13:45:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBCDC6FD19;
	Tue,  4 Mar 2014 13:45:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4FpezQqDiOxT46w2PpZE8KkASUk=; b=r4fFnM
	BpS0dc1BdkBtdkgfWqDGNaH+z3gXW244/eE2PHxVh5OUVnrNshxwbcYn3sog2SqM
	sprAvR5E171e+epCiL3VmA18EzXVQKAplP1Yp9cScGy0rf8+4qmTfy3HAqhNpYsN
	mDjIv17PxMLibT6Z1JVzJdxFfdfyp+AefxkCs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FtVazoL+5qEF9IDqZhq50+wiwWDwEEqv
	v3rMtqNbTR1uv2s5Hu390SWVJyd9uDbDlvgpGjkBjPCVkEt9CTc/6kRfJsjB74jI
	TZbJAUZlh14f1fMimfMWdbspvV2/sKMIbIt7CK0k4fIzsJn/j8FxO9VdVtYkZTmj
	xse1c0Gkero=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B76306FD18;
	Tue,  4 Mar 2014 13:45:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EABF06FD16;
	Tue,  4 Mar 2014 13:45:48 -0500 (EST)
In-Reply-To: <53159A81.4050905@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 04 Mar 2014 10:18:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3424E4C6-A3CD-11E3-894D-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243369>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 03/03/2014 07:31 PM, Junio C Hamano wrote:
>> That is a very good sign why this change is merely a code-churn and
>> not an improvement, isn't it?  We know (and any strbuf user should
>> know) that ->buf and ->len are the ways to learn the pointer and the
>> length the strbuf holds.
> ...
> ... Writing strbufs comes up frequently and will hopefully increase in
> usage and I think it is a positive thing to encourage the use of strbufs
> by making them increasingly first-class citizens.

Yeah, I understand that.  I suspect that the conclusion would have
been very different if we were a C++ project; most likely it would
be an excellent idea to add an often-used write_or_die() method to
the strbuf class.  But we are writing C.

> Faiz, this is the way things go on the Git mailing list.  It would be
> boring if everybody agreed all the time :-)

Surely, and thanks ;-)
