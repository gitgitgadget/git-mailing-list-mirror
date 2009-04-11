From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] process_{tree,blob}: Remove useless xstrdup calls
Date: Sat, 11 Apr 2009 11:19:01 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0904111115210.4583@localhost.localdomain>
References: <20090408112854.GA8624@atjola.homenet> <alpine.LFD.2.00.0904101517520.4583@localhost.localdomain> <alpine.LFD.2.00.0904101714420.4583@localhost.localdomain> <alpine.LFD.2.00.0904101806340.4583@localhost.localdomain> <20090411134112.GA1673@atjola.homenet>
 <20090411140756.GA15288@atjola.homenet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>, Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, david@lang.hm,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 11 20:28:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LshwN-0005hQ-Si
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 20:28:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757655AbZDKSZ1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Apr 2009 14:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757590AbZDKSZ0
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 14:25:26 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48610 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754344AbZDKSZZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Apr 2009 14:25:25 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n3BIJ3QT012855
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 11 Apr 2009 11:19:39 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n3BIJ1iD007320;
	Sat, 11 Apr 2009 11:19:02 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20090411140756.GA15288@atjola.homenet>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-5.445 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116307>



On Sat, 11 Apr 2009, Bj=F6rn Steinbrink wrote:

> On 2009.04.11 15:41:12 +0200, Bj=F6rn Steinbrink wrote:
> > On 2009.04.10 18:15:26 -0700, Linus Torvalds wrote:
> > > It obviously goes on top of my previous patch.
> >=20
> > Gives some nice results for the "rev-list --all --objects" test on =
the
> > gentoo repo says (with the old pack):
> >      | With my patch | With your patch on top
> > -----|---------------|-----------------------
> > VSZ  |       1667952 | 1319324
> > RSS  |       1388408 | 1126080
>=20
> linux-2.6.git:
>=20
>      | With my patch | With your patch on top
> -----|---------------|-----------------------
> VSZ  |        460376 | 407900
> RSS  |        292996 | 239760

Interesting. That's a 18+% reduction in RSS in both cases. Much bigger=20
than I expected, or what I saw in my limited testing. Is this in 32-bit=
=20
mode, where the pointers are cheaper, and thus the non-pointer data=20
relatively more expensive and a bigger percentage of the total? We real=
ly=20
wasted a _lot_ of memory on those names.

		Linus
