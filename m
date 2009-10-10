From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] disallow refs containing successive slashes
Date: Sat, 10 Oct 2009 14:50:18 -0700
Message-ID: <7vws327wbp.fsf@alter.siamese.dyndns.org>
References: <4AD0C93C.6050306@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Oct 10 23:52:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mwjrn-0007yS-QR
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 23:52:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756861AbZJJVvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Oct 2009 17:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756029AbZJJVvI
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Oct 2009 17:51:08 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56883 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503AbZJJVvH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Oct 2009 17:51:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C9D1B53163;
	Sat, 10 Oct 2009 17:50:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+kLAoZn7fFZKrDVH5be7eOTyUXU=; b=cjtnjF
	j66ifb9ZKhwQy0i7RbAKr0hm5ewXzVZkNGh7Wjlb14qCLfew6uueiNopBSXWPeQj
	Pjli5YSDHrGVQM5WdUXSbYRMFdwJzdZPla5ecEXtiO9Dq2JTHJuvszWLq4xKEGxp
	qCLUwqyllwR3zh3W20YYJ8SHlgC1+PMcf7Xxo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dzxPY32LWLG1wx9nVLCEBeohK0eSVsbJ
	akuoPU5oFYp+pLqvGrqd3wCrFIWDCNSD4vUTf51y6O/UJovKSs1JgKPNbhVfOaTk
	5LdlImNZ1UugHhs90FN+TblscEpfywlyIasxx8qkJMVG6hO1YTPbTSZxrCoG0iuU
	UwhXKBu73Rw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AA5D653162;
	Sat, 10 Oct 2009 17:50:22 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 119605315F; Sat, 10 Oct
 2009 17:50:19 -0400 (EDT)
In-Reply-To: <4AD0C93C.6050306@web.de> (Jens Lehmann's message of "Sat\, 10
 Oct 2009 19\:49\:48 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E92A511E-B5E6-11DE-865F-E80E3AD9C332-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129897>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> When creating branches using names starting with '/' or containing a '//',
> a leading slash would just vanish and successive slashes were 'compressed'
> into just one slash.

Hmm.  We already do that without your patch.

    $ git branch /foo//bar
    $ git for-each-ref --format='%(refname)'
    refs/heads/foo/bar
    refs/heads/master
    $ git branch -d /foo//bar
    Deleted branch /foo//bar (was deadbeef)
    $ git for-each-ref --format='%(refname)'
    refs/heads/master

> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---
>
> I became aware of this issue while looking into problems occuring
> when a user created a branch starting with a '/' in git gui (e.g.
> "/foo"). Strange things happen, while git gui shows the current
> branch as "/foo" under the hood a branch "foo" (without the slash)
> had been created. But then you can't delete "/foo" from git gui,
> because a branch of that name doesn't exist.

Perhaps an interface to give a cleaned-up version, e.g.

    $ git check-ref-format --print refs/heads//foo/bar
    refs/heads/foo/bar

is what you want in order to fix git-gui?  I dunno.
