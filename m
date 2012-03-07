From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/3] Fix memory leak in apply_patch in apply.c.
Date: Wed, 07 Mar 2012 15:39:43 -0800
Message-ID: <7vr4x4j800.fsf@alter.siamese.dyndns.org>
References: <cover.1331158240.git.jaredhance@gmail.com>
 <eadfc83a0d823cc04ea37bf606b57597fb632156.1331158240.git.jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jared Hance <jaredhance@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 00:40:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5QSh-0008Vu-En
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 00:40:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758954Ab2CGXjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 18:39:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65080 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758862Ab2CGXjp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 18:39:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06DD2676B;
	Wed,  7 Mar 2012 18:39:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=QpaxLvBtadpSDsJkoV+ILsRbGQ4=; b=dDi0RcOoxwhk66CpCAuF
	so+cmB+y9smhWgAEWkOWwvsTqnm/axCiLOd+H3TGEZsq0v9NLTNqgEDKXyFr56IA
	wn2FVSnIfaMFoVuBx2YYl37VjQPC1uy7noK/b+8xWivjHkNjPGkQz1iZC181ZTy4
	VaP0Z+UzKGdBIUVjxjTFC0o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=BwNFuxwcaa8Hf+U+yboJc1XoVM9fyePJqX9CYLW05G7s1F
	Qqk+A7bBbWxnkkcyWcav9a4ca4naireBeb5egWUGWZEhpnUT3CqR8CPqvNh76Bq7
	MyY3s9DUr4lntAf+/fCLPdAZ0oWr5iPzdd1dl2losNZ0YrWq7Cp2zxSE9aB6A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2DDA676A;
	Wed,  7 Mar 2012 18:39:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 842096769; Wed,  7 Mar 2012
 18:39:44 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D174AF06-68AE-11E1-A582-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192506>

Jared Hance <jaredhance@gmail.com> writes:

> In the while loop inside apply_patch, patch is dynamically allocated
> with a calloc. However, only unused patches are actually free'd; the
> rest are left in a memory leak. Since a list is actively built up
> consisting of the used patches, they can simply be iterated and free'd
> at the end of the function.
> ...

Thanks.

This more-or-less looks good modulo minor style issues.  We might
also want to make rejected a one-bit bitfield that sits next to the
new free_patch field to share the same word, but that is a separate
topic.

Will queue.
