From: John Tapsell <johnflux@gmail.com>
Subject: Re: git reflog --date
Date: Tue, 21 Oct 2014 18:31:42 +0100
Message-ID: <CAHQ6N+rb6eNC0_uzCAdH-HNb_SmdG4-W9DgmVKjfNpRcKKxk=w@mail.gmail.com>
References: <CAHQ6N+oQV8Uesv_eCBZc+hpwR5rDWA22OXR05AJ_zXcf7bfQ7g@mail.gmail.com>
 <xmqqh9yx1gkt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 21 19:32:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgdI1-0005l9-Ml
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 19:32:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933181AbaJURcF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 13:32:05 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:50689 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933046AbaJURcE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 13:32:04 -0400
Received: by mail-ig0-f169.google.com with SMTP id uq10so8695785igb.0
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 10:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dcqL6I3biwBBnkhHsVOX9UxSmQthh2ssjmg9S/rhQk4=;
        b=gpToug0y+mngFGigNTdSCH88PRwCGo1xnsozb1SjR5HTNP+S62E2ZA2McV3sAosics
         yJ7YdWIMsfP4S9OvR95OAoeBaiQVQ0gecWdCd3PW/FOEZ+SrAal1ZDbW3b4cjcWbTHtW
         gr8UDkrXw8vH40XAObEdnm+wzXlMKu64WW65B82d+PYHgQxuePKFQVn71F4yGqZhN03q
         Cw0vKl6fmgX1edCOrr9bM1YvM/VcHctBZLUmW2QmHEzqnEs8u01XzzigXzoJ4NU/BM8X
         yxKJ0Ice9kSfbLl9Q457fl09kJTEEzT9CDaAEG4xuh1CyP04SnGkpMuuGrTjtr7NT12W
         f2Qg==
X-Received: by 10.42.122.208 with SMTP id o16mr4565237icr.69.1413912722932;
 Tue, 21 Oct 2014 10:32:02 -0700 (PDT)
Received: by 10.107.11.96 with HTTP; Tue, 21 Oct 2014 10:31:42 -0700 (PDT)
In-Reply-To: <xmqqh9yx1gkt.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For me, writing "git reflog @{now}"  is a lot less intuitive than "git
reflog --date"

Currently the top google search for this question is here:

http://stackoverflow.com/questions/17369254/is-there-a-way-to-cause-git-reflog-to-show-a-date-alongside-each-entry

Which doesn't mention "@{now}"   at all.

My opinion:

1. Add --date   as an option to reflog.  Perhaps using the log.date
format as the default.
2. Document --date in the man page for "git reflog"
3. Document @{now}  in the man page for "git reflog"

Sound good?

John

On 21 October 2014 18:24, Junio C Hamano <gitster@pobox.com> wrote:
> John Tapsell <johnflux@gmail.com> writes:
>
>> Hi all,
>>
>>   Could we add a default to "--date" so that:
>>
>> git reflog --date
>>
>> just works?  (Currently you need to do:   git reflog --date=iso)  It
>> should probably obey the default in log.date?
>
> Hmph.  "--date=<style>" is not the way to choose between timed and
> counted output in the first place, though.
>
> In a similar way that "git log -g @{now}" and "git log -g @{0}"
> switch between two, "git reflog @{now}" and "git reflog @{0}" have
> been the primary way to choose between them.  Only because it is
> clear that you want the timed format when you specify any date style
> e.g. "git reflog --date=relative", we give timed output without
> @{<time>/<number>} but that is just icing on the cake.
>
> That at least is why things are the way they are.  And once you
> understand the above, you would understand why "--date=<style>" is
> not singled out as a useful option in the documentation, because
> that is not a primary way to choose between timed and counted
> output, but because it is merely a way to influence how times are
> shown once you chose timed output.
>
> Having said all that, I have a few comments:
>
>  - Perhaps use of @{<time>} vs @{<count>} as _the_ way to choose
>    between timed and counted output is not documented clearly enough
>    to lead to such a misunderstanding?
>
>  - Perhaps use of @{<time>} vs @{<count>} is a less intuitive than
>    ideal way to choose between them in the first place?
>
>  - Perhaps adding --date with no date-style specification as another
>    way to trigger "You said 'date' so you must mean you want timed
>    output" heuristics just like existing "--date=<style>" does may
>    let us get away without answering the above two questions,
>    sidestepping the issues?
>
> I dunno.
