From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git checkout: create unparented branch by --orphan
Date: Sat, 20 Mar 2010 13:30:57 -0700
Message-ID: <7v4okad9by.fsf@alter.siamese.dyndns.org>
References: <1268928579-11660-1-git-send-email-erick.mattos@gmail.com>
 <7vvdcrowlc.fsf@alter.siamese.dyndns.org>
 <55bacdd31003201206w6215c6a4qec09797fbe060725@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 20 21:31:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt5KK-0007cA-M4
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 21:31:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752401Ab0CTUbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 16:31:09 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45124 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339Ab0CTUbI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 16:31:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 758B7A3154;
	Sat, 20 Mar 2010 16:31:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=arsF4jdQNvyfMKzzEbt4TWfjbXc=; b=w55dt9
	Qa5okGpzmgZ3EyuXf9ZbZg8prrnhzGrz1kxWMr4NNu6gS+/fxlJLYNRUn3gxMVIr
	aUrMNJxdqXXdqGlnQ+x2izpvn9rf0LBwIqZpcYMo9N1l2GrpPocVP43fspagtWj+
	W9rtAeheza0OhWPXn26oXPvbQL9MsqkvJirfg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AY4w37UoJysJK+GbPYTfsT1cvAnovAEv
	gRngYd1cwYJxgYcJtLNIq/g4ZflS2Si9gIjuDfG9ZmjgXu+59b4qGpgHrcYzi9PL
	IjQVs6kSyDOTaKC2Z4tkIl/Qr87QJDay1Um2tyh5dN2QPQxurPIs6K8sr0XPzdkk
	91hY7Sr8yJg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F336A3151;
	Sat, 20 Mar 2010 16:31:02 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 727C6A314E; Sat, 20 Mar
 2010 16:30:58 -0400 (EDT)
In-Reply-To: <55bacdd31003201206w6215c6a4qec09797fbe060725@mail.gmail.com>
 (Erick Mattos's message of "Sat\, 20 Mar 2010 16\:06\:56 -0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8031FD2C-345F-11DF-B37D-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142745>

Erick Mattos <erick.mattos@gmail.com> writes:

>> With local changes in the index/working tree without "start commit" (which
>> should never fail) and with "start commit" (which should fail if HEAD and
>> start commit has differences to the same paths as you have local changes
>> to).
>
> It is behaving like that already and that is intrinsically a
> switch_branches() logic, not a special --orphan need.  It is not part
> of this implementation and It is probably tested elsewhere (you
> probably do know where).
>
>> Also you would want to check with -t, --no-t, branch.autosetupmrebe set to
>> always in the configuration with -t and without -t from the command line,
>
> The actual implementation is just ignoring track and -t is not even
> allowed.  So it is pointless.

I think you misunderstood the point of having tests.  It is not about
demonstrating that you did a good job implementing the new feature, or
your implementation works as advertised in the submitted form.  That is
the job of the review process before patch acceptance.

Tests are to pretect what you perfected during the patch acceptance review
from getting broken by other people in the future, while you are not
closely monitoring the mailing list traffic.  Many people, me included,
tend to concentrate on their own new addition, without being careful
enough not to break the existing features.  If "-t --orphan" should result
in an error, it should result in an error even after somebody restructures
the code, so it is not sufficient that it is obvious in the _current_ code
structure that breakage of that feature is unlikely.

If you can promise that you will be around on this list forever, and that
every time somebody posts patches to the related areas, you will make sure
that the changes do not inadvertently break this feature and respond to
the patches that do break it before they hit my tree, then theoretically
we do not need to have any test to make sure this feature keeps working as
advertised.  But we cannot ask that kind of time/attention commitment from
anybody.
