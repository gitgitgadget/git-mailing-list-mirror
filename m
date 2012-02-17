From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: git status: small difference between stating whole repository and
 small subdirectory
Date: Fri, 17 Feb 2012 17:55:03 +0100
Message-ID: <CAA01CsqfM4=cHBuJ5faPuWHPcHKAeO7fRQdSQzaFLZMdQaVGrA@mail.gmail.com>
References: <CAA01Csr8FbvQ8uFvxX8_6i-hysin6JuaifVVC-yoLyoT0N5F4Q@mail.gmail.com>
	<CAA01Csp6_9fP2rg4104UWUXwOxZmUVdQNDAaBe6fRou6agBz6g@mail.gmail.com>
	<8762f9k5sg.fsf@thomas.inf.ethz.ch>
	<CAA01Cso_8=159UDMFUHiYz1X=gYtpbqRO4h3TMw7N=4YMV8YNg@mail.gmail.com>
	<20120215190318.GA5992@sigill.intra.peff.net>
	<CAA01Cso5y23UMguEe0vwOc6kR3-DjuC8-LTMDsMeeOKU4rVGvg@mail.gmail.com>
	<87d39eswkx.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Feb 17 17:55:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyR5l-0003Ty-Tv
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 17:55:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753085Ab2BQQzK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Feb 2012 11:55:10 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:49097 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312Ab2BQQzF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Feb 2012 11:55:05 -0500
Received: by yhoo21 with SMTP id o21so1930671yho.19
        for <git@vger.kernel.org>; Fri, 17 Feb 2012 08:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=QGTd/DyqZwzeQbE1xIpL7V0u0DQ2AGbmVzDEc6d3DXo=;
        b=I8jRj+/XkK5FblMKZV7cWbeQ70AOZkkIaY9/O+vhXOqEcB6aKA5AV0uKMXkLQODCVs
         B5NfYS9OJT6xzbnMXYqO6Kg3U9g4nUylbcqDpVjKtWABltMaROVgKBEURdkiz5MY171y
         pzRd7o9MMQyIZI5JSzFV/AdXs9I6gjt+D0+ng=
Received: by 10.50.194.170 with SMTP id hx10mr24510886igc.6.1329497704038;
 Fri, 17 Feb 2012 08:55:04 -0800 (PST)
Received: by 10.50.46.33 with HTTP; Fri, 17 Feb 2012 08:55:03 -0800 (PST)
In-Reply-To: <87d39eswkx.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190962>

On Thu, Feb 16, 2012 at 3:05 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
> Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:
>
>> On Wed, Feb 15, 2012 at 8:03 PM, Jeff King <peff@peff.net> wrote:
>>> On Wed, Feb 15, 2012 at 09:57:29AM +0100, Piotr Krukowiecki wrote:
>>>>
>>> I notice that you're still I/O bound even after the repack:
>>>
>>>> $ time git status =A0-- .
>>>> real =A0 =A00m2.503s
>>>> user =A0 =A00m0.160s
>>>> sys =A0 =A0 0m0.096s
>>>>
>>>> $ time git status
>>>> real =A0 =A00m9.663s
>>>> user =A0 =A00m0.232s
>>>> sys =A0 =A0 0m0.556s
>>>
>>> Did you drop caches here, too?
>>
>> Yes I did - with cache the status takes something like 0.1-0.3s on w=
hole repo.
>
> So umm, I'm not sure that leaves anything to be improved.

But even with caches time on small directory is only half of time on wh=
ole repo:
0.15s vs 0.07s


> I looked at some strace dumps, and limiting the status to a subdirect=
ory
> (in my case, '-- t' in git.git) does omit the lstat()s on uninteresti=
ng
> parts of the index-listed files, as well as the getdents() (i.e.,
> readdir()) for parts of the tree that are not interesting.

Same in my case.

I've run strace with -c which shows system calls times. As I
understand the results the time used by lstat() is very small. With
dropped caches:

% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 90.70    0.065108           3     25361        12 lstat
  6.78    0.004869           1      6534           getdents
  1.94    0.001392           0      6964      3238 open
  0.27    0.000194           0      3726           close


> BTW, some other parts of git-status's display may be responsible for =
the
> amount of data it pulls from disk. =A0In particular, the "Your branch=
 is
> ahead" display requires computing the merge-base between HEAD and
> @{upstream}. =A0If your @{upstream} is way ahead/behind, or points at=
 a
> disjoint chunk of history, this may mean essentially pulling all of t=
he
> involved history from disk. =A0If my memory of pack organization serv=
es
> right, the commit objects involved would essentially be spread across
> the whole pack (corresponding to "time") and thus this operation woul=
d
> more or less load the entire pack from disk.

I don't think this is the case - I'm using git-svn and thus have no
upstream in git meaning.


--=20
Piotr Krukowiecki
