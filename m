From: Zachary Turner <zturner@chromium.org>
Subject: Re: Make the git codebase thread-safe
Date: Fri, 14 Feb 2014 11:16:50 -0800
Message-ID: <CAAErz9j=_FpWLSyUk43pp8A6e7Ej0crT8ghW5-yxBEbGkd6O+A@mail.gmail.com>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
	<CABPQNSZ_LLg5i+mpwUj7pzXVQMY1tcXz2gJ+PWG-mP1iyjxoaw@mail.gmail.com>
	<CAHOQ7J8QxfvtrS2KdgzUPvkDzJ1Od0CMvdWxrF_bNacVRYOa5Q@mail.gmail.com>
	<CABPQNSZtQd51gQY7oK8B-BbpNEhxR-onQtiXSfW9sv1t2YW_nw@mail.gmail.com>
	<CAHOQ7J_Jrj1NJ_tZaCioskQU_xGR2FQPt8=JrWpR6rfs=c847w@mail.gmail.com>
	<CABPQNSYVGc9m0_xfAWe=3b7CXyGZ-2FfTMRbTJ=UECeZUtdgmg@mail.gmail.com>
	<52FBC9E5.6010609@gmail.com>
	<loom.20140213T193220-631@post.gmane.org>
	<52FD4C84.7060209@gmail.com>
	<CAHOQ7J8syoQLGwwkwPEX3wZir8sWDQ+k8sgHAKn=n_-Q_S8ipA@mail.gmail.com>
	<CAAErz9hzeiJ9f9tJ+Z-kOHvrPqgcZrpvrpBpa_tMjnKm4YWSXA@mail.gmail.com>
	<52FE68C9.3060403@gmail.com>
	<CAAErz9g7ND1htfk=yxRJJLbSEgBi4EV_AHC9uDRptugGWFWcXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Zager <szager@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 14 20:17:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEOG9-0002aB-5z
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 20:17:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819AbaBNTRG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 14:17:06 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:52681 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252AbaBNTQv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 14:16:51 -0500
Received: by mail-ie0-f171.google.com with SMTP id as1so7631632iec.2
        for <git@vger.kernel.org>; Fri, 14 Feb 2014 11:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=qp0DzQjstnbCQXMZsgNTn0/SEyjqSsXoyuxreU8885A=;
        b=pc4kM9ozbDvJ4yOmsgEq2Qr2ZNH0DgCkTmsDSpavAPmWqvhc9+EFLPWey7SnHRKRuC
         1+fZgshhW6D/fiYs/PvSZLt6/wLS9fJwBU1l5+mZw8rO91oYHEQHSXBnLZnDY0LCG1O8
         ctV8xxeDDITSGMeuDsgsiwWffuAwFFmzplEqdOWW11xPZgFRg1Gi5V2M4NHJgzZiQJje
         svfqEUlonv9iozLISdiaJ4NhShYBnN8/xbs4Y53nSgAAqhlWXtSv3vHfsVwZl4aFrlTG
         WU+6Z1zGElC6gNIwlOLZPokipjpP4JJEKBgTy6Dy1PsAPuTMfJ/xWgMpli/dR1E07t1B
         Yhqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=qp0DzQjstnbCQXMZsgNTn0/SEyjqSsXoyuxreU8885A=;
        b=YDMBhLmraSufVu8h8luJptLeIag7ALirTlpHjkJ5dm1pDlbU4xcMnX6HZeej7v7dq9
         /DrxHDsXF6dfrsSsRvbxfHSDmx3HaSUzC7+qlk3CTWmwwYrMI9YoNo0Mta9zBzh5BGcv
         8+6urEoN6fsE8TJEtRVgnWmtKC8B9mM6fCKW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=qp0DzQjstnbCQXMZsgNTn0/SEyjqSsXoyuxreU8885A=;
        b=U6h9nlYjFQ4yKnA5HiqH3WbRXn3PzP3WznntBnVw3NsR75j0CmKCRu2yy/7JG2BsFZ
         /8O9kXZD+AekOULEMVYw6uFS07EmDtnCNP+zBxfQ7zZRWX2zziYDh7nuV1iOVUc+Wl6K
         OeUoD+WY7Kryu05mbSQyehJkVU7nuJ6vYf61v2Gt8RIGtlgeMa1sgeDVp3F6ISzvwZGw
         8/9hRTKYtZPP52DOHyTMjncrl5qAVQaP8Wx1ZIUfTifX7SdodzE4b+Rc6SdMRPKAHL6m
         Yfwtn+TZ3427L5TIX9JByBFZCOeuovElETiR5bz0VKTEKiDzRXr3ki2EAoFb0FIrFsu9
         aZ0w==
X-Gm-Message-State: ALoCoQnQfXA9btYNGcTjlK4G9XbouqC8wV5K4cy5A1GbKJc/2bsBY/k9Hc2CPUN4DH5ojpC7C8GSuaX4KL7UkHIpEz/SMYrlGEUXlI+un0Srpj4CbyKPk3tri/zDsyS6L/uW9xM31RAmcaTAYgu8fC9vGK9eTzGDoYGBEDFYqDN8wDogT9cFulghfryS+JMsFjVTAmYrN9fM
X-Received: by 10.50.254.131 with SMTP id ai3mr4281916igd.43.1392405410829;
 Fri, 14 Feb 2014 11:16:50 -0800 (PST)
Received: by 10.64.23.9 with HTTP; Fri, 14 Feb 2014 11:16:50 -0800 (PST)
In-Reply-To: <CAAErz9g7ND1htfk=yxRJJLbSEgBi4EV_AHC9uDRptugGWFWcXw@mail.gmail.com>
X-Google-Sender-Auth: 8CKeQeQZxTPFuqS1Fe0VKbydQ40
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242123>

(Gah, sorry if you're receiving multiple emails to your personal
addresses, I need to get used to manually setting Plain-text mode
every time I send a message).

For the mixed read, we wouldn't be looking for another caller of
pread() (since it doesn't care what the file pointer is), but instead
a caller of read() or lseek() (since those do depend on the current
file pointer).  In index-pack.c, I see two possible culprits:

1) A call to xread() from inside fill()
2) A call to lseek in parse_pack_objects()

Do you think these could be related?  If so, maybe that opens up some
other solutions?

BTW, the version you posted isn't thread safe.  Suppose thread A and
thread B execute this function at the same time.  A executes through
the ReadFile(), but does not yet reset the second lseek64.  B then
executes the first lseek64(), storing off the modified file pointer.
Then A finishes, then B finishes.  At the end, the file pointer is
still modified.

On Fri, Feb 14, 2014 at 11:15 AM, Zachary Turner <zturner@chromium.org> wrote:
> For the mixed read, we wouldn't be looking for another caller of pread()
> (since it doesn't care what the file pointer is), but instead a caller of
> read() or lseek().  In index-pack.c, I see two possible culprits:
>
> 1) A call to xread() from inside fill()
> 2) A call to lseek in parse_pack_objects()
>
> Do you think these could be related?  If so, maybe that opens up some other
> solutions?
>
> BTW, the version you posted isn't thread safe.  Suppose thread A and thread
> B execute this function at the same time.  A executes through the
> ReadFile(), but does not yet reset the second lseek64.  B then executes the
> first lseek64(), storing off the modified file pointer.  Then A finishes,
> then B finishes.  At the end, the file pointer is still modified.
>
>
>
> On Fri, Feb 14, 2014 at 11:04 AM, Karsten Blees <karsten.blees@gmail.com>
> wrote:
>>
>> Am 14.02.2014 00:09, schrieb Zachary Turner:
>> > To elaborate a little bit more, you can verify with a sample program
>> > that ReadFile with OVERLAPPED does in fact modify the HANDLE's file
>> > position.  The documentation doesn't actually state one way or
>> > another.   My original attempt at a patch didn't have the ReOpenFile,
>> > and we experienced regular read corruption.  We scratched our heads
>> > over it for a bit, and then hypothesized that someone must be mixing
>> > read styles, which led to this ReOpenFile workaround, which
>> > incidentally also solved the corruption problems.  We wrote a similar
>> > sample program to verify that when using ReOpenHandle, and changing
>> > the file pointer of the duplicated handle, that the file pointer of
>> > the original handle is not modified.
>> >
>> > We did not actually try to identify the source of the mixed read
>> > styles, but it seems like the only possible explanation.
>> >
>> > On Thu, Feb 13, 2014 at 2:53 PM, Stefan Zager <szager@google.com> wrote:
>> >> On Thu, Feb 13, 2014 at 2:51 PM, Karsten Blees
>> >> <karsten.blees@gmail.com> wrote:
>> >>> Am 13.02.2014 19:38, schrieb Zachary Turner:
>> >>>
>> >>>> The only reason ReOpenFile is necessary at
>> >>>> all is because some code somewhere is mixing read-styles against the
>> >>>> same
>> >>>> fd.
>> >>>>
>> >>>
>> >>> I don't understand...ReadFile with OVERLAPPED parameter doesn't modify
>> >>> the HANDLE's file position, so you should be able to mix read()/pread()
>> >>> however you like (as long as read() is only called from one thread).
>> >>
>> >> That is, apparently, a bald-faced lie in the ReadFile API doc.  First
>> >> implementation didn't use ReOpenFile, and it crashed all over the
>> >> place.  ReOpenFile fixed it.
>> >>
>> >> Stefan
>>
>> Damn...you're right, multi-threaded git-index-pack works fine, but some
>> tests fail badly. Mixed reads would have to be from git_mmap, which is the
>> only other caller of pread().
>>
>> A simple alternative to ReOpenHandle is to reset the file pointer to its
>> original position, as in compat/pread.c::git_pread. Thus single-theaded code
>> can mix read()/pread() at will, but multi-threaded code has to use pread()
>> exclusively (which is usually the case anyway). A main thread using read()
>> and background threads using pread() (which is technically allowed by POSIX)
>> will fail with this solution.
>>
>> This version passes the test suite on msysgit:
>>
>> ----8<----
>> ssize_t mingw_pread(int fd, void *buf, size_t count, off64_t offset)
>> {
>>         DWORD bytes_read;
>>         OVERLAPPED overlapped;
>>         off64_t current;
>>         memset(&overlapped, 0, sizeof(overlapped));
>>         overlapped.Offset = (DWORD) offset;
>>         overlapped.OffsetHigh = (DWORD) (offset >> 32);
>>
>>         current = lseek64(fd, 0, SEEK_CUR);
>>
>>         if (!ReadFile((HANDLE)_get_osfhandle(fd), buf, count, &bytes_read,
>> &overlapped)) {
>>                 errno = err_win_to_posix(GetLastError());
>>                 return -1;
>>         }
>>
>>         lseek64(fd, current, SEEK_SET);
>>
>>         return (ssize_t) bytes_read;
>> }
>>
>
