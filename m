From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git gc --aggressive led to about 40 times slower "git log --raw"
Date: Sat, 22 Feb 2014 20:00:47 +0700
Message-ID: <CACsJy8AS6FMqMXcsDtUvrC2bgZ90irMXDCh58KjmgQK8+yFwVA@mail.gmail.com>
References: <CAEjYwfU==yYtQBDzZzEPdvbqz1N=gZtbMr5ccRaC_U7NfViQLA@mail.gmail.com>
 <87r470ssuc.fsf@fencepost.gnu.org> <CACsJy8D9tws_gu6yWVdz3t+Vfg5-9iorptn4BLnTL3b+YWcHzQ@mail.gmail.com>
 <87ioscsoow.fsf@fencepost.gnu.org> <20140218155842.GA7855@google.com>
 <xmqqzjlocf28.fsf@gitster.dls.corp.google.com> <CACsJy8DnjQyzY2ym7=fAQzThuhMuFzGLuKc35JJXn5FfB7r4Gg@mail.gmail.com>
 <87fvnbhdn7.fsf@fencepost.gnu.org> <877g8nh6k8.fsf@fencepost.gnu.org> <CACsJy8Cyf6Mu3q1VWH7srCK4m=+UgR4m7RiNkMv-nr8eF4YAJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Jaeger <chrjae@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Feb 22 14:01:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHCD5-0003Jd-PK
	for gcvg-git-2@plane.gmane.org; Sat, 22 Feb 2014 14:01:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbaBVNBV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Feb 2014 08:01:21 -0500
Received: from mail-qg0-f51.google.com ([209.85.192.51]:50371 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173AbaBVNBU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Feb 2014 08:01:20 -0500
Received: by mail-qg0-f51.google.com with SMTP id q108so10195328qgd.10
        for <git@vger.kernel.org>; Sat, 22 Feb 2014 05:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+VuYHcr77BRO8mzt7x3kfi8s1gzeWqDCmj48TUDfOpI=;
        b=w/J+5ExX5jldF0wczWzns/Dd9e6Ml9ZITksi3lFI2FKAzWM9JTi3jTtZYeAg2X0XAJ
         Q9rhyBrtuBJCcbVk/MpjDtcRgdbYFcJUIKjUFtyze0bytLl7sym+/9hJtCY5ykBS35db
         dRxX2Svse+ZHO8c3A12DN9RZZqXy6hQLfW0KMGjFa2eLuznCc+xjG+mQ99BRR2gb31Zp
         fHi6JakuS4cotnPs2faMFyyg1A5uqF8rZ3kgTMp1iftxOPWgdzgPhb8gEFBudl1cbKcz
         TvO0NWIFwIzSFxFPEMTEmO1dZ7Qvbx81BYYHsP6ls0XwAM2vSc0IswxhGM8Sd9hoCHAt
         j3mA==
X-Received: by 10.224.36.129 with SMTP id t1mr17179133qad.8.1393074078375;
 Sat, 22 Feb 2014 05:01:18 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Sat, 22 Feb 2014 05:00:47 -0800 (PST)
In-Reply-To: <CACsJy8Cyf6Mu3q1VWH7srCK4m=+UgR4m7RiNkMv-nr8eF4YAJA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242526>

On Sat, Feb 22, 2014 at 4:14 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Feb 22, 2014 at 3:53 PM, David Kastrup <dak@gnu.org> wrote:
>> David Kastrup <dak@gnu.org> writes:
>>
>>> Duy Nguyen <pclouds@gmail.com> writes:
>>>
>>>> OK with git://git.savannah.gnu.org/emacs.git we have
>>>>
>>>>  - a 209MB pack with --aggressive
>>>>  - 1.3GB with --depth=50
>>>>  - 1.3GB with --window=4000 --depth=32
>>>>  - 1.3GB with --depth=20
>>>>  - 821MB with --depth=250 for commits --before=2.years.ago, --depth=50
>>>> for the rest
...
>>>>
>>>> I'm not really happy with --depth=250 producing 209MB while
>>>> --depth=250 --before=2.year.ago a 800MB pack. It looks wrong (or maybe
>>>> I did something wrong)
....
>> Another thing: did you really use --depth=250 here or did you use
>> --aggressive?  It may be that the latter also sets other options?
>
> I can't use --aggressive because I need to feed revisions directly to
> pack-objects. --aggressive also sets --window=250. Thanks for
> checking. My machine will have another workout session.

And 800MB is reduced to 177MB, containing history older than 2 years.
The final pack is 199MB, within the size range of current --aggressive
and should be reasonably fast on most operations. Again blame could
still hit long delta chains but I think we should just unpack some
trees/blobs when we hit long delta chains.

I think we should update --aggressive to do it this way. So

 - gc.aggressiveDepth defaults to 50 (or 20?), this is used for recent history
 - gc.aggressiveDeepDepth defaults to 250 (or smaller??), used for
ancient history
 - gc.aggressiveDeepOption is rev-list a rev-list option to define
"ancient history", default to --before=2.years.ago. This option could
be specified multiple times.

Both packing phases use the same gc.aggressiveWindow. We could add
gc.aggressiveDeepWindow too.

GSoC project?
-- 
Duy
