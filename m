From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log for only certain branches
Date: Tue, 08 Apr 2014 12:26:05 -0700
Message-ID: <xmqqvbuj39o2.fsf@gitster.dls.corp.google.com>
References: <CAHd499BSgxZ8EC1qKYRsF0hac6rQAegw9qTOoDjaiuh_UUVEng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 08 21:26:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXbfL-0006XV-61
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 21:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757579AbaDHT0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2014 15:26:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51734 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756894AbaDHT0J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2014 15:26:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C0AB97B636;
	Tue,  8 Apr 2014 15:26:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YpcFvTMdWQh/CG0DfsdON9wE1oA=; b=e6rlPf
	7h8nr5FAcp/KAnaHG0YcQ8xN/JcbRrQF9llMR7+KOOHqU1upviyhFeDkoSup+aFV
	mZUO3I29PrwpujbREWYN5cMf1zqHY6ZQMZiFz0OsVypQPX2la0XalwQ5HQc8vaBK
	8Avo/3XgMFAv8x9azuqcwbKPgDn8mkFRHr9xM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RBvitOWfZ+glO7b3OJqsNfXN/yb4oOFt
	0fJZGruv2TQuwFJ2wM2TxYWlYTLiFGibhqTEh6tUPIHKMB5EqkWIMj9YPGAfRNBl
	f+FrUZ28CXn2a/vjVzXVbbU6mQ/yW6cfTFVXBP7UyDygaPgRU0jY5bL0wsDbqA25
	EhRRaeGkWuY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A91187B631;
	Tue,  8 Apr 2014 15:26:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 45F267B630;
	Tue,  8 Apr 2014 15:26:07 -0400 (EDT)
In-Reply-To: <CAHd499BSgxZ8EC1qKYRsF0hac6rQAegw9qTOoDjaiuh_UUVEng@mail.gmail.com>
	(Robert Dailey's message of "Tue, 8 Apr 2014 08:43:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A2098FD6-BF53-11E3-B60B-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245952>

Robert Dailey <rcdailey.lists@gmail.com> writes:

> I have more details about my inquiry on StackOverflow:
> http://stackoverflow.com/questions/22823768/view-git-log-with-merges-for-only-certain-branches
>
> Basically I'd like to know if it is possible to show the graph for
> ONLY branches that I list. The key here is that the graph should also
> show relationships between only those branches that I list. In other
> words, any ancestors that I do not explicitly specify should not be
> rendered in the graph.
>
> I have an insanely huge number of branches in my git repo (we
> transitioned from SVN so we haven't had a chance to clean them up
> yet). As a result, the git log graph I see has literally 10-20
> vertical lines and I have to scroll 20+ pages to follow a line to a
> particular parent branch.

I do not quite get this part (note that it is impolite to ask people
to go to stackoverflow or any external site to answer questions
asked here, but I am making an exception today):

  $ git log --oneline --graph origin/master origin/topic1

  It will show all branches anyway, even though I've specified I only
  want to see two of them.

These should show commits reachable from these two branches,
origin/master and origin/topic1, and nothing else.

  $ git log --oneline --graph \
    origin/master origin/topic1 \
    --not $(git merge-base --all origin/master origin/topic1)

would stop where the histories of these two branches meet (assuming
that you consider that the common ancestors of these two not
interesting when you say "all branches anyway", but these common
ancestors are still part of these two branches ;-).
