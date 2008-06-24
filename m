From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: Segmentation fault on http clone, post-1.5.6
Date: Tue, 24 Jun 2008 23:55:56 +0300
Message-ID: <20080624205556.GA3565@mithlond.arda.local>
References: <20080624130457.GB13696@mithlond.arda.local> <20080624164034.GB4654@sigill.intra.peff.net> <20080624185723.GA3368@mithlond.arda.local> <alpine.LFD.1.10.0806241524480.2979@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Jun 24 22:57:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBFZg-0006rE-DM
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 22:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752435AbYFXU4Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Jun 2008 16:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752559AbYFXU4Q
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 16:56:16 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:60792 "EHLO
	jenni1.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752402AbYFXU4P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 16:56:15 -0400
Received: from mithlond.arda.local (80.220.180.140) by jenni1.rokki.sonera.fi (8.5.014)
        id 483E82F10136BFE0; Tue, 24 Jun 2008 23:56:02 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1KBFYS-0001t4-P2; Tue, 24 Jun 2008 23:55:56 +0300
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0806241524480.2979@xanadu.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86145>

Nicolas Pitre wrote (2008-06-24 15:34 -0400):

> I'm trying to reproduce your segfault with current master
> (v1.5.6-56-g29b0d01) but I just can't.
>=20
> Can you provide a gdb backtrace of the segfault?

Let's hope I'm doing this right. Just installed gdb for the first time.
I started with "gdb git" and then typed "run clone http://...".
Eventually it gave this:


Program received signal SIGSEGV, Segmentation fault.
0x080cb69a in find_pack_entry (sha1=3D0x81675bc "\224=EF=BF=BDd=EF=BF=BD=
BX\006=EF=BF=BD\020=EF=BF=BD=EF=BF=BD\016=EF=BF=BD2\214\002\n=EF=BF=BDR=
", e=3D0xbfcccd18, ignore_packed=3D0x0) at cache.h:489
489             return memcmp(sha1, sha2, 20);


And "bt" command prints this:


#0  0x080cb69a in find_pack_entry (sha1=3D0x81675bc "\224=EF=BF=BDd=EF=BF=
=BDBX\006=EF=BF=BD\020=EF=BF=BD=EF=BF=BD\016=EF=BF=BD2\214\002\n=EF=BF=BD=
R", e=3D0xbfcccd18, ignore_packed=3D0x0)
    at cache.h:489
#1  0x080cd05f in read_packed_sha1 (sha1=3D0x6900736b <Address 0x690073=
6b out of bounds>, type=3D0xbfccede4, size=3D0xbfccede8)
    at sha1_file.c:1924
#2  0x080cd211 in read_sha1_file (sha1=3D0x81675bc "\224=EF=BF=BDd=EF=BF=
=BDBX\006=EF=BF=BD\020=EF=BF=BD=EF=BF=BD\016=EF=BF=BD2\214\002\n=EF=BF=BD=
R", type=3D0xbfccede4, size=3D0xbfccede8)
    at sha1_file.c:2016
#3  0x080b468a in parse_object (sha1=3D0x81675bc "\224=EF=BF=BDd=EF=BF=BD=
BX\006=EF=BF=BD\020=EF=BF=BD=EF=BF=BD\016=EF=BF=BD2\214\002\n=EF=BF=BDR=
") at object.c:190
#4  0x080d69bd in walker_fetch (walker=3D0x8147610, targets=3D89, targe=
t=3D0x8163270, write_ref=3D0x0, write_ref_log_details=3D0x0) at walker.=
c:182
#5  0x080d16d1 in fetch_objs_via_curl (transport=3D0x81475e0, nr_objs=3D=
89, to_fetch=3D0x81630a0) at transport.c:369
#6  0x080d0c57 in transport_fetch_refs (transport=3D0x81475e0, refs=3D0=
x8163020) at transport.c:814
#7  0x0805be15 in cmd_clone (argc=3D2, argv=3Ddwarf2_read_address: Corr=
upted DWARF expression.
) at builtin-clone.c:465
#8  0x0804b081 in handle_internal_command (argc=3D2, argv=3D0xbfcd1568)=
 at git.c:252
#9  0x0804b272 in main (argc=3D0, argv=3D0x8165240) at git.c:448
