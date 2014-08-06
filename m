From: Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH] Documentation/config.txt: change "pull.rebase" description in favor of safer 'preserve' option.
Date: Wed, 06 Aug 2014 14:29:04 +0400
Message-ID: <87bnrxzzbj.fsf@osv.gnss.ru>
References: <87bnrzxhrm.fsf@osv.gnss.ru>
	<xmqqa97io9ef.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergey Organov <sorganov@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 12:29:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEyT4-0008S8-EZ
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 12:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754858AbaHFK3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 06:29:09 -0400
Received: from mail.javad.com ([54.86.164.124]:54498 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754225AbaHFK3I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 06:29:08 -0400
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id 3ECFA6184E;
	Wed,  6 Aug 2014 10:29:06 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <s.organov@javad.com>)
	id 1XEySu-0001aR-EA; Wed, 06 Aug 2014 14:29:04 +0400
In-Reply-To: <xmqqa97io9ef.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 05 Aug 2014 15:32:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254851>

Junio C Hamano <gitster@pobox.com> writes:
> Sergey Organov <sorganov@gmail.com> writes:
>
>> Previous description implicitly favored 'true' value for "pull.rebase"
>> and "pull.<branch>.rebase" options,
>
> I do not share that impression.  It is true that 'true' is described
> first before 'preserve', which can be argued that it is being
> implicitly favoured, but we have to pick one over the other when
> describing two things, so I do not see it as a strong preference.

I didn't say it's a strong preference, and I consider my patch to be
minor documenation improvement that may save from major trouble.

I still suggest to peek 'preserve' over 'true' in the description, an
opposite to what is there right now. I believe it'd help me to avoid the
mistake I did setting pull.merge to true, by stopping reading when I saw
that "pull.rebase" should be set to 'true' to rebase instead of merge.

Couldn't you please just read the new description and tell what's wrong
with it? Besides, it puts less favor on one mode over another than the
original.

Am I right that 'true' for "pull.rebase" historically precedes
'preserve'? This is the only cause of current wording in documentation I
can imagine.

>> when for some workflows 'preserve' is the right choice, and for
>> others it hardly makes any difference. Therefore, 'preserve' should
>> be preferred in general, unless the user knows exactly what she is
>> doing.
>
> I doubt we saw any such conclusion in the recent thread that
> discussed this, other than your repeating that statement---and I've
> learned to tell repeated voices and chorus apart over time ;-).

I've repeated request to tell me if somebody has any evidence 'preserve'
would break their workflow, and nobody provided one. I even hoped you
would say something, but it didn't happen till I suggested the patch ;-)

On the other hand, I did suffer from 'true' setting, and that seems to
be more common, as was shown by the problem of another git user soon
after I explained mine. Moreover, the order of "suffer" is worse with
'true' than it ever could be with 'preserve', see below.

> One approach is more suitable for some workflows while being
> inappropriate for others and that goes for both variants. A downside
> of flattening is that it gives a wrong result when the user wants to
> keep merges. Two downsides of preserving are that it gives a wrong
> result when the user wants to flatten, and it tends to be slower.

I understand this, but it does look like most of those who care about
entirely flat history don't do merges in the first place. At least I
didn't do it for my simple changes for 'git', so I was not aware how
dangerous the 'true' setting for "pull.rebase" I was using is for my own
workflows, when I started using git internally.

I'd also argue that if they do the merges themselves, they'd better do
flattening themselves as well (by "git rebase"), rather than (ab)using
pull.rebase feature which primary use is avoiding *automatic* merges
caused by pull(s).

> During that discussion, you seemed to assume that those who want a
> flattened end result would never merge locally; I do not think that
> is true.  Having your own merges on a branch that you would want to
> rebase to flatten is not unusual.

I didn't assume, I rather tried to figure it. However, I didn't hear
from anybody who do it regularly, and I waited for 2 weeks, so I decided
that even if there are any, they are in minority, or maybe are
experienced enough not to care.

But that even is not my main argument. Look, 'preserve' preserves
things. If one doesn't like the result, he can just rebase, or set
pull.merge to true and repeat the pull, or just "pull --rebase".
Simple. You are still inside the same set of commands and concepts.

On the other hand, recovering from unneeded flattening is much more
difficult, especially for novice, as it requres familarity with a bunch
of new concepts behind "git reset".

> You may employ a workflow to build on separate topic branches while
> developing, merge the topics among them that are ready into your
> local 'master' to be used personally, and after using it from your
> local 'master' for a while to make sure it is solid, you may decide
> to make it final by publishing it to the outside world, and at that
> point you would want to flatten the history on top of the latest
> upstream before pushing.

I'm not proposing to remove any functionality, do I? It's just that
'preserve' is safer in general and easier to deal with when result
doesn't fit. Once again, recovering from unexpected flattening is more
difficult.

BTW, even in this workflow, forgetting to pull after merge and before
push may still lead to the same result that 'preserve' has (no changes
upstream, so merge will be simply pushed), so setting pull.merge to true
doesn't eliminate the problem entirely even in this case. I think the
right advice for such workflow would then be to flatten your
history locally using "git rebase" explicitly, before trying to push
something upstream, that in turn would make this workflow  pull.rebase
true/preserve - agnostic.

>  That's not anything advanced that takes "the user knows exactly what
>  she is doing."

I didn't write this. This note was there, and I just left it as is. I
think it meant to describe both 'true' and 'preserve' settings, even
though originally 'preserve'  description was closer to it ;-)

To summarize, my point is that even if there are indeed workflows that
would somehow "suffer" from 'preserve' setting, it's much easier to
realize what happens and fix it either by changing settings and
repeating operation, or by rebasing manually, than it is in the case
when "pull.rebase" being set to 'true' flattens your merge(s). When that
happened to me, there were 3 merges and tens of commits that were
flattened, and I wish nobody to repeat this experience.

BTW, while we are at the subject,

$ git pull --rebase=true
Current branch master is up to date.
$ git pull --rebase=preserve
Successfully rebased and updated refs/heads/master.
$ git pull --rebase=preserve
Successfully rebased and updated refs/heads/master.

(notice no any changes anywhere) is rather surprising. Should I raise a
separate issue about it?

-- 
Sergey.
