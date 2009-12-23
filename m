From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH RFC 4/4] rebase -i: add --refs option to rewrite heads
    within branch
Date: Wed, 23 Dec 2009 09:53:42 +0100
Message-ID: <4B31DA96.1050608@drmicha.warpmail.net>
References: <20091222222032.GU30538@dr-wily.mit.edu>	 <20091222222316.GY30538@dr-wily.mit.edu>	 <7vzl5awpf1.fsf@alter.siamese.dyndns.org> <1ac2d430912222303k6180baa6j291bb4d18c7a4968@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Greg Price <price@ksplice.com>
X-From: git-owner@vger.kernel.org Wed Dec 23 09:55:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNN05-0007TY-AY
	for gcvg-git-2@lo.gmane.org; Wed, 23 Dec 2009 09:55:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754558AbZLWIzO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2009 03:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754407AbZLWIzN
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Dec 2009 03:55:13 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60458 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754159AbZLWIzN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Dec 2009 03:55:13 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4BF85C7DE1;
	Wed, 23 Dec 2009 03:55:12 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 23 Dec 2009 03:55:12 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=ID1JqGIsCR7ZX/if205dwsW/puY=; b=PeHDCYlLBN7pG70mbFLG5avMemiihCcthh6DhsQtk2SBGjG4uBWVrzeUJOd7NOwVKQmKvE8HOwXCYtf5MJId9xMcm/lY2tJquUMGOiHGYcCgwSeDp8j7UFj0GVVKFtJAn2js2BwRxx0EVE3Hi2J7FXMNzqj14ut6bLmV8T7Vvfc=
X-Sasl-enc: S5HFX/Ux6rd7S/sbkcfSVtvbQzd3WErjW+zFNPfstewH 1261558511
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 531564BA0D6;
	Wed, 23 Dec 2009 03:55:11 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7pre) Gecko/20091209 Lightning/1.0b2pre Shredder/3.0.1pre
In-Reply-To: <1ac2d430912222303k6180baa6j291bb4d18c7a4968@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135617>

Greg Price venit, vidit, dixit 23.12.2009 08:03:
> On Tue, Dec 22, 2009 at 6:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>  - As decoration is a fairly expensive operation (which is the reason why
>>   loading_ref_decorations() is called lazily by format_decoration() in
>>   the first place, especially in repositories with tons of refs), you
>>   shouldn't give --format=%D to rev-list when the new feature is not
>>   asked for.
> 
> OK, will do.
> 
> 
>>  - This seems to rewrite only branch heads; don't you want to allow users
>>   to rewrite lightweight tags and possibly annotated ones as well, by
>>   perhaps giving "--rewrite-refs=refs/heads/" or "--rewrite-refs=refs/"
>>   to limit what parts of the ref namespace to consider rewriting?
> 
> Sure.  I specifically left out tags because I generally think of a tag
> as something immutable that it would not make sense to rewrite.  But
> people use Git in different ways and it makes sense to give the option
> of rewriting tags as well as heads.
> 
> I do worry that passing --rewrite-refs=refs/ will set up remote refs
> for rewriting, which is likely to be confusing if the user does not
> notice them and remove them from the TODO.  Perhaps it makes sense to
> accept forms like "--rewrite-refs=refs/heads/,refs/tags/" or
> "--rewrite-refs=refs/heads/ --rewrite-refs=refs/tags/".  Is there a
> Git convention for accepting a sequence of arguments like this to an
> option -- one of these, or something else?
> 
> 
>> On the other hand, if the "partN" markers in your example workflow are
>> primarily meant to be used to mark places on a branch (as opposed to
>> arbitrary branch tips that independent development starting from them can
>> further continue), it would make a lot more sense to use lightweight or
>> annotated tags for them, and instead of "--refs" that rewrites only other
>> branch tips, it might make a lot more sense to have "--rewrite-tags" that
>> rewrites tags that point at the commits that are rewritten, without
>> touching any branch tip.
> 
> I think of them as a topic branch developing one feature, then another
> branch developing a related follow-on feature, etc.  I would also feel
> odd rewriting tags as a routine operation, or calling a ref a tag when
> I expect to rewrite it.  So I do think they're best recorded as branch
> tips rather than tags.
> 
> 
>> Obviously the series also needs tests.
> 
> Yes.
> 
> 
>> I also have to wonder if this feature should also handle a case like this:
>>
>>                  side
>>                  |
>>                  V
>>                  *
>>                 /
>>        part1   *    topic
>>          |    /      |
>>          v   /       v
>>    A--*--*--*--*--*--*
>>     \
>>      B <--master
>>
>> ===>
>>
>>                     side
>>                     |
>>                     V
>>                     *
>>                    /
>>           part1   *    topic
>>     A       |    /      |
>>      \      v   /       v
>>       B--*--*--*--*--*--*
>>       ^ [
>>       |
>>       master
>>
>> especially if it were to be specific to branch management.
> 
> Huh, that's an interesting idea.  I hadn't thought of that.  This
> feature could be nice.  But I am not sure what it would look like.
> How might the user indicate that they want both "side" and "topic" to
> be rebased?  I suppose we could extend the familiar command line
>    git rebase <upstream> [<branch>]
> to the form
>    git rebase <upstream> [...<branches>...]
> so that your example would be
>    $ git rebase -i --rewrite-heads master topic side
> If we choose this approach, it might even be independent of
> --rewrite-refs, though the implementation would presumably rely on the
> "ref" command.  Was this interface what you were thinking, or do you
> have another idea?
> 
> Greg

If I may jump in: I imagine this to be the more common use case, i.e.:
You have a part of the DAG which you want to rebase, with all kinds of
refs (branches, tags) pointing to commits in that part of the DAG. If
you rebase that part of the DAG you typically want some refs rewritten
(such as the head of the branch you're rebasing) but maybe not others
(say a release tag or branch). remote refs should never be rebased. So,
one would need an easy way to specify one ref, all or anything in between...

Michael
