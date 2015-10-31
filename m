From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: [PATCH] checkout: add --progress option
Date: Sat, 31 Oct 2015 12:14:39 -0600
Message-ID: <CAOc6etapqKNAXxNycAx9g9VTJXnnCxuXj5eU7giKvZUy5s8X3Q@mail.gmail.com>
References: <1446168186-4730-1-git-send-email-eantoranz@gmail.com>
	<CAPig+cTvRs_O8uY9_SrZZCf95Lraon8knkQUDgm0Lke3pve01A@mail.gmail.com>
	<xmqqh9l8kxa3.fsf@gitster.mtv.corp.google.com>
	<20151030193151.GB5336@sigill.intra.peff.net>
	<xmqq4mh8kv0e.fsf@gitster.mtv.corp.google.com>
	<CAOc6etYiqH8bvnCD_9hedzDW6fhknXLGesM6dX7S9DBB_r-9zA@mail.gmail.com>
	<CAOc6etYCzBYpf+7p8p3=zQun7bYXYVc-codoUf5Abcq+hAz8cA@mail.gmail.com>
	<xmqqk2q3hrbl.fsf@gitster.mtv.corp.google.com>
	<CAOc6eta7_0RfBUngtMg5ZAEUvjuPVgZ20ESgnbJK=--h53k+Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 19:14:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zsag2-0003YX-P8
	for gcvg-git-2@plane.gmane.org; Sat, 31 Oct 2015 19:14:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751989AbbJaSOk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2015 14:14:40 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33698 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbbJaSOj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2015 14:14:39 -0400
Received: by padhy1 with SMTP id hy1so98795952pad.0
        for <git@vger.kernel.org>; Sat, 31 Oct 2015 11:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Yy5be+0AYb2rDHIgq++I6SyHu5jW4axePGJDM0LAqZ0=;
        b=J551RmzFRj0rPTTHdC3+pmjmCipUHPUdNXCjdny2ELctNLUbhy+EL99FcocIn11+iN
         2kureIvvCx6NQbvQjm28evza+IDIZMiWbyQhRMyVersd57H9AU3aB0EgYCGvTLzZbIUB
         TaPdkJkr1BKRajRzqZUTX8UQJ3Q6iki/2ryaOnsjczGLU74KzhjT3NST3v1Y/scU7IyB
         gqcALxcTnqajmsA5NnlkrZi2j5ci+/9euChBm0/10nw7hSsTeIlHk+YiDKvMSkgr2tqy
         z2FzLN0Ef2EAZMrTUNhmjKSOXyeTI2OXyEk+KCt56MtNXPmKZ82VHJ/SxUFSmBdtDB+C
         HBxA==
X-Received: by 10.66.132.9 with SMTP id oq9mr16218424pab.101.1446315279116;
 Sat, 31 Oct 2015 11:14:39 -0700 (PDT)
Received: by 10.66.149.4 with HTTP; Sat, 31 Oct 2015 11:14:39 -0700 (PDT)
In-Reply-To: <CAOc6eta7_0RfBUngtMg5ZAEUvjuPVgZ20ESgnbJK=--h53k+Tw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280596>

I just noticed something interesting.

On Sat, Oct 31, 2015 at 11:42 AM, Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> On Sat, Oct 31, 2015 at 11:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> I do find what Peff showed us a lot easier to follow.
>>
>>         if (opts.show_progress < 0) {
>>                 if (opts.quiet)
>>                         opts.show_progress = 0;
>>                 else
>>                         opts.show_progress = isatty(2);
>>         }
>>
>
> Ok.... let me rewrite it that way. Other than that, the other things are ok?

In Peff's implementation I think he uses -1 as --no-progress, 1 as
--progress and 0 as undefined, right?

In my implementation I'm using -1 as undefined and 0 as --no-progress.
What would be the standard approach? From what I can see on
parse_options's behavior, if you select --no-progress, the variable
ends up with a 0, which makes me think I'm using the right approach.

End result with my assumptions would be:

        if (opts.show_progress) {
                /* user selected --progress or didn't specify */
                if (opts.quiet) {
                        opts.show_progress = 0;
                } else if (opts.show_progress < 0) {
                        opts.show_progress = isatty(2);
                }
        }
