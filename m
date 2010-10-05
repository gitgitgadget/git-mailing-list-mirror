From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tag,verify-tag: do not trip over rfc1991 signatures
Date: Tue, 05 Oct 2010 13:28:06 -0700
Message-ID: <7vr5g45qqx.fsf@alter.siamese.dyndns.org>
References: <4CAB46C0.9000807@drmicha.warpmail.net>
 <5cea498f34522d603a1561bfe69e2f92caa39ced.1286293083.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stephan Hugel <urschrei@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Oct 05 22:28:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3E7Z-0002hC-Pl
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 22:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757212Ab0JEU2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 16:28:17 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58551 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757208Ab0JEU2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 16:28:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D8C5DC44A;
	Tue,  5 Oct 2010 16:28:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FNtvJ7hSPik8j+/ZyojwV2radrI=; b=kEnOfY
	4fu2SWGITiBlRI498LEYWHs9qyjgSfONe+vUJH+fSQv8poo5y+jQzqi9aWsZcL0O
	aQypSy42eIyh3xjnkZjr5ypQ3OqUTKUC6t+g4a4iWXwH1Wavf+UgEvQ3WbN8NIo5
	FxgXu5cWnPnOWNEyyRt9pP20CgkRLhWKC3T5g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C/w5eBxMpxaisbEP5yqLNwhsQjEEzHw3
	XcAnBb5esT/oQ7coFyypOImpqcnrt0c0qTeFnm+Pp7xvuNOH/JSlOotmJH/QsmUn
	jUqaKXeLUiqE+iIaOXPsHPWd5Pp29ARZepK0kJT+81hm2L7q3zd9oJlTRgnvJag+
	pIsJfDwG8u4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CCA20DC446;
	Tue,  5 Oct 2010 16:28:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E936FDC443; Tue,  5 Oct
 2010 16:28:07 -0400 (EDT)
In-Reply-To: <5cea498f34522d603a1561bfe69e2f92caa39ced.1286293083.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Tue\,  5 Oct 2010 17\:40\:07 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 12DB003C-D0BF-11DF-80D9-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158233>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Currently, git expects "-----BEGIN PGP SIGNATURE-----" at the beginning of a
> signature. But gpg uses "MESSAGE" instead of "SIGNATURE" when used with
> the "rfc1991" option. This leads to git's faling to verify it's own
> signed tags.
>
> Be more lenient and take "-----BEGIN PGP " as the indicator.

Thanks, but it bothers me that the patch is a bit inconsistently lenient.

How many variants of PGP implementations are there?  For example, I'd ask
these without doing my own research because I am lazy:

 1. Does everybody place five dashes at the beginning (IOW, is there an
    odd variant that puts four or six)?

 2. Does everybody follow the dashes immediately with "BEGIN" (IOW, is
    there an odd variant that puts a SP between them)?

 3. Does everybody spell "BEGIN PGP " the same way, in all uppercase?

 4. Does everybody place five dashes at the end (IOW, is there an odd
    variant that puts four or six)?

 5. Does everybody follow the "BEGIN PGP SOMETHING" immediately with
    dashes without SP?

Your patch seem to answer <yes, yes, yes, no, no> to the above question.
I'd find it saner if the patched code at least checked that the line ends
with 5 dashes.
