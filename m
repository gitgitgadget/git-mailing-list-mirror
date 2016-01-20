From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Issue when changing staged files in a pre-commit hook
Date: Tue, 19 Jan 2016 17:44:22 -0800
Message-ID: <xmqqk2n56n49.fsf@gitster.mtv.corp.google.com>
References: <CAPYEnzGfnRbajDQAwBTNE5XSaB0WbHKbf1heRV0bUgbq5w_A5g@mail.gmail.com>
	<CACsJy8DhiYiie7+Cw3PkPJpSX7CGp-r2Mu98mLp4OMhhGdsXgQ@mail.gmail.com>
	<xmqq1t9dbe9y.fsf@gitster.mtv.corp.google.com>
	<CACsJy8DxQnGV5JZnHuvA1Zbpf2BuGdmMF+YNiq51HNK+8vW56Q@mail.gmail.com>
	<xmqqwpr56ste.fsf@gitster.mtv.corp.google.com>
	<CACsJy8Aj+_Qra312EWRsjmebd67EFQt4RP4LWFUyXUB-QCnKvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Niek van der Kooy <niekvanderkooy@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 02:44:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLhpC-0001wm-4S
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 02:44:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933984AbcATBoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 20:44:34 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63456 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934814AbcATBoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 20:44:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C45663D467;
	Tue, 19 Jan 2016 20:44:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZM7RDFjB1hxZkxINCzF5nZZWRrQ=; b=W/MoTx
	UA5UrEEWHhk7C33bxx1rsVOGkAjIl9CcebUfb9h8w525DkCi4o61pWMncxD0v5h0
	mFQVlqsJmdj67+/IUmdhK6oW87f08FlU9NRbYDf7WSNe1FLOwPGn8+1tCXK0gdAS
	bURytNi0nYp5wYs3mB9HkstIVb0E05w4Qp8Q4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UOROn6HNKU3F8jpAS0JGRy6/0uB9rp9z
	+s34Y+0X21WeOZHBGDyYKfifO0NJrAP7PkVp9UVYIpEB5g1Sp34VWpp3PWuSG/H9
	YHBbZgSL57Ef6JJ/V3/xGNCIarOpKlMIJONloK3q5VfEyjgbrWeJXEap/ob9zi/s
	aoRREndEgnY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BBD313D466;
	Tue, 19 Jan 2016 20:44:23 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 402B23D463;
	Tue, 19 Jan 2016 20:44:23 -0500 (EST)
In-Reply-To: <CACsJy8Aj+_Qra312EWRsjmebd67EFQt4RP4LWFUyXUB-QCnKvQ@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 20 Jan 2016 07:23:19 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 54D07534-BF17-11E5-9196-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284408>

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Jan 20, 2016 at 6:41 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> The only sensible thing we can do at that point in the code after
>> re-reading the index is to make sure that hasn't been changed by the
>> pre-commit hook and complain loudly to die if we find it modified, I
>> think.
>
> OK. Two more points
>
>  - do we catch index changes for partial commit case only? Because
> when $GIT_DIR/index is used, we do not have this problem.

I do not think you are correct.  As-is commit with un-added changes
in the working tree would have the same problem.  If the hook munged
the real index without touching the working tree, the next "commit
-a" would revert that change unless you reflect the same munging the
hook did to the working tree.

So if you _really_ wanted to be lenient and allow hooks to muck with
the index, you would have to do something along this line:

 - Take a snapshot of the working tree files (call it W0).
 - Prepare the false-index for partial commit if necessary.
 - Write-tree the index used to record the next commit (call the result T0)
   before calling the hook and showing that index to it.
 - Let the hook munge the index (and possibly the working tree.
 - Re-read the index and write-tree (call the result T1).
 - Take a snapshot of the working tree files (call it W1).
 - If T1 != T0:
     - If making a partial commit
       - apply diff(T0,T1) to the real index.
       - apply diff(T0,T1) - diff(W0,W1) to the working tree files.
     - Otherwise
       - apply diff(T0,T1) - diff(W0,W1) to the working tree files.

 And if any of the "apply the change" fails, fail the whole thing
 without leaving any damage.  As the index and the HEAD after making
 a partial commit is allowed to be different, we cannot resolve the
 3-way merge conflict using the index the usual way.

 And if all of the "apply the change" succeeds (including the easier
 cases where W0 == W1), allow such a change by the hook.

That would give us a more lenient system, but I do not necessarily
think that it would be a good thing.

Think what the error message has to say when "if any of the apply
fails" case.  "Commit failed because your hook munged X in such and
such way" (where X might be the index, the working tree, or both,
and "such and such way" would describe the overlapping changes that
cannot be automatically reconciled).  What is the impression such a
message give the user?  A hook is allowed to muck with the index
only under some complex condition but not always?  Surely there is a
solid technical reason why it cannot be allowed, but is that a rule
that is easy to understand by end users?

Wouldn't it be simpler if the rule the user has to remember is
"pre-X hook are designed to inspect and reject, not to tweak and
munge" (which has always been the case as far as I am concerned, and
the fact that the code trusted hooks too much to follow the rule and
did not verify was merely a bug) and rejected a hook that munged the
index when it did so, regardless of the state of the index and the
working tree when the commit command is run and the kind of commit
(either as-is or partial) that we are creating?

>  - is Niek's use case still valid? If so, what do we do to support it
> (at least in partial commit case)?

Especially in partial commit case, but more in general in any case,
I'd say the result is "undefined".

I think the _only_ case we can safely port forward the munging done
by the hook is during "git commit -a".  In that case, we know that
the working tree exactly matches the index being committed before
the hook runs, and after the hook munged the index, regardless of
what it did (or didn't) do to the working tree, the resulting HEAD,
the index, and the working tree ought to match, so porting forward
is just a matter of running "reset --hard" when we notice that the
hook munged the contents to be committed with "commit -a".

All other cases can create conflicts that we cannot express to the
user to resolve, and will introuce "hook is allowed to muck with the
index only under some complex condition but not always" confusion.

The above does not have to be the final verdict, though.  Somebody
else may able to come up with a more lenient behaviour that is easy
to understand by end users (I somehow doubt about the latter; coming
up with "a more lenient" behaviour is easy, and anybody who hacks up
such a behaviour may argue that the behaviour is easy to understand,
but that is merely due to knowing the implementation--explaining it
to the end users is a different matter).
