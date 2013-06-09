From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] diff: add --ignore-blank-lines option
Date: Sun, 9 Jun 2013 22:32:39 +0200
Message-ID: <CALWbr2xijB+UD9gwc+HmMdHM9OT+2Lzr9w3h22=CegKHK-Ocng@mail.gmail.com>
References: <7v61xt7gej.fsf@alter.siamese.dyndns.org>
	<1370724291-30088-1-git-send-email-apelisse@gmail.com>
	<7vsj0roxnr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 22:32:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlmI9-0001hE-MY
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 22:32:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339Ab3FIUcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 16:32:42 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:49779 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991Ab3FIUcl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 16:32:41 -0400
Received: by mail-la0-f43.google.com with SMTP id gw10so5166913lab.30
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 13:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/L06FC+Q5PczHBa7i4JM/4jgAUrcSkADwGzIDPeGFq8=;
        b=nJ+m1TVydNPwnMFwXP5w2lQlUpDL+i5uqIeWjdDx0x1cA2Z2nH/JoKt6ajvdMFZJrK
         3NWoguG7ARBNheVyqE7ISXpLsOK85BPk6SWjwcptM9iyyqSsnVoyxXGvVAbqpwfOIBdq
         URXXEbTQ5lVJbenTE7epuYjlgcvrs2183WiIATOkpa1ddcP3xO033d9Rf2eXwB4jQVdG
         YzAItbM+OMHoIvyFYjVbQMSXHbX6tsGo+nc+vnGzogM7ZQi4DV5rLrpm6/9p5pNY3Jqg
         uS8fIsjm5cDYeRXTdwZhLl04Df9CECWg3tGeqCKmesqBL1JsVWcLp/whiWYq2i/B5wZa
         FHuA==
X-Received: by 10.152.6.36 with SMTP id x4mr3522984lax.40.1370809959767; Sun,
 09 Jun 2013 13:32:39 -0700 (PDT)
Received: by 10.112.61.8 with HTTP; Sun, 9 Jun 2013 13:32:39 -0700 (PDT)
In-Reply-To: <7vsj0roxnr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227163>

On Sun, Jun 9, 2013 at 10:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
> by
> the way, do we also handle deletions and do your new tests check
> them?

As stated in the commit message, yes we should, but we don't have
tests for that.
I will need to add some as I think I found a bug when removing blank lines.

>> +     git diff --inter-hunk-context=100 --ignore-blank-lines >out.tmp &&
>> +     cat <<-\EOF >expected &&
>> +     diff --git a/x b/x
>> +     --- a/x
>> +     +++ b/x
>> +     @@ -1,7 +1,10 @@
>> +     +change
>> +      1
>> +      2
>> +     +
>> +      3
>> +      4
>> +     +
>> +      5
>> +      6
>> +      7
>> +     EOF
>> +     compare_diff_patch expected out.tmp
>> +'
>
> And from that point of view, this expected output may be excessively
> noisy.
>
> So I dunno.

It might be kind of noisy, but I think trying to improve the solution
might lead to over-engineering.
How would we compute the "minimal distance between interesting and
blank" so that the blank becomes interesting ?
Using the context size for that is quite convenient, while creating
another variable would probably become overkill..

The original goal is to remove hunks created solely for
addition/suppression, and I think it's what it should do for the
moment.
But of course, I have no strong opinion about that.

And by the way, I have also another bug, so you can expect another
re-roll (sorry about that, it's more complex than I initially
thought).

Thanks a lot,
Antoine
