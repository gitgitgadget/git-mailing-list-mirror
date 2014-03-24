From: Junio C Hamano <gitster@pobox.com>
Subject: Re: with reuse-delta patches, fetching with bitmaps segfaults due to possibly incomplete bitmap traverse
Date: Mon, 24 Mar 2014 13:30:58 -0700
Message-ID: <xmqqmwgfpce5.fsf@gitster.dls.corp.google.com>
References: <532CFC6F.8000008@fb.com>
	<20140322125626.GA22890@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Siddharth Agarwal <sid0@fb.com>, git@vger.kernel.org,
	bmaurer@fb.com, Aaron Kushner <akushner@fb.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 24 21:31:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSBWa-0006dn-Nt
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 21:31:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754070AbaCXUbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 16:31:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53145 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753593AbaCXUbB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 16:31:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CD6276582;
	Mon, 24 Mar 2014 16:31:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z3UDjpdZWoywMIJ4qgZrDNQzXo8=; b=d93odP
	xgMrYfhWrMNHE8E30A0y3KYpDh5zbRE+5VRdcsWlQGRDRmm/x724+E+kWfizFSBO
	VQis2E9PLijmDFqnuA0Infa8SzB1eKN8PsWq5lVFsLSpiR1D4iNer6AGH3UYGEOZ
	Zlpa9KY1mgNDz1vGxHC7B7WuNaLeVNM4/1l6M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZP1zQe0zqmhMrSh+17cgBXJ0gv1bHiC9
	jqwfNu+TuIuwpSmo/9KuDCqnwNds9ZyX8YbQRQvjz4bbPM3o3lNWWvOnE7acQoqI
	Hp6ftB9UzfF0/nNba+n1DV0HNHy2xf7MecfRIKqfa8uU5Mw7uGbvb1hGMMwsECxa
	1D7SHtN4NXk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C9DF76581;
	Mon, 24 Mar 2014 16:31:00 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B6CCE7657F;
	Mon, 24 Mar 2014 16:30:59 -0400 (EDT)
In-Reply-To: <20140322125626.GA22890@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 22 Mar 2014 08:56:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 35EE5D66-B393-11E3-8E7C-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244866>

Jeff King <peff@peff.net> writes:

> On Fri, Mar 21, 2014 at 07:58:55PM -0700, Siddharth Agarwal wrote:
>
>> At Facebook we've found that fetch speed is a bottleneck for our Git repos,
>> so we've been looking to deploy bitmaps to speed up fetches. We've been
>> trying out git-next with the top two patches from
>> https://github.com/peff/git/commits/jk/bitmap-reuse-delta, but the following
>> is reproducible with tip of that branch, currently 81cdec2.
>
> Is it also reproducible just with the tip of "next"? Note that the
> patches in jk/bitmap-reuse-delta have not been widely deployed (in
> particular, we are not yet using them at GitHub, and we track segfaults
> on our servers closely and have not seen any related to this).

Nice to hear.  I was worried for a short while if I merged what was
not cooked well, before I realized that Siddharth is on a codebase
that is more bleeding edge than I use myself ;-)
