From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Help understanding git checkout behavior
Date: Mon, 11 Jun 2012 14:34:42 -0700
Message-ID: <7vk3zd5y8d.fsf@alter.siamese.dyndns.org>
References: <CAMUXYmUFbixgA1bVMA46Zzjed1Dwmjv54kWWXyjsuyu904GpTA@mail.gmail.com>
 <20120611202132.Horde.dPo1XHwdC4BP1jcsTvSBaFA@webmail.minatec.grenoble-inp.fr> <CAA3EhH+iD-sS-3Sg4HJDHgs4Deg2=qbCuJD4UwZWtGQsKbV5aA@mail.gmail.com> <7vaa097k3q.fsf@alter.siamese.dyndns.org> <CAMUXYmUg12z8LUcFKwjH0Utrvxx0fa5Sne0u9adgoZ=oooBbig@mail.gmail.com> <7vobop5zmp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Leila <muhtasib@gmail.com>, konglu@minatec.inpg.fr,
	git@vger.kernel.org, Renato Neves <nevrenato@gmail.com>
To: =?utf-8?Q?Cl=C3=A1udio_Louren=C3=A7o?= <pt.smooke@gmail.com>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 11 23:34:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeCG9-0006yo-MV
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 23:34:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440Ab2FKVep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 17:34:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36445 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751391Ab2FKVep (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 17:34:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2427494ED;
	Mon, 11 Jun 2012 17:34:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7RW8q/EP9M6Guq8AQl9JsD+qvls=; b=UFu5X+
	ZtdR+Z1Vx5FEnvqJ11oiZZZT5VttxQ7YKCOW71jswSa2nd6PzTDkN6hyUdP06cU+
	wJ6ndTh26uSBYMxH3yhS4MgZVwW76qiYERMjnUJYVjka1yZOfynApk0wlLdV9fsU
	U4ZiNhyERhSHi6g0C/0vcUYgMg1MNFiZSaakk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Oahjz7BysQSA017czpCPmT8RB18Sj7F+
	K8M8c3LFZZ+6cfGfExDG0Zlv3hxVWtRz+QsVEbS9n7sCjv8JvGFB3Pkpk8ZivSWL
	+ZOQdx3hcmzHWwojDxUsWWA6SrYnwALWCr6y5UHnx5dEVfVph+tlx7+SvRHOjpaV
	KXQ/0/GVXO0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BBFC94EC;
	Mon, 11 Jun 2012 17:34:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A327D94EA; Mon, 11 Jun 2012
 17:34:43 -0400 (EDT)
In-Reply-To: <7vobop5zmp.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 11 Jun 2012 14:04:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 423EA116-B40D-11E1-BC55-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199735>

Junio C Hamano <gitster@pobox.com> writes:

> When checking the differences between the two branches (the current
> and the new), unpack-trees notices that the path "something" is not
> present in "b" branch, and even though your current branch and the
> index differs (the index does not have "something" as you have
> removed it), it thinks it is OK for the result to not have it (which
> is correct).  And when it does that, it forgets that a new path
> "something/f1" still needs to be kept (which is not correct), which
> is where the problem you are seeing comes from, methinks.

So there are two paths involved in this two-way merge.

The master branch (HEAD) has "something", but not "something/f1".
The index does not have "something", but has "something/f1".
The "b" branch does not have either.

For path "something", the rule 2 in the "Two Tree Merge" section of
Documentation/git-read-tree.txt applies.  It does not exist in the
index, it does exist in HEAD, and it does not exist in the other
branch we are checking out.  The result should be to remove it.

For path "something/f1", the rule 4 ought to apply.  The index entry
for it is up to date with respect to the working tree file
(i.e. clean), the HEAD does not have it, and the other branch does
not have it either.  We should be keeping it intact across the
checkout.  For whatever reason, this is not happening and I suspect
that is because we have to remove "something" due to rule 2.

I just checked the history of unpack-trees code (which is the
underlying machinery of read-tree, which in turn is the machinery
used to check out another branch by "git checkout"), and I suspect
that this particular case has never worked.
