From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/4] builtin: add git-check-mailmap command
Date: Fri, 12 Jul 2013 02:24:43 -0400
Message-ID: <CAPig+cTwXe7rSKUgJPVHbAvrxYbmL77xNXtLyUeRnd8Taxtrdw@mail.gmail.com>
References: <1373554528-15775-1-git-send-email-sunshine@sunshineco.com>
	<1373554528-15775-2-git-send-email-sunshine@sunshineco.com>
	<7vli5crk8l.fsf@alter.siamese.dyndns.org>
	<CAPig+cQvnKSxZ5M6zW_r6Y9xwZ0Ch99JDq4SccYXCRof9svsOg@mail.gmail.com>
	<7vbo68pbwm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 08:24:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxWmg-0002mf-3i
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 08:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752631Ab3GLGYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 02:24:46 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:45593 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616Ab3GLGYp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 02:24:45 -0400
Received: by mail-lb0-f174.google.com with SMTP id x10so7437080lbi.33
        for <git@vger.kernel.org>; Thu, 11 Jul 2013 23:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=aXwLEtkBGYBMo4OdIcdVSXHEM4AyihXJ8EJcIJT5da4=;
        b=jOlHnVyM3r6QAJQJxS0jHuN2n0JLcAD+wnY/sFhXDQdM5pYytVLCnrxJGdRlVpl0Fd
         RZMI+EExubNxdhAzgCDwQN/CP0cibq5vR0YBEQYIWFeXAopnGeE4nFX7C2/aijddusEe
         Cao3hlxJJH8+4SnyeNw5hzSvLiqszj95QEGF6bEIBu8FVi0cXFrhPAN7XYJfAhaYHfR4
         sFxDnlkNab7fNJUYL/mOxMMyXx5jj4XFL3T6VgX119NTuNQjXTXer1CBorhpNdDEmmGI
         NMaUSAX/XnKvjR5lpfoE1pIOy/5jgNhZ54O5ia1YKw9UlYY9Oku5WsRh5AKEfK+WrtRV
         uTFQ==
X-Received: by 10.112.97.132 with SMTP id ea4mr18209958lbb.80.1373610283643;
 Thu, 11 Jul 2013 23:24:43 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Thu, 11 Jul 2013 23:24:43 -0700 (PDT)
In-Reply-To: <7vbo68pbwm.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: ji3AuwIU-1Ph2LrqUuLR7TVLweE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230173>

On Fri, Jul 12, 2013 at 1:47 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>>>         For each contact information (either in the form of ``Name
>>>         <user@host>'' or ...)
>>>
>>> in order to clarify that the two forms of input is what you call
>>> "contact information".
>>
>> Is this easier to read?
>>
>>     For each ``Name $$<user@host>$$'' or ``$$<user@host>$$'' from the
>>     command-line or standard input (when using `--stdin`), print a line
>>     showing either the canonical name and email address (see "Mapping
>>     Authors" below), or the input ``Name $$<user@host>$$'' or
>>     ``$$<user@host>$$'' if there is no mapping for that person.
>
> I find it easier than your original, but I do not know if you would
> want to repeat the "Name... or <user@host>" at the end.  It does not
> seem to add much useful information and is distracting.

Next attempt:

    For each ``Name $$<user@host>$$'' or ``$$<user@host>$$'' from the
    command-line or standard input (when using `--stdin`) look up the
    person's canonical name and email address (see "Mapping Authors"
    below). If found, print them; otherwise print the input as-is.

>> In check-attr, null_term_line indicates that _input_ lines are
>> null-terminated. In check-ignore, null_term_lines is overloaded (and
>> perhaps abused) to mean that both _input_ and _output_ lines are
>> null-terminated.
>
> That is unfortunate but it is good that you found the breakage.  As
> we do not have --nul-terminated-input and --nul-terminated-output
> options separtely, -z should apply to both input and output.  What
> b4666852 (check-attr: Add --stdin option, 2008-10-07) did is broken.

I can make git-check-mailmap behave this way, however, other than
git-check-ignore (which is quite new), there doesn't seem to be any
precedence (that I can find) anywhere else in git which ties input and
output null-termination to a single switch. Is it desirable to do so
or should the user have more fine-grained control? ("xargs -0" comes
to mind when thinking of a null-termination input switch.)

> Also "git check-ignore -h" advertises "-z" as only affecting "--stdin",
> which is also wrong.  It does affect both input and output as it should,
> so it should be described as such, I think.

I also noticed this. (It was copied from check-attr.c).
