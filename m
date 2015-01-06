From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH v2 2/2] t/t3308-notes-merge.sh: succeed with relaxed notes refs
Date: Tue, 6 Jan 2015 15:29:08 -0800
Message-ID: <A5A16FEC-D72C-4B21-8BE1-3A41696DFF49@gmail.com>
References: <d4509363c8f670483dacdd2a5070f5a@74d39fa044aa309eaea14b9f57fe79c> <e514c72c481c66f9808f1dd09117a16@74d39fa044aa309eaea14b9f57fe79c> <xmqq8uhgqkge.fsf@gitster.dls.corp.google.com> <F6072C48-FA50-4F9D-AD26-0B4C4DD64B91@gmail.com> <xmqqtx03pxzf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>,
	Scott Chacon <schacon@gmail.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 00:29:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8dYr-0004Tn-MJ
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 00:29:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbbAFX3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 18:29:13 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:37946 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085AbbAFX3M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 18:29:12 -0500
Received: by mail-pa0-f41.google.com with SMTP id rd3so861130pab.0
        for <git@vger.kernel.org>; Tue, 06 Jan 2015 15:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=Euf4OhTyNNDIDzlTJl3mtI4w3IvU10uc3JY+5OC/jSw=;
        b=Bc/qP2Uj+gHvarfp1SIJ7B4hZIc55PUKKjpP77sYwfjohJHkLAFApH0zxU2D4H+vg+
         cnv0fPJyKVTDkIB90fMALvaLSEoFa7lWpO1U3/aI+aF5LWWNHSkJ2ZAma1oqZK01OPRc
         DQy6QXP/JVKSUYHHUluFJyDM642yMZsLBxCc6mdDoy4s3pfUUPUkOtOeM26HvJOBGLHO
         4iXsFSuJ4uUWfLF2VmZw5qz3OqNNphNKwHKzF+MEQkKK5AeCShpiyAaE7Su1zfAuBt8V
         wKh11YSV973bpY4wkmlmtaA7C2AoPYhTc8v5gLYR/ExGKI9rwg+5o7cb1eMXsJ8cZwtB
         r6sw==
X-Received: by 10.66.249.99 with SMTP id yt3mr148253184pac.59.1420586951705;
        Tue, 06 Jan 2015 15:29:11 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id de7sm57922053pdb.74.2015.01.06.15.29.10
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 06 Jan 2015 15:29:11 -0800 (PST)
In-Reply-To: <xmqqtx03pxzf.fsf@gitster.dls.corp.google.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262111>

On Jan 6, 2015, at 10:25, Junio C Hamano wrote:

> "Kyle J. McKay" <mackyle@gmail.com> writes:
>
>> So despite the name of the test, the actual tree contents do not seem
>> to be examined.
>
> Yes, but the thing is, thanks to refs/notes restriction, there is no
> need to do such examination [*1*].
>
> Note that it is an entirely different matter when you deliberately
> violate the expectation using plumbing (e.g. update-ref).  Users of
> plumbing commands are expected to know what they are doing, so the
> level of safety we need to give them can be much lower than Porcelain
> commands such as 'git notes'.
>
> But when you stick to Porcelain commands, it is very hard to mix
> refs/notes/* with refs/heads/* and refs/remotes/* by mistake.  You
> have to really work on it by doing something unusual to have a non
> commit in refs/heads/*, a commit in refs/notes/*, or a regular
> non-note commit in refs/notes/*.

Perhaps that is the crux of the issue.  There is no git notes-plumbing  
command where the git notes command continues to apply restrictions  
but the vaporware notes-plumbing command allows anything just like  
update-ref does.

I think there are two issues here:

1) There's no simple way to store remote notes refs outside the refs/ 
notes namespace in such a way that they can be used with git notes  
commands.

2) People who want to experiment with using git notes storage as a  
basis for building some new feature are forced to store their refs  
under the refs/notes namespace even if that does not make sense for  
the feature when what's stored in the notes tree is not intended to  
provide any content that is directly meaningful to the user.

> That is exactly what I meant by that the existing safety pays price
> of not being able to store notes outside refs/notes, which may be
> too high a price to pay.
>
>>> Although I am not fundamentally against allowing to store notes
>>> outside refs/notes/, it is different from "anywhere is fine".
>>> Can't we do this widening in a less damaging way?
>>
>> Without arbitrarily restricting where notes can be stored it seems to
>> me the only option would be to have the notes machinery actually
>> inspect the tree of any existing notes ref it's passed.
>
> As I said earlier (assuming you read footnotes before you read a new
> paragraph), the ship has already sailed.

Hmpf.  So the only possible safety check is refname-based.  But, as  
you say, it's no use crying over spilled milk [3].

> Obvious two sensible ways forward are to do a blacklist (i.e. allow
> anywhere except for known non-notes namespaces like refs/heads/) or
> do a whitelist (i.e. allow refs/<some-known-space> in addition to
> refs/notes) of the namespace, and the latter is vastly preferrable
> than the former, because you can practically *never* crawl back a
> namespace once you give it to the general public, even if you later
> find it a grave error to open it too widely and need a more
> controlled access [*2*].  And the name of the game for a software
> that can be relied for a long haul is to avoid painting ourselves in
> a corner that we cannot get out of.
>
> If we add refs/remote-notes/* to the whitelist now, and if later it
> turns out to be not so ideal and we would prefer another layout for
> remotes, e.g. refs/remotesNew/*/{heads,notes,tags}/, we can add
> refs/remotesNew/*/notes/ to the whitelist _without_ breaking those
> who have already started using refs/remote-notes/*.  That is why
> I said whitelist is preferrable than blacklist.

A whitelist solves issue (1) but is no help for issue (2) unless some  
additional additional part of the refs namespace were to be also  
whitelisted.  Perhaps something like refs/x-<anything>/... in the same  
vein as the various IETF standards for experimental names.

> [Footnote]
>
> *1* I actually do not think a tree examination would help very much
>    here.  IIRC, somebody decided long time ago that it would be a
>    good idea to be able to store a path that is not a fanned-out
>    40-hex in a notes tree and 'git notes merge' would accept such a
>    notes-tree.  Although I doubt that the resulting notes-tree
>    produced by 'notes merge' is carefully designed one (as opposed
>    to whatever the implementation happens to do) with sensible
>    semantics, people may already be relying on it.
>
> *2* The above 'notes-tree can store non fanned-out 40-hex' is a good
>    example why you need to start strict and loosen only when it
>    becomes necessary.  Despite that even Git itself does not use
>    that "facility" to do anything useful AFAIK, only because we
>    started with a loose variant that allows arbitrary garbage, we
>    cannot retroactively tighten the definition of what a notes-tree
>    should look like without risking to break practice of other
>    people.


[3] http://cheezburger.com/6423972864

-Kyle
