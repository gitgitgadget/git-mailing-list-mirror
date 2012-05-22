From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] fetch-pack: avoid quadratic loop in filter_refs
Date: Tue, 22 May 2012 13:16:34 -0700
Message-ID: <7v396s3ra5.fsf@alter.siamese.dyndns.org>
References: <20120521221417.GA22664@sigill.intra.peff.net>
 <20120521222329.GE22914@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Fick <mfick@codeaurora.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 22 22:16:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWvVa-0004hr-Az
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 22:16:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317Ab2EVUQh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 16:16:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35311 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753440Ab2EVUQh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 16:16:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FFEA8458;
	Tue, 22 May 2012 16:16:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M52LPEHelOhUfMv/iiN59q2O98M=; b=UPi6ir
	eaieDynzaXxY20YvdsxGh1172V/HM4UpYgKPL9PlHBXEQH+l59Gp9a/r17cFv7Qd
	Ei6OVVVjZmF7rv/rA3JsKTFPEAWvp50qR85CyQhkh0sey/a3aXv4gCF99eyth70w
	+Isl4iGeftKEVFEqkpgIypxJ0d4uLU5Gk9Kj8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GgTBQfY3NhCPdBdOv7WAx3sseyPSpnKr
	g/vtw8vqcjopXO2DO0qd1yZ37GQHCt9Y6cA9SFAj1YlKIVeDFtdDeQbRD+Fu59B5
	Pm1ModNi1dSJ4jYiPNQ0Hkcqc1AWld/DDirIGuA4bS4xL77t/kwJ3HF9jcWgo3mN
	MR6ZdwaDC3Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 774678457;
	Tue, 22 May 2012 16:16:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0DD098455; Tue, 22 May 2012
 16:16:35 -0400 (EDT)
In-Reply-To: <20120521222329.GE22914@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 21 May 2012 18:23:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 07F2EB6A-A44B-11E1-8110-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198237>

Jeff King <peff@peff.net> writes:

> We have a list of refs that we want to compare against the
> "match" array. The current code searches the match list
> linearly, giving quadratic behavior over the number of refs
> when you want to fetch all of them.
>
> Instead, we can compare the lists as we go, giving us linear
> behavior.
>
> Signed-off-by: Jeff King <peff@peff.net>

Nice.  Thanks.
