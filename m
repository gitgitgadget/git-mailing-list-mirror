From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 1/9] Add has_extension()
Date: Thu, 10 Aug 2006 20:42:09 +0200
Message-ID: <44DB7E01.4000901@lsrfire.ath.cx>
References: <11552221582769-git-send-email-rene.scharfe@lsrfire.ath.cx> <11552221581171-git-send-email-rene.scharfe@lsrfire.ath.cx> <20060810182117.GA13446@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 10 20:42:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBFUA-0005Dn-3S
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 20:42:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030291AbWHJSmN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 10 Aug 2006 14:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030552AbWHJSmM
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 14:42:12 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:61877
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1030291AbWHJSmM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Aug 2006 14:42:12 -0400
Received: from [10.0.1.3] (p508E54C8.dip.t-dialin.net [80.142.84.200])
	by neapel230.server4you.de (Postfix) with ESMTP id 388967004;
	Thu, 10 Aug 2006 20:42:11 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20060810182117.GA13446@c165.ib.student.liu.se>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25206>

=46redrik Kuivinen schrieb:
> On Thu, Aug 10, 2006 at 05:02:30PM +0200, Rene Scharfe wrote:
>> +static inline int has_extension(const char *filename, int len,
>> const char *ext) +{ +	int extlen =3D strlen(ext); +	return len >
>> extlen && !memcmp(filename + len - extlen, ext, extlen); +} +
>=20
> Wouldn't this function be much easier to use if len is computed from=20
> filename with strlen? (after a quick look through the other patches I
>  couldn't find a call site where filename wasn't NUL-terminated)

Yes, it would be a bit easier, and my first version had only two
arguments.  Then I found out that the length of the first string is
already known at _all_ potential callsites, using this command to
identify candidates:

	$ grep 'cmp.*"\..*"' *.[ch]

We could add something like this:

	#define has_ext(a, b) has_extension(a, strlen(a), b)

to make it easier to use for code that doesn't already determine the
string length.  I think we should add it only after a user has been
identified, though.

Thanks,
Ren=E9
