From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] .mailmap: Map email addresses to names
Date: Fri, 12 Jul 2013 21:21:21 +0200
Message-ID: <1373656881-5187-2-git-send-email-stefanbeller@googlemail.com>
References: <1373656881-5187-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Fri Jul 12 21:21:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uxiua-0000PU-BN
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 21:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757423Ab3GLTVo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Jul 2013 15:21:44 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:57870 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757318Ab3GLTVm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 15:21:42 -0400
Received: by mail-wi0-f181.google.com with SMTP id hq4so1041026wib.2
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 12:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=UsU+3n1CeBN20Z7Jn9psmIhaVS4jTpHsxBUAhNz/dDI=;
        b=XZa8ne4uhBMYJ+PtyPIXq3j+IuZsoHRKVTFbJEeYduxmXjrqXse5laOS5fWqmtG2Lu
         RlbfqeUqwl6sVt8xzHmViSi3JTlykIEzIdtx6iLl06XeDTrY+j1ZjZLm5lRWfpLyUjsF
         sjXflru6dZb5v2ufLLfcKIxriIegDhbCGR9GybP6fn2GJxn0x8TGuM9xppBVHE3Ziz50
         zCNtjfVag/OpzZGTA1TSQqmgGgW+6MQUkj1kj1g9ly5rWlxhApZd5mkJ/89jgyegAXQY
         UGSpzHILLqHNMvB1sJSXah4qbvIbZlNGykqDTSoeanMJUjpKXis2+fl9kYLnqzEqfsK2
         vYwA==
X-Received: by 10.194.93.74 with SMTP id cs10mr25402171wjb.9.1373656900956;
        Fri, 12 Jul 2013 12:21:40 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id iz8sm4638458wic.3.2013.07.12.12.21.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jul 2013 12:21:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.790.g9192b0b
In-Reply-To: <1373656881-5187-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230243>

People change email addresses quite often and sometimes
forget to add their entry to the mailmap file.
I have contacted lots of people, whose name occurs
multiple times in the short log having different
email addresses. The entries in the mailmap of
this patch are either confirmed by them or are trivial.
Trivial means different capitalisation of the domain
(@MIT.EDU and @mit.edu) or the domain was localhost,
(none) or @local.

Additionally to adding (name, email) mappings to the
=2Emailmap file, it has also been sorted alphabetically.
(which explains the removals, which are added
3 lines later on again). The sorting was done using
export LC_ALL=3DC; /usr/bin/sort without arguments.

While the most changes happen at the email addresses,
we also have a name change in here. Karl Hasselstr=C3=B6m
is now known as Karl Wiberg due to marriage. Congratulations!

To find out whom to contact I used the following small
script:
-
    #!/bin/bash
    git shortlog -sne |awk '{ NF--; $1=3D""; print }' |sort |uniq -d > =
mailmapdoubles
    while read line ; do
        # remove leading whitespace
        trimmed=3D$(echo $line | sed -e 's/^ *//g' -e 's/ *$//g')
        echo "git shortlog -sne | grep \""$trimmed"\""
    done < mailmapdoubles > mailmapdoubles2
    sh mailmapdoubles2
    rm mailmapdoubles
    rm mailmapdoubles2
-
Also interesting for similar tasks are these snippets:

    # Finding out duplicates by comparing email addresses:
    git shortlog -sne |awk '{ print $NF }' |sort |uniq -d

    # Finding out duplicates by comparing names:
    git shortlog -sne |awk '{ NF--; $1=3D""; print }' |sort |uniq -d
-

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 .mailmap | 135 +++++++++++++++++++++++++++++++++++++++++++++++++++----=
--------
 1 file changed, 110 insertions(+), 25 deletions(-)

diff --git a/.mailmap b/.mailmap
index 345cce6..22d3d70 100644
--- a/.mailmap
+++ b/.mailmap
@@ -5,99 +5,184 @@
 # same person appearing not to be so.
 #
=20
+<nico@fluxnic.net> <nico@cam.org>
+Alejandro R. Sede=C3=B1o <asedeno@MIT.EDU> <asedeno@mit.edu>
 Alex Benn=C3=A9e <kernel-hacker@bennee.com>
+Alex Riesen <raa.lkml@gmail.com> <fork0@t-online.de>
+Alex Riesen <raa.lkml@gmail.com> <raa@limbo.localdomain>
+Alex Riesen <raa.lkml@gmail.com> <raa@steel.home>
+Alex Vandiver <alex@chmrr.net> <alexmv@MIT.EDU>
 Alexander Gavrilov <angavrilov@gmail.com>
+Alexey Shumkin <alex.crezoff@gmail.com> <zapped@mail.ru>
+Anders Kaseorg <andersk@MIT.EDU> <andersk@ksplice.com>
+Anders Kaseorg <andersk@MIT.EDU> <andersk@mit.edu>
 Aneesh Kumar K.V <aneesh.kumar@gmail.com>
+Bernt Hansen <bernt@norang.ca> <bernt@alumni.uwaterloo.ca>
+Brandon Casey <drafnel@gmail.com> <casey@nrlssc.navy.mil>
 Brian M. Carlson <sandals@crustytoothpaste.ath.cx>
+Bryan Larsen <bryan@larsen.st> <bryan.larsen@gmail.com>
+Bryan Larsen <bryan@larsen.st> <bryanlarsen@yahoo.com>
 Cheng Renquan <crquan@gmail.com>
 Chris Shoemaker <c.shoemaker@cox.net>
 Dan Johnson <computerdruid@gmail.com>
 Dana L. How <danahow@gmail.com>
 Dana L. How <how@deathvalley.cswitch.com>
 Daniel Barkalow <barkalow@iabervon.org>
+David Brown <git@davidb.org> <davidb@quicinc.com>
 David D. Kilzer <ddkilzer@kilzer.net>
 David K=C3=A5gedal <davidk@lysator.liu.se>
+David Reiss <dreiss@facebook.com> <dreiss@dreiss-vmware.(none)>
 David S. Miller <davem@davemloft.net>
 Deskin Miller <deskinm@umich.edu>
 Dirk S=C3=BCsserott <newsletter@dirk.my1.cc>
+Eric Blake <eblake@redhat.com> <ebb9@byu.net>
+Eric Hanchrow <eric.hanchrow@gmail.com> <offby1@blarg.net>
 Eric S. Raymond <esr@thyrsus.com>
 Erik Faye-Lund <kusmabite@gmail.com> <kusmabite@googlemail.com>
+Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com> <eyvind-git@orakel.n=
tnu.no>
+Florian Achleitner <florian.achleitner.2.6.31@gmail.com> <florian.achl=
eitner2.6.31@gmail.com>
+Franck Bui-Huu <vagabon.xyz@gmail.com> <fbuihuu@gmail.com>
+Frank Lichtenheld <frank@lichtenheld.de> <djpig@debian.org>
+Frank Lichtenheld <frank@lichtenheld.de> <flichtenheld@astaro.com>
 Fredrik Kuivinen <freku045@student.liu.se>
 Fr=C3=A9d=C3=A9ric Heitzmann <frederic.heitzmann@gmail.com>
 H. Merijn Brand <h.m.brand@xs4all.nl> H.Merijn Brand <h.m.brand@xs4all=
=2Enl>
-H. Peter Anvin <hpa@bonde.sc.orionmulti.com>
-H. Peter Anvin <hpa@tazenda.sc.orionmulti.com>
-H. Peter Anvin <hpa@trantor.hos.anvin.org>
+H. Peter Anvin <hpa@zytor.com> <hpa@bonde.sc.orionmulti.com>
+H. Peter Anvin <hpa@zytor.com> <hpa@smyrno.hos.anvin.org>
+H. Peter Anvin <hpa@zytor.com> <hpa@tazenda.sc.orionmulti.com>
+H. Peter Anvin <hpa@zytor.com> <hpa@trantor.hos.anvin.org>
+Han-Wen Nienhuys <hanwen@google.com> Han-Wen Nienhuys <hanwen@xs4all.n=
l>
 Horst H. von Brand <vonbrand@inf.utfsm.cl>
-=C4=B0smail D=C3=B6nmez <ismail@pardus.org.tr>
+J. Bruce Fields <bfields@citi.umich.edu> <bfields@fieldses.org>
+J. Bruce Fields <bfields@citi.umich.edu> <bfields@pig.linuxdev.us.dell=
=2Ecom>
+J. Bruce Fields <bfields@citi.umich.edu> <bfields@puzzle.fieldses.org>
 Jakub Nar=C4=99bski <jnareb@gmail.com>
-Jay Soffian <jaysoffian+git@gmail.com>
+Jason Riedy <ejr@eecs.berkeley.edu> <ejr@EECS.Berkeley.EDU>
+Jason Riedy <ejr@eecs.berkeley.edu> <ejr@cs.berkeley.edu>
+Jay Soffian <jaysoffian@gmail.com> <jaysoffian+git@gmail.com>
 Jeff King <peff@peff.net> <peff@github.com>
+Jeff Muizelaar <jmuizelaar@mozilla.com> <jeff@infidigm.net>
 Joachim Berdal Haga <cjhaga@fys.uio.no>
-Johannes Sixt <j6t@kdbg.org> <johannes.sixt@telecom.at>
-Johannes Sixt <j6t@kdbg.org> <j.sixt@viscovery.net>
+Johannes Schindelin <Johannes.Schindelin@gmx.de> <johannes.schindelin@=
gmx.de>
 Johannes Sixt <j6t@kdbg.org> <J.Sixt@eudaptics.com>
+Johannes Sixt <j6t@kdbg.org> <j.sixt@viscovery.net>
+Johannes Sixt <j6t@kdbg.org> <johannes.sixt@telecom.at>
 Jon Loeliger <jdl@freescale.com>
-Jon Seymour <jon@blackcubes.dyndns.org>
-Jonathan Nieder <jrnieder@uchicago.edu>
+Jon Seymour <jon.seymour@gmail.com> <jon@blackcubes.dyndns.org>
+Jonathan Nieder <jrnieder@gmail.com> <jrnieder@uchicago.edu>
+Jonathan del Strother <jon.delStrother@bestbefore.tv> <maillist@steels=
kies.com>
+Josh Triplett <josh@joshtriplett.org> <josh@freedesktop.org>
+Josh Triplett <josh@joshtriplett.org> <josht@us.ibm.com>
+Julian Phillips <julian@quantumfyre.co.uk> <jp3@quantumfyre.co.uk>
 Junio C Hamano <gitster@pobox.com> <gitster@pobox.com>
-Junio C Hamano <gitster@pobox.com> <junio@pobox.com>
-Junio C Hamano <gitster@pobox.com> <junio@twinsun.com>
-Junio C Hamano <gitster@pobox.com> <junkio@twinsun.com>
 Junio C Hamano <gitster@pobox.com> <junio@hera.kernel.org>
 Junio C Hamano <gitster@pobox.com> <junio@kernel.org>
+Junio C Hamano <gitster@pobox.com> <junio@pobox.com>
+Junio C Hamano <gitster@pobox.com> <junio@twinsun.com>
 Junio C Hamano <gitster@pobox.com> <junkio@cox.net>
-Karl Hasselstr=C3=B6m <kha@treskal.com>
-Kevin Leung <kevinlsk@gmail.com>
+Junio C Hamano <gitster@pobox.com> <junkio@twinsun.com>
+Karl Wiberg <kha@treskal.com> Karl Hasselstr=C3=B6m <kha@treskal.com>
+Karl Wiberg <kha@treskal.com> Karl Hasselstr=C3=B6m <kha@yoghurt.hemma=
=2Etreskal.com>
+Karsten Blees <blees@dcon.de> <karsten.blees@dcon.de>
+Karsten Blees <blees@dcon.de> <karsten.blees@gmail.com>
+Kay Sievers <kay.sievers@vrfy.org> <kay.sievers@suse.de>
+Kay Sievers <kay.sievers@vrfy.org> <kay@mam.(none)>
+Keith Cascio <keith@CS.UCLA.EDU> <keith@cs.ucla.edu>
 Kent Engstrom <kent@lysator.liu.se>
+Kevin Leung <kevinlsk@gmail.com>
+Kirill Smelkov <kirr@navytux.spb.ru> <kirr@landau.phys.spbu.ru>
+Kirill Smelkov <kirr@navytux.spb.ru> <kirr@mns.spb.ru>
+Knut Franke <Knut.Franke@gmx.de> <k.franke@science-computing.de>
 Lars Doelle <lars.doelle@on-line ! de>
 Lars Doelle <lars.doelle@on-line.de>
 Li Hong <leehong@pku.edu.cn>
-Linus Torvalds <torvalds@linux-foundation.org> <torvalds@woody.linux-f=
oundation.org>
-Linus Torvalds <torvalds@linux-foundation.org> <torvalds@osdl.org>
-Linus Torvalds <torvalds@linux-foundation.org> <torvalds@g5.osdl.org>
 Linus Torvalds <torvalds@linux-foundation.org> <torvalds@evo.osdl.org>
-Linus Torvalds <torvalds@linux-foundation.org> <torvalds@ppc970.osdl.o=
rg>
+Linus Torvalds <torvalds@linux-foundation.org> <torvalds@g5.osdl.org>
+Linus Torvalds <torvalds@linux-foundation.org> <torvalds@osdl.org>
 Linus Torvalds <torvalds@linux-foundation.org> <torvalds@ppc970.osdl.o=
rg.(none)>
-Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>
+Linus Torvalds <torvalds@linux-foundation.org> <torvalds@ppc970.osdl.o=
rg>
+Linus Torvalds <torvalds@linux-foundation.org> <torvalds@woody.linux-f=
oundation.org>
+Lukas Sandstr=C3=B6m <luksan@gmail.com> <lukass@etek.chalmers.se>
+Marc Khouzam <marc.khouzam@ericsson.com> <marc.khouzam@gmail.com>
 Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com>
+Marco Costalba <mcostalba@gmail.com> <mcostalba@yahoo.it>
+Mark Levedahl <mdl123@verizon.net> <mlevedahl@gmail.com>
 Mark Rada <marada@uwaterloo.ca>
 Martin Langhoff <martin@laptop.org> <martin@catalyst.net.nz>
 Martin von Zweigbergk <martinvonz@gmail.com> <martin.von.zweigbergk@gm=
ail.com>
+Matt Draisey <matt@draisey.ca> <mattdraisey@sympatico.ca>
+Matt Kraai <kraai@ftbfs.org> <matt.kraai@amo.abbott.com>
+Matthias Kestenholz <matthias@spinlock.ch> <mk@spinlock.ch>
+Matthias Urlichs <matthias@urlichs.de> <smurf@kiste.(none)>
+Matthias Urlichs <matthias@urlichs.de> <smurf@smurf.noris.de>
 Michael Coleman <tutufan@gmail.com>
 Michael J Gruber <git@drmicha.warpmail.net> <michaeljgruber+gmane@fast=
mail.fm>
 Michael W. Olson <mwolson@gnu.org>
+Michael Witten <mfwitten@gmail.com> <mfwitten@MIT.EDU>
+Michael Witten <mfwitten@gmail.com> <mfwitten@mit.edu>
 Michele Ballabio <barra_cuda@katamail.com>
+Miklos Vajna <vmiklos@frugalware.org> <vmiklos@suse.cz>
+Namhyung Kim <namhyung@gmail.com> <namhyung.kim@lge.com>
+Namhyung Kim <namhyung@gmail.com> <namhyung@kernel.org>
 Nanako Shiraishi <nanako3@bluebottle.com>
 Nanako Shiraishi <nanako3@lavabit.com>
+Nelson Elhage <nelhage@mit.edu> <nelhage@MIT.EDU>
+Nelson Elhage <nelhage@mit.edu> <nelhage@ksplice.com>
 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
-<nico@fluxnic.net> <nico@cam.org>
-Peter Krefting <peter@softwolves.pp.se> <peter@svarten.intern.softwolv=
es.pp.se>
+Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com> <nicolas=
=2Emorey@free.fr>
+Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com> <nmorey@=
kalray.eu>
+Paolo Bonzini <bonzini@gnu.org> <paolo.bonzini@lu.unisi.ch>
+Pascal Obry <pascal@obry.net> <pascal.obry@gmail.com>
+Pascal Obry <pascal@obry.net> <pascal.obry@wanadoo.fr>
+Pat Notz <patnotz@gmail.com> <pknotz@sandia.gov>
+Paul Mackerras <paulus@samba.org> <paulus@dorrigo.(none)>
+Paul Mackerras <paulus@samba.org> <paulus@pogo.(none)>
 Peter Krefting <peter@softwolves.pp.se> <peter@softwolves.pp.se>
+Peter Krefting <peter@softwolves.pp.se> <peter@svarten.intern.softwolv=
es.pp.se>
 Petr Baudis <pasky@ucw.cz> <pasky@suse.cz>
+Petr Baudis <pasky@ucw.cz> <xpasky@machine>
+Phil Hord <hordp@cisco.com> <phil.hord@gmail.com>
+Philip J=C3=A4genstedt <philip@foolip.org> <philip.jagenstedt@gmail.co=
m>
+Philipp A. Hartmann <pah@qo.cx> <ph@sorgh.de>
 Philippe Bruhat <book@cpan.org>
 Ralf Thielow <ralf.thielow@gmail.com> <ralf.thielow@googlemail.com>
 Ramsay Allan Jones <ramsay@ramsay1.demon.co.uk>
 Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>
 Robert Fitzsimons <robfitz@273k.net>
 Robert Zeh <robert.a.zeh@gmail.com>
-Sam Vilain <sam@vilain.net>
-Santi B=C3=A9jar <sbejar@gmail.com>
+Robin Rosenberg <robin.rosenberg@dewire.com> <robin.rosenberg.lists@de=
wire.com>
+Salikh Zakirov <salikh.zakirov@gmail.com> <Salikh.Zakirov@Intel.com>
+Sam Vilain <sam@vilain.net> <sam.vilain@catalyst.net.nz>
+Santi B=C3=A9jar <santi@agolina.net> <sbejar@gmail.com>
 Sean Estabrooks <seanlkml@sympatico.ca>
+Sebastian Schuberth <sschuberth@gmail.com> <sschuberth@visageimaging.c=
om>
 Shawn O. Pearce <spearce@spearce.org>
-Steven Grimm <koreth@midwinter.com>
+Stefan Sperling <stsp@elego.de> <stsp@stsp.name>
+Stephen Boyd <bebarino@gmail.com> <sboyd@codeaurora.org>
+Steven Grimm <koreth@midwinter.com> <sgrimm@sgrimm-mbp.local>
+Sven Verdoolaege <skimo@kotnet.org> <Sven.Verdoolaege@cs.kuleuven.ac.b=
e>
+Sven Verdoolaege <skimo@kotnet.org> <skimo@liacs.nl>
 Tay Ray Chuan <rctay89@gmail.com>
+Ted Percival <ted@midg3t.net> <ted.percival@quest.com>
 Theodore Ts'o <tytso@mit.edu>
+Thomas Ackermann <th.acker@arcor.de> <th.acker66@arcor.de>
 Thomas Rast <trast@inf.ethz.ch> <trast@student.ethz.ch>
+Timo Hirvonen <tihirvon@gmail.com> <tihirvon@ee.oulu.fi>
+Toby Allsopp <Toby.Allsopp@navman.co.nz> <toby.allsopp@navman.co.nz>
+Tom Grennan <tmgrennan@gmail.com> <tgrennan@redback.com>
 Tony Luck <tony.luck@intel.com>
-Uwe Kleine-K=C3=B6nig <Uwe_Zeisberger@digi.com>
+Trent Piepho <tpiepho@gmail.com> <tpiepho@freescale.com>
+Trent Piepho <tpiepho@gmail.com> <xyzzy@speakeasy.org>
 Uwe Kleine-K=C3=B6nig <Uwe.Kleine-Koenig@digi.com>
+Uwe Kleine-K=C3=B6nig <Uwe_Zeisberger@digi.com>
 Uwe Kleine-K=C3=B6nig <ukleinek@informatik.uni-freiburg.de>
 Uwe Kleine-K=C3=B6nig <uzeisberger@io.fsforth.de>
 Uwe Kleine-K=C3=B6nig <zeisberg@informatik.uni-freiburg.de>
 Ville Skytt=C3=A4 <scop@xemacs.org>
 Vitaly "_Vi" Shukela <public_vi@tut.by>
+W. Trevor King <wking@tremily.us> <wking@drexel.edu>
 William Pursell <bill.pursell@gmail.com>
 YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
 anonymous <linux@horizon.com>
 anonymous <linux@horizon.net>
+=C4=B0smail D=C3=B6nmez <ismail@pardus.org.tr>
--=20
1.8.3.2.790.g9192b0b
