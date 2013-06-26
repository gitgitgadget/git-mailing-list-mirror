From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 11/16] rev-list: add bitmap mode to speed up lists
Date: Wed, 26 Jun 2013 16:13:59 -0700
Message-ID: <87obaslb2g.fsf@linux-k42r.v.cablecom.net>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
	<1372116193-32762-12-git-send-email-tanoku@gmail.com>
	<87mwqdlvsq.fsf@linux-k42r.v.cablecom.net>
	<CAFFjANSYoRGFDx109kMWJtYAO4TaTwSW0NCaemnrERuwakfpGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Vicent =?utf-8?Q?Mart=C3=AD?= <tanoku@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 27 01:14:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uryug-0001f8-I2
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 01:14:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753151Ab3FZXOG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Jun 2013 19:14:06 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:42929 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753102Ab3FZXOE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jun 2013 19:14:04 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 27 Jun
 2013 01:13:56 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (204.16.157.26) by
 CAS12.d.ethz.ch (172.31.38.212) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Thu, 27 Jun 2013 01:14:01 +0200
In-Reply-To: <CAFFjANSYoRGFDx109kMWJtYAO4TaTwSW0NCaemnrERuwakfpGg@mail.gmail.com>
	("Vicent \=\?utf-8\?Q\?Mart\=C3\=AD\=22's\?\= message of "Wed, 26 Jun 2013 03:45:26
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [204.16.157.26]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229070>

Vicent Mart=C3=AD <tanoku@gmail.com> writes:

> I'm afraid I cannot reproduce the segfault locally (assuming you're
> performing the rev-list on the git/git repository). Could you please
> send me more information, and a core dump if possible?

Sure, but isn't the core dump useless if you don't have the same
executable?  And since I'm building "custom" git, you won't have that.

Here's a semi-full backtrace (I left out the spammy output in the
outermost frames).  Some variables in #2 and #3 seem to have gone off
the rails.

#0  0x00007ffff72b06fb in __memset_sse2 () from /lib64/libc.so.6
No symbol table info available.
#1  0x000000000054c31c in bitmap_set (self=3D0x89c360, pos=3D1844674407=
2278122040) at ewah/bitmap.c:46
        old_size =3D 7666
        block =3D 288230376129345656
#2  0x00000000004e6c70 in add_to_include_set (data=3D0x7fffffffcd00, sh=
a1=3D0x85c014 "\230\062=CB=9DM\311i\373\372\317\321\370\224\017\313\336=
\301\213\271\060", bitmap_pos=3D-1431429576) at pack-bitmap.c:428
        hash_pos =3D 512
#3  0x00000000004e6cd6 in should_include (commit=3D0x85c010, _data=3D0x=
7fffffffcd00) at pack-bitmap.c:443
        data =3D 0x7fffffffcd00
        bitmap_pos =3D -1431429576
#4  0x000000000050cf1d in add_parents_to_list (revs=3D0x7fffffffce30, c=
ommit=3D0x85c010, list=3D0x7fffffffce30, cache_ptr=3D0x0) at revision.c=
:784
        parent =3D 0x88c260
        left_flag =3D 32767
        cached_base =3D 0x0
#5  0x0000000000512b66 in get_revision_1 (revs=3D0x7fffffffce30) at rev=
ision.c:2857
        entry =3D 0x8f9ce0
        commit =3D 0x85c010
#6  0x0000000000512dcf in get_revision_internal (revs=3D0x7fffffffce30)=
 at revision.c:2964
        c =3D 0x0
        l =3D 0x1000
#7  0x0000000000512fe1 in get_revision (revs=3D0x7fffffffce30) at revis=
ion.c:3040
        c =3D 0xb92608
        reversed =3D 0x89c360
#8  0x00000000004d2a24 in traverse_commit_list (revs=3D0x7fffffffce30, =
show_commit=3D0x4e6b72 <show_commit>, show_object=3D0x4e6afa <show_obje=
ct>, data=3D0x89c360) at list-objects.c:179
        i =3D -1
        commit =3D 0xb92608
        base =3D {
          alloc =3D 4097,=20
          len =3D 0,=20
          buf =3D 0x87bbe0 ""
        }
#9  0x00000000004e6fa4 in find_objects (revs=3D0x7fffffffce30, roots=3D=
0x0, seen=3D0x85b760) at pack-bitmap.c:549
        incdata =3D {
          base =3D 0x89c360,=20
          seen =3D 0x85b760
        }
        base =3D 0x89c360
        needs_walk =3D true
        not_mapped =3D 0x8f9dc0
#10 0x00000000004e747b in prepare_bitmap_walk (revs=3D0x7fffffffce30, r=
esult_size=3D0x0) at pack-bitmap.c:679
        i =3D 2
        pending_nr =3D 2
        pending_alloc =3D 64
        pending_e =3D 0x853e10
        wants =3D 0x8545b0
        haves =3D 0x854820
        wants_bitmap =3D 0x0
        haves_bitmap =3D 0x85b760
#11 0x0000000000474bb3 in cmd_rev_list (argc=3D2, argv=3D0x7fffffffd6e8=
, prefix=3D0x0) at builtin/rev-list.c:356
#12 0x0000000000405820 in run_builtin (p=3D0x7c3ef8 <commands.20770+204=
0>, argc=3D4, argv=3D0x7fffffffd6e8) at git.c:291
#13 0x00000000004059b3 in handle_internal_command (argc=3D4, argv=3D0x7=
fffffffd6e8) at git.c:454
#14 0x0000000000405b87 in main (argc=3D4, av=3D0x7fffffffd6e8) at git.c=
:544


This is with a version of your series that you can find at

  https://github.com/trast/git.git vm/ewah

I am'd your patches on top of Junio's master at the time, except for th=
e
parts to the Makefile that did not apply, which I fixed up manually.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
