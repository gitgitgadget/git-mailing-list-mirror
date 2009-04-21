From: James Cloos <cloos@jhcloos.com>
Subject: Re: [PATCH 1/1] Improve progress display in kB range.
Date: Tue, 21 Apr 2009 16:16:53 -0400
Message-ID: <m3d4b5oj76.fsf@lugabout.jhcloos.org>
References: <cover.1240115957.git.cloos@jhcloos.com>
	<d03620ac4d99f3280df31708032a072a4a6cd96e.1240115957.git.cloos@jhcloos.com>
	<alpine.LFD.2.00.0904210054190.6741@xanadu.home>
	<m3skk2szgv.fsf@lugabout.jhcloos.org>
	<alpine.LFD.2.00.0904211319570.6741@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Apr 21 22:54:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwMym-0000Bx-7A
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 22:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754134AbZDUUwd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Apr 2009 16:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754112AbZDUUwc
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 16:52:32 -0400
Received: from eagle.jhcloos.com ([207.210.242.212]:1691 "EHLO
	eagle.jhcloos.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218AbZDUUwc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 16:52:32 -0400
Received: by eagle.jhcloos.com (Postfix, from userid 10)
	id 563B4401A0; Tue, 21 Apr 2009 20:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jhcloos.com;
	s=eagle; t=1240347151;
	bh=L634avucOkyGkWsDDrb326VCdxZsYwG9yOmWvFDp7MA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=RjpoKAUVLuWMbskZYz6zMWupcMtkq64O/KW2uGVrReiIukI/n12Nyf1tMrxd9wKtV
	 54qlyuyKCiuxxG/RSe0vx8SWXg1UdApTAKxIPiBWfQ1YEKWBPmBrhn3zmqOD5vwhsQ
	 v/Vok6srUPvGnce/B3m/2Lrvg9oOuj6+j42KOnpI=
Received: by lugabout.jhcloos.org (Postfix, from userid 500)
	id 519A58B686; Tue, 21 Apr 2009 20:17:20 +0000 (UTC)
In-Reply-To: <alpine.LFD.2.00.0904211319570.6741@xanadu.home> (Nicolas Pitre's
	message of "Tue, 21 Apr 2009 13:28:04 -0400 (EDT)")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.0.92 (gnu/linux)
Face: iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAI1J
 REFUOE+lU9ESgCAIg64P1y+ngUdxhl5H8wFbbM0OmUiEhKkCYaZThXCo6KE5sCbA1DDX3genvO4d
 eBQgEMaM5qy6uWk4SfBYfdu9jvBN9nSVDOKRtwb+I3epboOsOX5pZbJNsBJFvmQQ05YMfieIBnYX
 FK2N6dOawd97r/e8RjkTLzmMsiVgrAoEugtviCM3v2WzjgAAAABJRU5ErkJggg==
Copyright: Copyright 2009 James Cloos
OpenPGP: ED7DAEA6; url=http://jhcloos.com/public_key/0xED7DAEA6.asc
OpenPGP-Fingerprint: E9E9 F828 61A4 6EA9 0F2B  63E7 997A 9F17 ED7D AEA6
X-Hashcash: 1:29:090421:nico@cam.org::Dbu0S5JmFhvaY0FK:00008S+7R
X-Hashcash: 1:29:090421:git@vger.kernel.org::qLUcM++ClBzR2JCK:00000000000000000000000000000000000000000iVqEO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117155>

>>>>> "Nicolas" =3D=3D Nicolas Pitre <nico@cam.org> writes:

Nicolas> Empirical evidence on my side shows the opposite.  I just did =
a fetch in=20
Nicolas> my kernel repo and got:

Nicolas>    Receiving objects: 100% (1373/1373), 223.36 KiB, done.

OK.  That does show that my proposed patch is incomplete.

The contrary example is from the final output, if the received pack
is less than a Meg.  The annoyance is in the progress display.

In index-pack.c, fill() calls xread() and then display_throughput().
Since xread() is designed to call read(2) and simple continue on any
EINTR or EAGAIN, then =E2=80=94 even though xread() explicitly does not
guarantee that =E2=80=98len=E2=80=99 bytes are read even if the data ar=
e available =E2=80=94
in practice xread() fills its buffer.  (At least on 32-bit x86,
using Linus=E2=80=99 kernel.)

Therefore, in practice =E2=80=94 and as I have witnessed several thousa=
nd times
without ever having seen a contrary example =E2=80=94 display_throughpu=
t() is
called *durring* a download only when total & 0xFFF =3D=3D 0xFFF.

Perhaps, then, display_throughput() should round differently, so that
the logical equivilent of:

         ( ( n << 10) & 0x3FF ) / 1024.0

would be rounded up.  Then throughput_string() could elide the ".%2.2u"
whenever ((int)(total & ((1 << 10) - 1)) * 100) >> 10) =3D=3D 0.

Or throughput_string() could simply elide the ".%2.2u" whenever
total & 0x3FF =3D=3D 0x3FF.

Nicolas> I must NACK your patches.  Presumptions are not good enough
Nicolas> justification for such a change, especially if results can't
Nicolas> be reproduced.

Understood.  I concentrated on the progress display and ignored the
final display.

-JimC
--=20
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6
