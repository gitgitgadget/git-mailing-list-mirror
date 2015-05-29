From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git clone --depth: shallow clone problems
Date: Fri, 29 May 2015 08:52:05 -0700
Message-ID: <xmqqiobbe5zu.fsf@gitster.dls.corp.google.com>
References: <CALxdAKiyRMR-jF2KcBQGYgXUb+D8=YaESU3E9KN+zBLx=0UCNw@mail.gmail.com>
	<20150526124702.GA12101@lanh>
	<xmqqmw0rl78r.fsf@gitster.dls.corp.google.com>
	<CACsJy8AO7UNF-SnuqohOPDy2dOvfg=bA+b0rdVihabxBLAz19Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michal Pomorski <misieck@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 29 17:52:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyMZx-0008Ie-8f
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 17:52:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756191AbbE2PwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 11:52:09 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:36251 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753479AbbE2PwH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 11:52:07 -0400
Received: by igbpi8 with SMTP id pi8so17372599igb.1
        for <git@vger.kernel.org>; Fri, 29 May 2015 08:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=1lRPVsvXmjD4TzJY8+yWhdUvSwZfldkVPB01WqxcwwA=;
        b=glB+u/CKpttYSsYIHjmGEjokzoGS4cC69csH9Wm/AOsvpjDucmvXT/0rJmMRU9u9DR
         jV7UUQ9wdw3LcSvqNY1VBTVXZu67VWf2AL88K+eYuW1hnzTad4CPRXb7nji+tz6AOc2R
         J4e7TVXJglcQ+/D/TMWghi+yVM97mw7g+WS2crpEoQ5DxOpLt0q3PNCYGaFkbPz6lS+q
         /ZG9DNvhMx2T2vl0Tw7Hme46E3tLplg2u4VtSU+ru6hTurVeRcCl8g9GKv8tIFibUTko
         RusI+lEIS+ZVu5+b3UrPOIIPZRLzJfQ6Pk+lZ8Ay9YX/ubbsLE8SVIjU+8epxefXr76c
         SgBw==
X-Received: by 10.50.78.170 with SMTP id c10mr674357igx.0.1432914726968;
        Fri, 29 May 2015 08:52:06 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:89d0:c49e:8012:77d2])
        by mx.google.com with ESMTPSA id 85sm3076843iom.25.2015.05.29.08.52.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 29 May 2015 08:52:06 -0700 (PDT)
In-Reply-To: <CACsJy8AO7UNF-SnuqohOPDy2dOvfg=bA+b0rdVihabxBLAz19Q@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 29 May 2015 18:04:31 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270248>

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, May 26, 2015 at 9:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>>>  --unshallow::
>>> -     If the source repository is complete, convert a shallow
>>> -     repository to a complete one, removing all the limitations
>>> +     If the source repository is complete, convert all shallow
>>> +     refs to complete ones, removing all the limitations
>>
>> Define "shallow ref", or better yet explain without introducing such
>> a new term (I do not think shallow-ness is a property of a ref, by
>> the way---I think you meant all refs that can reach the points the
>> history is cauterised by .git/shallow, but we shouldn't assume that
>> the target audience of this paragraph to know Git as well as I do).
>
> OK maybe
>
> Make sure all existing refs have the same history as the ones from the
> source repository. If the source repository is complete, this removes
> all limitations imposed by shallow repositories.

OK, I can understand that description a lot easier than the original
one.

>>> ++
>>> +Note that if the repository is created with --single-branch, which is
>>> +default for a shallow clone, only one ref is completed. `--unshallow`
>>> +does not fetch all remaining refs from source repository.
>>
>> I do not think this "Note" is being as helpful as it could be.
>>
>>  - If the repository was created with --single-branch but if the
>>    user later fetched and started tracking other branches, the
>>    statement "only one ref is completed" is untrue; the true version
>>    is "only the existing refs are completed", which leads to a more
>>    important point.  It says the same thing as "all existing refs"
>>    above and does not add any useful information.
>>
>>  - The last sentence is less than useful but merely frustrating---it
>>    says what you cannot do with this option, strongly hints that the
>>    writer of the sentence knows what the reader wants to achieve,
>>    but without saying what other way the reader go to achieve it.
>>
>> Perhaps replace that Note paragraph with something along this line?
>>
>>     +
>>     By fetching and tracking refs that you haven't been tracking,
>>     you can add these new refs to "all refs" to be unshallowed.
>
> It was meant to emphasize --unshallow would not create a true clone,
> if people miss the keywords "all existing" refs.. Maybe..

I know; it is not helpful to describe what it does *NOT* do, without
saying what the reader is likely trying to find out.

> You may need to fetch and track other refs from the source repository
> if you want to make full clone.

That is much better.
