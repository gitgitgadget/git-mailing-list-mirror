From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Porting git to HP NonStop
Date: Mon, 20 Aug 2012 07:41:37 -0700
Message-ID: <7vy5l9lj6m.fsf@alter.siamese.dyndns.org>
References: <003a01cd7709$63725260$2a56f720$@schmitz-digital.de>
 <CAJo=hJvwih+aOMg6SKP94_1q-az1XV-1Pcf=_fGbvdDcDpC23A@mail.gmail.com>
 <004701cd771e$21b7cbb0$65276310$@schmitz-digital.de>
 <CAJo=hJsz3ooDAV-0S-BDknnbQPK9ASEYw8b7t7PyKEtJ5jgxQA@mail.gmail.com>
 <01a801cd7de8$b4c311a0$1e4934e0$@schmitz-digital.de>
 <7v628epzia.fsf@alter.siamese.dyndns.org>
 <000601cd7ebd$a4ef5740$eece05c0$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "'Shawn Pearce'" <spearce@spearce.org>, <git@vger.kernel.org>,
	<rsbecker@nexbridge.com>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Mon Aug 20 16:41:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3TAs-0005uD-QU
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 16:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756668Ab2HTOll (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 10:41:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41554 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754703Ab2HTOlk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 10:41:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F8509821;
	Mon, 20 Aug 2012 10:41:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YTYrdxrm0NOOAiq6DtWlL/rzNMU=; b=v8Rwq7
	lj7TD4z3ojT8z53yjYNlAE9A5OrBc4R6adX9sBr8zMkr6ZfdaNudfy1l8TmB7yIU
	VQAUa9E6zEueaSOawjDRELxR1LUDLRyFESWazZjaXmL063FAC3NBjItYuKnfL8KI
	NnzFR46XgL50B7eLb/hd3RlWn/Lj3EKSmNCLg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s1jTTokFJfrnZUE8cex4BSRTdN+uvpcO
	QOcgVivoCs0P4J3DG/yCUgTaC82hSUC2mJo050HOyPAKRTNIhuZ/aCqxen1BygKk
	RyMC/+6w03Rcd7dzVeZBbRm0o/NQ/13zr2ESN9n5xaHqusdBEOogmmgxOetNA2T0
	S33cYsInPns=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C4459820;
	Mon, 20 Aug 2012 10:41:39 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9586C981E; Mon, 20 Aug 2012
 10:41:38 -0400 (EDT)
In-Reply-To: <000601cd7ebd$a4ef5740$eece05c0$@schmitz-digital.de> (Joachim
 Schmitz's message of "Mon, 20 Aug 2012 12:22:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 261D5776-EAD5-11E1-899C-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203847>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

> OK, I'll go for a compat/mkdir.c though.

No.  See below.

> We shouldn't call it tandem.c as Tandem, the Company, doesn't exist anymore
> and since more than a decade (bough by Compaq, then HP), only the __TANDEM
> survived in our compiler and headers/libraries. Could call it NonStop.c, but
> I don't really like that idea either, I'd rather keep it more generic, just
> in case someone else might need it too, or that issue someday gets fixed for
> NonStop.

compat/hp_nonstop.c is also fine, but I think matching "#ifdef __TANDEM" is
the most sensible.

And I wouldn't call it just "mkdir", as it is more likely than not
that we will find other incompatibilities that needs to be absorbed
in the compat/ layer, and we can add it to compat/tandem.c, but not
to compat/mkdir.c, as that will be another nonstop specific tweak. 
A separate file, compat/tandem/mkdir.c, is fine, though.

> I'll go for git_mkdir(), similar to other git wrappers, (like for mmap,
> pread, fopen, snprintf, vsnprintf, qsort).

Again, no.  Your breakage is that having underlying system mkdir
that does not understand trailing slash, which may not be specific
to __TANDEM, but still is _not_ the only possible mode of breakage.
Squatting on a generic "git_mkdir()" name makes it harder for other
people to name their compat mkdir functions to tweak for the
breakage on their platforms.  The examples you listed are all "the
platform does not offer it, so we implement the whole thing" kind,
so it is in a different genre.
