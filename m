From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase: add --verify-signatures
Date: Wed, 16 Dec 2015 10:12:12 -0800
Message-ID: <xmqqfuz2e003.fsf@gitster.mtv.corp.google.com>
References: <20151210130228.GA22641@netblarch.tu-darmstadt.de>
	<xmqq37vai0ev.fsf@gitster.mtv.corp.google.com>
	<xmqqy4d2gjw6.fsf@gitster.mtv.corp.google.com>
	<20151216133915.GA3586@blarch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Alexander 'z33ky' Hirsch <1zeeky@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 19:12:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9GZG-000551-At
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 19:12:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934677AbbLPSMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 13:12:17 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59175 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934392AbbLPSMP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 13:12:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7E1C8347DC;
	Wed, 16 Dec 2015 13:12:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YQhxAEXdkV4sDyvYyvkKUJ/8qf8=; b=r1CpWt
	vyvCFiPlHAojClm78zpLSJSKAjDyfVa6Je8dCrvSy47dMxfc/xEbCNuFxG2xYRJ9
	knxKJ7RWKYgZCCVjZuLyXu7zoCBQInC+f5jGaVskWnJH5kdNRCEKQAsTt/ngHEM8
	MJKxCJgc086KQnddFH+jfDnjVVp0zo6sWweVc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dFKFF9vAposgYMSiKTaJ6kVA/UojQXjD
	nTf0MKrv1VmQSZgZlRThmR4zL7ZeEzUrzdoKY3bLEqY/Q9ZgWRCdhxxzlQoLmIZq
	+YZDxch2wM2mbPr0upbphN4MXHPsJhCgyrs1Gu5i7icnKmEA+9X9hSkG3nQZtfS2
	v+eMmA0Ps+Y=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 756D0347DB;
	Wed, 16 Dec 2015 13:12:14 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C1394347D8;
	Wed, 16 Dec 2015 13:12:13 -0500 (EST)
In-Reply-To: <20151216133915.GA3586@blarch> (Alexander Hirsch's message of
	"Wed, 16 Dec 2015 14:39:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8858416E-A420-11E5-A536-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282579>

Alexander 'z33ky' Hirsch <1zeeky@gmail.com> writes:

> On Thu, Dec 10, 2015 at 11:53:45AM -0800, Junio C Hamano wrote:
>
>> In a workflow that is built around "pull --rebase", you are _given_
>> the authoritative history with all the good things from another
>> place and then you rebuild your own work on top of it.  The sanity
>> and cleanliness of what you built on top is given, and rejecting it
>> at that point would not help you make further progress in any way,
>> as that is a published history that is shared and more authoritative
>> than what you have.
>
> Well, the rejection would not refer to the work you put on top, but to
> the commits you want to base your work on.
> If validation fails, then an empty commit that is signed can be
> committed on top of the previously unsigned branch if commit rewriting
> is not allowed.

I do not quite understand how that would help anything.  I do not
personally believe in projects that wants to sign each and every
commit, but to them, "an empty signed commit on top" would not fix
anything once they have an unsigned commit at the tip of a public
branch.  And for those that care about only the tip to be signed,
instead of adding such an empty commit, you would rebuild and sign
your work on top of that unsigned public tip and push back---at
which point the tip of the public branch would have a signature from
you.  So such an empty signed commit would either not help, or not
necessary, to make the resulting history kosher again.
