From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: Provide situational hints for non-fast-forward
 errors
Date: Thu, 15 Mar 2012 11:06:26 -0700
Message-ID: <7vfwd9kacd.fsf@alter.siamese.dyndns.org>
References: <20120313232256.GA49626@democracyinaction.org>
 <7vobrzst7n.fsf@alter.siamese.dyndns.org> <20120314121434.GB28595@in.waw.pl>
 <vpqobrzgww9.fsf@bauges.imag.fr> <20120314142752.GD28595@in.waw.pl>
 <20120315085426.GA11003@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christopher Tiwald <christiwald@gmail.com>,
	git@vger.kernel.org, peff@peff.net
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Thu Mar 15 19:06:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8F4M-00088u-IL
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 19:06:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430Ab2COSG3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Mar 2012 14:06:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46801 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752022Ab2COSG2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Mar 2012 14:06:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AA407196;
	Thu, 15 Mar 2012 14:06:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vZE2DQDr85Xi
	5U+rIv0WPDWGPjs=; b=nRt2iKwHLAXWuT6wLa4STJP5gamVcnxh4PAI5YZZNAE3
	xgS5zp6M+tUzM/rpgARUg6FtcEFtUUXcjtvKvK0tW464/N77dUdDFhQvf4RNfUGc
	mXGa/KY6KAna8ThZ+MeIgtv1WTp0GJhQcvqoiU8Mp6HZ9oM6oesUd/LDv9ns0/w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=i3L+/3
	whYG/e3JfGetQo6qugeXzktDpqsyk53Y4ipRYml2+KPU0piDmVsAFJs2Lft0fKcx
	9Ed25pF6dx7XHBunmzDp28DzFHNCXJnLBkwOx1Z83dt9blKEQTMItC/PTcYX3mX/
	7ynks72COoUhei/e8KQ+FF54VayuifODGFAFA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4215B7195;
	Thu, 15 Mar 2012 14:06:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C195F7194; Thu, 15 Mar 2012
 14:06:27 -0400 (EDT)
In-Reply-To: <20120315085426.GA11003@ecki> (Clemens Buchacher's message of
 "Thu, 15 Mar 2012 09:54:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 95C5688A-6EC9-11E1-B589-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193220>

Clemens Buchacher <drizzd@aon.at> writes:

> On Wed, Mar 14, 2012 at 03:27:52PM +0100, Zbigniew J=C4=99drzejewski-=
Szmek wrote:
>> On Wed, Mar 14, 2012 at 02:00:38PM +0100, Matthieu Moy wrote:
>> ...
>> > The advice messages do not point explicitely to the way to disable=
 them,
>> > so users who know how to set advice.* are users who know a little =
about
>> > configuration files, and who read the docs.=20
>>=20
>> Elsewhere in this thread it was proposed to add an actual 'git confi=
g'
>> command to the advice.
>
> The proposed command does not turn off the advice. It only changes
> push.default. The advice about push.default is effectively disabled o=
nce
> they change push.default, but the other warnings are still in effect.

True.

I looked to see if some existing message that is triggered by advice.* =
has
an extra comment at the end to suggest setting advice.* to false to
decline seeing the advice in the future, as it feels like a sensible th=
ing
to do and also I vaguely recalled us actually doing such a patch, but I=
 do
not seem to be able to find such a message in the current codebase.

Nothing from a quick "git log --no-merges --grep=3Dadvice --grep=3Dadvi=
se"
pops at me telling that we used to have instructions on how to decline =
but
we deliberately removed them, so I probably is misremembering things.

We do mention them in git-config(1), but it may be hard to match the
variables to situations from the description there UNLESS the user alre=
ady
understands what the annoying "I know what I am doing, no need for this
advice anymore" advice is about.

Oh, wait.  Perhaps the advice messages are designed to be declined only=
 by
the user who do understand, so perhaps it is a *good* think that we do =
not
mention how to squelch in the message.  In a twisted way, the logic sor=
t
of makes sense.

I dunno.
