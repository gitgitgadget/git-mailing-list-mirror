From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] fast-export: improve argument parsing
Date: Thu, 09 May 2013 21:49:02 -0700
Message-ID: <7v4neb5tj5.fsf@alter.siamese.dyndns.org>
References: <1368063095-22861-1-git-send-email-felipe.contreras@gmail.com>
	<1368063095-22861-2-git-send-email-felipe.contreras@gmail.com>
	<7vzjw37q7o.fsf@alter.siamese.dyndns.org>
	<CAMP44s2RYPENwsPAcoaKjmHxkuVA52vvRrQ_stmT_qY-Pmt6HA@mail.gmail.com>
	<7vy5bn68eu.fsf@alter.siamese.dyndns.org>
	<CAMP44s1GAeu5v5xqLu8BgisprmWN=C8zoFYNidoyBPXmu-cvJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 10 06:49:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UafGa-0000HQ-AP
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 06:49:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317Ab3EJEtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 00:49:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57744 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751009Ab3EJEtF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 00:49:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D6E416903;
	Fri, 10 May 2013 04:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=hIF73r5lhHe1xmDrDbwrVCNxu74=; b=u6tY4D5cPwaTq5bNJTBv
	hWGFbRKvUzgdQu2HyX3tBb+8MN7XKjwaKl6swnySbEZ1wT8PNJksXRgRr/VomUrI
	CD5I6Ohn/Uj71ox3hmN9n7YbJWv4NFU7OmH1j3RdbIf/HxLw5niE6tKmmvLiLAaU
	rq0DPOVv8wEGS73NWbnvVwU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=RG7GRiTb8TDNkOzBbPt99Tcx3AVs/qy0vP1Csi5kNLGdG0
	yTwUVAOBkILawkmMi5xo8d9O1xsurfzLRMMqR9vDQg0isFnaL9a0q7/Eu7G75uUu
	lVezoxpBZUqSJ+WtlSdcwCb0YP8OefvWpmUY65D5Qh1QwCoMfElPclQ+COGFA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 94D5816902;
	Fri, 10 May 2013 04:49:04 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1B06E16900;
	Fri, 10 May 2013 04:49:04 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F09FF5DC-B92C-11E2-BAF2-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223813>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, May 9, 2013 at 6:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> That is the kind of thing that needs to be said, not in the
>> discussion but in the history, either in the log or in a new test,
>> or both.
>
> If only I had known that when I wrote the commit message.

This is exactly what we review patches on the list for.  There is no
need to feel bad.  Nobody expects anybody to be perfect on the first
try.

Other people who may not know what the thought process of the author
was when the patch was written (or those who may not be as familiar
with the area in question as the author of the patch) can sometimes
spot a gap in the thought that is recorded in the patch.

Regarding the text of the patch in question, I am of two minds.  It
may solve the "--import-marks foo" to swap the orders, but I suspect
that may merely be shifting the problem and break rev-list options
(e.g. "--since 3.days") for the same reason.

In the longer term, setup_revisions() may need to allow its callers
to tell it what to do when it sees a parameter that it does not
understand.

There already is a similar cascading mechanism in place from
revision argument parsing to diff argument parsing (look for the
place where diff_opt_parse() is called in revision.c).  It may be
just the matter of adding a "struct option *" to rev_info and
calling parse_options_step() after diff_opt_parse() says "I dunno
about this option".

For the mechanism to be more flexible, we may want to give the
custom option table the caller of setup_revisions() gives us
precedence over revision/diff options, though.
