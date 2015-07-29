From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/6] notes: replace pseudorefs with real refs
Date: Wed, 29 Jul 2015 09:37:14 -0700
Message-ID: <xmqqpp3aapj9.fsf@gitster.dls.corp.google.com>
References: <1438107144-24293-1-git-send-email-dturner@twopensource.com>
	<1438107144-24293-3-git-send-email-dturner@twopensource.com>
	<xmqqpp3cds44.fsf@gitster.dls.corp.google.com>
	<xmqqegjsdq3n.fsf@gitster.dls.corp.google.com>
	<CALKQrgdLC_sLkM3jyH6pnDoY+RTHr9wJR_VH6iirBWmvyHYcVA@mail.gmail.com>
	<xmqqpp3bc2u6.fsf@gitster.dls.corp.google.com>
	<CALKQrgfxc83-yjrCWZqC+pyPhbQDgYbrpCDSaBk78YypO=BXOg@mail.gmail.com>
	<xmqqlhdzby5o.fsf@gitster.dls.corp.google.com>
	<CALKQrge31G7-Ng8kZmy8=MgB+WQ3-bKimxCxOHOOwUMDuvRBzA@mail.gmail.com>
	<xmqqzj2fa764.fsf@gitster.dls.corp.google.com>
	<CALKQrgfeFrr5SygixW=pJoOCheGR9kUhqwjNyuXGvzJnWU_LyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>,
	Git mailing list <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Philip Oakley <philipoakley@iee.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jul 29 18:37:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKUM9-0004RR-FF
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 18:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753155AbbG2QhS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 12:37:18 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35001 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532AbbG2QhR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 12:37:17 -0400
Received: by pabkd10 with SMTP id kd10so8265582pab.2
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 09:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=yZwAAvscWF06MqS7hzU0MWQPGRBrIi4Z5W7xZ+1T35I=;
        b=JuZrQaDBosa69NYsiyNY/bJg/8aPzRIItZsS3PJsp+VmwKt82MiYHX4OvA0QtQmxG4
         zevQzlSzVzecQxVbyeByR3WA8Zcab56LuWUW7l56I0o02cQg2E23jjeLXiykQtEbbNzo
         DwFcNArI/ooX30D1MD4hpaD3Ahh7OWK4eBeJiPOuWj7Fhr7rI+3be03TU3+hbYsYSzmU
         JHiE/5F7WJ04CEKvhNiKuG0HXuZn3LCzjfnbSmSyeQRt1zbxffoctKC5m+N8FTQtWnZv
         71zIT+Q+SaiNLRYLFw8ffU/HzKWwGPNDg5t8NggTm7xKUqDKQHTKv45KEhc60Ca3nbl6
         rUbA==
X-Received: by 10.66.194.201 with SMTP id hy9mr96124387pac.140.1438187836468;
        Wed, 29 Jul 2015 09:37:16 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4c0b:2701:e242:17dc])
        by smtp.gmail.com with ESMTPSA id s7sm36534576pdn.85.2015.07.29.09.37.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 29 Jul 2015 09:37:15 -0700 (PDT)
In-Reply-To: <CALKQrgfeFrr5SygixW=pJoOCheGR9kUhqwjNyuXGvzJnWU_LyQ@mail.gmail.com>
	(Johan Herland's message of "Wed, 29 Jul 2015 15:19:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274920>

Johan Herland <johan@herland.net> writes:

> On Wed, Jul 29, 2015 at 7:01 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Johan Herland <johan@herland.net> writes:
>>
>>> I believe it is a bad compromise. It complicates the code, and it
>>> provides a concurrent notes merges that is unnecessarily tied to (and
>>> dependent on) worktrees. For example, if I wanted to perform N
>>> concurrent notes merges in a project that happens to have a huge
>>> worktree, I would now have to create N copies of the huge worktree...
>>
>> Who said worktree has to be populated?  You should be able to have
>> an absolutely empty checkout just like "clone --no-checkout".
>
> IMHO that's an insane workaround that only serves to highlight the
> conceptual problems of binding notes merges (as they are implemented
> today) to worktrees.

Actually, the name "linked worktree" is probably a misnomer.

There is nothing fundamental in the mechanism or in the concept that
says that these multiple $GIT_DIR's must not be a bare one.  The
main thing the separation between $GIT_DIR and $GIT_COMMON_DIR
affords you is that you can have some things shared across them
(e.g. refs/*, objects) while making others per $GIT_DIR (e.g. HEAD,
index, etc.).

With that in mind, it is not an insane workaround but a very natural
mechanism suited exactly for what you want to do: using a feature
(e.g. "notes merge") that currently can have at most one instance
running at a time because it stores its state inside $GIT_DIR, and
you want to have N concurrent one going.  You keep that "state per
running instance" inside $GIT_DIR (i.e. not shared) and use the
"linked worktree" mechanism to have multiple $GIT_DIR, connected
to the same $GIT_COMMON_DIR.

> But, whatever. This is unrelated to David's current effort, and I
> don't want to hold that up, so please move along, nothing to see here.

I need this part from an earlier message answered to unblock David's
topic:

    Now we are getting somewhere.  So is there more that is needed
    than separating NOTES_MERGE_REF per worktree to make this work
    (remember, multiple notes-merge in a single worktree is a
    non-goal, just like multiple merge in a single worktree is not
    supported today and will not be)?  Is there some other state
    that is not captured by NOTES_MERGE_REF and friends that you
    would end up recording a wrong merge result, if two worktrees
    that have NOTES_MERGE_REF pointing at a different ref in
    refs/notes/* try to do the notes-merge at the same time?

If we do not change anything (not even applying the [v3 2/6] patch
we are discussing), all these things prefixed with NOTES_ will
become per $GIT_DIR with linked worktrees.

    NOTES_EDITMSG, NOTES_MERGE_REF, NOTES_MERGE_PARTIAL,
    NOTES_MERGE_WORKTREE

The user could attempt to start different notes merges in her
multiple $GIT_DIRs.  The question is to what degree we want to
support her.

Is it sufficient to have these per $GIT_DIR, when the user has two
$GIT_DIRs connected to the same repository and wants to do two
"notes merge" acting on different ref in refs/notes/*?  Or are there
some other states in the shared part kept, which would be stomped on
by simultaneously running "notes merge" instances in different
$GIT_DIRs, that make this not to work?  Any other problems in the
remainder of the current implementation of "notes merge"?

If there are reasons/limitations that make simultaneous "notes
merge" of different notes in different $GIT_DIRs impossible, then I
agree we shouldn't bother with [v3 2/6] patch.  We should just
declare "do not do it, it does not (yet) work".

But if there isn't, [v3 2/6] is the absolute minimum thing we could
do to make "notes merge" usable by making sure that the user does
not attempt merging the same refs/notes/commits in two different
places.
