From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] retain reflogs for deleted refs
Date: Fri, 20 Jul 2012 08:42:57 -0700
Message-ID: <7vliietp4u.fsf@alter.siamese.dyndns.org>
References: <20120719213225.GA20311@sigill.intra.peff.net>
 <20120719213311.GA20385@sigill.intra.peff.net>
 <7vy5mftm3q.fsf@alter.siamese.dyndns.org>
 <20120720144337.GA31946@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alexey Muranov <alexey.muranov@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 20 17:43:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsFMA-0008WH-2B
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jul 2012 17:43:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753162Ab2GTPnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jul 2012 11:43:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33841 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751829Ab2GTPm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2012 11:42:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4078679A9;
	Fri, 20 Jul 2012 11:42:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vfCTyEldik0iLec4qTQziEL+CsQ=; b=YzXv5e
	tDlAkCXLZWDw+BBDPHSuK7V4IWr2RcdsbQY+DeJUX1eG1dqA0pEXnFpcqkj7dNxj
	WXuQwq73s47Idx/QkVW1G9lIx8xQQhrTpeWmbc1lFwp9MsOPYXYEA/IfAOvikJ9a
	PRtFtccD88LZ7GoTu68yLd7cwjXePWqToAvbI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dGjaMf8K4/sH3EKTeJoakamHrt2SNc3v
	xJ2Sj+c4jzAxGhS3VusN8tq8GKrHoolefHj+Y8vQ8739laBjm0GC4a4hSKBPqQFu
	lltMnGNu7k2fpDTVDELgL1BxYR19esKnVXgxlEDg0Xs1oQ2TTVUKHXHa3xJLe41Z
	6qD2ZISThqY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E53379A5;
	Fri, 20 Jul 2012 11:42:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A254E79A4; Fri, 20 Jul 2012
 11:42:58 -0400 (EDT)
In-Reply-To: <20120720144337.GA31946@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 20 Jul 2012 10:43:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 94CA3EA8-D281-11E1-A11B-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201775>

Jeff King <peff@peff.net> writes:

> But it would mean that you cannot naively run
>
>   echo $sha1 >.git/refs/heads/foo
>
> anymore. I suspect that the packed-refs conversion rooted out many
> scripts that did not use update-ref and rev-parse to access refs, but
> the above does still work today. So I suspect there would be some
> fallout. Not to mention that older versions of git would be completely
> broken, which would mean we need a lengthy deprecation period while
> everybody upgrades to versions of git that support the reading side.

We have that "core.repositoryversion" thing, so we could treat it
just like "update-index --index-version 4" to make it a "flag day
event for each repository, on the day of end-user's choice".
