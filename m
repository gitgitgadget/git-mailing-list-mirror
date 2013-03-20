From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/6] remote.c: introduce a way to have different remotes
 for fetch/push
Date: Thu, 21 Mar 2013 01:13:58 +0530
Message-ID: <CALkWK0=29fu92A8_XQCmW86U2y-ktNAOy4qMmJAhyYHo8FgX1Q@mail.gmail.com>
References: <1363783501-27981-1-git-send-email-artagnon@gmail.com>
 <1363783501-27981-5-git-send-email-artagnon@gmail.com> <7vfvzpevwf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 20:44:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIOwI-0007P4-Iu
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 20:44:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756606Ab3CTToT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 15:44:19 -0400
Received: from mail-ia0-f182.google.com ([209.85.210.182]:60145 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120Ab3CTToS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 15:44:18 -0400
Received: by mail-ia0-f182.google.com with SMTP id u8so1737431iag.41
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 12:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=EikWFbHI3/9XDvWadKdV7Ulwc86494sJLTRAYmR4Ngo=;
        b=th6+AJH8ENBJIttiEq7POQgJaaWum6nLGj9s+Uoihaw7VgzsIrmAiQPsA9404nVaXo
         S06a7AcbhN3H7lu5btVNxSr4aikZsf4QoNA2IU5/Cgh2jo6oOG5WlmZZqldqceUFv+eO
         yfMjTu+PzKhBa/9C342AGosZK9KtshHkKqv3l/vu7zZnhPkxZ8q8FQc+wsbNW4suOZLO
         9azYO7JAptN3kAw63CbOJxh3obBExn/269lxGukaC0PHQoiH4tdDvoL7TI/AUCLFOLhi
         MOG+Eo2Gb6DVAOAbqExSQS+QQPTo9soqum2ojKFoheO7FGBTejwm+MHSq5uMhJ8XeZRx
         O9zA==
X-Received: by 10.50.50.71 with SMTP id a7mr245646igo.14.1363808658471; Wed,
 20 Mar 2013 12:44:18 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Wed, 20 Mar 2013 12:43:58 -0700 (PDT)
In-Reply-To: <7vfvzpevwf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218664>

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>>       if (name)
>>               name_given = 1;
>>       else {
>> -             name = default_remote_name;
>> -             name_given = explicit_default_remote_name;
>> +             if (pushremote_name) {
>> +                     name = pushremote_name;
>> +                     name_given = 1;
>> +             } else {
>> +                     name = default_remote_name;
>> +                     name_given = explicit_default_remote_name;
>> +             }
>>       }
>
> The code to read branch.$name.remote configuration flips
> explicit_default_remote_name to one when it is used to set the
> default_remote_name, and that controls the value of name_given in
> this codepath.  At this point in the series, you do not have a
> corresponding branch.$name.pushremote, but your [6/6] does not seem
> to do the same.
>
> Why isn't it necessary to add explicit_default_pushremote_name and
> do the same here in patch [6/6]?

Sorry, I'm still trying to understand your comment.  Okay, yes:
branch.$name.remote does flip explicit_default_remote_name, because we
need to know if the default remote name was explicitly given.  Wait,
how is explicit_default_remote_name used to set default_remote_name?
Don't you mean name_given?  It controls name_give, yes.  At this point
I don't have .pushremote, yes: I'm setting up for [5/6] and [6/6].  My
[6/6] doesn't seem to do the "same"?  The same thing as .remote?  Are
you asking why .pushremote doesn't flip explicit_default_remote_name
like .remote does?  Because .pushremote can only ever be specified
explicitly: otherwise, it falls back to the .remote logic.

Okay, next paragraph.  Why isn't it necessary to add
explicit_default_pushremote_name?  Like I said, .pushremote can only
ever be specified explicitly.  There is no implicit fallback (like
"origin"): it just falls back to the .remote codepath, if not
explicitly specified.  In other words, it's just a small override on
the .remote codepath.
