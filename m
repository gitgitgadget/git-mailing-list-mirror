From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Add interpret-trailers builtin
Date: Wed, 06 Nov 2013 09:18:12 -0800
Message-ID: <xmqq4n7pa1pn.fsf@gitster.dls.corp.google.com>
References: <20131103211731.15716.95056.chriscool@tuxfamily.org>
	<xmqqli14yoqi.fsf@gitster.dls.corp.google.com>
	<20131106.074355.225932577498673677.chriscool@tuxfamily.org>
	<CAP8UFD0STna++2StV1RcT2bB83Lh_hFQU94A0y4ziovs61Z==A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 06 18:18:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ve6kH-0008Ss-53
	for gcvg-git-2@plane.gmane.org; Wed, 06 Nov 2013 18:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754509Ab3KFRSR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Nov 2013 12:18:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49299 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754235Ab3KFRSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Nov 2013 12:18:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E8A04EDEF;
	Wed,  6 Nov 2013 12:18:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=10zNrkFkN1yyFWLi/GIqB0bnBcM=; b=dS45lv
	EYm5F2kmradaDvCYrkPv7ntqhFd+DXvV9tYzRw8dgZEjaNw6AmpfRmK3Yt5F3blw
	0baVUIGZfIOkr05TuJYcj7as3e/QU+Oh0nFp4DV8gtxo6KAQ1JCusZiwdKfAkql3
	skkTY4f+gtuVEISyqMCuY3N5okcXrnezqEVRM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ezo3O+xBb936oJ1d/A31JiGOVIYosgYv
	0aduuWG+QbdNP3qdL1CIOQmEvHiFQuoNLRgQ3OPOuynGPptN/OWL5hOzrMzmgblf
	zQVHAz1dmjoMjTDrib+cWPE/8+yi+8tcIjkYjLp52QJvYjLdIsjGiKKTDv1rpegR
	xpUdKyQJx0M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9199F4EDEE;
	Wed,  6 Nov 2013 12:18:15 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D88EF4EDED;
	Wed,  6 Nov 2013 12:18:14 -0500 (EST)
In-Reply-To: <CAP8UFD0STna++2StV1RcT2bB83Lh_hFQU94A0y4ziovs61Z==A@mail.gmail.com>
	(Christian Couder's message of "Wed, 6 Nov 2013 10:23:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6BC5FAB4-4707-11E3-8C5A-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237358>

Christian Couder <christian.couder@gmail.com> writes:

> To append a s-o-b only if there is no s-o-b already, one would need to use:
>
> [trailer "signoff"]
>          key = "Signed-off-by:"
>          if_exist = dont_append
>          if_missing = append
>          command = echo "$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"'

But that is insufficient to emulate what we do, no?  I.e. append
unless the last one is from the same person we are about to add.
