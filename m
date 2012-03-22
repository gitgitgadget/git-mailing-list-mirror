From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Demonstrate failure of 'core.ignorecase = true'
Date: Thu, 22 Mar 2012 09:57:23 -0700
Message-ID: <7vbonozi8c.fsf@alter.siamese.dyndns.org>
References: <1332370222-5123-1-git-send-email-pj@irregularexpressions.net>
 <4F6ACB67.1080503@viscovery.net> <4F6B0C3E.8090501@in.waw.pl>
 <20120322141245.GB8803@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Johannes Sixt <j.sixt@viscovery.net>,
	"Peter J. Weisberg" <pj@irregularexpressions.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 22 17:57:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAlKS-0003VV-Nr
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 17:57:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965042Ab2CVQ52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 12:57:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50771 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964871Ab2CVQ50 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 12:57:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CCB5E650C;
	Thu, 22 Mar 2012 12:57:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3gNW+kkWLLJlIR1c7CS8eRU7Uw4=; b=ZdZrpY
	UBujiIu1M90e+mdewEIv0T8IiLph4jiLOiRffHeAueRDz+4ThgCx2q3vh8hL5o35
	oH6xLD2io328BkPVJAlJ5bvhBt5kPbX7YZ9CWhqjkcIxWu3jnlwepUdGJxMN1PYN
	xhTmURAKbbYIxdIg47/VEr5rYl59Nr6PZImcs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r5k2/npGkd5RbWRu6hcNHbkE3nFoPdqp
	/2HiVxV2n3oDQ8M/o8R4jvqwY5KYuG/WM/ry0ptgXvCr+SJWHNrpUHjIWuPJepwg
	9M50wS4lMvasJHSpFvjw2ucfeQle2Zl6XC26WtPgUAD204OMkkWe0SNl6bEeNQVH
	yxYUbcN1aYY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C4762650B;
	Thu, 22 Mar 2012 12:57:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 531206506; Thu, 22 Mar 2012
 12:57:25 -0400 (EDT)
In-Reply-To: <20120322141245.GB8803@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 22 Mar 2012 10:12:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 199176F6-7440-11E1-9722-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193664>

Jeff King <peff@peff.net> writes:

> I don't know. It says:
>
>   If true, this option enables various workarounds to enable git to work
>   better on filesystems that are not case sensitive, like FAT. For
>   example, if a directory listing finds "makefile" when git expects
>   "Makefile", git will assume it is really the same file, and continue
>   to remember it as "Makefile".
>
> which seems pretty clear to me that this is "let git work better on
> case-insensitive filesystems", not "make git magically case-insensitive
> on case sensitive filesystem".

Yes, it says what it needs to say quite clearly.

> But maybe we could add be more explicit,
> like:

Hrm, replacing unclear part with clarified text may make sense, but it
would not help adding new text if the existing description is not clear
enough.

How about doing it like this?

   Case-insensitive filesystems like FAT and HFS+ have various strange
   behaviours, like reporting that a file "Makefile" already exists when
   the file that actually exists on them is "makefile". By setting this
   variable to `true`, Git employs logic to work around them.

   The default is false, except that git-clone[1] and git-init[1] will
   probe the filesystem and set it to `true` as necessary when a new
   repository is created.
