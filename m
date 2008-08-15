From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: pack operation is thrashing my server
Date: Thu, 14 Aug 2008 17:06:13 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808141656120.3324@nehalem.linux-foundation.org>
References: <20080813145944.GB3782@spearce.org> <alpine.LFD.1.10.0808131123221.4352@xanadu.home> <20080813155016.GD3782@spearce.org> <alpine.LFD.1.10.0808131228270.4352@xanadu.home> <alpine.LFD.1.10.0808141014410.3324@nehalem.linux-foundation.org>
 <alpine.LFD.1.10.0808141022500.3324@nehalem.linux-foundation.org> <alpine.LFD.1.10.0808141442150.4352@xanadu.home> <alpine.LFD.1.10.0808141215520.3324@nehalem.linux-foundation.org> <alpine.LFD.1.10.0808141633080.4352@xanadu.home>
 <alpine.LFD.1.10.0808141544150.3324@nehalem.linux-foundation.org> <20080814233958.GA31225@atjola.homenet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Geert Bosch <bosch@adacore.com>,
	Andi Kleen <andi@firstfloor.org>, Ken Pratt <ken@kenpratt.net>,
	git@vger.kernel.org
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 15 02:08:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTmrS-0005Fe-4P
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 02:08:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277AbYHOAHE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Aug 2008 20:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752282AbYHOAHD
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 20:07:03 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38663 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752225AbYHOAHB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Aug 2008 20:07:01 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7F06EnD032172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 14 Aug 2008 17:06:16 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7F06Dfs004446;
	Thu, 14 Aug 2008 17:06:14 -0700
In-Reply-To: <20080814233958.GA31225@atjola.homenet>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.413 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92445>



On Fri, 15 Aug 2008, Bj=F6rn Steinbrink wrote:
>=20
> Since you mention the delta cache, uau (no idea about his real name) =
on
> #git was talking about some delta cache optimizations lately, althoug=
h
> he was dealing with "git log -S", maybe it affects rev-list in a simi=
lar
> way. Unfortunately, I can't seem to find any code for that, just a
> description of what he did and some numbers on the results in the IRC
> logs.

Yes, interesting.

The delta cache was really a huge hack that just turned out rather=20
successful. It's been hacked on further since (to do some half-way=20
reasonable replacement with _another_ hack by adding an LRU on top of i=
t),=20
but it really is very hacky indeed.

The "hash" we use for looking things up is also pretty much a joke, and=
 it=20
has no overflow capability, it just replaces the old entry with a new o=
ne.

I wonder how hard it would be to replace the whole table thing with our=
=20
generic hash.c hash thing. I'll take a look.

			Linus
