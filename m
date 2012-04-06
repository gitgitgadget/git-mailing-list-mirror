From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] argv-array: Add argv_array_pop function [v2]
Date: Fri, 06 Apr 2012 09:49:19 -0700
Message-ID: <7vvclc24c0.fsf@alter.siamese.dyndns.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1333654745-7898-1-git-send-email-nhorman@tuxdriver.com>
 <1333654745-7898-2-git-send-email-nhorman@tuxdriver.com>
 <7vd37m5458.fsf@alter.siamese.dyndns.org>
 <20120405232429.GA8654@hmsreliant.think-freely.org>
 <7vobr53bbe.fsf@alter.siamese.dyndns.org>
 <20120406022058.GA16264@sigill.intra.peff.net>
 <7v4nsx2vu1.fsf@alter.siamese.dyndns.org>
 <20120406073314.GB27115@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Neil Horman <nhorman@tuxdriver.com>, git@vger.kernel.org,
	Phil Hord <phil.hord@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 06 18:49:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGCLo-0005uM-Nm
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 18:49:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755110Ab2DFQtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 12:49:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39258 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754882Ab2DFQtW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 12:49:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 02E9B7308;
	Fri,  6 Apr 2012 12:49:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rvN+8oGuh1g0vxOVi+hpQJEBR10=; b=AIXoKF
	IeDJkLiySi+uTbIG9VfC9b7e1mMtpkvm0LK3h90VLbnwNFexnAPMJVNwUMXlflBP
	4ABpfQCrNkM09gUTaIb8F9wKlFhb1e4djZFgdEnSdap+L/TVtT86FcKbVleexdCw
	zJsH027MmQWZ65BDfd0Q+aJT04hHeQ523Ufd8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=is6UpqiL8kPlv03L6c7aEVBW3D3YvQVi
	SO6Qm3Ukn04/VSnAQy4sFH2pRyAau3RU2hMdHwZ/EHoN1BLsgX/ip//5sgsuJ9JR
	vYJdTGVBC7J+BD64Q18uCp7nAFArSope4gEL8v6qdHC5Q4TqPRsVqnPSxYllHfy5
	yz1r5KI2Ufg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E64897307;
	Fri,  6 Apr 2012 12:49:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F8087306; Fri,  6 Apr 2012
 12:49:21 -0400 (EDT)
In-Reply-To: <20120406073314.GB27115@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 6 Apr 2012 03:33:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7544ED9C-8008-11E1-A066-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194880>

Jeff King <peff@peff.net> writes:

> On Thu, Apr 05, 2012 at 11:55:18PM -0700, Junio C Hamano wrote:
> ...
> I've played with that workflow before. While it's a neat trick, note
> that something like "format-patch -s" will put the signoff at the end,
> like:
>
>   commit subject
>
>   commit body
>   ---
>   Cc: whomever
>   Signed-off-by: you
>
> which is not what you want.

Well, then "don't do it then".  The reason the Cc: was abused in this
thread originally is about recording the people who reviewed, so you are
doing an amend of an existing commit in an editor.  Why wouldn't the
commit that was already reviewed at least once didn't have S-o-b in the
first place?  In other words, isn't the "-s" option in "format-patch" a
useless feature creep that would only help those with broken workflows?

> About a year ago I had an RFC series to let "git commit" parse off the
> "---" bit and turn it into a git-note ...
> ... Ultimately I didn't follow up because
> I've found that I just don't end up keeping a lot of notes. I tend to do
> the re-roll and then send it out pretty soon afterward, so I just write
> any notes in the emails as they go out.
>
> For complex "cc" lists and the like, I have a (fairly hacky) script that
> takes an existing message as input and generates a format-patch series
> with the to, cc, and in-reply-to fields filled in (and then I ship the
> result out via my regular MUA after proof-reading and tweaking).
> Potentially git-send-email could do the same thing.

Perhaps.
