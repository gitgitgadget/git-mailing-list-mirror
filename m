From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFD PATCH 0/3] Free all the memory!
Date: Tue, 17 May 2016 10:58:30 -0700
Message-ID: <CAGZ79kaJoAxqtsTuErQSgJiVeD_vdZ1MQXKr-LTtyro-FbscTQ@mail.gmail.com>
References: <20160517032247.25092-1-sbeller@google.com> <CAPig+cT9UKEcNXvsQsFDrQycKwMJR5bCter76UL-zpkncniPBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue May 17 19:58:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2jGQ-0002yL-0e
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 19:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbcEQR6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 13:58:33 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:35642 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571AbcEQR6c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 13:58:32 -0400
Received: by mail-io0-f176.google.com with SMTP id d62so33700904iof.2
        for <git@vger.kernel.org>; Tue, 17 May 2016 10:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ERwl5PbHQ7uUcUVe1wQ1DtpcxnZcFq8Px2ox5XPOUwE=;
        b=o15erxyiFuHOwWNdghvUWhPYTGnY4otHZfRteBT71EkR1DsbcO0YgHnErQwKihSlmz
         HzE2pERBBBNSUMVdD8pDSyKOIgCg32wnIDMkraGCsO3bJ5Ff6e3G2yfK9/2WNquuIGYP
         91iPgbz42rhZ9b46WV7Y5lA0AbkAXYjjMPf8zN2N6q6YBTo+W/Mdx39BocNiT69REnn7
         8m/whnUfQ7ETIKHEukxKUy9KvK3f32JIxDKFmVtuHfLEOqq9qJcmpg+HEsHfY2qnh1vt
         KuMpgN5pwLaCfJ/E+UcYfHnirfBaAzJ7dO/krwqOWi34gXLWnvjQWA/kMXClp2MjPYps
         luiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ERwl5PbHQ7uUcUVe1wQ1DtpcxnZcFq8Px2ox5XPOUwE=;
        b=WC8wqp7wya0icoSbopZoK2mXrc1DPcXI3ITV/gzh8f/v9ib+o1noUEWQg9cC0Dg+od
         evWDmzQG/qkZAJxSPDyukGZw/BGwkk9fN6O+h0Sjlbmp1+LIQuv5MigbXNVxB7OxTCuy
         FlgPXN3swCf5IGgJjOOUsmoBBrpcofBCNpo7TidFjvf+CiaPsEodehl+b32LAOwrZMdi
         0GKJq9J6Rl7mrlN693/dXsBM3WburzHvJht0zeuaWhbDuNp/HSExtqX1m7qzXfwWo3t7
         W1mostx77SkNkdEXB0ILWdc1/mspJCmujYcrBNVy9XtyhpkvUB3mOm9DAQIYOX/t/7uN
         4X3g==
X-Gm-Message-State: AOPr4FWFc7RJNsJgc109DXpMGilLADJRcjXQkyN5F+xIM6EOgTC9c5a8HLkLZNqEyG1ER6On/GwYZK0V8B+O8pV7
X-Received: by 10.36.62.133 with SMTP id s127mr2107328its.98.1463507911128;
 Tue, 17 May 2016 10:58:31 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Tue, 17 May 2016 10:58:30 -0700 (PDT)
In-Reply-To: <CAPig+cT9UKEcNXvsQsFDrQycKwMJR5bCter76UL-zpkncniPBw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294886>

On Mon, May 16, 2016 at 8:41 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, May 16, 2016 at 11:22 PM, Stefan Beller <sbeller@google.com> wrote:
>> When using automated tools to find memory leaks, it is hard to distinguish
>> between actual leaks and intentional non-cleanups at the end of the program,
>> such that the actual leaks hide in the noise.
>>
>> The end goal of this (unfinished) series is to close all intentional memory
>> leaks when enabling the -DFREE_ALL_MEMORY switch. This is just
>> demonstrating how the beginning of such a series could look like.
>
> Considering the signal-to-noise ratio mentioned above, the goal seems
> reasonable, but why pollute the code with #ifdef's all over the place
> by making the cleanup conditional? If you're going though the effort
> of plugging all these leaks, it probably makes sense to do them
> unconditionally.

I tried that once upon a time. The resentment from the list was:

    We're exiting soon anyway (e.g. some cmd_foo function). Letting the
    operating system clean up after us is faster than when we do it, so don't
    do it.

However it would be nice to have a distinction between "I know we're leaking
this memory, but we don't care for $REASONS" and a genuine leak that
should concern the developers.

So as a developer I wish we would close all leaks that are non-concerning.
As a user I don't care about those leaks.

David writes:
> AFAIK, nothing in the "definitely lost" category is fixed by your rev-parse patch.
>
> I don't think we care that much about "still reachable" memory -- I only care about lost memory.  I could imagine, I guess, something that happens to save a pointer to a bunch of memory that should be freed, but I don't think that's the common case.

As said above I'd want them to be fixed for me as a developer for
better automated tooling and detection. (The alternative to fix the automated
tooling is a no-no for me ;)

Matthieu Moy writes:
> One potential issue with this is: if all developers and the testsuite
> use this -DFREE_ALL_MEMORY, the non-free-all-memory setup will not be
> well tested, and still this is the one used by real people. For example,
> if there's a really annoying memory leak hidden by FREE_ALL_MEMORY, we
> may not notice it.
>
> Perhaps it'd be better to activate FREE_ALL_MEMORY only when tools like
> valgrind or so is used.

That's a really good point. I'l keep it in mind for a reroll.


Eric Wong writes:
> I haven't checked for git, but I suspect we get speedups by not
> calling free().  I've never needed to profile git, but free() at
> exit has been a measurable bottleneck in other projects I've
> worked on.  Often, free() was more expensive than *alloc().

Thanks for reiterating that original response I got back then :)

>
> In any case, I like constant conditionals in C or inline wrappers
> macros over CPP #ifdefs littered inside functions:
>
> /* in git-compat-util.h */
> #ifdef FREE_ALL_MEMORY
> static inline void optional_free(void *ptr) {}
> #else
> #  define FREE_ALL_MEMORY (0)
> #  define optional_free(ptr) free(ptr)
> #endif
>
> /* inside any function: */
>        if (FREE_ALL_MEMORY)
>                big_function_which_calls_multiple_frees();
>

Shouldn't that be "#ifndef" instead? I really like the
"optional_free", I'll keep it in mind!

>
> Also Valgrind has suppression files, so code modifications may
> not be necessary at all.

But there are more tools than just valgrind. (Although valgrind is really good!)
