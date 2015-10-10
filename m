From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 01/10] ref-filter: implement %(if), %(then), and
 %(else) atoms
Date: Sat, 10 Oct 2015 21:52:11 +0530
Message-ID: <CAOLa=ZSVJnZu2vuhR8breWkiYTQWb2ZxygGOv3QB4kqJ5nBDiA@mail.gmail.com>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
 <1444295885-1657-2-git-send-email-Karthik.188@gmail.com> <vpqvbahmc1i.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Oct 10 18:22:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zkwv1-0000Ii-3m
	for gcvg-git-2@plane.gmane.org; Sat, 10 Oct 2015 18:22:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175AbbJJQWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Oct 2015 12:22:42 -0400
Received: from mail-vk0-f47.google.com ([209.85.213.47]:33746 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbbJJQWm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Oct 2015 12:22:42 -0400
Received: by vkaw128 with SMTP id w128so11063957vka.0
        for <git@vger.kernel.org>; Sat, 10 Oct 2015 09:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2+v18CzJyrheFom7OZkNkhE6T95Q5nqN8S2bPKXLFbM=;
        b=SuRdAvFelXtUjHkyDBOp3xEt26vB6M0yMFa6N5v2Im0U8h64x6PNuYVlKMMEwB44FN
         SGubbM/5eyWASHNem6tDogA2DOZ9MJgNpQI53iv4T+5kd8AL2q+/ecEsX6/pXd7qNpmI
         oJ1XZ/mjzs44xLf28ShI6zDSZwUZEa0cERXyP0pGtNN0bHoKedjMUZQeBW0+SaKYTst6
         rvsa/RHWBl0tTO5stLkdPcN/U2ZBLlc8E0JL2aC/vYZ80YjHcLaOFmi6NZHcoNvAElSm
         cVgQD7aSss+DOf4ljXMzKAvBWWRoWO1HHXcxLOQBYAPsH5utsA+aGFlUkmSWqf+VAJ1N
         2Xbw==
X-Received: by 10.31.15.69 with SMTP id 66mr12822621vkp.142.1444494161104;
 Sat, 10 Oct 2015 09:22:41 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Sat, 10 Oct 2015 09:22:11 -0700 (PDT)
In-Reply-To: <vpqvbahmc1i.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279324>

On Fri, Oct 9, 2015 at 12:18 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +static void if_then_else_handler(struct ref_formatting_stack **stack)
>> +{
>> +     struct ref_formatting_stack *cur = *stack;
>> +     struct ref_formatting_stack *prev = cur->prev;
>> +     struct if_then_else *if_then_else = (struct if_then_else *)cur->at_end_data;
>> +
>
> You should add
>
>         if (!if_then_else->then_atom)
>                 die(_("format: %%(if) atom used without a %%(then) atom"));
>
> here ...
>

Will do.

>> +static void then_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
>> +{
>> +     struct ref_formatting_stack *cur = state->stack;
>> +     struct if_then_else *if_then_else = NULL;
>> +
>> +     if (cur->at_end == if_then_else_handler)
>> +             if_then_else = (struct if_then_else *)cur->at_end_data;
>> +     if (!if_then_else)
>> +             die(_("format: %%(then) atom used without an %%(if) atom"));
>> +     if (if_then_else->then_atom)
>> +             die(_("format: %%(then) atom used more than once"));
>> +     if_then_else->then_atom = 1;
>
> ... and
>
>         if (if_then_else->else_atom)
>                 die(_("format: %%(then) atom used after %%(else)"));
>
> here, just in case (adding the two corresponding test_must_fail wouldn't
> harm of course).
>

Will do, thanks!

-- 
Regards,
Karthik Nayak
