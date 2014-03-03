From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] rebase: new convenient option to edit a single commit
Date: Mon, 3 Mar 2014 17:15:46 +0700
Message-ID: <CACsJy8DQz-74QJCOq8O7pZG3BwsyzoLhayxmALv6LjaFYWP4YQ@mail.gmail.com>
References: <1393506078-7310-1-git-send-email-pclouds@gmail.com>
 <1393728794-29566-1-git-send-email-pclouds@gmail.com> <1393728794-29566-4-git-send-email-pclouds@gmail.com>
 <CAPig+cQ7pd4mQTTsT2Kq3KL-erUdncBsYmFjt8aFWB5THE6Srw@mail.gmail.com>
 <CAPig+cS8XRf8LzajSJL7LVxVKb_cqLviwSimYyYXRWL46dh9QA@mail.gmail.com> <53145523.7020900@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 03 11:16:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKPv5-00060y-Be
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 11:16:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754557AbaCCKQT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Mar 2014 05:16:19 -0500
Received: from mail-qa0-f51.google.com ([209.85.216.51]:37856 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753968AbaCCKQS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Mar 2014 05:16:18 -0500
Received: by mail-qa0-f51.google.com with SMTP id cm18so1017844qab.38
        for <git@vger.kernel.org>; Mon, 03 Mar 2014 02:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=GA6nDRS+CEzVfBFJjZuAq9OYaQq/HMDwuz4SS0tzOGs=;
        b=Va5IE9LoQ/EF9b2wC6a8vwyN/PtKinsZQwTr1D6LN3dGoNYyeKE0ro031dcV3wowsW
         CuHX3/2P7SRB4FGMP/sr/N2ng0hCKPHQVRZUjsVumllnagbnpGlLazmcz08PNJRQXKJs
         BE1a1PeFyMPnkms9QSXS7SKuT2FSK1fY1x/S0xKC5XJ3l9IZkC4I1FNstGlccdZsmSCB
         4UFJoMXARorScWkwP843ONKcoDnkpCJh6o5UaPaHEKypzFaa3L+RBD5OKD7ZRc4qbvS8
         l6jciBr8bGL8Q1puopcHH42yiEn9N2gkMjB5mKIeiq2b9OGZXEH93gD2ec4IJRrIHu1h
         zm4A==
X-Received: by 10.224.136.67 with SMTP id q3mr18017075qat.8.1393841777491;
 Mon, 03 Mar 2014 02:16:17 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Mon, 3 Mar 2014 02:15:46 -0800 (PST)
In-Reply-To: <53145523.7020900@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243213>

On Mon, Mar 3, 2014 at 5:10 PM, Michael Haggerty <mhagger@alum.mit.edu>=
 wrote:
> On 03/02/2014 10:09 AM, Eric Sunshine wrote:
>> On Sun, Mar 2, 2014 at 4:04 AM, Eric Sunshine <sunshine@sunshineco.c=
om> wrote:
>>> On Sat, Mar 1, 2014 at 9:53 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
>>>> "git rebase -e XYZ" is basically the same as
>>>>
>>>> EDITOR=3D"sed -i '1s/pick XYZ/edit XYZ/' $@" \
>>>> git rebase -i XYZ^
>>>>
>>>> In English, it prepares the todo list for you to edit only commit =
XYZ
>>>> to save your time. The time saving is only significant when you ed=
it a
>>>> lot of commits separately.
>>>
>>> Should this accept multiple -e arguments? Based upon the above
>>> justification, it sounds like it should, and I think that would be =
the
>>> intuitive expectation (at least for me).
>>>
>>> The current implementation, however, is broken with multiple -e arg=
uments. With:
>>>
>>>     git rebase -i -e older -e newer
>>>
>>> 'newer' is ignored entirely. However, with:
>>>
>>>     git rebase -i -e newer -e older
>>>
>>> it errors out when rewriting the todo list:
>>>
>>>     "expected to find 'edit older' line but did not"
>>>
>>> An implementation supporting multiple -e arguments would need to
>>> ensure that the todo list extends to the "oldest" rev specified by =
any
>>> -e argument.
>>
>> Of course, I'm misreading and abusing the intention of -e as if it i=
s
>> "-e <arg>".
>
> I think that your misreading is more consistent than the feature as
> implemented.
>
>     git rebase -e OLDER
>
> does not mean "do 'git rebase -i OLDER' and oh, by the way, also set =
up
> commit OLDER to be edited".  It means "do 'git rebase -i OLDER^' ..."
> (note: "OLDER^" and not "OLDER").  So it is confusing to think as "-e=
"
> as a modifier on an otherwise normal "git rebase -i" invocation.
> Rather, it seems to me that "-e" and "-i" should be mutually exclusiv=
e
> (and consider it an implementation detail that the former is implemen=
ted
> using the latter).
>
> And if that is our point of view, then is perfectly logical to allow =
it
> to be specified multiple times.

Logically, yes. Practically, no. If you have to put multiple -e and
some hashes in one line, wouldn't editing to-do list in your favorite
editor be faster?

> OTOH there is no reason that v1 has to
> allow multiple "-e", as long as it properly rejects that usage.
--=20
Duy
