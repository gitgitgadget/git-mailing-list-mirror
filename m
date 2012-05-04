From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] checkout (detached): truncate list of orphaned
 commits at the new HEAD
Date: Fri, 04 May 2012 12:51:28 -0700
Message-ID: <7vaa1nafnj.fsf@alter.siamese.dyndns.org>
References: <4FA41C3A.9080002@kdbg.org> <4FA41C98.2010105@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri May 04 21:51:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQOXR-000149-4g
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 21:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759591Ab2EDTvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 15:51:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41428 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759552Ab2EDTvb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 15:51:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81E6E7FC5;
	Fri,  4 May 2012 15:51:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nBPQqgH/FAiOA0HsWeGUQQ2drmM=; b=EhfgNE
	+FFRgakvuYUNWb1u2bU3EBFBvwhdig8eD1mIRM+vNshMQu26aJ3KDxgP3E7dh6b4
	cNPSjEdqbRSgXa2eo+erZgGD2kbUIGfmanD9gBrc6jhqMHRF77doB9UvfFxXV7Kq
	6R0AFGsyrNfLZgla14tTk1UZDiuG7mY7XY0D4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ate/5+0ACKRn+Kiz2QJ5WbRPl1DvbXfm
	KZynTr5AGgTMpFikMktqvqsXKK23axsFMetPbJdnq0aBGA5EVOgRaFgM+FrRy9rZ
	CBlG1vQtXg6Rbl6o8/qs54RQNj+Sq+qh8Qi2lB+NBhgrg9EPv8ZdWEi1mwCX0Pgv
	KHhrxr6ZtxI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79C867FBA;
	Fri,  4 May 2012 15:51:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C8BD7FB9; Fri,  4 May 2012
 15:51:29 -0400 (EDT)
In-Reply-To: <4FA41C98.2010105@kdbg.org> (Johannes Sixt's message of "Fri, 04
 May 2012 20:14:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8ADCE76A-9622-11E1-85A8-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197069>

Johannes Sixt <j6t@kdbg.org> writes:

> When git checkout switches from a detached HEAD to any other commit, then
> all orphaned commits were listed in a warning:
>
>   Warning: you are leaving 2 commits behind...:
>
>     a5e5396 another fixup
>     6aa1af6 fixup foo
>
> But if the new commit is actually one from this list (6aa1af6 in this
> example), then the list in the warning can be truncated at the new HEAD,
> because history beginning at HEAD is not "left behind". This makes it so.

If you did:

	git checkout master^0
        git commit --allow-empty -m emp0
        git commit --allow-empty -m emp1
        tip=$(git rev-parse HEAD)
        git reset --hard HEAD^

and then

	git checkout $tip

it used to warn about "emp0" but because you are checking out "emp1",
which is a descendant of "emp0", nothing is lost and no lossage is
reported with the updated code.

Makes sense; thanks.
