From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 0/5] Use watchman to reduce index refresh time
Date: Mon, 9 Nov 2015 21:06:53 +0100
Message-ID: <CAP8UFD0rAL62eFdtLo__ta=_Yhq4cdRcqmfYTqw3imNa5Lde-A@mail.gmail.com>
References: <1446386146-10438-1-git-send-email-pclouds@gmail.com>
	<CAHVLzcn3j8eLi9VrNoZjyOZ2UzE7=NYF1bqB9UyKmghUoUw1Zg@mail.gmail.com>
	<CACsJy8DzSEVJYc85-3vSAZ8wB1pR9TLz0RrKyKFfHth9Tq+xyg@mail.gmail.com>
	<CACsJy8Dz17gRSHch9e=iB2Kq2t4FbssatW84DF8pHTuFMgEgjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Git <git@vger.kernel.org>,
	David Turner <dturner@twopensource.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 21:07:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvsiR-0006Ap-Vs
	for gcvg-git-2@plane.gmane.org; Mon, 09 Nov 2015 21:07:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbbKIUGz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Nov 2015 15:06:55 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:34257 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbbKIUGy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Nov 2015 15:06:54 -0500
Received: by igvg19 with SMTP id g19so34506844igv.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2015 12:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=wR+qGudvkVUmjSAePle6ixV+VLyUCMqln2URdyMCUVM=;
        b=ZunYy97Qb3tD9FjxUlalCHuuFNP1oqyKxYNyyqXh9cYRAFWdtOJqQqKTVkjEv30elZ
         iHSnNwCa9i0ykbSuY/o3YtpohGl0svR3dDFyQZEy7dzAVCqoPxO4W9EJ49HPfYLw5x8V
         yrTNSVDylUDimhzQMXIcGcfimGwBJD0FsYASvIlhKkvsBBK6zp3oDau6oJkiD6wuibJ8
         ysgge+1QaKr9dmCNA/fU828z3d+b5IxiRXdeyQDczbJxIfXsxOfsRVOMEBTCM77yCEjj
         idtNX5INMiVXnirxrI/YbhALk0CWP8qr7BNikJu5YDecAuug85uXXWV06vuonp59XGMV
         MOlg==
X-Received: by 10.50.49.46 with SMTP id r14mr240190ign.71.1447099614001; Mon,
 09 Nov 2015 12:06:54 -0800 (PST)
Received: by 10.36.146.68 with HTTP; Mon, 9 Nov 2015 12:06:53 -0800 (PST)
In-Reply-To: <CACsJy8Dz17gRSHch9e=iB2Kq2t4FbssatW84DF8pHTuFMgEgjQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281081>

On Tue, Nov 3, 2015 at 10:21 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, Nov 2, 2015 at 8:23 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Mon, Nov 2, 2015 at 3:54 PM, Paolo Ciarrocchi
>> <paolo.ciarrocchi@gmail.com> wrote:
>>> On Sun, Nov 1, 2015 at 2:55 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
>>>
>>> Hi Duy,
>>>
>>>> This series builds on top of the index-helper series I just sent a=
nd
>>>> uses watchman to keep track of file changes in order to avoid lsta=
t()
>>>> at refresh time. The series can also be found at [1]
>>>>
>>>> When I started this work, watchman did not support Windows yet. It
>>>> does now, even if still experimental [2]. So Windows people, pleas=
e
>>>> try it out if you have time.
>>>>
>>>> To put all pieces so far together, we have split-index to reduce i=
ndex
>>>> write time, untracked cache to reduce I/O as well as computation f=
or
>>>> .gitignore, index-helper for index read time and this series for
>>>> lstat() at refresh time. The remaining piece is killing lstat() fr=
om
>>>> untracked cache, but right now it's just some idea and incomplete
>>>> code.
>>>
>>> Did you manage to measure the speedup introduced by this series?
>>
>> It was from last year. I may have measured it but because I didn't
>> save it in the commit message, it was lost anyway. Installing watchm=
an
>> and measuring with webkit.git soon..
>
> Test repo: webkit.git with 104665 tracked files, 5615 untracked,
> 3517 dirs. Best numbers out of a few tries. This is best case
> scenario. Normal usage could have worse numbers.

Thank you for the tests!

I tried to replicate your results on webkit.git with 184672 tracked
files, 5631 untracked, 9330 dirs. Also best numbers out of a few
tries.

> There is something strange about the "-uno" measurements. I don't
> think watchman+untracked cache can beat -uno..  Maybe I did something
> wrong.
>
> 0m0.383s   index v2
> 0m0.351s   index v4
> 0m0.352s   v2 split-index
> 0m0.309s   v2 split index-helper
> 0m0.159s   v2 split helper untracked-cache
> 0m0.123s   v2 split helper "status -uno"
> 0m0.098s   v2 split helper untracked watchman
> 0m0.071s   v2 split helper watchman "status -uno"

I got the following results from "time git status ...":

0m0.774s
0m0.799s split
0m0.766s split helper
0m0.335s split helper untracked
0m0.232s split helper untracked -uno
0m0.284s split helper untracked watchman
0m0.188s split helper untracked watchman -uno

Using David's series I get worse results than all of the above but I
guess it's because his series is based on an ancient git version
(v2.0.0-rc0).

> Note, the watchman series needs
> s/free_watchman_shm/release_watchman_shm/ (I didn't do a good job
> of testing after rebase). And there's a small bug in index-helper
> --detach code writing incorrect PID..

I did the s/free_watchman_shm/release_watchman_shm/ change, but I
didn't notice the index-helper bug.

Thanks,
Christian.
