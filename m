From: Junio C Hamano <gitster@pobox.com>
Subject: Re: test-mergesort conflict with stdlib.h
Date: Tue, 17 Apr 2012 10:46:09 -0700
Message-ID: <7vd376ntem.fsf@alter.siamese.dyndns.org>
References: <E6D295C2-C35E-4ECF-990D-FCF8407C2429@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 19:46:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKCTq-0001Zi-Ph
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 19:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753485Ab2DQRqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 13:46:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61904 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753330Ab2DQRqN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 13:46:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E249D743B;
	Tue, 17 Apr 2012 13:46:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3aB4oClEs/givglAzzwcluXLXzE=; b=gys+mY
	TsKNC+dh32NahwjQGeK9BHGpQDzsV0gKXX8ztIbankQoZuSTYJn2b4XcN+QTHSRA
	ao++IIqSchUd2nBzcoIosoavtRjCi08XlOVRoIaF+ldzVxu2GKuPT2ycO6Ejudl2
	TSyXVGuU8duCIirje70GG/rAPapA4e+fkqZRw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t/TLC9jCWWN2/8HtJdZedqf4nU1+QSaz
	YBL6M860NY2RyJ9hjTTuI21+/mmzWUZbXb9imkmKwal93O+D4CldQ7APsg9F+r+x
	HQIJ0UVVxuWNnM0MLN69/qr/a4k5cmoaOxfm7Vt5QjQv5yI1bAkIH9rxAfgRVykK
	16wiM8mlbvc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA3FB7427;
	Tue, 17 Apr 2012 13:46:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7675C7426; Tue, 17 Apr 2012
 13:46:10 -0400 (EDT)
In-Reply-To: <E6D295C2-C35E-4ECF-990D-FCF8407C2429@gernhardtsoftware.com>
 (Brian Gernhardt's message of "Tue, 17 Apr 2012 13:25:48 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 37D483A4-88B5-11E1-AE1B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195774>

Brian Gernhardt <brian@gernhardtsoftware.com> writes:

> On OS X 10.7.3, I get the following error attempting to build next:
>
>     CC test-mergesort.o
> In file included from test-mergesort.c:2:
> ./mergesort.h:4:7: error: conflicting types for 'mergesort'
> void *mergesort(void *list,
>       ^
> /usr/include/stdlib.h:306:6: note: previous declaration is here
> int      mergesort(void *, size_t, size_t,
>          ^
>
> This appears to be due to the fact that 0db71e0: "add mergesort() for
> linked lists" added a mergesort implementation with a different
> signature than a mergesort implemented by OS X's standard library.

Unfortunate.  OS X shouldn't contaminate the user namespace by adding such
names in stdlib.h (which incidentally has qsort()), but the damage is done
already, so I am not opposed to rename it to llist_mergesort() or something.
