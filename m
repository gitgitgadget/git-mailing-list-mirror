From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git checkout: create unparented branch by --orphan
Date: Sun, 21 Mar 2010 14:38:32 -0700
Message-ID: <7vk4t5icdj.fsf@alter.siamese.dyndns.org>
References: <1269185678-3039-1-git-send-email-erick.mattos@gmail.com>
 <20100321171431.GE2557@m62s10.vlinux.de>
 <7vd3yxqxdj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Baumann <waste.manager@gmx.de>,
	Erick Mattos <erick.mattos@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 21 22:38:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtSrB-000448-WD
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 22:38:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753366Ab0CUVio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 17:38:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63992 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330Ab0CUVio (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 17:38:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D5091A30D9;
	Sun, 21 Mar 2010 17:38:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nVr6+QNBtAJschR9Al1kRdviQZs=; b=ty1d+B
	zECom/iJ8uBt5mwOtTkn+K+blCOhyWjOOuotDc78CrOSUnGu0gwhXqn5GyO3sie/
	J9mCa1bFDPyzu/WUXWj5T1krXlSw9BHeoEInMol+K9BN+AypFMQ8ieTuJAM2mmUR
	v7i2juVFHk38YvqlMrXPnFc9yaVdOGRria9D8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hd6O/pB73ivPTgykFHmnTMq/dpAhxeH2
	acfmfKse3HpDu3TNhETjaBY7jxNYkrVP9u/IaUY54fQbZeiJ5afd7b9FQogQ9GXH
	riEkW9HWStN7AdX5/V8+BGC7jCddVL+XTtiamYHwP676yJ8lGOi3MRLl4C6rAHLx
	l3r+wgQZvDo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FDBCA30D6;
	Sun, 21 Mar 2010 17:38:38 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B8ECDA30D3; Sun, 21 Mar
 2010 17:38:33 -0400 (EDT)
In-Reply-To: <7vd3yxqxdj.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun\, 21 Mar 2010 12\:37\:44 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1C2350AA-3532-11DF-9218-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142865>

Junio C Hamano <gitster@pobox.com> writes:

> GitTips page of git wiki mentions this under "a new branch that has no
> ancestor", and speaks of a way to add "a new and empty branch".  Scott
> Chacon also creates "new empty branches" in the community book.

By the way, I would actually suggest updating these web pages not to make
it sound as if it is a good thing to create a new "empty" history (aka "no
common paths") in an existing repository.  Git wiki lists "create in a
separate repository and push into the same" as "The easy way", as if it is
easy-but-amateurish, making it sound as if experts should use different
ways for extra coolness point.  People may think that having branches like
'man' and 'html' in the same repository as I do is somehow cool, but it is
a total misconception.  That part of Git wiki page should be reworded to
reduce user confusion; "The easy way" is actually "the one true way".

While it indeed is useful to have them in the same public repository
(think of my git.git repository at k.org) for distribution purposes, it
does not mean that it is a good thing to create and manipulate these
unrelated histories in the same repository at all.  These two branches
(and the same thing can be said for 'todo' branch) are never checked out
in a repository with an worktree that normally checks out the primary
branches (e.g. 'master', 'next', etc.) nowhere in my workflow for two very
simple reasons:

 (1) doing so would disrupt the normal work done in the primary branches.

 (2) updating them requires a separate checkout of the primary branch
     anyway.

Growing these histories are done in separate repositories unrelated to the
primary project worktree; they are pushed into the same public repository
only for ease of cloning, for Documentation/install-doc-quick.sh script to
run a moral equivalent of "tar-tree | (cd elsewhere && tar xf -)".

And even the "ease-of-cloning" is merely a justfication after the fact.
The original and the only reason why these pregenerated documentation
branches are in the same distribution repository is because I only have
write privilege to /pub/scm/git/git.git/ at k.org, and not to the whole
/pub/scm/git/ hierarchy.  Otherwise I may have published these unrelated
branches in their own repositories (e.g. /pub/scm/git/docs.git/) and made
install-doc-quick.sh use data from there; it might have avoided confusing
end users, perhaps.

It also might be useful to extend these pages with the "going open source?
here is how to use a 'mostly same paths' disconnected history to do so"
example from the discussion.  That workflow I can see how it may make
sense to use "checkout --orphan" to create the new history in the same
repository.
