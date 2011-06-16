From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log --follow doesn't follow a rename over a merge
Date: Thu, 16 Jun 2011 10:59:23 -0700
Message-ID: <7vy611hd38.fsf@alter.siamese.dyndns.org>
References: <BANLkTimjEp0ntq80qttT9uZN2YGuhsnZBw@mail.gmail.com>
 <m362o5vrhd.fsf@localhost.localdomain>
 <BANLkTik1-UvEXqzgdXwcK3x6_o8fDiwB7g@mail.gmail.com>
 <20110616173451.GB6584@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Blackburn <jamesblackburn@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 16 19:59:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXGqq-0001zY-P2
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 19:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155Ab1FPR71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 13:59:27 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61471 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932107Ab1FPR71 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 13:59:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C7AE659DA;
	Thu, 16 Jun 2011 14:01:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k3df1X35AfvBk7vwi8L2Lz4A4tM=; b=VFHD+K
	Pj4IzsDAJ5N8UJ5s875BFSDBpoU4K27LdIO/gkxH4VBD44c9cNJpvjw78hrXVm8M
	JcUrlxmoE3RBpDMHxRtuxuLm2cowsN3HeUp7PH0wZfR98uiykMTNYmK5Cq4/ybAb
	xDjxWrW3A3Jl6ACRTDZS2FmvEYv86yr8pI+WI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gQpZ8AiFXbQ4lIrL2zDVENtZkXdrxo49
	LwIId0E56PwO8EWAXJ9f+ATtPFsUa/Schh7LbQTPimWJbkOked/+bWAJtbZpO1xB
	UzMm1uBkZyS5zc2d7HQszWKteTbIzMlUqBjrHVBYvfpKvOJ/DU+NY2sdf5nvr/h5
	KkgB31lkCzA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BFF3859D9;
	Thu, 16 Jun 2011 14:01:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1F49559D8; Thu, 16 Jun 2011
 14:01:36 -0400 (EDT)
In-Reply-To: <20110616173451.GB6584@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 16 Jun 2011 13:34:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AD26A132-9842-11E0-A3D1-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175907>

Jeff King <peff@peff.net> writes:

> On Thu, Jun 16, 2011 at 02:31:02PM +0100, James Blackburn wrote:
>
>> I'm also interested in knowing what incantation I need to give to
>> actually get history of the file which was previously removed.  e.g. I
>> know the full path:
>>    plugins/org.eclipse.dd.dsf.debug/src/org/eclipse/dd/dsf/debug/service/IBreakpoints.java
>> used to exist, but without --follow, git log returns nothing.
>
> Doesn't:
>
>   git log -- plugins/org.eclipse.dd.dsf.debug/src/org/eclipse/dd/dsf/debug/service/IBreakpoints.java
>
> do that?

If the file emerged in one branch (either the primary or a side branch) in
the past as a failed experiment and then got removed before merging back,
i.e.

   past ---o----o-----o-----o-----o-----o-----o-----o--- now
            \                          /
             o----*----o----o----*----o
                  ^added         ^removed

then the merges are simplified away and you would not see it.

Perhaps simplify-merges option may help.
