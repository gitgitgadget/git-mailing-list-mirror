From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4/5] Make 'diff_populate_filespec()' use the new  
 'strbuf_readlink()'
Date: Thu, 18 Dec 2008 09:49:23 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812180945330.14014@localhost.localdomain>
References: <alpine.LFD.2.00.0812171034520.14014@localhost.localdomain> <alpine.LFD.2.00.0812171042120.14014@localhost.localdomain> <alpine.LFD.2.00.0812171042500.14014@localhost.localdomain> <alpine.LFD.2.00.0812171043180.14014@localhost.localdomain>
 <alpine.LFD.2.00.0812171043440.14014@localhost.localdomain> <20081218121118.3635c53c@crow> <alpine.LFD.2.00.0812180851120.14014@localhost.localdomain> <494A8B57.6070106@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Burton <markb@ordern.com>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Dec 18 18:51:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDN1X-0008JU-Dr
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 18:50:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbYLRRtl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Dec 2008 12:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbYLRRtl
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 12:49:41 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34685 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751046AbYLRRtk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Dec 2008 12:49:40 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBIHnOuJ012973
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Dec 2008 09:49:25 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBIHnNFH015174;
	Thu, 18 Dec 2008 09:49:23 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <494A8B57.6070106@lsrfire.ath.cx>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.923 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103477>



On Thu, 18 Dec 2008, Ren=E9 Scharfe wrote:
>=20
> Yes, but now I get two new warnings:
>=20
> diff.c: In function `diff_populate_filespec':
> diff.c:1809: warning: passing arg 2 of `sha1_object_info' from
> incompatible pointer type
> diff.c:1811: warning: passing arg 3 of `read_sha1_file' from
> incompatible pointer type

Yeah, yeah, we should probably fix it all, but you're right, your patch=
=20
avoids the pain.

The good news is that "size_t" and "unsigned long" really are the same=20
size on all sane platforms. You'll see differences just in the odd 16-b=
it=20
world ("small" memory model with 16-bit size_t and possibly 32-bit "lon=
g")=20

Although I guess some really odd more modern case might have a 32-bit=20
pointer (and size_t) and 64-bit long. If it's possible to screw the typ=
e=20
system up, history shows that somebody (usually Windows) will do it.

		Linus
