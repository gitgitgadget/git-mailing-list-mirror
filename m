From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v3 03/23] refs.c: add a new refs.c file to hold all common
 refs code
Date: Tue, 26 Aug 2014 15:00:46 -0700
Message-ID: <CAL=YDWmsqDFUn1z6Z+YwPBGChqz_UctQsa9XRwv-R+Sx2=A6zg@mail.gmail.com>
References: <1408465847-30384-1-git-send-email-sahlberg@google.com>
	<1408465847-30384-4-git-send-email-sahlberg@google.com>
	<xmqqd2bngcpf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 00:00:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMOnK-0005XJ-EP
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 00:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755799AbaHZWAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 18:00:48 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:35965 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755781AbaHZWAq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 18:00:46 -0400
Received: by mail-yk0-f179.google.com with SMTP id 142so12097420ykq.10
        for <git@vger.kernel.org>; Tue, 26 Aug 2014 15:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2tUgeT9Egwa1DHQKK5FF7zgH/aL+aLfWk4Gr9iX2E2w=;
        b=bC1aKkoE/sspg0fp70GApRtsp+fg3PYCGpfuQq6ri01p3HK9oY0azaOnJeCji3m7WK
         4piMvlyitEJ+2o2oi2M3JKTkLSH8PiMkraFlaEj/FbNZISIGNS+ojylFZU0XBwfZTzsL
         4mYyD1FbPIqsQ+VWhj9TSWkrR0/u9hepg33ZUc+/UkLfA6JgZuYu1IOsAlxaZ8OWGNdv
         Lsa0waUQPv/QGVjLBmAIiacw1dhFhrtBlfcadW22VExOtFrhTag2elvxQEf6ZWXOu2ml
         Y8AjhOjSZSNj4GBDKxyXu/VDHfosQO+xralIwDAzrKReviYKHBhq5Pr5hy/4q+YnZ4xa
         ifIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=2tUgeT9Egwa1DHQKK5FF7zgH/aL+aLfWk4Gr9iX2E2w=;
        b=ViWdPdXXuc/DqjmCYVoNoYADRGkKo8Co+YaYRZ8PMh/v0Po1IzEx+N5yyZMCIPTXi7
         zzloOevC7PI7BoBgcK4B38BBD3feSPsYGWi1epI+EKAG0IM9ZTiw9msN0CIa4SDmdwi6
         RVTFEX3tG58c2mNTpaBzS5FMY9pOI+sy5neRf+0zJjvOxru20YXBnL4yHPtvuNCOikex
         nDHEFczR7I49Lbi2mbzq0QYXPRxhbgU/0CobwHi9u1mR8lSiMKTAHD/aGf5XhQJD5B94
         n0UmyX2YTh2+kMwN3bUXVbuWoWnv2wIFrBxTnHo9/vVqSr4CdVXjubbi/MrVsYkx87nJ
         YwKw==
X-Gm-Message-State: ALoCoQk0fyL3+2/h4k0QAV24xFO6CKdI55Gvwy/BosbcgXlPPdBGvUW2US43u8vIaK42hnXKHSEB
X-Received: by 10.220.114.66 with SMTP id d2mr13875885vcq.27.1409090446168;
 Tue, 26 Aug 2014 15:00:46 -0700 (PDT)
Received: by 10.52.69.136 with HTTP; Tue, 26 Aug 2014 15:00:46 -0700 (PDT)
In-Reply-To: <xmqqd2bngcpf.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255949>

On Tue, Aug 26, 2014 at 2:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ronnie Sahlberg <sahlberg@google.com> writes:
>
>> Create a new erfs.c file that will be used to hold all the refs
>> code that is backend agnostic and will be shared across all backends.
>>
>> The reason we renamed everything to refs-be-files.c in the previous patch
>> and now start moving the common code back to the new refs.c file
>> instead of the other way around is the etive volumes of code.
>
> Huh?  Why not create refs-be-files.c and move whatever need to be
> there over there, instead of rename the file and move things that
> shouldn't have been moved back like this?
>

The reason is the relative size of the code. I could do it the other
way but then
the changes that is moving the code would be much bigger.

Moving it like this, by first renaming it to refs-be-files.c and then
moving the backend agnostic parts back
is that the backend agnostic parts are mostly helper functions that
are independent of eachother.
This makes it possible to move just a few functions at a time making
the individual changes smaller and easier to manage when there are
merge conflicts.

A lot of the code that implements the actual files implementation for
refs storage implements the ref-cache/ref-dir/packed-refs/loose refs
etc.
This is all code that is intertwined and is difficult to split up.
Thus almost forcing me to move the whole 3000 lines of implementation
in one single monolithic patch.

I think "first rename, then move the agnostic parts a small section at
a time" was the least bad solution.




> Puzzled.
>
> I do not see 02/23 here, but I am assuming that is is just
>
>     git mv refs.c refs-be-files.c
>
> which may have been a seven-line patch with "format-patch -M" ;-)
>
>>
>> With the ref_cache, packed refs and loose ref handling that are all
>> part of the files based implementation the backend specific part
>> of the old refs.c file is several times larger than the backend agnostic
>> part. Therefore it makes more sense to first rename everything to be
>> part of the files based backend and then move the parts that can be used
>> as common code back to refs.c.
>>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  Makefile | 1 +
>>  refs.c   | 3 +++
>>  2 files changed, 4 insertions(+)
>>  create mode 100644 refs.c
>>
>> diff --git a/Makefile b/Makefile
>> index e010ad1..937d22a 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -857,6 +857,7 @@ LIB_OBJS += quote.o
>>  LIB_OBJS += reachable.o
>>  LIB_OBJS += read-cache.o
>>  LIB_OBJS += reflog-walk.o
>> +LIB_OBJS += refs.o
>>  LIB_OBJS += refs-be-files.o
>>  LIB_OBJS += remote.o
>>  LIB_OBJS += replace_object.o
>> diff --git a/refs.c b/refs.c
>> new file mode 100644
>> index 0000000..77492ff
>> --- /dev/null
>> +++ b/refs.c
>> @@ -0,0 +1,3 @@
>> +/*
>> + * Common refs code for all backends.
>> + */
