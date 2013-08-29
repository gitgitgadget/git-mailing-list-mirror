From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/5] replace: forbid replacing an object with one of a different type
Date: Thu, 29 Aug 2013 09:04:03 -0700
Message-ID: <xmqqli3k7abw.fsf@gitster.dls.corp.google.com>
References: <xmqqk3j6c1x0.fsf@gitster.dls.corp.google.com>
	<878uzmclva.fsf@linux-k42r.v.cablecom.net>
	<xmqqa9k1a9wq.fsf@gitster.dls.corp.google.com>
	<20130829.082936.1893875995125817253.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: trast@inf.ethz.ch, git@vger.kernel.org, philipoakley@iee.org,
	j6t@kdbg.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Aug 29 18:04:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF4hp-0001ak-WC
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 18:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376Ab3H2QEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 12:04:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36861 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752200Ab3H2QEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 12:04:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B7F93B5B2;
	Thu, 29 Aug 2013 16:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Zy1LIRApnyUkM/0P/jruBUq9udY=; b=CfND7l
	IC4gTkaCJ5CkWVRt0qYVLPdD6JT0a3efwGGOePN+dvYk7VaAu2X4aJ8iziJ0SY2w
	0NLUN2dahiCwa3gz08X9i3+66c3m9xfbRCQZGjZ7r9cjdCqgOfWbzhGqTO4HzF6M
	6d79jmQ+TMgiDV3yxZO9TiDrib5rQQ5Bz7vOw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NQNNpKXHw5KONWJmCzrlwNQl37mHP6T8
	VYw/Hk8oReoQJTlNXuIPkro77umEONe3KfSML9Gn6bmurqgyOvkaAARBK0c7xlrB
	aVYVOlmpSYniTdzbnt6XrOxTbvcXI2H2DppZhGU7kydy/VMz1ZMfkKorsiPsjwor
	owMO1/4exJ8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BE563B5B1;
	Thu, 29 Aug 2013 16:04:08 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F20643B5A8;
	Thu, 29 Aug 2013 16:04:05 +0000 (UTC)
In-Reply-To: <20130829.082936.1893875995125817253.chriscool@tuxfamily.org>
	(Christian Couder's message of "Thu, 29 Aug 2013 08:29:36 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A17A539A-10C4-11E3-9D6B-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233282>

Christian Couder <chriscool@tuxfamily.org> writes:

> But if all the objects that point to an object, called O, are to be
> replaced, then in most cases object O probably doesn't need to be
> replaced. It's probably sufficient to create the new object, called
> O2, that would replace object O and to replace all the objects
> pointing to object O with objects pointing to O2.

Hmmmm.

What the above says, with "probably" and "most cases", can easily
inferred by anybody remotely intelligent, and the only reason to
have something like the above paragraph would be if it assures that
the statement holds without these qualifications to weaken it, which
it doesn't.  I am not sure this paragraph adds much value.

> The only case where someone might really want to replace object 0,
> with an object O2 of a different type, and all the objects pointing to
> it, is if it's really important, perhaps for external reasons, to have
> object O's SHA1 point to O2.

The same comment applies here.

> And anyway, if one really wants to do that, it can still be done using
> "git update-ref".

And I really do not think this sentence is right---you can justify
with the same sentence to remove "git replace" wrapper.

The earlier suggestion to bypass the new hand-holding with "--force"
is more sensible, I think.
