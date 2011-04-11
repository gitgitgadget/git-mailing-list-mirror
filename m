From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug Report: git add
Date: Mon, 11 Apr 2011 10:55:31 -0700
Message-ID: <7v1v18y8oc.fsf@alter.siamese.dyndns.org>
References: <4D9BA35E.6040204@dcook.org> <20110406055200.GA12547@kytes>
 <m31v1a4keq.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Darren Cook <darren@dcook.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 11 19:55:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9LL9-0008GU-Hv
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 19:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755033Ab1DKRzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 13:55:49 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62460 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754775Ab1DKRzs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 13:55:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7A2F44E1E;
	Mon, 11 Apr 2011 13:57:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vFDasFndwagreuJeMPUr+fn3oms=; b=qwql2v
	L1yeNqBVYXtCMQlJPG3oq0yi5mw3lGQbbkTR7CyMe7rcdg4hp9OLVIk7eIJ+lINn
	+U8GymYGg9aswTRTGE8RwjA2aZ4W28ILNmIoz53eU3wqreAPr3ewuKzWFvQzHTf/
	4rcFcP8xqRIakU0Nhgv3kbEOQeMOgXL8aKP50=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b/OL2Q6ttY48+3h5kuPqzv/SxK0MU/ha
	DV9oF0fxc956f96GBzz4ikxlTWfEVUCx/eEBVtl8HxvGw94WCwDZMlgq/90lkdNS
	PAHteTVnrkdnMWOY6+TuZb+yLkjEmcGLW/ENdTuywsj4fNoIsCdcHZnxHlT2ODdR
	I7NFL/ZWnD4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 289FC4E19;
	Mon, 11 Apr 2011 13:57:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9007B4E15; Mon, 11 Apr 2011
 13:57:31 -0400 (EDT)
In-Reply-To: <m31v1a4keq.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Sun, 10 Apr 2011 00:48:49 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2FFE030A-6465-11E0-88F0-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171340>

Jakub Narebski <jnareb@gmail.com> writes:

> Currently I have TODO file in gitweb/ subdirectory, which is stored in
> gitweb/.git repository.  Still it doesn't prevent me from "git add"-ing
> e.g. 'gitweb/gitweb.perl' to git repository itself.

I would have to say that it is somewhat a sensible thing to want to do
from an individual contributor's point of view to keep track of personal
notes on a subpart of a project in a separate repository.

It however directly contradicts with the approach I suggested earlier,
which resulted in Peff's patch

  http://thread.gmane.org/gmane.comp.version-control.git/170937/focus=171040 

and will be broken, I think.

We could skip the check for a directory D where there already is a path
D/P (where P has one or more path components, e.g. "file", "subdir/file")
tracked and check only if D/.git is a git directory when adding path in D
if there is no other D/P is tracked (and perhaps require --force), if we
really wanted to keep supporting what you are doing.  But I do not think
it is worth doing, considering the possibility that such a loophole would
lead to even more confusing behaviour to new users.

If there is an equally easy way of keeping track of personal notes in a
subpart of a larger project like you do, without having an unrelated .git/
directory in a worktree that is controlled by a project and mixing files
in a single directory in such a way that some belong to the main project
while others belong to the unrelated "personal notes" project, I would
rather see us recommend such an approach, and declare that your use case
is forbidden, as it would give us a far easier to explain rule: "files in
one directory can be controlled only by one .git/ directory".

Besides, if the subpart of the project you are interested in and want to
have personal notes about were at the top-level of the project, you
wouldn't be using the same workflow as you currently do, as you cannot
obviously have two .git/ at the same level.
