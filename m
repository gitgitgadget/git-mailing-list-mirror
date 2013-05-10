From: Filipe Cabecinhas <filcab@gmail.com>
Subject: Re: write() _will_ fail on Mac OS X/XNU if nbytes > INT_MAX
Date: Fri, 10 May 2013 16:19:48 -0700
Message-ID: <CAEDE853WiuoPenuuBgPehTg89_cLfBckr3CD=fEMuXTXwVv5kQ@mail.gmail.com>
References: <CAEDE852zw9EhmnVaWb_oa_BX_d_--TZoTcs1kgkMPHooM_E6Cw@mail.gmail.com>
	<7v4nffpbct.fsf@alter.siamese.dyndns.org>
	<CAEDE8504Pa_hRcHBLt4S9CL74noqrX3fWGCSf+x45zCr_43+5A@mail.gmail.com>
	<7vbo8j600q.fsf@alter.siamese.dyndns.org>
	<CAEDE8507jPW4sKW7-xX5-+3YpFgfzkXzeskCNRrD7T6ynxgdNA@mail.gmail.com>
	<7va9o2zba9.fsf@alter.siamese.dyndns.org>
	<CAEDE851rRw24Dpxugt3_qJBtROdfcv4c6kskaizXnVy=gYVCBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 11 01:19:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UawbS-0002IL-IY
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 01:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755436Ab3EJXTu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 19:19:50 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:38764 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755295Ab3EJXTu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 19:19:50 -0400
Received: by mail-wg0-f48.google.com with SMTP id f11so4437222wgh.3
        for <git@vger.kernel.org>; Fri, 10 May 2013 16:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=UUrLoFhWXaRX9l4+eymI1ObBkfNjqFsjsnxlXxRGdfI=;
        b=TGuya4EnqDYxFHt3NQVTufeerKLKuRsfmukoDCKpmmxsAt6/jb/NIvGpZej9EYnFUo
         uwx0rMCn7RO6if/0K2wIWFUdKlVimTq6O8h3pht8K3Sp+PSBNFxHfy8gAszfcmkITLAt
         1XKJ/PscjfbhB5zhbuMaMgjQ9q0nORGoqP92dGZ1TptFjXyjH8mJL1vciovlZUAyI2nN
         DLNami6QTzr4DYgP05qyaDQtQFJTZUte+ldZUARelO0u8dy40j0CzcB0rVsrmNfmR5M9
         4he79DGYHeDY+nsy4iub/5IaYYwkMnhSGP+WYlwSypQqxgTzurzAGXE+OtaRH+GRXwvZ
         vvOw==
X-Received: by 10.180.88.162 with SMTP id bh2mr6779694wib.3.1368227988700;
 Fri, 10 May 2013 16:19:48 -0700 (PDT)
Received: by 10.194.38.233 with HTTP; Fri, 10 May 2013 16:19:48 -0700 (PDT)
In-Reply-To: <CAEDE851rRw24Dpxugt3_qJBtROdfcv4c6kskaizXnVy=gYVCBg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223921>

Hi Junio,

It compiles cleanly and runs. I'm running the test suite anyway, but
don't expect any change from your latest patch.

Thank you,

  Filipe
  F


On Fri, May 10, 2013 at 4:13 PM, Filipe Cabecinhas <filcab@gmail.com> wrote:
> Hi Junio,
>
> Thanks for helping. Your text is correct and only diffs from my patch
> in the #define write(...) part, where I suppose you stripped the
> spaced in the arglist.
>
> Thank you,
>
>   Filipe
>
>   F
>
>
> On Fri, May 10, 2013 at 4:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Filipe Cabecinhas <filcab@gmail.com> writes:
>>
>>> Due to a bug in the Darwin kernel, write() calls have a maximum size of
>>> INT_MAX bytes.
>>>
>>> This patch introduces a new compat function: clipped_write
>>> This function behaves the same as write() but will write, at most, INT_MAX
>>> characters.
>>> It may be necessary to include this function on Windows, too.
>>>
>>> Signed-off-by: Filipe Cabecinhas <filcab+git@gmail.com>
>>> ---
>>
>> Somehow your MUA seems to have lost _all_ tabs, not just in the new
>> lines in your patch but also in the existing context lines.
>>
>>> diff --git a/Makefile b/Makefile
>>> index 0f931a2..ccb8f3f 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -1466,6 +1466,11 @@ ifndef NO_MSGFMT_EXTENDED_OPTIONS
>>>   MSGFMT += --check --statistics
>>>  endif
>>>
>>> +ifdef NEEDS_CLIPPED_WRITE
>>> + BASIC_CFLAGS += -DNEEDS_CLIPPED_WRITE
>>> + COMPAT_OBJS += compat/clipped-write.o
>>> +endif
>>> +
>>> ...
>>
>> Here is what I resurrected and queued. I _think_ I did not make any
>> silly mistake while transcribing from your whitespace-mangled patch,
>> but please double check; I do not have any Darwin, so this hasn't
>> even been compile tested.
>>
>> Also I have a small suggestion I'd like you to try on top of it,
>> which I'll be sending in a separate message.
>>
>> Thanks.
>>
>> -- >8 --
>> From: Filipe Cabecinhas <filcab@gmail.com>
>> Date: Fri, 10 May 2013 15:24:57 -0700
>> Subject: [PATCH] compate/clipped-write.c: large write(2) fails on Mac OS X/XNU
>>
>> Due to a bug in the Darwin kernel, write(2) calls have a maximum size
>> of INT_MAX bytes.
>>
>> Introduce a new compat function, clipped_write(), that only writes
>> at most INT_MAX bytes and returns the number of bytes written, as
>> a substitute for write(2), and allow platforms that need this to
>> enable it from the build mechanism with NEEDS_CLIPPED_WRITE.
>>
>> Set it for Mac OS X by default.  It may be necessary to include this
>> function on Windows, too.
>>
>> Signed-off-by: Filipe Cabecinhas <filcab+git@gmail.com>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  Makefile               |  5 +++++
>>  compat/clipped-write.c | 13 +++++++++++++
>>  config.mak.uname       |  1 +
>>  git-compat-util.h      |  5 +++++
>>  4 files changed, 24 insertions(+)
>>  create mode 100644 compat/clipped-write.c
>>
>> diff --git a/Makefile b/Makefile
>> index 26d3332..7076b15 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1463,6 +1463,11 @@ ifndef NO_MSGFMT_EXTENDED_OPTIONS
>>         MSGFMT += --check --statistics
>>  endif
>>
>> +ifdef NEEDS_CLIPPED_WRITE
>> +       BASIC_CFLAGS += -DNEEDS_CLIPPED_WRITE
>> +       COMPAT_OBJS += compat/clipped-write.o
>> +endif
>> +
>>  ifneq (,$(XDL_FAST_HASH))
>>         BASIC_CFLAGS += -DXDL_FAST_HASH
>>  endif
>> diff --git a/compat/clipped-write.c b/compat/clipped-write.c
>> new file mode 100644
>> index 0000000..9183698
>> --- /dev/null
>> +++ b/compat/clipped-write.c
>> @@ -0,0 +1,13 @@
>> +#include <limits.h>
>> +#include <unistd.h>
>> +
>> +/*
>> + * Version of write that will write at most INT_MAX bytes.
>> + * Workaround a xnu bug on Mac OS X
>> + */
>> +ssize_t clipped_write(int fildes, const void *buf, size_t nbyte)
>> +{
>> +       if (nbyte > INT_MAX)
>> +               nbyte = INT_MAX;
>> +       return write(fildes, buf, nbyte);
>> +}
>> diff --git a/config.mak.uname b/config.mak.uname
>> index e09af8f..e689a9a 100644
>> --- a/config.mak.uname
>> +++ b/config.mak.uname
>> @@ -95,6 +95,7 @@ ifeq ($(uname_S),Darwin)
>>         NO_MEMMEM = YesPlease
>>         USE_ST_TIMESPEC = YesPlease
>>         HAVE_DEV_TTY = YesPlease
>> +       NEEDS_CLIPPED_WRITE = YesPlease
>>         COMPAT_OBJS += compat/precompose_utf8.o
>>         BASIC_CFLAGS += -DPRECOMPOSE_UNICODE
>>  endif
>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index b636e0d..3144b8d 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -181,6 +181,11 @@ typedef unsigned long uintptr_t;
>>  #define probe_utf8_pathname_composition(a,b)
>>  #endif
>>
>> +#ifdef NEEDS_CLIPPED_WRITE
>> +ssize_t clipped_write(int fildes, const void *buf, size_t nbyte);
>> +#define write(x,y,z) clipped_write((x),(y),(z))
>> +#endif
>> +
>>  #ifdef MKDIR_WO_TRAILING_SLASH
>>  #define mkdir(a,b) compat_mkdir_wo_trailing_slash((a),(b))
>>  extern int compat_mkdir_wo_trailing_slash(const char*, mode_t);
>> --
>> 1.8.3-rc1-268-g30389da
>>
