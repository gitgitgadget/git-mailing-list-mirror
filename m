From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Index format v5
Date: Fri, 04 May 2012 08:46:47 -0700
Message-ID: <7vzk9oaqzc.fsf@alter.siamese.dyndns.org>
References: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com>
 <2A6D903A618147EEBBFEF99234104EE6@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Thomas Gummerer" <t.gummerer@gmail.com>, <git@vger.kernel.org>,
	<trast@student.ethz.ch>, <mhagger@alum.mit.edu>, <peff@peff.net>,
	<spearce@spearce.org>, <davidbarr@google.com>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri May 04 17:46:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQKid-0005hv-69
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 17:46:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578Ab2EDPqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 11:46:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41386 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751209Ab2EDPqt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 11:46:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D8C0633F;
	Fri,  4 May 2012 11:46:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YV+wMmOgNo78GvA1g5bP28NQVm8=; b=elIdC2
	HuyXvHp9yKvbTuPvdyHovET/Cv9hgEvsT7xUJny4IW36Zs7YLE8ou8ylQvXIyLRO
	YL6DmPTa/Z0atWFzKHnTKRZE3tYWfruHcLPHdwBQiJzK8rM+KGryrIJYWNoIL8rn
	X5r8i5KnxhrK3Uc9HSMrA5Ffhk0WUKGYDaXHY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=egRvHndYYYJx0oIlXocD/i48HgvcYTJZ
	86wG9r0PB6YhoNMneq+NpXnR1lYW/aeG7BxP9ruJRyGneFbwI3Pt1oO+ZYyDJO6A
	E4WcZFTCgznqHPje0mdE4RMMC7LvQULai1v+V0JkX6a6R8Na7o8mZ/P7VXhDr78H
	Sh0oJ1JFRBw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80594633D;
	Fri,  4 May 2012 11:46:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0F6B1633C; Fri,  4 May 2012
 11:46:48 -0400 (EDT)
In-Reply-To: <2A6D903A618147EEBBFEF99234104EE6@PhilipOakley> (Philip Oakley's
 message of "Fri, 4 May 2012 14:25:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5C53D3D0-9600-11E1-B46D-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197031>

"Philip Oakley" <philipoakley@iee.org> writes:

> Does the prohibition of ".git" prevent the potential for versioning of
> the .git directory itself (e.g. .gitignore the pack & objects
> themselves)?

It is a good thing that you are forbidden from adding .git/anything to the
index and the trees.  The information inside your .git/ repository does
have to change from time to time.  For example, you may change your e-mail
address and update user.email in your .git/config file.

But the history of them and the history of the evolution of the project
itself are distinct [*1*]. When you clone git.git, you have no business
learning what is in .git/config in my repository.  The project should not
be able to overwrite what is in your .git/hooks/. These are only a few
reasons why an attempt to "git add .git/something" is always a mistake.

And it is irrelevant to this discussion, as the rest of .git does not
allow putting .git anyway.  In that sense, the index "format" does not
have to enforce it.  For that reason, I would suggest dropping the mention
of ".git" (but not "..") from the format description.

[Footnote]

*1* You could choose to track the contents of .git/ in another repository
with creative uses of GIT_DIR/GIT_WORK_TREE/core.worktree and friends.
