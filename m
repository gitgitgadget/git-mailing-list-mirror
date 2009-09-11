From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: obnoxious CLI complaints
Date: Fri, 11 Sep 2009 07:47:01 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0909110744030.3654@localhost.localdomain>
References: <ef38762f0909091427m5b8f3am72c88fd4dbfebc59@mail.gmail.com> <m3fxavvl5k.fsf@localhost.localdomain> <ef38762f0909091709t7336d86dkd2f175e5b3a6a3f@mail.gmail.com> <200909101116.55098.jnareb@gmail.com> <4AA97B61.6030301@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Brendan Miller <catphive@catphive.net>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri Sep 11 16:48:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mm7Pu-0004Us-QE
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 16:48:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684AbZIKOrw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Sep 2009 10:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752179AbZIKOrw
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 10:47:52 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38565 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752109AbZIKOrv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Sep 2009 10:47:51 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n8BEl1wW015104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 Sep 2009 07:47:02 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n8BEl1bQ002977;
	Fri, 11 Sep 2009 07:47:01 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <4AA97B61.6030301@lsrfire.ath.cx>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.458 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128197>



On Fri, 11 Sep 2009, Ren=E9 Scharfe wrote:
>=20
> Using zlib directly avoids the overhead of a pipe and of buffering th=
e
> output for blocked writes; surprisingly (to me), it isn't any faster.

In fact, it should be slower.

On SMP, you're quite likely better off using the pipe, and compressing =
on=20
another CPU. Of course, it's usually the case that the compression is _=
so_=20
much slower than generating the tar-file (especially for the hot-cache=20
case) that it doesn't matter or the pipe overhead is even a slowdown.

But especially if generating the tar-file has some delays in it=20
(cold-cache object lookup, whatever), the "compress in separate process=
"=20
is likely simply better, because you can compress while the other proce=
ss=20
is looking up data for the tar.

				Linus
