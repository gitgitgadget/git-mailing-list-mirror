From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V2 3/3] strbuf: allow to use preallocated memory
Date: Wed, 08 Jun 2016 11:07:53 -0700
Message-ID: <xmqqziqvlfk6.fsf@gitster.mtv.corp.google.com>
References: <20160606151340.22424-1-william.duclot@ensimag.grenoble-inp.fr>
	<20160606151340.22424-4-william.duclot@ensimag.grenoble-inp.fr>
	<xmqqvb1mxmk4.fsf@gitster.mtv.corp.google.com>
	<20160606203901.GA7667@Messiaen>
	<xmqqfusquedk.fsf@gitster.mtv.corp.google.com>
	<20160606225847.GA22756@sigill.intra.peff.net>
	<xmqqbn3dvr22.fsf@gitster.mtv.corp.google.com>
	<20160607090653.GA4665@Messiaen> <575845D9.2010604@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	antoine.queru@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	Johannes.Schindelin@gmx.de, mh@glandium.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 08 20:23:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAhta-0003tW-9N
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 20:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756935AbcFHSH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 14:07:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65158 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752826AbcFHSH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 14:07:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 01023206AF;
	Wed,  8 Jun 2016 14:07:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VB1ro7Cvbxr7DStQwsr7oHO6AZk=; b=gC+R3w
	8jX/QDeRpCBu6FqZpQPRydZmklcqNXkiBM3N3dm2UuOHxBsVCtRbjpH0vefnSjqU
	b7cT354GsItK5gOhDvU6I6e2bEohXIX/HRe7+JT/UkqXUHx6mTSH/exemDMCuHdv
	FXSZ28FIMPcnh3QEyMaa4pk37agaWC/hJBmYg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vqIDXjj0mvhv+68Egeh7HV1eoWj0MH3e
	m7YzTgVkOyT2/0IjhXFRBJ+mldsGGFwqviicNC2ZWYjROpV06Pe/X1k4eu6nGdBO
	iYlEMy36UFcof3HMi5FM9SQPZZnR+nM4ash2iX44wo0UUacYiypGhWXrtp8jvCU4
	QqSejv20704=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EBD31206AD;
	Wed,  8 Jun 2016 14:07:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6B7C4206AC;
	Wed,  8 Jun 2016 14:07:55 -0400 (EDT)
In-Reply-To: <575845D9.2010604@alum.mit.edu> (Michael Haggerty's message of
	"Wed, 8 Jun 2016 18:20:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ECAEE61A-2DA3-11E6-8AB9-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296826>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> * It's a little less manual bookkeeping, and thus less error-prone,
>   than the current code.
>
> * If somebody decides to add another character to the line but
>   forgets to increase the allocation size, the code dies in testing
>   rather than (a) overflowing the buffer, like the current
>   code, or (b) silently becoming less performant, as if it used a
>   preallocated but non-fixed strbuf.

Yeah, thanks.  A relization of pretty much the same came to me after
I wrote my last message on this topic.  The above two are
attractive.
