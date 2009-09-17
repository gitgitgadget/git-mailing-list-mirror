From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/4] reset: add option "--merge-safe" to "git reset"
Date: Thu, 17 Sep 2009 00:07:39 -0700
Message-ID: <7vr5u6jbgk.fsf@alter.siamese.dyndns.org>
References: <20090917040835.4048.51057.chriscool@tuxfamily.org>
 <20090917041440.4048.16353.chriscool@tuxfamily.org>
 <7vk4zykv7o.fsf@alter.siamese.dyndns.org> <4AB1D957.20902@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Sep 17 09:08:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoB69-0006Ex-Vw
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 09:08:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757084AbZIQHIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 03:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756745AbZIQHIA
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 03:08:00 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33828 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756743AbZIQHH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 03:07:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 71FC035025;
	Thu, 17 Sep 2009 03:08:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/X22IMhl5grNPpRnXAVXe6c1H20=; b=BLI/Py
	mOUuEGk1wszbj6cKwe0fBK+TXHil53zNXUTDmS4g7Q3XamDjLGGnrU7uTc/ENUgR
	ggYVaIsmFxQLaJjyjEbWA56FpycbiX7zORJGavtiancWHnvrmZQM7+8mp4hVP3iN
	3Ix5Sv0EkOkZqe5vVThVJplf54yvLj7KGEtsA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R1j3IWZjOf6dgVIh5xd2CQ1M1Hq3bNMJ
	wfRe2ei+weNaz9Iv/12J+0JgcYi2BhGUuRu57dfK7wXL7006ltTwhqNkWs/Q0001
	gLEVIrhwvtt0CAzxiPLjKEzoRt0hHiio4lsVBh0hEozGgu9DQxZ7WL0MHvu972G7
	p6P9YNacg70=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A76435024;
	Thu, 17 Sep 2009 03:07:53 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6B16E3501A; Thu, 17 Sep
 2009 03:07:43 -0400 (EDT)
In-Reply-To: <4AB1D957.20902@viscovery.net> (Johannes Sixt's message of
 "Thu\, 17 Sep 2009 08\:38\:15 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D1316552-A358-11DE-ABE7-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128718>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Junio C Hamano schrieb:
>> As we established in the previous round, this is _different_ from --merge,
>> but *not* in the sense that --merge is more dangerous and users should be
>> using this new option instead, but in the sense that --merge perfectly
>> works well for its intended use case, and this new option triggers a mode
>> of operation that is meant to be used in a completely different use case,
>> which is unspecified in this series without documentation.
>> 
>> In that light, is --merge-safe still a good name for the option, or merely
>> a misleading one?
>
> Do I understand this correctly?
>
> (1) The intended use-case of --merge is to "reset _a_ merge".

See my review comment for the previous round where I described the
intended use case of "reset --merge" and explained why discarding the
changes to the index is _the right thing_.  It is to throw away the
changes that was done to your index by an either completed or conflicted
merge.

> (2) The intended use-case of --merge-safe is to point the branch head to a
> different commit, but to carry the changes that currently are in the index
> and wd over to the new commit, similar to checkout --merge.

I have _no_ idea what the intended use-case of --merge-safe is, and that
was why I asked Christian for clarification in the previous round.  The
answer was still not clear enough so I pointed out --merge-safe could be
still doing a wrong thing even in _his_ use-case.
