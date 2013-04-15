From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] pull: introduce --[no-]autostash and pull.autostash
Date: Mon, 15 Apr 2013 09:32:15 -0700
Message-ID: <7vbo9fzre8.fsf@alter.siamese.dyndns.org>
References: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
 <1365887729-9630-4-git-send-email-artagnon@gmail.com>
 <vpq38us2oov.fsf@grenoble-inp.fr>
 <CALkWK0mdC_tK2CGqAa67fr189PQCjSjzAOPujipOHFfoiYW0qA@mail.gmail.com>
 <vpqppxvoqsc.fsf@grenoble-inp.fr>
 <CALkWK0nqrw7DFQSnMvULYjJtBHRnadKWqCLQOAjzJH0o7USo+A@mail.gmail.com>
 <vpqwqs3lqlf.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 15 18:32:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URmKN-00048S-9P
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 18:32:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932945Ab3DOQcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 12:32:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61454 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932162Ab3DOQcS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 12:32:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 528C0158A8;
	Mon, 15 Apr 2013 16:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9ULDihXNll89ws+K8AExUqqemmo=; b=rkRqKT
	Var2u410GPHjQaBmIDxZDt+t9KCkQGdUGyTfkdJraV7p00Mnf3JVcqCYFGiGQ1ip
	tDye4IsPlfm4FeGPxn9A+QBQjsecB62E7rbe5raZGLNo3VkuyMyIFJ/Bs1G2HA04
	XZ/FR8LZwGQMQVN5iJOw5Rd6NvcMqb+AoHEAY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MqSbIcIcmti2WTZYdgjwQhHtAs2ZAUnX
	3M9PqTmt6d8Bgmof7ASeG00BNM6jXxO9CNAaFbqL3F1RpMnebXfIMH4LuMceYzx5
	TIb6nLFuqNm8idxmoT/twsaGWDVKEhAUv3cKTD2rwciqS4a+Nzd1EhXzECyd+5Jm
	l2PIBBlIDLA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 466FC158A6;
	Mon, 15 Apr 2013 16:32:17 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A8DA1158A5; Mon, 15 Apr
 2013 16:32:16 +0000 (UTC)
In-Reply-To: <vpqwqs3lqlf.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Mon, 15 Apr 2013 18:13:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 09083590-A5EA-11E2-9629-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221247>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> Matthieu Moy wrote:
>>> AFAICT, "git merge --abort" is an alias for "git reset --merge"
>>
>> Yes, that is correct.
>>
>>> which
>>> was precisely designed to reset only modifications comming from a merge,
>>> and not the local changes that were present before the merge was
>>> started. The man pages are relatively obscure on the subject, but I'd
>>> call that a documentation bug.
>>
>> I see.  Either way, we need a clean worktree for it to work, no?
>
> No, you don't. Just try if you're not convinced:

Heh, I still remember breaking "git merge" and got yelled at loudly.

cf. http://thread.gmane.org/gmane.comp.version-control.git/9073

>>> It does. stashing means the user will have to "stash pop" later. One
>>> extra step, one extra opportunity to forget something important.
>>
>> That's only if there are conflicts.  If there are conflicts, you'll
>> have to stash anyway if:
>> - You're doing a pull-merge and want merge --abort to work.
>
> Again, no.
>
>>> A minor annoyance is that it will touch files that have no reason to be
>>> touched, hence may trigger extra rebuilds with "make", disturbing text
>>> editors that have the file open, etc.
>>
>> Okay, I need to ask you something at this point: do you ever run merge
>> on a dirty worktree unless you're absolutely sure that your local
>> changes won't conflict with the changes introduced by the merge? 
>
> Most of the time, I just run "git pull" or "git merge". I know it's
> conservative enough, to it will stop if there's anything dangerous.

Exactly.

> No, I'm not proposing to do anything for merge. There's no reason to try
> being uniform in conflict resolution for pull-merge and pull-rebase as
> it is already different now. We already have "git rebase --continue", we
> don't have "git merge --continue". So what? The fact that merge doesn't
> have the equivalent doesn't mean we should not do something for "rebase
> --continue".

Well said.
