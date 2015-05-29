From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git clone --depth: shallow clone problems
Date: Fri, 29 May 2015 18:04:31 +0700
Message-ID: <CACsJy8AO7UNF-SnuqohOPDy2dOvfg=bA+b0rdVihabxBLAz19Q@mail.gmail.com>
References: <CALxdAKiyRMR-jF2KcBQGYgXUb+D8=YaESU3E9KN+zBLx=0UCNw@mail.gmail.com>
 <20150526124702.GA12101@lanh> <xmqqmw0rl78r.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michal Pomorski <misieck@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 29 13:05:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyI6F-00038O-8F
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 13:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755514AbbE2LFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 07:05:04 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:37441 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754472AbbE2LFD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 07:05:03 -0400
Received: by igbsb11 with SMTP id sb11so11321777igb.0
        for <git@vger.kernel.org>; Fri, 29 May 2015 04:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=POKlbXNKxFnnh2VIhq2luOZpIx0DMH7uAmBGcpBofeY=;
        b=bKcixtbUF41QmYEv0DvBRlljZRtQL13FoLNnPrYWSJdP80M+S+jGMKndAGxW2dxreM
         bM+mBE47AGumaSaeBKJrA75+fCXeNf3HR/JgWO0lhE70IjG7cjMYvIamdmaeNZ5Iwani
         9iEdOMjZWPD8wqdXpmdrt7vXb+yfhTctoBpB6Us4vyz7FAH2BzgxOX82KYOmkzqfakT5
         IBbQY1VoTwKGAgTdbK7O36A+MlPrayGJhYjJ8WC3XOoFen8fKfx1zwugA+z4Nuf/Zgc9
         DQqLsyFSqOvCc070P2h7uOXwIWrxXClsJCGy0hen3e5Yzr5vkRwyYUaQiLYAqJcuEp4G
         /wZQ==
X-Received: by 10.43.172.68 with SMTP id nx4mr14160519icc.48.1432897502304;
 Fri, 29 May 2015 04:05:02 -0700 (PDT)
Received: by 10.107.6.9 with HTTP; Fri, 29 May 2015 04:04:31 -0700 (PDT)
In-Reply-To: <xmqqmw0rl78r.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270225>

On Tue, May 26, 2015 at 9:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>>  --unshallow::
>> -     If the source repository is complete, convert a shallow
>> -     repository to a complete one, removing all the limitations
>> +     If the source repository is complete, convert all shallow
>> +     refs to complete ones, removing all the limitations
>
> Define "shallow ref", or better yet explain without introducing such
> a new term (I do not think shallow-ness is a property of a ref, by
> the way---I think you meant all refs that can reach the points the
> history is cauterised by .git/shallow, but we shouldn't assume that
> the target audience of this paragraph to know Git as well as I do).

OK maybe

Make sure all existing refs have the same history as the ones from the
source repository. If the source repository is complete, this removes
all limitations imposed by shallow repositories.

?

>>       imposed by shallow repositories.
>>  +
>>  If the source repository is shallow, fetch as much as possible so that
>> -the current repository has the same history as the source repository.
>> +the all existing refs of current repository have the same history as in
>> +the source repository.
>
> Makes sense, modulo "so that the all existing refs" sounds strange
> to my ears ("all the existing refs" perhaps).

Will fix. Although I think the new paragraph above already covers this case too.

>> ++
>> +Note that if the repository is created with --single-branch, which is
>> +default for a shallow clone, only one ref is completed. `--unshallow`
>> +does not fetch all remaining refs from source repository.
>
> I do not think this "Note" is being as helpful as it could be.
>
>  - If the repository was created with --single-branch but if the
>    user later fetched and started tracking other branches, the
>    statement "only one ref is completed" is untrue; the true version
>    is "only the existing refs are completed", which leads to a more
>    important point.  It says the same thing as "all existing refs"
>    above and does not add any useful information.
>
>  - The last sentence is less than useful but merely frustrating---it
>    says what you cannot do with this option, strongly hints that the
>    writer of the sentence knows what the reader wants to achieve,
>    but without saying what other way the reader go to achieve it.
>
> Perhaps replace that Note paragraph with something along this line?
>
>     +
>     By fetching and tracking refs that you haven't been tracking,
>     you can add these new refs to "all refs" to be unshallowed.

It was meant to emphasize --unshallow would not create a true clone,
if people miss the keywords "all existing" refs.. Maybe..

You may need to fetch and track other refs from the source repository
if you want to make full clone.

?

>
>>> 2) git fetch --unshallow should convert the clone into an actual
>>> equivalent of a normal, not shallow clone.
>>
>> I was thinking of some way to undo --single-branch too. I don't think
>> it should be the job of --unshallow, maybe a new option, but I can't
>> think of a name better than --really-unshallow :P
>
> Isn't that just the matter of updating remote.origin.fetch?  I do
> not think it belongs to "clone" (or "fetch").  Perhaps it belongs to
> "remote", where it already shows with "git remote -v" what is
> fetched and pushed.

Yeah, perhaps showing an advice about git-remote is enough if the
current ref spec does not fetch everything.

>>  --depth <depth>::
>>       Create a 'shallow' clone with a history truncated to the
>> -     specified number of revisions.
>> +     specified number of revisions. --single-branch is
>> +     automatically specified unless the user overrides it with
>> +     --no-single-branch
>
> Yeah, something like that would be a definite improvement.
>
> By the way, while composing this message, I scratched my head after
> typing
>
>     $ git clone --shallow=4 --no-local ./git.git ./playpen
>
> Is it just me or do we want to add such a synonym?

I have a series to define shallow boundaries by tags or dates, in
addition to history depth. It may take a few more months until I'm
finished with my ongoing topics. Then you could think about what
--shallow means exactly ;-)
-- 
Duy
