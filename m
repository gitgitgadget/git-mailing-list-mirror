From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC] show-branch: use pager
Date: Thu, 13 Jun 2013 10:33:40 -0700
Message-ID: <7vobb9vrt7.fsf@alter.siamese.dyndns.org>
References: <1371105811-3112-1-git-send-email-oystwa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, peff@peff.net,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 19:33:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnBPA-0006a6-7S
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 19:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756159Ab3FMRdo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Jun 2013 13:33:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48089 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752653Ab3FMRdn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Jun 2013 13:33:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39F4B27170;
	Thu, 13 Jun 2013 17:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=smNRrqpjnCVU
	j4md0aGAWRQmvK8=; b=fMr8AgOr17J4EUe3HXbUPv6rmGNyiIOQj++XuhcqMfvl
	yRjlVh1Cn1yGBy8n7BJhHPlikUdETf9P/qAWthFIfVIdcKOl+Do09AeB7R5fUhyX
	KrrOgGilEwMZ3Ct8+f1kak0DyAR9Ph3KfUA/zdUG/uxdO6mmNVxLbICFlFFbotw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=tOsIcv
	AIxB6FqODL6vKIWmkqaVc7X7nFjdNFnFXsCpnYHroyCgrbBsXGd4sQwJgPwX1qtR
	miz1oE9Ks65xvSiQbu1aLyF+h9zCh4iPkQyAhswnkroSHHVz93yZ7akkMB4Kc5VV
	yt7IrRsKs9Ur1ejbbe/vXjSAICKInDdXk4zp0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CC432716F;
	Thu, 13 Jun 2013 17:33:43 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A2CC62715E;
	Thu, 13 Jun 2013 17:33:41 +0000 (UTC)
In-Reply-To: <1371105811-3112-1-git-send-email-oystwa@gmail.com>
 (=?utf-8?Q?=22=C3=98ystein?=
	Walle"'s message of "Thu, 13 Jun 2013 08:43:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 63D25918-D44F-11E2-B3F8-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227751>

=C3=98ystein Walle <oystwa@gmail.com> writes:

> This is for consistency with other porcelain commands such as 'log'.
>
> Signed-off-by: =C3=98ystein Walle <oystwa@gmail.com>
> ---
> The rationale for this patch I hope is consicely explained in the com=
mit
> message. I was rather surprised it didn't use a pager as I've gotten =
used to it
> for most commands.
>
> I marked this as an RFC because of Jeff King's comments in
> daa0c3d97 where I got the impression this this might not be a good id=
ea.
> However I haven't found any bugs and all the tests pass.

The tests are run largely without tty to allow them to run
unattended, aren't they?

I think it makes a lot of sense to use pager by default for the
normal show-branch output.  I however do not think pager should
apply to other modes (e.g. --independent, --merge-base).

But the use of these other modes are meant to be on the upstream
side of a pipe or to be written out to a file, so a blanket call to
setup_pager() before you even discover what mode we are in would not
hurt in practice.
