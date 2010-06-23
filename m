From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] builtin/checkout: learn -B
Date: Wed, 23 Jun 2010 11:36:06 -0700
Message-ID: <7vr5jxegvd.fsf@alter.siamese.dyndns.org>
References: <7vpqzlrmo4.fsf@alter.siamese.dyndns.org>
 <1277140782-4064-1-git-send-email-rctay89@gmail.com>
 <1277140782-4064-2-git-send-email-rctay89@gmail.com>
 <1277140782-4064-3-git-send-email-rctay89@gmail.com>
 <1277140782-4064-4-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Clemens Buchacher <drizzd@aon.at>,
	Michel Lespinasse <walken@google.com>,
	Erick Mattos <erick.mattos@gmail.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 23 20:36:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORUoG-0003mQ-4v
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 20:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753243Ab0FWSgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 14:36:23 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34438 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753226Ab0FWSgW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 14:36:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 967CEBEA66;
	Wed, 23 Jun 2010 14:36:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KpvyVggvHXE8GPyK8bksSJ/GsnM=; b=PaWYdl
	p5Ux69bRqaCGP0b+J7cOaSg7BnmJ/067wBjjKMYUlkVzj3ZBEMcVmlN4Zv5qCI6S
	4WPQlxFyEEy2Kp2anBDdtIR/UdedK2DPF8FEc45ud2eSZ7NofdAT3UCnczexO7Sq
	12zzsHCkZThYy3dTGb5ElbSvQBM6+KRvrvDV0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LAL3zLFELIMYM8NXfGFzZiFftymleGd6
	Zu/RiffGrfnsDYWbC2LDYqlhhHNA2ZWc2mCyHnvum6DhrRmUatwD7aNlQHfm0iAQ
	By+jR98VFLqjOdzVlxvG2hXEvIDrdvSCSNUflxPL6bO92a7K3W78iRKANhVcfSMd
	3xx+5dgZ6Us=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 33068BEA65;
	Wed, 23 Jun 2010 14:36:15 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E969CBEA5E; Wed, 23 Jun
 2010 14:36:07 -0400 (EDT)
In-Reply-To: <1277140782-4064-4-git-send-email-rctay89@gmail.com> (Tay Ray
 Chuan's message of "Tue\, 22 Jun 2010 01\:19\:42 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 34741E24-7EF6-11DF-86D4-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149529>

Tay Ray Chuan <rctay89@gmail.com> writes:

> diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> index 261dd90..5849e13 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -31,6 +31,13 @@ were called and then checked out; in this case you can
>  use the `--track` or `--no-track` options, which will be passed to
>  'git branch'.  As a convenience, `--track` without `-b` implies branch
>  creation; see the description of `--track` below.
> ++
> +If `-B` is given, <branch> is created if it doesn't exist; otherwise, it
> +is reset. This is equivalent to
> ++
> +------------
> +$ git branch -f <branch> [<start point>] && git checkout <branch>
> +------------

It is somewhat sad if these are truly equivalent.  In the above sequence,
"git checkout <branch>" could stop to prevent you from clobbering your
local changes, but at that point the branch has already been updated.

I was hoping that the check (and stop) can be done first and then the
branch head is cloberred after you know you will succeed the checkout.
