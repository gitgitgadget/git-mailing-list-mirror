From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git-archive's wrong documentation: really write pax rather than
 tar
Date: Wed, 10 Aug 2011 21:55:28 +0200
Message-ID: <4E42E230.5060303@lsrfire.ath.cx>
References: <1312945714.193.YahooMailClassic@web29510.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: htl10@users.sourceforge.net
X-From: git-owner@vger.kernel.org Wed Aug 10 21:56:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrEsj-0008HO-FR
	for gcvg-git-2@lo.gmane.org; Wed, 10 Aug 2011 21:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754769Ab1HJTz4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Aug 2011 15:55:56 -0400
Received: from india601.server4you.de ([85.25.151.105]:35037 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283Ab1HJTzz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2011 15:55:55 -0400
Received: from [192.168.2.105] (p4FFDA9AB.dip.t-dialin.net [79.253.169.171])
	by india601.server4you.de (Postfix) with ESMTPSA id D6D012F8064;
	Wed, 10 Aug 2011 21:55:53 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <1312945714.193.YahooMailClassic@web29510.mail.ird.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179076>

Am 10.08.2011 05:08, schrieb Hin-Tak Leung:
> --- On Sat, 6/8/11, Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> wrot=
e:
>=20
>> That doesn't sound good.  Looking at the R source,
>> however, I can see
>> that they use a two different algorithms to compute the
>> checksum than
>> the one specified by POSIX (even though I don't fully
>> understand what it
>> actually is their doing, since I don't know R).  So
>> worry too much about
>> the warning; as long e.g. "tar tf <file>" doesn't
>> complain your archive
>> should be intact.
>=20
> I filed the bug,
> https://bugs.r-project.org/bugzilla3/show_bug.cgi?id=3D14654
> and they have fixed it bug has a few comments to make:
>=20
> ---------------
> Fixed in R-devel and patched (your checksum field has more than 6 dig=
its which
> is highly unusual [since it can't be larger than 6 digits] but techni=
cally
> allowable).
>=20
> I should add that the original tar format mandated that checksums are
> terminated by NUL SPACE, so in that sense your tar file is invalid (t=
here can't
> be more than 6 digits since the checksum field consists of 8 bytes). =
untar2
> will now be more forgiving, but whatever program created that tar fil=
e should
> be fixed.
> -----------------

That's good to read, thanks.

> Please feel free to respond directly at the R bug tracking system, or
> I can cut-and-paste bits of e-mails also...

I don't think any further action is needed; there's nothing to fix.

There is not such thing as "the" tar archive format -- there are
multiple dialects.  While compatibility is important, ancient versions
of tar haven't been a target for git archive so far.

It creates files in the same format as POSIX pax.  I called it "tar"
instead of "pax" because the result can be extracted using GNU tar,
bsdtar, 7-Zip etc., supports long file names as well as symlinks -- and
I had never heard of anyone actually using the pax command, while tar i=
s
quite common.  (And pax doesn't restrict the checksum to six digits.)

It would be interesting to know which other tar extractor insists on th=
e
checksum being stored as six zero-padded octal digits followed by NUL
and SPACE instead of seven zero-padded octal digits followed by NUL,
though.  (Side note: I guess the reason for using only six digits is
that this enough for even the biggest possible header checksum.)

Ren=E9
