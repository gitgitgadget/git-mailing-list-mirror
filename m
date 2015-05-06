From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] contrib/subtree: fix linefeeds trimming for cmd_split()
Date: Wed, 6 May 2015 15:58:33 -0400
Message-ID: <CAPig+cT1JY2N6gkzj1kbQKR+nXBMu19-Mkw7V7BNewsOj4mm0Q@mail.gmail.com>
References: <CAMbsUu6xZrMu_jrV=jR4XNLf1UXLApBiAWJiWJuKRb4xN90QJQ@mail.gmail.com>
	<xmqq4mnqet5d.fsf@gitster.dls.corp.google.com>
	<CAMbsUu6=U92TRo-UeOL1qtaTipMQFzD+m+wM7sn1o-AjD6LJBw@mail.gmail.com>
	<xmqqwq0lbp87.fsf@gitster.dls.corp.google.com>
	<CAMbsUu4bix6pJA4OOoMSwYu0M6nO1+aZ7RLXU5sSOdOevN_Wzw@mail.gmail.com>
	<xmqqfv79trk8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Danny Lin <danny0838@gmail.com>, git develop <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 06 21:58:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yq5Sp-0005Ci-HQ
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 21:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbbEFT6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 15:58:35 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:35494 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853AbbEFT6e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 15:58:34 -0400
Received: by ieczm2 with SMTP id zm2so23229247iec.2
        for <git@vger.kernel.org>; Wed, 06 May 2015 12:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=MrGFKyeiCnU9mYDxplh9s17dLOtTSvEmUe9lx5ModkE=;
        b=PX85i30vlcL3QWHoFta+DXpvQ2XFerdB7OBt8JYk5BCsmxO05O66xF9MckU9aJNUoT
         Ipgfa1JvFQ+/Mz4/4iUbJtd05D4m6SyVwnCyHbHRfkY5z9jfbsI1xMvVLg2rN9Er1YtF
         g8h4E6luE8h7B8C9ys8dFkTHNKd5CAcQrI8L2TwcKiPTjCFNVbcfP95BvXembGe/rjWv
         Z6ciB0URPa5sa/gnID6Jctq09dm+nFfYD1WiYqE62ESD6tcUY6HaOhWIk4UZR0TlbcOL
         KSGFYm5BlaremGCMsjnc1ZW7fW3rb6ro8yg5g3XqomoI+MZqMxJwnSQ5D0wGiraFYckd
         L5Sg==
X-Received: by 10.107.169.74 with SMTP id s71mr560956ioe.46.1430942313930;
 Wed, 06 May 2015 12:58:33 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Wed, 6 May 2015 12:58:33 -0700 (PDT)
In-Reply-To: <xmqqfv79trk8.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: fhYgbv-vByovBw8-uz5Eel-H9x4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268489>

On Wed, May 6, 2015 at 3:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Danny Lin <danny0838@gmail.com> writes:
>
>> cmd_split() prints a CR char by assigning a variable
>> with a literal CR in the source code, which could be
>> trimmed or mis-processed in some terminals. Replace
>> with $(printf '\r') to fix it.

For future readers of the patch who haven't followed the email
discussion, it might be a good idea to explain the problem in more
detail. Saying merely "could be trimmed or mis-processed in some
terminals" doesn't give much for people to latch onto if they want to
understand the specific problem. Concrete information would help.

>> Signed-off-by: Danny Lin <danny0838@gmail.com>
>> ---
>> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
>> index fa1a583..3a581fc 100755
>> --- a/contrib/subtree/git-subtree.sh
>> +++ b/contrib/subtree/git-subtree.sh
>> @@ -596,10 +596,11 @@ cmd_split()
>>      revmax=$(eval "$grl" | wc -l)
>>      revcount=0
>>      createcount=0
>> +    CR=$(printf '\r')
>>      eval "$grl" |
>>      while read rev parents; do
>>          revcount=$(($revcount + 1))
>> -        say -n "$revcount/$revmax ($createcount)
>> "
>> +        say -n "$revcount/$revmax ($createcount)$CR"
>
> Interesting.  I would have expected, especially this is a portability-fix
> change, that the change would be a single liner
>
> -       say -n ...
> +       printf "%s\r" "$revcount/$revmax ($createcount)"
>
> that does not touch any other line.

Unfortunately, that solution does not respect the $quiet flag like
say() does. I had envisioned the patch as reimplementing say() using
printf rather than echo, and having say() itself either recognizing
the -n flag or just update callers to specify \n when they want it
(which is probably the cleaner of the two approaches).

>
>>          debug "Processing commit: $rev"
>>          exists=$(cache_get $rev)
>>          if [ -n "$exists" ]; then
> --
