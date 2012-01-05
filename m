From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone: allow detached checkout when --branch takes a tag
Date: Thu, 05 Jan 2012 08:22:17 -0800
Message-ID: <7v7h16nmpy.fsf@alter.siamese.dyndns.org>
References: <1325771380-18862-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 05 17:22:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Riq5C-0000aC-1B
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 17:22:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932759Ab2AEQWV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jan 2012 11:22:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55775 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757613Ab2AEQWU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jan 2012 11:22:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EE435C0E;
	Thu,  5 Jan 2012 11:22:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=LfAgViJDE7y0
	7c6W3UmTzy/43qA=; b=wRuvqBqGWrUyRs8Gy4gSIUxdIeWhmhYn2Aui4lDSWl5t
	zdUQTuPoO7VYQOuh1dJywT6hxDG/fXU73Lt3fwTPLw6252bl+0e7Z+F2TDSV+9v3
	HoHtG1GhkCT482Vo6reuXBW64KEQmgqyFHJa0vXrRdXcm9BwN7kbI3Qs4Usp2Zk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=VhurUh
	4/Gq9Goqk4QyvNOkGuR3mGyIOw/JgXBOXVcg72wH49sHtn95PFvaPQv+gH9W1I7h
	B3wrpq7vv0H3pFt45YB8skJ+oEtqCNMXfJB6LpjjBmDxjQsFrwXTCrA7J2xK3KdG
	YT4F2YSBAOFpEu+JojwdRMU9SCP5V+dxCbmO8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05BC85C0D;
	Thu,  5 Jan 2012 11:22:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 607B95C09; Thu,  5 Jan 2012
 11:22:19 -0500 (EST)
In-Reply-To: <1325771380-18862-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 5 Jan
 2012 20:49:40 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7084D32C-37B9-11E1-8D2B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187987>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This allows you to do "git clone --branch=3Dv1.7.8 git.git" and work
> right away from there. No big deal, just one more convenient step, I
> think. --branch taking a tag may be confusing though.
>
> We can still have master in this case instead of detached HEAD, which
> may make more sense because we use --branch. I don't care much which
> way should be used.

You clone a single lineage of the history, either shallowly or fully,
either starting at the tip of one single branch or a named tag.

What is the expected use scenario of a resulting repository of this new
feature? As this is creating a repository, not a tarball extract, you
certainly would want the user to build further history in the resulting
repository, and it would need a real branch at some point, preferably
before any new commit is made. Which makes me think that the only reaso=
n
we would use a detached HEAD would be because we cannot decide what nam=
e
to give to that single branch and make it the responsibility of the use=
r
to run "git checkout -b $whatever" as the first thing.

I think the real cause of the above is because this patch and its previ=
ous
companion patch conflate the meaning of the "--branch" option with the
purpose of specifying which lineage of the history to copy. The option =
is
described to name the local branch that is checked out, instead of usin=
g
the the same name the remote's primary branch. But these patches abuse =
the
option to name something different at the same time---the endpoint of t=
he
single lineage to be copied.

These two may often be the same, and use of "clone --branch=3Dmaster" i=
n
such a case would mean that you want to name the local branch of the fi=
nal
checkout to be "master" _and_ the endpoint of the single lineage you ar=
e
copying is also their "master".

But the "tag" extension proposed with this change is different.

You are specifying an endpoint of the single lineage with the option th=
at
is different from any of the branches at the origin, and because you us=
ed
the "--branch" option for that purpose, you lost the way to specify the
primary thing the option wanted to express: what the name of the result=
ing
checkout should be.

Perhaps something like "clone --branch=3Dmaster --$endpoint=3Dv1.7.8" t=
hat
says "I want a clone of the repository limited to a single lineage, who=
se
history ends at the commit pointed by the v1.7.8 tag, and name the loca=
l
checkout my master branch" be more appropriate?

Also, the user is likely to want to fetch and integrate from the origin
with his own history. How should "git pull" and "git fetch" work in the
resulting repository? What should the remote.origin.* look like?
