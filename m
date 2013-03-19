From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git merge <tag> behavior
Date: Tue, 19 Mar 2013 09:19:38 -0700
Message-ID: <7vfvzrjrad.fsf@alter.siamese.dyndns.org>
References: <1363704914.6289.39.camel@test.quest-ce.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: Yann Droneaud <ydroneaud@opteya.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 17:20:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHzGj-0006Mp-II
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 17:20:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757028Ab3CSQTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 12:19:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62930 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751682Ab3CSQTl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 12:19:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F57EA2CB;
	Tue, 19 Mar 2013 12:19:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tDRPSZUQNOfJBw06oQv1YoO/3y4=; b=uyNn+X
	oPjj3N/qSUg7O+P7Z+HzNS3dqmZSre0IASy6MlTX+zZAXsTy+4MJDd9cjg+mplzb
	ihMbII7UQ/5Vtk2zvTCCUGn/8RtLZQ4SgdcIYLutFxCPCKH0E0htklwjYNhqVDfd
	YdhKV9o/H4t7c2W0KHv7v31ExyXYGZTZBBOfo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pOfeBvkoKumnSWvjr5VLoqik9rRIadO/
	LlToSVYOU9/BiwhxvRBQYFsv6vL+eie5rx4BosGgSsEiv4k++sIVqzuvc74ZOhC1
	AaoPhpaCbXFIsFrXcxhgH9Th2rhhQ6uZGQ9I+2+Am/bK+cJfU+ARREN5OSn4by/Q
	2yvceAo8zpo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 742A4A2C9;
	Tue, 19 Mar 2013 12:19:40 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D19B4A2C6; Tue, 19 Mar 2013
 12:19:39 -0400 (EDT)
In-Reply-To: <1363704914.6289.39.camel@test.quest-ce.net> (Yann Droneaud's
 message of "Tue, 19 Mar 2013 15:55:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CCC547A6-90B0-11E2-9CA3-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218537>

Yann Droneaud <ydroneaud@opteya.com> writes:

> 1) there's no mention of the git merge <tag> behavior in git-merge.1
>
> When asking Git to merge a tag (such as a signed tag or annotated tag),
> it will always create a merge commit even if fast-forward was possible.
> It's like having --no-ff present on the command line.
>
> It's a difference from the default behavior described in git-merge.1[4].
> It should be documented as an exception of "FAST-FORWARD MERGE" section
> and "--ff" option description.

Yes; we welcome documentation patches.

> 2) git merge <tag> VS git merge <object-id>
>
> If <tag> is an object (not a lightweight/reference tag), git merge <tag>
> ...
> But, if you use the tag object-id instead of its name, for example using
> git merge `git show-ref <tag>`,

"git show-ref <tag>" gives you something like

    572a535454612a046e7dd7404dcca94d6243c788 refs/tags/v1.8.2

which is an invalid thing to merge with.  Perhaps you meant

	git merge $(git rev-parse v1.12.2)

> signature is not checked. Git still create a merge commit, but doesn't
> prepare a commit message with the tag message and the signature:
>
> It would be great to have Git using the tag message and check the
> signature.

Perhaps, but if you feed the $(git rev-parse v1.12.2) to merge, your
subject will not be able to say "Merge tag 'v1.12.2'" in the first
place, so I do not think you would want to encourage such usage in
the first place.
