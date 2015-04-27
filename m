From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] blame: add blame.showemail config option
Date: Mon, 27 Apr 2015 15:57:14 -0400
Message-ID: <CAPig+cRYUng43rxCJExMEs1ti6wp0oangTzwJbbesmsqM3c+tA@mail.gmail.com>
References: <1429841612-5131-1-git-send-email-qneill@quicinc.com>
	<CAPig+cQrUPHOaKjNhsmLho+bFdAOQxb0NK2YK2QsFmdDBF6h4g@mail.gmail.com>
	<CACfD1vvaAGkx2P3yMfZPOZrRvG3-H96zQVOCevnd-O0rBJ7wjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Quentin Neill <quentin.neill@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 21:57:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ymp9c-0001oh-J0
	for gcvg-git-2@plane.gmane.org; Mon, 27 Apr 2015 21:57:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbbD0T5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2015 15:57:16 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:33266 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbbD0T5P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2015 15:57:15 -0400
Received: by iecrt8 with SMTP id rt8so2788436iec.0
        for <git@vger.kernel.org>; Mon, 27 Apr 2015 12:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Uz1EEsGQTgO0jvPjGYICwEYRBklT8+Vr7Ys7ItnRjCU=;
        b=frtljojHfFgoB+xc1UyPZD8J+TNEmRdZqlwm2wCXjaZ+sMTdqeBb1wgKFL2auoEz/V
         9FyBXjJZVNzUMWG7cLkGi5B14caOQWndZIpRYKH/PqiMPFxzj5w6qhy7P4ae4+zAzfza
         hx7ssUft16eUeHvf4zGfEEQt+cBHYV89TK1bJSREx4gj5YS4I2qBQpTLbyj6gJKqJh27
         8l5Ftdme6cBy9vvHOGVGb09XPyy3mgk3O/ngC7i7wi99Er1wfyArsnj655QfVs5o/czx
         Dm566BnNndeAOBAGVTA3DhUGcVL1uYCcDJOMgDjDew1nodOBf5wSoc0+NQybOC+mkP1C
         AU3Q==
X-Received: by 10.50.61.200 with SMTP id s8mr15637410igr.7.1430164634662; Mon,
 27 Apr 2015 12:57:14 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Mon, 27 Apr 2015 12:57:14 -0700 (PDT)
In-Reply-To: <CACfD1vvaAGkx2P3yMfZPOZrRvG3-H96zQVOCevnd-O0rBJ7wjw@mail.gmail.com>
X-Google-Sender-Auth: pXfTLkBR8RuXtJcUsjnCMype6io
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267879>

On Mon, Apr 27, 2015 at 9:46 AM, Quentin Neill <quentin.neill@gmail.com> wrote:
> On Fri, Apr 24, 2015 at 12:22 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> It's not clear why you relocated documentation of --show-email from
>> git-blame.txt to blame-options.txt, and the commit message does not
>> explain the move. If there's a good reason for the relocation, the
>> justification should be spelled out so that people reviewing the patch
>> or looking through history later on will not have to guess about it.
>
> I moved it to be with the other variables that had configuration
> options, but I will move it back.
>
>> It might also make sense to do the relocation as a separate
>> preparatory patch of a 2-patch series, in which the patch adding
>> blame.showemail is the second of the two.
>
> If you think it should be relocated, I will address in a separate patch.

Junio's response[1] addresses both points nicely. To be clear, I
wasn't suggesting that you should do the relocation, but instead that
the relocation seemed unrelated to the overall intent of the patch and
that its purpose wasn't clear. So, as a general statement, when the
motive for a change is unclear, it deserves explanation in the commit
message; and when a change is not directly related to the patch
itself, it often deserves to be placed in its own patch. In this case,
neither applies since the relocation is unwarranted.

>>> -                       if (opt & OUTPUT_SHOW_EMAIL)
>>> +                       if ((opt & OUTPUT_SHOW_EMAIL) || show_email)
>>
>> The desired behavior is for a configuration setting to provide a
>> fallback, and for a command-line option to override the fallback. So,
>> for instance, if blame.showemail is "true", then --no-show-email
>> should countermand that. Unfortunately, the way this patch is
>> implemented, it's impossible to override the setting from the
>> command-line since show_email==true will always win (when
>> blame.showemail is "true").
>>
>> More below.
>
> I followed the code for blame.showRoot and blame.blankboundary.
>
> I think the desired behavior for the other switches would go in a
> separate patch, the question is should it precede this one adding
> 'blame.showemail'?

As per Junio's response[1], logic for the other configuration options
seems to be fine, so I'm not quite sure what changes you propose.

>> You'll also want to add tests for the new blame.showemail
>> configuration. There's already one test in t8002-blame.sh which checks
>> that --show-email works, but you will want tests to ensure that you
>> get the expected results for all combinations of blame.showemail and
>> --show-email (including when --show-email is not specified).
>
> Agreed, but again I don't see tests for the other switches with options.

Unfortunately, test coverage is sometimes sparse, however, patches
with accompanying tests are looked upon with favor and instill greater
confidence, so they are encouraged. If you need assistance with the
tests, feel free to ask.

It's not your responsibility to fill the gaps of missing tests for
other options which you're not touching, but you're welcome to add
tests for them if you want to.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/267720/focus=267862
