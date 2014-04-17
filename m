From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Update SVN.pm
Date: Thu, 17 Apr 2014 10:39:49 -0700
Message-ID: <xmqqwqenety2.fsf@gitster.dls.corp.google.com>
References: <20140416141605.GA9692@camelia.ucw.cz>
	<xmqq61m9gka6.fsf@gitster.dls.corp.google.com>
	<20140417052438.GA13907@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stepan Kasal <kasal@ucw.cz>
X-From: git-owner@vger.kernel.org Thu Apr 17 19:40:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaqIn-0001lH-UL
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 19:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbaDQRkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 13:40:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39608 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752196AbaDQRjx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 13:39:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 826807A13B;
	Thu, 17 Apr 2014 13:39:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=st+lHuUfphO7+TOUTOVaCsShe+U=; b=NGJ5p4
	pwQdWVfh0Smm1vuZFmdwvRiFda8lf1subZomGReg7ngVBDiUoRQhKL9UhIq2A/CH
	Fhto/nXLFidOzPSD2QyBA+qbcxifuuzAEIb65yaLEcaWeK2A7Ek+Js+dWStGLRkf
	vNpoA5B+4afaDMEXPVUn9+giJiXQh76MnslKU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KGIW6yJsrcY9CuMhEpARZGf4ZBCmv5A4
	M66YsKgHnMEldJwRp9vAvic+2JxjDWX3J9iDLSoeQhnX9t4zYOJv5Yr113E4pQkh
	6enZeZplu+/jKEJefmTtPmHFiKyQIagl3RnH6nC3mp2rknPY1fn7bhdsDihaRFLP
	TMpDCLaAmwE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 67C857A13A;
	Thu, 17 Apr 2014 13:39:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 085E57A137;
	Thu, 17 Apr 2014 13:39:50 -0400 (EDT)
In-Reply-To: <20140417052438.GA13907@camelia.ucw.cz> (Stepan Kasal's message
	of "Thu, 17 Apr 2014 07:24:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4739F2FC-C657-11E3-ADF7-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246428>

Stepan Kasal <kasal@ucw.cz> writes:

> On Wed, Apr 16, 2014 at 12:13:21PM -0700, Junio C Hamano wrote:
>> Interesting.  What other strange forms can they record in their
>> repositories, I have to wonder.  Can they do
>>     2014-01-07T5:8:6.048176Z
>> for example?
>
> Roman Belinsky, the author of this fix, witnessed after large scale
> conversion that the problem happens with the hour part only.

Is this "large scale conversion" done from a SVN repository that is
created by bog standard SVN, or something else?  How certain are we
that this "hour part is broken" is the only kind of breakage in
timestamps we would encouter?

What I am trying to get at is that "we didn't see any breakage at
positions other than hour part after checking 2 million commits" is
different from "there will no breakage at positions other than hour
part", and by being slightly more lenient than necessary to cover
one observed case that triggered the patch, we can cover SVN
repositories broken in a similar but slightly different way.

Especially given that this regexp matching is not used for finding a
timestamp from random places but to parse out the datum we find at a
place where we expect to see a timestamp (check the callers), I
think loosening to allow single-digit minutes and seconds in the
same commit that allows single-digit hours would be such "slightly
more lenient than necessary" change without additional risk of
mistaking something that is not a timestamp as a timestamp.

Thanks.
