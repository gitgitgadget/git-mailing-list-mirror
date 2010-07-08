From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 5/6] fast-export: Fix output order of D/F changes
Date: Wed, 07 Jul 2010 23:04:44 -0700
Message-ID: <7voceiqzk3.fsf@alter.siamese.dyndns.org>
References: <1278480034-22939-1-git-send-email-newren@gmail.com>
 <1278480034-22939-6-git-send-email-newren@gmail.com>
 <7vy6dnrmvu.fsf@alter.siamese.dyndns.org>
 <AANLkTiklqqxUhTBd4In-VQed_SMQ6X0nk2j2ysE20bmD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org, agladysh@gmail.com
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 08:05:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWkEM-0006oB-6N
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 08:05:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753318Ab0GHGE7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 02:04:59 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60831 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092Ab0GHGE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 02:04:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B380DC2F0B;
	Thu,  8 Jul 2010 02:04:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M6QpONIFtKQD3pDySMdRSPY9p7U=; b=JapL9o
	5bGS9aSSW7kOOU2dgrv89T2rUG0grUja9novHUEM0wdkF5b7shLmE4BDAkztd+QJ
	94Mu1yTPTLl8lq3FurNmaNUzGCjz2vm1n72gObvPXE9jEfMsUZ5Ru2jzTO9vx3dn
	muRRlA01uWy1nzrLhdQR3kPApmBT5xDUkIlsg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qkx2qzh18Ch/FuA/xoHnp406PXbmaCOT
	MyBjSN/Jbk14SskP1ssnBWK7zlhIPdwoUOjT6u3O5Lj2Qmo35ZOBJXJ0FbVGAWIG
	3ZQtkkE/NfAjz46i4iOJcVPMkCmsFkNPOkwXsQno97HWXxsTy0j5hq8+l7dEeuIp
	GuHTKeqjbCU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B9D9C2F0A;
	Thu,  8 Jul 2010 02:04:51 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9186DC2F09; Thu,  8 Jul
 2010 02:04:46 -0400 (EDT)
In-Reply-To: <AANLkTiklqqxUhTBd4In-VQed_SMQ6X0nk2j2ysE20bmD@mail.gmail.com>
 (Elijah Newren's message of "Wed\, 7 Jul 2010 22\:36\:38 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B8A617F4-8A56-11DF-8E97-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150538>

Elijah Newren <newren@gmail.com> writes:

>>> We correct the order by instructing the diff_tree machinery to compare
>>> entries using df_name_compare instead of base_name_compare.
>
> Doh! Yep, you're right.  My patch would not handle that case
> correctly.

If all you want is to force a particular order of paths in the output
(e.g. depth first) in this one single application, the cleanest way might
be to let the diffcore do its work and at the very end sort the elements
in the diff_queued_diff to your liking (c.f. diffcore_fix_diff_index()
that uses diffnamecmp() to sort the list).
