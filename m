From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Tue, 3 Sep 2013 17:59:38 -0500
Message-ID: <CAMP44s3XSVLCn7M33D4uZwUoEsY6wj34N7L8MF8bGOx0+fmV2w@mail.gmail.com>
References: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com>
	<xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
	<CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
	<xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>,
	John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 04 00:59:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGzZY-0000sB-5l
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 00:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933085Ab3ICW7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 18:59:40 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:39773 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932914Ab3ICW7k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 18:59:40 -0400
Received: by mail-lb0-f177.google.com with SMTP id p5so5500745lbi.22
        for <git@vger.kernel.org>; Tue, 03 Sep 2013 15:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DwWigL1I7ghIlrNNznD+ig2PlnhjRyknvCwWUzMwW6c=;
        b=R+Dot4ZcTFA5Fi6lXmOE9uygiRiwDaIftM5MINRfXLqSSOQXcU5lpIk6gEfSPTb0Sy
         5sGNdOQ4XbSqo8NX17ZJ55oxmzGL7j+oIbpictMSFd1ObWyYg48BRoMoD89ZzukN6Nxd
         nUbmDtyIXZd8vtdYwXGxGiGR82SYqZprlO39d+atKZV0zU+E9Q+Bdp8MPKcz6WZPb7UC
         O+qMeYkYldPAuG8k2jaTY5lYT8Pna2KFd+9k61VxA1pCi1f8nE8v9gNwFqYNewNNHGI9
         O19XVycs2P/DSoy/QzM55NZXFbs6bE8nno/nW++xotYPT3VIRvtIGVdsCah0Fk+OjX3g
         xXEw==
X-Received: by 10.112.57.49 with SMTP id f17mr12869015lbq.26.1378249178615;
 Tue, 03 Sep 2013 15:59:38 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Tue, 3 Sep 2013 15:59:38 -0700 (PDT)
In-Reply-To: <xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233795>

On Tue, Sep 3, 2013 at 5:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Tue, Sep 3, 2013 at 12:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> Junio already sent a similar patch, but I think this is simpler.
>>>
>>> I agree that this is simpler, but I am not sure if the behaviour is
>>> necessarily better (note that this is different from saying "I think
>>> the behaviour of this patch is worse").  The motivation I read from
>>> the original discussion was that new people did "git pull" (no other
>>> parameters) to "sync my tree with the central repository" as if it
>>> were SVN, and because we are not SVN, projects that prefer rebases
>>> were unhappy, and the other one was to address *only* that use case.
>>> I do not personally like that special casing (i.e. "only when no
>>> 'integrate with what from where' is given"), and applying the "you
>>> must be explicit between rebase and merge" like this series does
>>> uniformly might (or might not) be a good thing.  I dunno.
>>
>> As I already said; there's is essentially no difference between "git
>> pull" and "git pull origin".
>
> We know what you said earlier. That does not make it right or wrong,
> but I do not think it is in line with the original discussion (that
> is why John Keeping is kept on the Cc: line).

And nobody provided any argument against that claim. People staying
silent doesn't make it wrong.

>>> The difference in changes needed to the test suite is illustrative;
>>> this series affects any use of "git pull" (with or without explicit
>>> "what to integrate with and from where"), unlike the other one that
>>> only affects the case where "git pull" was not given "what to
>>> integrate with and from where".  I think an earlier draft I did for
>>> the previous one did not special case "only when no 'integrate with
>>> what from where' is given" and had to touch all the places in the
>>> test in a similar way.
>>
>> Yeah, that version affects less, but it also doesn't achieve what we
>> actually want.
>
> I do not think we know what we want is to affect "git pull origin".

Of course we do.

What we want is to make "git pull" more user-friendly, specially to
newcomers, and specially those that come from centralized VCS, where
"tool pull" updates the checkout, and thus we want "git pull" not to
create merges inadvertently, and the best way to do that is to warn
the user that the merge is non-fast-forward, and he should do a merge
or rebase.

The fact that a particular user might have learned about remotes and
did "git pull origin" instead is irrelevant, he would still want to be
warned about non-fast-forward merges.

Everybody would want to be warned about that by default, I know I
would, I might even start using 'git pull' again, and so countless
people that have stopped using 'git pull' precisely for this reason.

-- 
Felipe Contreras
