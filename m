From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] optionally disable gitattributes
Date: Wed, 27 Jan 2016 03:59:21 -0800
Message-ID: <xmqqy4bb8c86.fsf@gitster.mtv.corp.google.com>
References: <20160127095021.GA25281@ecki.hitronhub.home>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Jan 27 12:59:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOOky-0006Wu-LJ
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 12:59:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753010AbcA0L7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 06:59:25 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52896 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752259AbcA0L7X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 06:59:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 070D23992A;
	Wed, 27 Jan 2016 06:59:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/IArhpyf8snKeunEDsxaymNKEWY=; b=ITKdWN
	TPpJICcr7PKbveQG7hkSHEEDJWCyz6oxr8iTMBHpSc29fMWevsJQyxqPpqJrAX3J
	hDdGTVWZiFAng98FokZ4KJETKw+LbPisCFLr8WE4/GHas94l/zTkdY/EVQbDEUK0
	b1hnLV5yWq+oP7JGAv/YMHGaaRwJ4uiyFOUf4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q2E3xkT4J+Xgv/4NUVRRR8jcXbWyOpLd
	OHFYg9TUejoE1aoxIPzzW+hbm8dIqYUrmmhgHRsw7l1BGsNsQqMRw9htkIX2z50W
	fs/hzeBP/iqnjFBobKaKEt50CTS+PaYbLIyP6Qp91MKSzctpbKuJxcyNOPA5xFNO
	fBOS71+E6Wc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F321239929;
	Wed, 27 Jan 2016 06:59:22 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7780F39928;
	Wed, 27 Jan 2016 06:59:22 -0500 (EST)
In-Reply-To: <20160127095021.GA25281@ecki.hitronhub.home> (Clemens Buchacher's
	message of "Wed, 27 Jan 2016 10:50:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 675B9C3E-C4ED-11E5-BCB3-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284909>

Clemens Buchacher <drizzd@aon.at> writes:

> If committed files are not normalized, adding gitattributes has the
> side effect that such files are shown as modified, even though they
> were not actually modified by the user, and the work tree matches
> the committed file. This is because with gitattributes, the file is
> modified on the fly when git reads it from disk, before it compares
> with the index contents.
>
> This is desirable in most situations, because it makes the user
> aware that files should be normalized. However, it can become an
> issue for automation. Since Git considers the work tree to be
> dirty, some operations such as git rebase or git cherry-pick refuse
> to operate. Those commands offer no flag to force overwrite work
> tree changes. The only options are to commit the changes, or to
> remove gitattributes, but that changes the repository state, which
> may be undesirable in a scripted context.
>
> Introduce an environment variable GIT_ATTRIBUTES_DISABLED, which if
> set makes Git ignore any gitattributes.
>
> Signed-off-by: Clemens Buchacher <drizzd@aon.at>
> ---

Is the problem you are trying to solve related to the issue we
discussed recently in a nearby thread?

That is, even after "reset --hard", if the result of converting the
contents in the index to the working tree representation and then
converting that result back to the normalized representation does
not match what is in the index, Git would sometimes say that the
working tree contents differ from the index?

I think the change in this patch has some uses, and I think the
issue we discussed recently in a nearby thread indeed is a problem,
but I do not think there is an impedance mismatch beween the two, so
I'd like to first make sure you are trying to solve the problem I
think you are trying to solve.
