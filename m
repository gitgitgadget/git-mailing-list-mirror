From: Alangi Derick <alangiderick@gmail.com>
Subject: Re: Patch that modifies git usage message
Date: Fri, 1 May 2015 17:38:58 +0100
Message-ID: <CAKB+oNtKi6e7H9U75WEJDKH2KK349JT+vGE8+acHvM6SasCWfQ@mail.gmail.com>
References: <CAKB+oNtYbJXNb2wGzJCdQ5Ru5fq3HzcapSqiTVC_34=xDnTb7Q@mail.gmail.com>
	<CAGZ79kY1ZoYrVwVVqfyB+uMGsJo59qDxbDLgyo5qygSm=CUVhA@mail.gmail.com>
	<xmqqfv7gxnup.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 01 18:39:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoDxw-0006hQ-EK
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 18:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbbEAQi7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 12:38:59 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:34223 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795AbbEAQi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 12:38:59 -0400
Received: by qgfi89 with SMTP id i89so40038485qgf.1
        for <git@vger.kernel.org>; Fri, 01 May 2015 09:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=izEinAE4h8JSe4peKQiVseReVOxC10nP9hWQphTh6G8=;
        b=OfQiE1Bt3rsg+KcgPzp+uZ51v+8OI+ORA92tsojeI6CKIENJjLyAmt7XpGcbjO1xU0
         CltGLT2eZ8o8GAs2tipJVu8UJ+T7LBJwp6h6cVDmh9mYkOyXPSoXnsqVgzKO317OrbDP
         GoEFAf6cmo8b5JZx9YrLRGA4UaLXhxLPDJbvM+FuF/+CBKXGqckV7NFhVkl/19Fq6jCq
         knZZR0/GhR/bXcfKL9mq4uNEDkSoCir3B2eB2f6CS9xMmwzit+YgaWbS8W0fPWb4iSnp
         4IzA5gWua2UWNojBnMOQO9NoMIBclTU+fiRUhK7usyYHFhfzfnegoitcmyGlXoUlqs5X
         nk6g==
X-Received: by 10.140.145.78 with SMTP id 75mr6899126qhr.61.1430498338351;
 Fri, 01 May 2015 09:38:58 -0700 (PDT)
Received: by 10.229.45.71 with HTTP; Fri, 1 May 2015 09:38:58 -0700 (PDT)
In-Reply-To: <xmqqfv7gxnup.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268156>

Ok, thanks for the correction. What about the other strings used for
error display? For example
die("cannot handle %s as a builtin", cmd);
Can't i change the "cannot" to "Cannot"? Or is there a problem with
that one too?
Regards
Alangi Derick Ndimnain


On Fri, May 1, 2015 at 5:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> For the patch itself:
>>
>> $ grep -r usage *.c builtin/*.c |wc -l
>> 551
>> $ grep -r Usage *.c builtin/*.c |wc -l
>> 3
>>
>> The community agreed (maybe subconciously) to prefer lower case
>> for the 'usage' string, so I don't think this is an improvement.
>
> I tend to agree with the conclusion, but you need to be a bit
> careful here.  These catch all the variable names that contain
> "[uU]sage" as substring, but we do not spell in-code variables
> with camelCase, so the former probably is over-counting.  Things
> like "static const char usage[] = ..." are counted; so are calls
> to usage_with_options().
>
> If you look for the beginning of a string constant, you would get
> this:
>
>     $ git grep '"usage' -- \*.c builtin/\*.c
>     12
>     $ git grep '"Usage' -- \*.c builtin/\*.c
>     0
>
> The former undercounts the messages because many usage messages are
> produced by calling usage_with_options() these days.
>
> The latter being zero made me scratch my head and do this:
>
>     $ git grep Usage -- \*.c builtin/\*.c
>     commit.c: * Usage example:
>     test-hashmap.c: * Usage: time echo "perfhas...
>
> I cannot find the third one you found for "Usage" in your example,
> though.
