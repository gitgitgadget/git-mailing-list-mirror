From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git-archive's wrong documentation: really write pax rather than
 tar
Date: Sat, 06 Aug 2011 20:57:45 +0200
Message-ID: <4E3D8EA9.3000609@lsrfire.ath.cx>
References: <1312482802.68635.YahooMailClassic@web29518.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: htl10@users.sourceforge.net
X-From: git-owner@vger.kernel.org Sat Aug 06 20:58:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qpm4Q-0004kU-L5
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 20:58:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756401Ab1HFS55 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Aug 2011 14:57:57 -0400
Received: from india601.server4you.de ([85.25.151.105]:43957 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755831Ab1HFS55 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 14:57:57 -0400
Received: from [192.168.2.105] (p4FFD9080.dip.t-dialin.net [79.253.144.128])
	by india601.server4you.de (Postfix) with ESMTPSA id B16512F8035;
	Sat,  6 Aug 2011 20:57:55 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <1312482802.68635.YahooMailClassic@web29518.mail.ird.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178888>

Am 04.08.2011 20:33, schrieb Hin-Tak Leung:
> --- On Thu, 4/8/11, Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx>
> wrote:
>=20
>> From: Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx>
> <snipped>
>> Ah, here it is:
>>=20
>> https://svn.r-project.org/R/trunk/src/library/utils/R/tar.R
>>=20
>> It's the ctype handling in function untar2 that rejects unknown
>> entry types.
>>=20
>> For reference, the documentation of the pax format including a=20
>> suggestion to treat unknown types like regular files can be found
>> here (search for "typename"):
>>=20
>> http://pubs.opengroup.org/onlinepubs/9699919799/utilities/pax.html
>>=20
>>> I think I tried the tree example and the R code also
>> didn't like it
>>> much... may be I'll give it another try.
>>=20
>> Did you try adding a ":" to the tree argument, e.g. this:
>>=20
>> $ git archive HEAD:
>>=20
>> instead of this?
>>=20
>> $ git archive HEAD
>>=20
>> Ren=E9
>=20
> That's better! With a HEAD: , that code does a lot of:
>=20
> Warning in untar2(tarfile, files, list, exdir) : checksum error for
> entry 'file...'
>=20
> for each file it tries to extract, but at least it is extracting the
> files.=20

That doesn't sound good.  Looking at the R source, however, I can see
that they use a two different algorithms to compute the checksum than
the one specified by POSIX (even though I don't fully understand what i=
t
actually is their doing, since I don't know R).  So worry too much abou=
t
the warning; as long e.g. "tar tf <file>" doesn't complain your archive
should be intact.

> I wasn't entirely sure about the notation used in the man page
> - is "v1.4.0^{tree}" same as "v1.4.0:" ? "HEAD:" is clearer, as most
> people has a HEAD...

They're a bit different in principle, but point to the same target in
this particular case.  "<ref>:<path>" gets you an object (blob or tree)
of a commit; with an empty <path> you get the root tree.
"<ref>^{<type>}" gives you the requested object of <type> (tag, commit
or tree) behind the <ref>; with "tree" you get the root tree of the com=
mit.

Ren=E9
