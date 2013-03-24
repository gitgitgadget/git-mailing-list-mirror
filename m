From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [regression?] trailing slash required in .gitattributes
Date: Sat, 23 Mar 2013 22:25:30 -0700
Message-ID: <7v8v5d4bed.fsf@alter.siamese.dyndns.org>
References: <20130319175756.GA13760@sigill.intra.peff.net>
 <20130319181042.GA14295@sigill.intra.peff.net>
 <20130322222438.GA13207@sigill.intra.peff.net>
 <7vzjxv3uef.fsf@alter.siamese.dyndns.org>
 <20130323083927.GA25600@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <avila.jn@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 24 06:26:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJdSD-00074P-67
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 06:26:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752551Ab3CXF0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 01:26:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57269 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751449Ab3CXF0V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 01:26:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD70C8D95;
	Sun, 24 Mar 2013 01:25:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qbvbOoMuTIcMIjYlmCEuoJ281Xo=; b=KVwMoM
	952SSlL3j2t9Z0dXvGVAAd1GnDmIxqLrylFeB1vXJsfnOg3R8Pp5XrkuGcLesUwz
	D0qOvoF7sfGtDP3E8D+RTrz5ZUfRR4/T18S2PD9STwOmiibTX6x3NyOsBiLSoR+7
	BBzeWN9VWPXYUnGrfzRNS/beBOWIulGXUFHBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m4e7r5j+kGgLmgorvtF3OhGf6IVGoXfI
	pfVEq8wZ0SFns6+Kzd3isqBZb3+F/fj5gnlgEhUhZch+x+09cH50wrpU3/MXLP1A
	cULHnVfXVvfNd4mR9dyXtpl7LMaznB20W5owJPPKXBzb2NcNYmDuESQhdJ5pSFzW
	IIH7fkRFm8w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2ADB8D94;
	Sun, 24 Mar 2013 01:25:32 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5631A8D93; Sun, 24 Mar 2013
 01:25:32 -0400 (EDT)
In-Reply-To: <20130323083927.GA25600@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 23 Mar 2013 04:39:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3F8026B8-9443-11E2-A9F0-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218936>

Jeff King <peff@peff.net> writes:

> Yeah, that is a possibility, though it involves casting away some
> constness. Patch is below, which seems to work.

Hmm, because this was after I read this part:

> ... match_basename, despite taking the length
> of all of the strings we pass it, will happily use NUL-terminated
> functions like strcmp or fnmatch.

I actually meant to do that inside match_basename(), not in one
particular caller of it.  Otherwise, new callers to match_basename()
will also suffer from this broken API that pretends as if it takes
counted strings but uses strings as NUL terminated, no?

> It still feels really ugly to me, and like match_basename is misdesigned
> and should respect the lengths we pass it.

Exactly.
