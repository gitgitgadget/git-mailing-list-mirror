From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] fread does not return negative on error
Date: Wed, 24 Jun 2009 10:18:19 +0200
Message-ID: <20090624081819.GA10436@elte.hu>
References: <4A3FB09D.9050903@gmail.com> <20090622153431.GA18466@elte.hu> <25e057c00906220847t15425f38maf486c291d1d2468@mail.gmail.com> <4A3FB479.2090902@lsrfire.ath.cx> <7vhby64i8f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	roel kluin <roel.kluin@gmail.com>, git@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753477AbZFXISv@vger.kernel.org Wed Jun 24 10:19:26 2009
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753477AbZFXISv@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJNhH-000514-6W
	for glk-linux-kernel-3@gmane.org; Wed, 24 Jun 2009 10:19:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753477AbZFXISv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 24 Jun 2009 04:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbZFXISe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Jun 2009 04:18:34 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:36485 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751131AbZFXISb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Jun 2009 04:18:31 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1MJNgX-0001Rd-5j
	from <mingo@elte.hu>; Wed, 24 Jun 2009 10:18:30 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 3125F3E22B8; Wed, 24 Jun 2009 10:18:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vhby64i8f.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx2.mail.elte.hu: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.5
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122130>


* Junio C Hamano <gitster@pobox.com> wrote:

> Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
> > the following patch is for git.  I just removed the unneeded check =
for
> > res =3D=3D 0 from your version.  Does it look OK?
>=20
> The patch looks good, and both of our in-tree users do error out=20
> when the returned value is 0 (imap-send.c checks with "<=3D 0" which=20
> looks a tad amateurish, though) correctly.
>=20
> Funny, there is no caller of this function in the original context=20
> this bug originally found, which I think is linux-2.6/tools/perf=20
> ;-).

Hehe, yes :-)

Background: when creating tools/perf/ i cherry-picked all the nice=20
Git libraries into tools/perf/util/, to give a standard environment=20
for all tooling things that might come up in the future.

Some of those are not used yet but it looked more logical to pick up=20
whole pieces - some already gained uses. For example config.c is not=20
truly used yet, but very much expected to have a role in the future.

( The only invasive thing i had to do was the s/git_/perf_/ mass=20
  rename across all the files - having 'git_' in perf looked
  quite confusing. )

And our general experience with the Git libraries in=20
tools/perf/util/* is: we love them!

=46or example parse-options.c is a striking improvement compared to=20
getopt.h we used before, and all the other facilities are sane and=20
straight to the point as well. So in this sense 'perf' is an ...=20
interesting cross-discipline 'fork' of Git's generic libraries.

The auto-generation of everything out of Documentation/*.txt is=20
another thing we picked up, and that's very nice too.

One bookeeping issue: i found few explicit credits in those files -=20
so i noted in the changelog that i took them from Git and i noted=20
the specific upstream Git sha1 when i copied them. Would be nice to=20
update each file with names to make credit more explicit:

-rw-rw-r-- 1 mingo mingo  2808 2009-06-23 10:49 abspath.c
-rw-rw-r-- 1 mingo mingo  1447 2009-06-23 10:49 alias.c
-rw-rw-r-- 1 mingo mingo  4660 2009-06-23 10:49 cache.h
-rw-rw-r-- 1 mingo mingo  4817 2009-06-23 10:49 color.c
-rw-rw-r-- 1 mingo mingo  1187 2009-06-23 10:49 color.h
-rw-rw-r-- 1 mingo mingo 19149 2009-06-23 10:49 config.c
-rw-rw-r-- 1 mingo mingo  1041 2009-06-23 10:52 ctype.c
-rw-rw-r-- 1 mingo mingo   256 2009-06-23 10:49 environment.c
-rw-rw-r-- 1 mingo mingo  3262 2009-06-23 10:49 exec_cmd.c
-rw-rw-r-- 1 mingo mingo   496 2009-06-23 10:49 exec_cmd.h
-rw-rw-r-- 1 mingo mingo  8515 2009-06-23 10:49 help.c
-rw-rw-r-- 1 mingo mingo   751 2009-06-23 10:49 help.h
-rw-rw-r-- 1 mingo mingo  2592 2009-06-23 10:49 levenshtein.c
-rw-rw-r-- 1 mingo mingo   201 2009-06-23 10:49 levenshtein.h
-rw-rw-r-- 1 mingo mingo  1909 2009-06-23 10:49 pager.c
-rw-rw-r-- 1 mingo mingo 12454 2009-06-23 10:49 parse-options.c
-rw-rw-r-- 1 mingo mingo  5693 2009-06-23 10:49 parse-options.h
-rw-rw-r-- 1 mingo mingo  7986 2009-06-23 10:49 path.c
-rw-rw-r-- 1 mingo mingo 10442 2009-06-23 10:49 quote.c
-rw-rw-r-- 1 mingo mingo  2667 2009-06-23 10:49 quote.h
-rw-rw-r-- 1 mingo mingo  7966 2009-06-23 10:49 run-command.c
-rw-rw-r-- 1 mingo mingo  2838 2009-06-23 10:49 run-command.h
-rw-rw-r-- 1 mingo mingo   969 2009-06-23 10:49 sigchain.c
-rw-rw-r-- 1 mingo mingo   215 2009-06-23 10:49 sigchain.h
-rw-rw-r-- 1 mingo mingo  7270 2009-06-23 10:49 strbuf.c
-rw-rw-r-- 1 mingo mingo  4995 2009-06-23 10:49 strbuf.h
-rw-rw-r-- 1 mingo mingo   556 2009-06-23 10:52 string.c
-rw-rw-r-- 1 mingo mingo   120 2009-06-23 10:52 string.h
-rw-rw-r-- 1 mingo mingo 13859 2009-06-24 10:01 symbol.c
-rw-rw-r-- 1 mingo mingo  1112 2009-06-23 10:52 symbol.h
-rw-rw-r-- 1 mingo mingo  1690 2009-06-23 10:49 usage.c
-rw-rw-r-- 1 mingo mingo  9878 2009-06-23 10:52 util.h
-rw-rw-r-- 1 mingo mingo  4249 2009-06-23 10:49 wrapper.c

	Ingo
