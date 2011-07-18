From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git show-branch --topics and merge commits
Date: Mon, 18 Jul 2011 11:14:34 -0700
Message-ID: <7v4o2jlalx.fsf@alter.siamese.dyndns.org>
References: <CA+6x0LWXz-SpnZjdiV3UKJzUz3+0LiMOsbZHTn2gJ+v6bPGndA@mail.gmail.com>
 <7v8vrwl46q.fsf@alter.siamese.dyndns.org>
 <CA+6x0LXHKZgvW4_hWz8qrWQshqxB3pQ-=08itqnV5smA_NCrBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Shal <marfey@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 18 20:14:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QisL4-0000DT-Sj
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 20:14:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754575Ab1GRSOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 14:14:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65469 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754535Ab1GRSOi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 14:14:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0937C4D36;
	Mon, 18 Jul 2011 14:14:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=38lqQrzXHFkyQPi4Q5/sanJ7SMo=; b=RniDh/
	NszQw+R+iT53pluIONRuI04us69anCpIhHlfOzRUh6Wta3Zh532yK0Tq2rvl29/p
	rHQSFn709D9UD7O7JSwM2HQFxdiqv3w0+haPX3uLyzgWtIS6N2z7wdw9/v9UWM4W
	ip+Q2g8N5YTIgd0DmLM75gLcwV9dz0y0udhXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wc5jPLUKWol3i2yVaKAd4SHzGKJ7SfME
	pm1wpzZyNpWXLoaUD8EuCG7CxxQ8Iu43F2THY7mZZx3XXjIpRVml4GW6dE5ZknBp
	18e2v9ISe59JECWoE4Al0DKhcFID2wR4o9UMpfUF4PbSN+r+VwWM33/RyK7VVxkJ
	3phTZn40clE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 008594D35;
	Mon, 18 Jul 2011 14:14:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 883774D33; Mon, 18 Jul 2011
 14:14:36 -0400 (EDT)
In-Reply-To: <CA+6x0LXHKZgvW4_hWz8qrWQshqxB3pQ-=08itqnV5smA_NCrBA@mail.gmail.com> (Mike
 Shal's message of "Sun, 17 Jul 2011 23:37:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CB8AF71E-B169-11E0-8B0A-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177395>

Mike Shal <marfey@gmail.com> writes:

> Ok, makes sense. Is 'git rev-list' supposed to give the same list of
> commits then? In my example, rev-list shows the commit on the branch
> even after upstream has been merged in.

"show-branch" was designed to stop after seeing a commit that are shared
with all the branches it was given, so

	git show-branch A B

is more like

	git rev-list --left-right --boundary A...B

and not at all like

	git rev-list A..B

which is to show all commits not in A that appear in B.

Note that show-branch was invented way before the log family of commands
(which rev-list is a member of) learned --left-right/--boundary/--graph
options, and I personally think its graphical output mode outlived its
usefulness as a stopgap measure.  As its "merge-base" and "independent"
modes have also been made redundant (see "git merge-base" for two options
to mimic their behaviour), we may want to start thinking about deprecating
the command, and the first step perhaps would be to replace its mention
from the first part of the Everyday Git document with something more
appropriate such as "git log".
