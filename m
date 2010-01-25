From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Handle double slashes in make_relative_path()
Date: Mon, 25 Jan 2010 02:06:48 +0100
Message-ID: <201001250206.48138.robin.rosenberg@dewire.com>
References: <379d55c6a4110736aadb8ace3b050de879a9deab.1264118830.git.trast@student.ethz.ch> <201001241744.57139.j6t@kdbg.org> <7v8wbn8ie2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, Thomas Rast <trast@student.ethz.ch>,
	git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 02:07:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZDQ3-00031K-MT
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 02:07:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140Ab0AYBG6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Jan 2010 20:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583Ab0AYBG6
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 20:06:58 -0500
Received: from mail.dewire.com ([83.140.172.130]:19485 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751398Ab0AYBG5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jan 2010 20:06:57 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 491BB147E152;
	Mon, 25 Jan 2010 02:06:56 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZK8mfxy-7lGs; Mon, 25 Jan 2010 02:06:49 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 76DF1800267;
	Mon, 25 Jan 2010 02:06:49 +0100 (CET)
User-Agent: KMail/1.12.4 (Linux/2.6.31-17-generic; KDE/4.3.4; i686; ; )
In-Reply-To: <7v8wbn8ie2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137932>

s=F6ndagen den 24 januari 2010 19.31.01 skrev  Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> > On Samstag, 23. Januar 2010, Johannes Sixt wrote:
> >> On Samstag, 23. Januar 2010, Junio C Hamano wrote:
> >> > What happens if you did this?
> >> >
> >> > 	git --git-dir=3D//git/repo/repo.git --work-tree=3D/git/repo
> >> >
> >> > where "//git/repo" is on the "git server" and you are working in=
 local
> >> > hierarchy "/git/repo"?
> >>
> >> Ah, right, this would not do the right thing. (But I can't verify =
this
> >> claim right now.)
> >
> > I tested it, and it does the right thing. The reason is that before
> > setup_work_tree() calls make_relative_path(), the --work-tree argum=
ent
> > has been processed by make_absolute_path(), which adds the drive pr=
efix.
> >
> > As long as setup_work_tree() remains the only caller of
> > make_relative_path(), we are safe.
>=20
> Thanks; I think a more correct description of your findings is:
>=20
>  - msysgit's make_absolute_path() does the right thing (i.e. adds "dr=
ive
>    prefix" to "git/repo" given to --work-tree); and
>=20
>  - as long as the callers feed what the platform considers absolute p=
aths
>    in abs and base, make_relative_path() does the right thing.
>=20
> So I think we are Ok.  We _might_ want to add Windows-only test at th=
e
> beginning of make_relative_path() to make sure that the both inputs h=
ave
> double-slashes at the beginning to catch future broken callers, but I
> think that is a separate topic, and we don't have to do that as long =
as
> setup_work_tree(0 remains the only caller, as you said.

Separate patch posted since this problem occurs in more than one place.=
=20

-- robin
