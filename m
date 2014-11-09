From: Michael Blume <blume.mike@gmail.com>
Subject: Re: [PATCH] t1410: fix breakage on case-insensitive filesystems
Date: Sun, 9 Nov 2014 13:36:31 -0800
Message-ID: <CAO2U3QgpyxqmDWmN7v8W742hNpj-kzhuFEJjO6mZrSRHK9jvoA@mail.gmail.com>
References: <CAO2U3QiFvwMiwVCdVju_vJKK_HVndpQf4VyrEaHeeVVN6rgYgA@mail.gmail.com>
 <20141109014354.GA23883@peff.net> <20141109015918.GA24736@peff.net>
 <CAO2U3QiNYCWF_otPnR43gHNA22otR62aC2g8b0CnxVz3rjp7kQ@mail.gmail.com> <545FC8D1.1040803@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Nov 09 22:36:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnaAK-0007oA-VK
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 22:36:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbaKIVgx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Nov 2014 16:36:53 -0500
Received: from mail-oi0-f54.google.com ([209.85.218.54]:48106 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbaKIVgw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Nov 2014 16:36:52 -0500
Received: by mail-oi0-f54.google.com with SMTP id a141so4530151oig.41
        for <git@vger.kernel.org>; Sun, 09 Nov 2014 13:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=8Q4jm6Nt0xQkV2g9tFlemC+bU7APmbw/YyIDWHVSe5s=;
        b=z+FCoN6q63d1TbUaAAFn5zHhtPiJi0jXplrDlLDntqzePl5EPZAy6oH3xO7+CqRfGa
         lSw8QvpGM/1odBpXCJZELywqmNdZ2vU7lYq4Kqm2UiSNRqzBpigv9wF7zzS4rmYBjpwN
         yxwLijqCVuaifAyiqLUrya3ornfNgqvhnsYtD7lzU+hx6hS/6GxQsqBffEZ2Us7zHAJ/
         0AmQgT/BtfDtFA0vnVd0n0V3aXy//5zSKffuGuR43CjkcTdBBwnoDjQuEnmJ1grPLj3a
         LXA63VOg4jNwBnYQQ+loxLnJz2PE5JN1K3pKuxiGq3K2IPkjO56mfjaGxP7Ai/OMgw3+
         QESg==
X-Received: by 10.60.150.129 with SMTP id ui1mr22860238oeb.38.1415569011464;
 Sun, 09 Nov 2014 13:36:51 -0800 (PST)
Received: by 10.202.18.132 with HTTP; Sun, 9 Nov 2014 13:36:31 -0800 (PST)
In-Reply-To: <545FC8D1.1040803@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Actually I have a build break in pu on my mac right now. Seems to
build fine in ubuntu, but:

progress.c:66:15: error: use of undeclared identifier 'CLOCK_MONOTONIC'
        timer_create(CLOCK_MONOTONIC, &sev, &progress_timer);
                     ^
=2E/git-compat-util.h:233:54: note: expanded from macro 'timer_create'
#define timer_create(clockid, sevp, timerp) ((void) (clockid), (void) (=
s...
                                                     ^
progress.c:71:2: warning: incompatible pointer to integer conversion as=
signing
      to '__darwin_time_t' (aka 'long') from '__darwin_time_t *' (aka '=
long *');
      remove & [-Wint-conversion]
        timer_settime(progress_timer, 0, &value, NULL);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
=2E/git-compat-util.h:242:29: note: expanded from macro 'timer_settime'
        _ivalue.it_interval.tv_sec =3D value.it_interval.tv_sec;
         \
                                   ^ ~~~~~~~~~~~~~~~~~~~~~~~~
progress.c:71:2: error: invalid operands to binary expression
      ('long *' and 'long')
        timer_settime(progress_timer, 0, &value, NULL);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
=2E/git-compat-util.h:243:58: note: expanded from macro 'timer_settime'
        _ivalue.it_interval.tv_usec =3D value.it_interval.tv_nsec /
1000L;        \
                                      ~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~
progress.c:71:2: error: use of undeclared identifier '_ivalue_it_value'
=2E/git-compat-util.h:245:2: note: expanded from macro 'timer_settime'
        _ivalue_it_value.tv_usec =3D value.it_value.tv_nsec / 1000L...
        ^
progress.c:71:2: error: invalid operands to binary expression
      ('long *' and 'long')
        timer_settime(progress_timer, 0, &value, NULL);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
=2E/git-compat-util.h:245:52: note: expanded from macro 'timer_settime'
        _ivalue_it_value.tv_usec =3D value.it_value.tv_nsec / 1000L;
         \
                                   ~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~
progress.c:71:35: warning: expression result unused [-Wunused-value]
        timer_settime(progress_timer, 0, &value, NULL);
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~
=2E/git-compat-util.h:244:27: note: expanded from macro 'timer_settime'
        _ivalue.it_value.tv_sec  value.it_value.tv_sec...
                                 ^
progress.c:74:1: error: expected 'while' in do/while loop
static void clear_progress_signal(void)
^
progress.c:71:2: note: to match this 'do'
        timer_settime(progress_timer, 0, &value, NULL);
        ^
=2E/git-compat-util.h:240:52: note: expanded from macro 'timer_settime'
  ...flags, value, ovalue) do {                         \
                           ^
progress.c:264:2: error: expected '}'
}
 ^
progress.c:50:1: note: to match this '{'
{
^
2 warnings and 6 errors generated.
make: *** [progress.o] Error 1

On Sun, Nov 9, 2014 at 12:04 PM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> On 09.11.14 18:34, Michael Blume wrote:
>> Works for me, thanks =3D)
>>
>> I'm curious now, is there an automated build of git running on a mac
>> anywhere? There's a mac mini running jenkins in my office and it's
>> possible I could convince someone to let me set up a git build that'=
ll
>> e-mail me if there's a test failure.
>
> The basic idea is to run
> make clean &&
> git fetch git.git &&
> git checkout git.git/pu &&
> make -k test
>
> (and pipe stdlog+stdout into a file)
>
> I have a script here doing that, if you want, I can send it to you
>
>
>
>
>
