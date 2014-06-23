From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 0/5] verify-commit: verify commit signatures
Date: Mon, 23 Jun 2014 14:23:20 -0700
Message-ID: <xmqqoaxjb9rr.fsf@gitster.dls.corp.google.com>
References: <cover.1402655838.git.git@drmicha.warpmail.net>
	<cover.1403506792.git.git@drmicha.warpmail.net>
	<20140623172805.GD4838@sigill.intra.peff.net>
	<xmqq61jrcy3d.fsf@gitster.dls.corp.google.com>
	<20140623210930.GB15766@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 23 23:23:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzBiA-00074o-Hu
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 23:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755369AbaFWVXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 17:23:30 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50978 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755332AbaFWVX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 17:23:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 90D67235A5;
	Mon, 23 Jun 2014 17:23:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J7o27Mvy8FOvUzrG8ws8i+E7LLA=; b=V0m4Q0
	yksaI7W7iIrcEM2gCw62VHrKuVc3PyCqnOtRzwXozPjOkeh/5AOLCbgSFHOEtw3s
	o3RRPYv3dMtlNWm2dpWl/IsLjqoCto7lZolF+6mBgTR6jDy47De9I83kRfSJJcZQ
	ptVv8IyqLeULR699mGjLnOYkpBmMHArofTLOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WL+6lmYEos3+zHd2lhETEXplThLdb63n
	KHa057kxhHaGvdM2+au/4hkyCFH1Jvmmv1aKOPwi4+CxhmlF3pKpVA+9L/+22A50
	0tJ9FeU7zUa/3yu6M+kgkYpe87NLuV7ZKsSu7n/KMixXLPdSaFJ/++Xa4p2/+ww4
	jN+bJncEtV0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8790D235A4;
	Mon, 23 Jun 2014 17:23:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AE7172359E;
	Mon, 23 Jun 2014 17:23:17 -0400 (EDT)
In-Reply-To: <20140623210930.GB15766@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 23 Jun 2014 17:09:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 97E52E3E-FB1C-11E3-BF7B-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252370>

Jeff King <peff@peff.net> writes:

> On Mon, Jun 23, 2014 at 10:52:38AM -0700, Junio C Hamano wrote:
>
>> > The one thing that does give me pause is that we do not seem to have any
>> > way of accessing mergetag signatures. We should perhaps stop and think
>> > for a second about how we might expose those (and whether it would fit
>> > into the "git-verify-{commit,tag}" paradigm). I am tempted to say that
>> > "git verify-tag" on a commit should verify the mergetag (right now it
>> > would simply be an error). But I haven't though that hard on it.
>> 
>> I agree that "verify-commit" that lives next to "verify-tag" is fine
>> and does not have to wait for a unified "verify" that may not even
>> be a good idea, but if we were to verify the mergetags in one of
>> these "verify-$OBJECTTYPE" commands, I would think "verify-commit"
>> should be the one to check them, for the simple reason that they
>> appear in "commit" objects, not in "tag" objects.
>
> My thinking was the opposite: it is a signature on a tag, but that
> signature happens to be stuffed into a commit object. But I do not have
> a strong feeling either way.

Well, the whole point of storing mergetag inside commit objects is
so that these transient "please pull, here is a tag to prove you
that it is from me" tags do not have to be kept in the history;
hence people who are following along only see commits and not tags.
The signature being sent via a signed tag from the requestor to the
integrator is merely an implementation detail after the mergetag is
recorded and when people would want to verify them.

So...
