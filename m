From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git archive invocation using sha1 to specify commit
Date: Wed, 29 Feb 2012 00:46:59 -0800
Message-ID: <7v7gz6uiv0.fsf@alter.siamese.dyndns.org>
References: <CA+OUE96-mLc0RJZz0g0oBWxdZKeCMQ9xJbg6DjCacN119TFY+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Zdenek Crha <zdenek.crha@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 29 09:47:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2fBl-0008IB-Fp
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 09:47:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755761Ab2B2IrE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 03:47:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34817 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754519Ab2B2IrC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 03:47:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE4D84A32;
	Wed, 29 Feb 2012 03:47:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=62K0mPsj94WLRaJx9OQBeZmaUio=; b=VzTizx
	KLotD1eZpUaF5SjheIDzyBikakgcGLmG+kS9xNPMnLy8IFNmnl+chRU2FUAZf8Vk
	iNtytJ8wJnUcTp7N1L8/N7hzodpmT7Nl8Ly7LL6ZNWLHv36mP9MbnS2Gx7HrL/tr
	yX4HRRTtULtS7JAslutGvlCu6f0S3QCipFcmA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K2jZtk+RZRMZXofHGYI26EOYZwW0+yOC
	onEH6cGebCqwhEk1fd0KZ6vppGyXS2q25dDS3iOHdk6s+yjDCREHzS2lkH9c0h6I
	RenHV9DfXhtzshNKkEWhRsxnveITpK1iRrHgeh3FE8KstbJ0CyCXg1q88gyXpxeq
	h5AzoDKBMFc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5A034A31;
	Wed, 29 Feb 2012 03:47:01 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6184E4A30; Wed, 29 Feb 2012
 03:47:01 -0500 (EST)
In-Reply-To: <CA+OUE96-mLc0RJZz0g0oBWxdZKeCMQ9xJbg6DjCacN119TFY+A@mail.gmail.com> (Zdenek
 Crha's message of "Wed, 29 Feb 2012 08:45:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F271BEAE-62B1-11E1-B840-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191821>

Zdenek Crha <zdenek.crha@gmail.com> writes:

> In out company we are using git together with source indexing. We
> store a git command for retrieval of source code file that was used
> for building into pdb file(s). Currently,...
> ... I'm not sure whenever ability to export arbitrary sha1 will be
> allowed too.

No, that will be a premium feature that your company _could_ pay for with
the source of that "source indexing" system ;-)

Jokes aside, this was part of a security tightening to make sure nobody
could reach something that cannot be obtained by cloning, without incurring
large computation overhead.

Theoretically we could selectively loosen the restriction [*1*], but it is
not very high on our priority list.


[Footnote]

*1* When the given starting point is a raw SHA-1, we could run a single
merge_bases_many() to see if any of the refs can reach it, and only serve
the tree the check passes, or something.
