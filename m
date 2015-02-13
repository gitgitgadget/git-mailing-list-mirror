From: David Glasser <glasser@davidglasser.net>
Subject: Re: Keep original author with git merge --squash?
Date: Thu, 12 Feb 2015 16:21:56 -0800
Message-ID: <CAN7QDoKODKwSzWn-Py7zEzbELe4JjoSSjQ7riBRYLcXU-0TLXg@mail.gmail.com>
References: <CAN7QDoKQAZKUt_MHWjgt1k3PvXQv6XTcjdijh8KRodO3=VD47A@mail.gmail.com>
 <20150212092824.GA19626@peff.net> <xmqqpp9erihg.fsf@gitster.dls.corp.google.com>
 <CAN7QDoLKFBCJpFa+QL8dPQtwyAyDNt-ck_sNJ3fS+vTrK_Lg9w@mail.gmail.com>
 <xmqq8ug2rfi2.fsf@gitster.dls.corp.google.com> <CAN7QDoJ+hOFqoc54sAbLeSxvj8TQKQRSVKbNQXZYfPv1uOy=WA@mail.gmail.com>
 <xmqq4mqqrc70.fsf@gitster.dls.corp.google.com> <CAN7QDoK8ePJW-pM=m0+WpEsiYb_aUdt_YUm3gyBhctY_nWBshA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 01:22:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YM41Y-0004wN-RS
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 01:22:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbbBMAWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 19:22:18 -0500
Received: from mail-wi0-f171.google.com ([209.85.212.171]:64713 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325AbbBMAWR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 19:22:17 -0500
Received: by mail-wi0-f171.google.com with SMTP id hi2so8384619wib.4
        for <git@vger.kernel.org>; Thu, 12 Feb 2015 16:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=dxln+HrQWyjX+7xp/ayR8V59ROJOA0KYWqXHEORcC0o=;
        b=arTpoVw1apRya0FLRU1Rv4lSe98xVL9Ig6a/E2HXwsLaB3gSpLRxLK1C4wIzB3ctKD
         24SFwViTOsr9NRvd8KTGpYe8RLffvpP6hno2qmKqR8vAw+4dXMSpIptB9iSmlAv7OMMg
         d9ZsJVyD32FBKmyTVhScLBisBHLd73hzU/HhuQjnZ54hvwobc+2t/RobVDLLMktDzgzD
         7Suvc7LRu8imRP5pp3M+kG1lTDd3x/qE7tA/FirmM4x+vEi4tm3YEwW9R/ZZucMepihC
         EuFz6gx72xzg2Y2EXvK85E74ZpjCNsAnuODsC/VGrGISSjgRwU2OJWQG5HGaV0Kx6FSg
         GuUg==
X-Received: by 10.180.19.228 with SMTP id i4mr11245859wie.13.1423786936226;
 Thu, 12 Feb 2015 16:22:16 -0800 (PST)
Received: by 10.194.29.200 with HTTP; Thu, 12 Feb 2015 16:21:56 -0800 (PST)
In-Reply-To: <CAN7QDoK8ePJW-pM=m0+WpEsiYb_aUdt_YUm3gyBhctY_nWBshA@mail.gmail.com>
X-Google-Sender-Auth: 3xkPUk1iQOoBrZ-bxKJ8_Y-a37E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263793>

On Thu, Feb 12, 2015 at 4:17 PM, David Glasser <glasser@davidglasser.net> wrote:
> On Thu, Feb 12, 2015 at 2:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> David Glasser <glasser@davidglasser.net> writes:
>>
>>> So to be concrete: What I'm proposing (and I'm excited to implement
>>> it!) is the following:
>>>
>>> When running "git commit" and:
>>> - You've fallen into the case where the message was read from SQUASH_MSG
>>> - You haven't used another method of specifying the author (--author,
>>>   -C, -c, --amend)
>>> - You have not specified --reset-author
>>> - You have set the "commit.useSquashAuthor" option
>>> - Before invoking prepare-commit-msg, all of the `Author:` lines found
>>>   in SQUASH_MSG have the same value
>>>
>>> then that author is used, as if it were specified with --author.  (And
>>> this will show up, commented-out, at the bottom of COMMIT_EDITMSG.)
>>
>>
>> I actually was hoping that this would extend to cases other than
>> "git merge --squash".
>>
>> When running "git commit" and:
>>
>>  - You didn't use a more explicit method of specifying the
>>    authorship identity (--author, --date, -C, -c --amend,
>>    --reset-author options, or environment variables GIT_AUTHOR_*);
>>
>>  - You have commit.useAuthorFromEditorComment variable;
>>
>>  - You have "# Author: " line that are identical in the result of
>>    the editor,
>>
>> then use that author.  That would allow "git commit --amend" to
>> update a misspelled author name, for example.
>>
>> Is that a bit too liberal?  Would it invite mistakes?
>
> That does sound pretty good.  And for the specific case of squash,
> what I would do would be (a) take one of the existing "Author: " lines
> and turn it into an "# Author:" line and (b) do the ordinary editing
> that I do to combine the existing messages?
>
> (Maybe my proposed "detect that they're all the same" code would run
> at `merge --squash` time, producing a trailing "# Author:" line if all
> of the produced "Author: " lines were identical?)

Or, well, as Peff suggested, maybe SQUASH_MSG should look exactly like
the message that rebase's squash gives you, which in fact is a lot
better: no random indent, "# Author", etc.  So making your suggested
change to parse "# Author" in `git commit`, plus a second change to
make SQUASH_MSG look like rebase's squash, would achieve my goals.


-- 
glasser@davidglasser.net | langtonlabs.org | flickr.com/photos/glasser/
