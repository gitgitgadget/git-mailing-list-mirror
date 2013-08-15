From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Understanding Git Under The Hood: Trees
Date: Thu, 15 Aug 2013 10:31:47 -0700
Message-ID: <7vwqnmrhbw.fsf@alter.siamese.dyndns.org>
References: <CAB46HOnsOdYyt3sEe=iv3AJu_BDpTqCLKUpTBFQSnVGMZc8r8A@mail.gmail.com>
	<520CCC53.4090308@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Bernoth <erik.bernoth@gmail.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Aug 15 19:31:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA1Ov-0007AX-MF
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 19:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758246Ab3HORbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 13:31:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35317 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756829Ab3HORbw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 13:31:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2C5F39EA7;
	Thu, 15 Aug 2013 17:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OUgVuDYKa5AknhZdWimO71TvC/c=; b=MGhCtq
	a1OjiFfIwfhkx7KpfGaFI1k2uOZuypfavDJ9QQImJRn71gVP3r5G4c8+oCHq0/7N
	4Y2Ak02b/UM/mUgmDEGachMKRZr0Ik+zUUVW2awYTRhNQ3IIc/in6ZZfIha70zrk
	DukIZjM0IljsrvaAosfk4KQcCJ6vL9t5Q5ePo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kPfKI2DYUE6QL9cvkL+gEhDtV8PUhsec
	t4LgLXki3KvUHIzXObwYCGxTlaaK/JpabLLrDAE9mv6CdONuXdZG00HHoWlho42r
	UnQ802MFsZuk65IDaHEhoy9XpQhdT1xCAD/cMx5HCXhjRi6pZtfQ9576h/sIBqSX
	+ssE5+p19oU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB68039EA6;
	Thu, 15 Aug 2013 17:31:51 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4881339EA2;
	Thu, 15 Aug 2013 17:31:49 +0000 (UTC)
In-Reply-To: <520CCC53.4090308@op5.se> (Andreas Ericsson's message of "Thu, 15
	Aug 2013 14:40:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 90FC96EE-05D0-11E3-BFB2-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232354>

Andreas Ericsson <ae@op5.se> writes:

> You seem to believe that the in-memory representation of trees have to
> be the same as the on-disk one. That's simply not true. Git cheats
> outrageously with internal formats for pretty much everything in order
> to squeeze out more performance.

While the last statement applies to other parts of the system, it is
not true for the in-core index design.  We always had a flat index,
and it is not cheating at all.  The original "tree" was also a flat
representation of everything under the sun, and hierarchical tree
objects came much later.
