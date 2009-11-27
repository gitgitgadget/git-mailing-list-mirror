From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] format-patch: fix dashdash usage
Date: Thu, 26 Nov 2009 16:03:00 -0800
Message-ID: <7vhbsg25sb.fsf@alter.siamese.dyndns.org>
References: <1259262720-24077-1-git-send-email-felipe.contreras@gmail.com>
 <1259262720-24077-2-git-send-email-felipe.contreras@gmail.com>
 <7vd4355aaw.fsf@alter.siamese.dyndns.org>
 <94a0d4530911261414o533aa108l202d4c6926da361e@mail.gmail.com>
 <7v7htc3mqo.fsf@alter.siamese.dyndns.org>
 <94a0d4530911261523q25147f12h2e6c9e4fe4f6b12b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 27 01:03:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDoIt-00058Y-Jo
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 01:03:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627AbZK0ADD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 19:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752549AbZK0ADD
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 19:03:03 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59752 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359AbZK0ADB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 19:03:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7A341A192F;
	Thu, 26 Nov 2009 19:03:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4svOSv0nYkqqHr2g1DVRjgIkqnY=; b=dcNwze
	N3qcBEcvdYQBYAwVDxTfFR5Esa0tiUBjM9CsVCbbACcGJNAYUB3IA9m7flsqq40z
	NkwiMuADcZeDFdy2gIxJ+AGLxVJ5Li2SxVJ047P8CgNjJVo8cPBMH4g15lwE5u1t
	fjeDr9TPdxL3RkIa7+jv+M8KlDxJGxNpVyy9A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bMwSO5yLILQ2l2CxZyruf+KXdpyjrhE4
	HXXSiwAwizNSNRvnNCleOp+w13JJdQPkQEf5KkcrL8h0ETzWy+ep8x3fwxspS5UX
	OJCPSYNcBtuYBxOuyBPlVZEz7pY0Z4Sh84AHCT6mAohtUZsXZn5sUks2lPIAEoq7
	V0tdWMnY3Ek=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 527FFA192D;
	Thu, 26 Nov 2009 19:03:05 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2C5E2A192C; Thu, 26 Nov 2009
 19:03:01 -0500 (EST)
In-Reply-To: <94a0d4530911261523q25147f12h2e6c9e4fe4f6b12b@mail.gmail.com>
 (Felipe Contreras's message of "Fri\, 27 Nov 2009 01\:23\:01 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3CA8D4FC-DAE8-11DE-AE47-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133851>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> How about 'git format-patch --full-diff'? Isn't that a valid way to
> filter patches just like --author, --grep, and so on?

Our messages obviously crossed and I think we are in agreement that
pathspec that only is used to pick which commit to show and not limits
which parts of the chosen commits are shown might have some uses.

In any case, your patch we are discussing, with a proper commit log
message (without discussing if it is a good idea to give pathspecs) would
be a good first step, regardless of which direction we end up going as the
next step.

As to the "next step", my current thinking, unless there are convincing
arguments why there should be a way to also limit the parts of the commits
are shown, is to

 (0) take your patch with an updated message (eh, that is not "next step"
     but the "first step");

 (1) make --full-diff implicit and default of format-patch (--no-full-diff
     could be supported _if_ somebody can argue successfully why limiting
     the diff is also a useful thing to do); and

 (2) document clearly that format-patch takes optional pathspecs, and in
     what situation they are useful.

I think (0) is 'maint' material, and with a good documentation update (1)
and (2) could also be.
