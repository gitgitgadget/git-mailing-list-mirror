From: Bastien ROUCARIES <roucaries.bastien@gmail.com>
Subject: Re: poll() emulation in git
Date: Wed, 5 Sep 2012 13:55:18 +0200
Message-ID: <CAE2SPAZnq1y7SuCAsS0YJ8wv6=L-QJiay03BerSZvgyqXyPX8w@mail.gmail.com>
References: <00c001cd8b59$028e41c0$07aac540$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Paolo Bonzini <bonzini@gnu.org>, bug-gnulib@gnu.org,
	git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Wed Sep 05 13:55:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9ECk-0005bS-1Q
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 13:55:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042Ab2IELzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 07:55:21 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:56129 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751318Ab2IELzU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Sep 2012 07:55:20 -0400
Received: by lagy9 with SMTP id y9so244770lag.19
        for <git@vger.kernel.org>; Wed, 05 Sep 2012 04:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=q1Ei+LVvzDvbDa8JYomwuKkUjRBdWIq07ZqWWmdxQtU=;
        b=SpHpIgSfcKwjNABPpIEYKmBTl5/UzG2Vf8Ml7tUlNYGatvzu9HJCe7kh+h6SqSXyDN
         8Fu5XVckQ5HJ+C8i/Qz7SmwG0ToMoEcauKEmmxaFp74PejJ6uXL+IVjYLCuTZ9FEOISg
         BCY0VxEA3VQBlpC198X/j6ZEYlKTAHA+gul/qRoc7iLBQIq6mMkgzJRwjKCPJbpOxjUm
         73B2o9Tz3s5gJYHUrvKz5P1qtMHyReqOh7X0+QZB1Z97ZMoGNDFkAcS1YkWNDmvlIiXm
         xiaKW6z3J4ZI9ZK4FF3VRpA5d1LpdaubaoN1iKvcNIIagtnfPj0VRLAeT0lb0wfzax2t
         zTMg==
Received: by 10.112.24.196 with SMTP id w4mr7381341lbf.37.1346846118451; Wed,
 05 Sep 2012 04:55:18 -0700 (PDT)
Received: by 10.112.6.40 with HTTP; Wed, 5 Sep 2012 04:55:18 -0700 (PDT)
In-Reply-To: <00c001cd8b59$028e41c0$07aac540$@schmitz-digital.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204817>

On Wed, Sep 5, 2012 at 1:24 PM, Joachim Schmitz <jojo@schmitz-digital.de> wrote:
>> From: Joachim Schmitz [mailto:jojo@schmitz-digital.de]
>> Sent: Tuesday, September 04, 2012 1:49 PM
>> To: 'Junio C Hamano'
>> Cc: 'git@vger.kernel.org'; 'Erik Faye-Lund'
>> Subject: RE: [PATCH v2] Support non-WIN32 system lacking poll() while keeping the WIN32 part intact
>>
>> > From: Junio C Hamano [mailto:gitster@pobox.com]
>> > Sent: Friday, August 24, 2012 9:47 PM
>> > To: Joachim Schmitz
>> > Cc: git@vger.kernel.org; 'Erik Faye-Lund'
>> > Subject: Re: [PATCH v2] Support non-WIN32 system lacking poll() while keeping the WIN32 part intact
>> >
>> > "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
>> >
>> > > Different, but related question: would poll.[ch] be allowed to #include "git-compat-util.h"?
>> >
>> > Seeing other existing generic wrappers directly under compat/,
>> > e.g. fopen.c, mkdtemp.c, doing so, I would say why not.
>> >
>> > Windows folks (I see Erik is already CC'ed, which is good ;-),
>> > please work with Joachim to make sure such a move won't break your
>> > builds.  I believe that it should just be the matter of updating a
>> > couple of paths in the top-level Makefile.
>>
>> Haven't heard anything from the Windows folks yet.
>>
>> I'd prefer to move compat/win32/poll.[ch] into compat/poll.
>> Then adjust a few paths in Makefile and that would be the 1st patch
>>
>> A 2nd patch would be my already proposed ones that make this usable for others (me in this case ;-)), namely wrapping 2 #inludes.
>>
>> diff --git a/compat/poll/poll.c b/compat/poll/poll.c
>> index 403eaa7..49541f1 100644
>> --- a/compat/poll/poll.c
>> +++ b/compat/poll/poll.c
>> @@ -24,7 +24,9 @@
>>  # pragma GCC diagnostic ignored "-Wtype-limits"
>>  #endif
>>
>> -#include <malloc.h>
>> +#if defined(WIN32)
>> +# include <malloc.h>
>> +#endif
>>
>>  #include <sys/types.h>
>>
>> @@ -48,7 +50,9 @@
>>  #else
>>  # include <sys/time.h>
>>  # include <sys/socket.h>
>> -# include <sys/select.h>
>> +# ifndef NO_SYS_SELECT_H
>> +#  include <sys/select.h>
>> +# endif
>>  # include <unistd.h>
>>  #endif
>>
>> --
>> 1.7.12
>
> However: this poll implementation, while compiling OK, doesn't work properly.
> Because it uses recv(...,MSG_PEEK), it works on sockets only (returns ENOTSOCK on anything else), while the real poll() works on all
> kind if file descriptors, at least that is my understanding.
>
> Here on HP NonStop, when being connected via an non-interactive SSH, we get a set of pipes (stdin, stdout, stderr) instead of a
> socket to talk to, so the poll() just hangs/loops.
>
> As git's implementation is based on ('stolen' from?) gnulib's and still pretty similar, CC to the gnulib list and Paolo
>
> Any idea how this could get solved? I.e. how to implement a poll() that works on non-sockets too?
> There is some code that pertains to a seemingly similar problem in Mac OS X, but my problem is not identical, as that fix doesn't
> help.

Could you give more context ? Are you speaking about win32 or about HP non stop?

If so pipe are broken and unfixable under windows see
http://www.mail-archive.com/bug-gnulib@gnu.org/msg23365.html

> Bye, Jojo
>
>
