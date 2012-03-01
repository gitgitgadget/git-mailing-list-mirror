From: Steven Noonan <steven@uplinklabs.net>
Subject: Re: Running git on ARM systems
Date: Wed, 29 Feb 2012 22:56:29 -0800
Message-ID: <CAKbGBLgSiZ+iOb92837-EKpZ=ucdxb5kytNX0hYuYc21u7FS1Q@mail.gmail.com>
References: <CAH5451=ngnGxpSd4+8xg1PwTSPOJ0napS+Y9KNVE_82a+n+GQQ@mail.gmail.com>
	<CAKbGBLj5EcQ=DLqhTO9FPKJGyP-tw=HyGYEgAv_7vz_0erSDMA@mail.gmail.com>
	<CAH5451=bQ=_Bn2tLRM5mBRSHA3BqMU7S=V1DxNaUeKxZ1G1XsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 07:56:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2zwK-0000CO-VE
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 07:56:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755035Ab2CAG4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 01:56:32 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:35766 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754952Ab2CAG4b (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Mar 2012 01:56:31 -0500
Received: by lahj13 with SMTP id j13so349373lah.19
        for <git@vger.kernel.org>; Wed, 29 Feb 2012 22:56:29 -0800 (PST)
Received-SPF: pass (google.com: domain of steven@uplinklabs.net designates 10.152.148.2 as permitted sender) client-ip=10.152.148.2;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of steven@uplinklabs.net designates 10.152.148.2 as permitted sender) smtp.mail=steven@uplinklabs.net
Received: from mr.google.com ([10.152.148.2])
        by 10.152.148.2 with SMTP id to2mr3311358lab.39.1330584989771 (num_hops = 1);
        Wed, 29 Feb 2012 22:56:29 -0800 (PST)
Received: by 10.152.148.2 with SMTP id to2mr2726119lab.39.1330584989648; Wed,
 29 Feb 2012 22:56:29 -0800 (PST)
Received: by 10.112.18.168 with HTTP; Wed, 29 Feb 2012 22:56:29 -0800 (PST)
In-Reply-To: <CAH5451=bQ=_Bn2tLRM5mBRSHA3BqMU7S=V1DxNaUeKxZ1G1XsA@mail.gmail.com>
X-Gm-Message-State: ALoCoQn3BQU1IIg4cuRQAkIhZMk9upAGRShPUutwSzyF0gUcHINZhnYbaE2j6iBuQuI0COi7LmUw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191902>

On Wed, Feb 29, 2012 at 9:47 PM, Andrew Ardill <andrew.ardill@gmail.com> wrote:
> On 1 March 2012 16:31, Steven Noonan <steven@uplinklabs.net> wrote:
>> I've been using git on three different ARM boxes (TrimSlice,
>> PandaBoard, i.MX53 Quick Start Board). It works okay, if a bit slow.
>> Even on a small repository (< 1MB), git is a bit laggy, but that's
>> true of most everything on those devices. It would be nice if they had
>> decent SATA controllers so I could attach some small SSDs or something
>> instead of relying on MicroSD or SD. I think you'll find the biggest
>> problem you will run into is memory usage when repacking or garbage
>> collecting, but you probably wouldn't really want to anyway (and if
>> you do, move the whole .git dir to something that can handle a proper
>> repack).
>>
>> I've never used the ARM11 processor though. My experience has been
>> with the ARM7 and ARM9, where I was -extremely- memory constrained
>> (4MB of RAM if I recall) and couldn't really build anything on the
>> device itself, as well as the Cortex-A8 and Cortex-A9 -- which was a
>> huge leap compared to the ARM7/ARM9, particularly since the newer
>> devices have a couple orders of magnitude more memory.
>>
>> Would be curious to see how one of the Raspberry Pi devices does
>> running my incomplete and silly microbenchmarking tool
>> (https://github.com/tycho/cpu-test-arm)... Perhaps I'll order one when
>> they're back in stock. :)
>>
>> Is there anything specific you wanted to know about git on such devices?
>
> It's good to hear that git has worked on these devices. Did you
> compile it for them especially, and if so what did you have to do?

Well, on the ARM7/9 4MB RAM device, I have no OS. It's actually a
Nintendo DS Lite with no real headroom for that kind of thing. :)

On the newer devices, I have Linaro, with kernels I cross-compiled for
each device. I found that replacing CONFIG_PREEMPT with
CONFIG_PREEMPT_VOLUNTARY was necessary for decent overall performance,
along with disabling CONFIG_OMAP_32K_TIMER on the OMAP4-based system.
The Cortex-A8 and Cortex-A9 are based on the ARMv7 architecture and
the ARM11 in your Raspberry Pi will use the ARMv6 architecture. I'm
pretty sure Linaro builds ARMv7 binaries, in which case that won't be
an option for you.

It looks like the Raspberry Pi will be supported by Debian, though, so
the instructions whether you used Linaro or Debian would be basically
the same: just 'apt-get install git' and you should be ready to rock.

If you really want to build it, you can. It just takes a while. Be
prepared to go grab a snack while you wait for it to finish things.
Here's how long things took on my OMAP4430 (PandaBoard):

snoonan@nerva ~/Development $ time git clone
git://git.uplinklabs.net/scm/git/snoonan/mirrors/git.git
Cloning into git...
remote: Counting objects: 155044, done.
remote: Compressing objects: 100% (38100/38100), done.
remote: Total 155044 (delta 115235), reused 154745 (delta 114946)
Receiving objects: 100% (155044/155044), 34.93 MiB | 5.05 MiB/s, done.
Resolving deltas: 100% (115235/115235), done.

real	1m10.960s # NOTE: Most of this was the "Resolving deltas" stage
(7-ish seconds to clone [from a server on LAN], 63-ish seconds for
deltas).
user	0m59.260s
sys	0m6.860s
snoonan@nerva ~/Development $ cd git
snoonan@nerva ~/Development/git $ time make -j2 V=1 >/dev/null
GIT_VERSION = 1.7.9.2.323.gf051a
    * new build flags or prefix
    * new link flags
Writing perl.mak for Git
14 translated messages.
GITGUI_VERSION = 0.16.0
    * new locations or Tcl/Tk interpreter
520 translated messages.
381 translated messages, 4 fuzzy translations, 6 untranslated messages.
520 translated messages.
514 translated messages.
519 translated messages, 1 untranslated message.
520 translated messages.
474 translated messages, 39 untranslated messages.
520 translated messages.
516 translated messages, 4 untranslated messages.
521 translated messages.
366 translated messages, 7 fuzzy translations, 17 untranslated messages.
289 translated messages.
200 translated messages, 7 untranslated messages.
276 translated messages, 4 fuzzy translations.
288 translated messages.
283 translated messages, 6 untranslated messages.
284 translated messages.
290 translated messages.
245 translated messages.
290 translated messages.

real	6m15.970s
user	10m13.280s
sys	0m57.640s
snoonan@nerva ~/Development/git $

So 6 minutes, 16 seconds with 2 make jobs. Compared to other platforms
I have on hand...

'make -j16' on an i7-2600K (3.4GHz, 4-core, 8-thread):

real	0m15.428s
user	1m33.691s
sys	0m10.416s

'make -j64' on a dual Xeon X5670 (2.93GHz, 12-core, 24-thread):

real	0m7.647s
user	1m52.219s
sys	0m12.173s

So it's only 25x as long as the i7 and 50x as long as the Xeon. Not
-terrible-, but obviously not competitive either. :)

Also, I'd recommend skipping builds of the documentation (man pages,
etc). It's a -very- slow and memory-hungry process. Even on the Xeon
box it takes a while with 'make -j64 doc':

real	0m27.726s
user	9m33.256s
sys	0m25.014s

'make -j128 test' is longer still (again, dual Xeon box):

real	1m42.696s
user	3m9.611s
sys	1m43.343s

So if it takes this long on super high-end Intel boxes, consider how
long it would take on an ARM box. Probably want to avoid the
'doc'/'man'/'test' targets!

> The RPi will have 256M ram, which is significantly better than what
> you have been working with. I think my first real goal will be to
> compile git on it. Hopefully it will be flawless!

Oops, sorry, I wasn't really clear. The ARM7+ARM9 system had 4MB of
RAM, but my new ARM systems have at least 512MB each (I think one has
2GB and the others have 1GB).

> In terms of running git on these devices, are there any limitations to
> the functionality, barring memory constraints?

Things are generally slower, but there's nothing really breaking any
functionality, AFAICT.

> The device will also have USB ports, and I imagine the two most common
> use cases will have the working directory on SD card and on USB hard
> drive. I wonder how git will perform comparatively on each.

It's hard to say. My TrimSlice has a SATA port, but it's implemented
as a USB-to-SATA adapter (blech). Performance really blows on it.
