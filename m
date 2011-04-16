From: Junio C Hamano <gitster@pobox.com>
Subject: Re: textconv not invoked when viewing merge commit
Date: Sat, 16 Apr 2011 09:23:21 -0700
Message-ID: <7vtydyb1xi.fsf@alter.siamese.dyndns.org>
References: <4DA415AB.9020008@drmicha.warpmail.net>
 <20110414190901.GA1184@sigill.intra.peff.net>
 <7vipughbxh.fsf@alter.siamese.dyndns.org>
 <7vd3kohb5n.fsf@alter.siamese.dyndns.org>
 <7v8vvcha2s.fsf@alter.siamese.dyndns.org>
 <20110414202356.GB6525@sigill.intra.peff.net>
 <vpq62qg3sxy.fsf@bauges.imag.fr> <7v7havckgg.fsf@alter.siamese.dyndns.org>
 <20110416014758.GB23306@sigill.intra.peff.net>
 <7v39lid8uz.fsf@alter.siamese.dyndns.org>
 <20110416063353.GB28853@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Peter Oberndorfer <kumbayo84@arcor.de>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 16 18:23:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QB8Ho-000873-St
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 18:23:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611Ab1DPQXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2011 12:23:42 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38128 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667Ab1DPQXk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2011 12:23:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A7DDC53C9;
	Sat, 16 Apr 2011 12:25:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OWoS/GLjYqSsMsvpADCpbHuhQqw=; b=Dn8aXY
	8x5k2tRlJy+1qiwrc6Wkqaz67OXFCyDXli4r0XDHg5mdeFNBh+o9rvcQuEd95obL
	xb1X3l7cPDFZKDieWzDp5FRBN2z2vaUaMy5944TM/hCWzL5hrQSvA/+qPjcem5h+
	TAnaNcowg7FbuoDUUfqsbgihdUZnLwI2AXnRs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FBpp0KNupfRuTstflGFlzP+ovBQcAw07
	txDg80JlIAA1jiSScQvqt8sw9cz8V1QipLWlveAJQWWgwhbpSCvnxi4HbL/IjTQ9
	WFH8sMl7n0Rcoqhl102/+3Y5GQZkGD0iR9XXo6EbkySCQP7y0BINTp1TrNi2HZFD
	EKIK7YPvX+8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3660B53C8;
	Sat, 16 Apr 2011 12:25:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9EAB553C7; Sat, 16 Apr 2011
 12:25:23 -0400 (EDT)
In-Reply-To: <20110416063353.GB28853@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 16 Apr 2011 02:33:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2526B2F8-6846-11E0-9396-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171676>

Jeff King <peff@peff.net> writes:

> OK, but what do you intend to do for a plumbing command _without_
> --textconv? I think what it is doing now (pretending that lines in the
> binary file are relevant, and either truncating output on NUL or spewing
> NULs to the output stream) is just wrong.

Oh, no question about it.  "Binary files differ" codepath needs to be
added, and independent of if we want to add a fallback textconv.

> Ick, why? That pseudo-diff contains no additional interesting
> information that is not already there (since the "index" line already
> contains the blob sha1s).

True enough.

The only case that might make a difference would be if one side was binary
and the other side and the result was text, in which case the user can not
just see but read the result, but I don't think it is worth caring about.

Also unlike my weatherbaloon patch, Michael's approach (if it is updated
to pass the whole diff options structure instead of just one "do we care
about the textconv" bit to intersect_paths() function) will let us
determine if the combined path should say "Binary files differ" a lot
early, so there is no need to worry about what to do on binary files in
the places we would be adding textconv anymore.
