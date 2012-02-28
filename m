From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: allow {--amend|-c foo} when {HEAD|foo} has empty
 message
Date: Tue, 28 Feb 2012 13:12:49 -0800
Message-ID: <7vpqcyy84u.fsf@alter.siamese.dyndns.org>
References: <8529824c8569a8a0b4c4caf3a562750925758e74.1330419275.git.trast@student.ethz.ch> <20120228090540.GB5757@sigill.intra.peff.net> <20120228091422.GC5757@sigill.intra.peff.net> <87haybco1j.fsf@thomas.inf.ethz.ch> <7vr4xe27sq.fsf@alter.siamese.dyndns.org> <20120228195931.GE11260@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 28 22:14:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2UNQ-0003u5-CW
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 22:14:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756113Ab2B1VMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 16:12:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49130 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755470Ab2B1VMy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 16:12:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D49DB7DD0;
	Tue, 28 Feb 2012 16:12:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AZmxUTWZxmb5VXJ7B0tWqCRMBjA=; b=NfW2tJ
	0VYfYHxsOV5cooU4BmUXzU+e65afvL5jsIMdz667QYOmOnD/LSFNPR6uId8rwHup
	77hoFZieA42pfKjz3gJs8XAba2Cp1qTYexqUxER4FzXR5/ry00J/VnV1Ezij9CfA
	avupQLrUUsIV//A7uIoea/eInWQzVrPuQ1K4k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YSfaX0CyTatBCCOynHNdAnjo4U+8K7tx
	RkDajXwlZu+ESwNY+9bMqJy7dv6umHcq4wyjAFJiyZxTFsSJzJFrjAGNv7N9knbg
	+G/cygZcYEK1CHNMc/R3K6xjFRLFhyQvAMtwK4iW25ZubsVxJWdR6nvfxCBckGIA
	KvMt+NddLHQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB4897DCF;
	Tue, 28 Feb 2012 16:12:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 41E5A7DCE; Tue, 28 Feb 2012
 16:12:51 -0500 (EST)
In-Reply-To: <20120228195931.GE11260@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 28 Feb 2012 14:59:32 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F90873AE-6250-11E1-A8D7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191784>

Jeff King <peff@peff.net> writes:

> Yeah, I agree that treating it like an empty body is reasonable
> (possibly with a warning). But given that nobody has actually seen this
> in the wild, maybe it is simpler to mark it with fsck, and to just die()
> when we see it. That would hopefully alert the author of the broken tool
> early, before the tools is made public. If it turns out that such
> commits do end up in the wild, then we can relax the behavior then.

Yeah, it is not like we would want to encourage a commit with empty body,
be it preceded with "\n\n" or just a "\n", in the first place.

We would need to locate all the places that expect that strstr("\n\n")
will find something, and add die("commit made with a broken git") at these
places anyway, in addition to the change to fsck. Given that, I suspect
that the extra amount of the work needed to tweak the code to tolerate
such a commit and keep going might not be so big, and going that route
would avoid punishing the users of broken versions of git (or broken
imitations of git, for that matter), so...
