From: Junio C Hamano <gitster@pobox.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 19:06:05 -0800
Message-ID: <7vvdek70ma.fsf@alter.siamese.dyndns.org>
References: <ron1-2E17EF.12204629012010@news.gmane.org>
 <hjvgs1$rep$1@ger.gmane.org> <ron1-953427.13240429012010@news.gmane.org>
 <fabb9a1e1001291328s1df443d6jdf0501cda17072de@mail.gmail.com>
 <7vmxzwh906.fsf@alter.siamese.dyndns.org>
 <ron1-6C7BCB.14122429012010@news.gmane.org>
 <b4087cc51001291633l68760880i340d12e865641077@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ron Garret <ron1@flownet.com>, git <git@vger.kernel.org>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 04:10:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb3jS-0003dY-FX
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 04:10:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756211Ab0A3DGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 22:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756196Ab0A3DGP
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 22:06:15 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37011 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756193Ab0A3DGO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 22:06:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 637CF95483;
	Fri, 29 Jan 2010 22:06:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=7f1A0KaoE9isA/R1Z0QLzSA0IC0=; b=yFCSTNq5yGTtsS9lclflhet
	vxBysZreth9QuWUkVRGSuiUxYLWEw3thrFPXVXzln0Yx7J2EMtqstCUwdRLwWIV+
	zLlBpZx/w7DA2x7nMR/Sr17HI8B60f45ZONE2qjXoSP5BTfpP7TnqWVriMJDUTDW
	eMHE8j0MknPXsQM4gaEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=v3P+/C1HPzUEzw8H2FOxVoItmg1R/K+XoD3/r/QU8+4u9SAGW
	DEPcTQBv/i8aE2xVJKLzK4Gprn/zRKW6/WLzcU3soVhFCWcKcHFfbK0ZeekJw15P
	2jBVEK7g1T4fgBTJk5PbeSuNpP+y2RWy67tvEF/8ATbPBRXoI7gA3D77WE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 31D9295482;
	Fri, 29 Jan 2010 22:06:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 55B5695481; Fri, 29 Jan
 2010 22:06:07 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6B3430C8-0D4C-11DF-9AE3-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138431>

Michael Witten <mfwitten@gmail.com> writes:

> Isn't the difference between 'checkout' and 'reset' almost essentially
> a matter of whether the branch reference (HEAD), index, and tree are
> modified? Couldn't these commands be merged into one command or make
> use of one command?

I don't think that reduces any confusion.

By exposing orthogonal options like --index, --head, etc., you are opening
yourself to nonsensical combinations that were never possible with the
existing command set, and I suspect it would make it even more confusing,
not less.

What does "git update --detach $commit" _really_ mean, for example?

You can of course say "it detaches the HEAD at $commit, but otherwise does
not change anything else", but such a mechanical description does not give
an answer that helps end users.  "What would I do after doing that?" and
"What would I use this for?" are the questions they need an answer to.

What matters is "after doing this, next commit will record _this_, which
is often what users want in _that_ situation, and that is why this
combination of options makes sense."  Do all (or majority) of option
combinations to your "update" think have _meaning_ in that sense?  I don't
think so.

Flexibility and orthogonality is often good, but uncontrolled flexibility
is not.  And I suspect your "git update" is just an uncontrolled mess that
would not help users [*1*].

[Footnote]

*1* It is a different matter to have something like that as an ingredient
to build Porcelain scripts out of.  Porcelain writers may appreciate the
flexibility and they will choose to use only combinations that make sense
for the situation they are trying to deal with.
