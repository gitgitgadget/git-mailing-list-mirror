From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A slight inconvenience with 'git archive --format=tar'
Date: Wed, 13 Jun 2012 10:45:36 -0700
Message-ID: <7vmx47gl6n.fsf@alter.siamese.dyndns.org>
References: <20120613144758.GA2438@blackspire>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?UmFmYcWCIE11xbx5xYJv?= <galtgendo@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 19:45:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SerdY-0001ug-Pg
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 19:45:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754606Ab2FMRpj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jun 2012 13:45:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49492 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754590Ab2FMRpi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jun 2012 13:45:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DFD28771;
	Wed, 13 Jun 2012 13:45:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=l41JFrlg64/0
	OsbUgo/9E5EEDX4=; b=eTOXUs7f0HV8r3Hu7EbEj3PdWN639itzDXV1QlkZeuSs
	gl86PKIlfbNJCxk340zwCTgSwYqwvbPf4N2z5xt81xcR2Z0mmoZTB8+s765U76XY
	pnyDDpPBj4KGQzoW9JviEzVaVYfrm3l8OF0ugbCEpjL9dgD4R1ElCpfg5Sdd7/w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=OMbSdO
	4JHgCNmIMgCb3f1GG46kpULeb/erLk6kW9nxSlQJF5IMqj6FYiNOWCiRc/kPz/+c
	F25ETo8PB5FKwxCvBcbKh9YagaY2SUfs7MJho782GudMPKr4kjlZ/t/+TniwAPt9
	212Awt+riTPcBa01CQ/A+IHFNIugujz8O5vXU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42E148770;
	Wed, 13 Jun 2012 13:45:38 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F115876F; Wed, 13 Jun 2012
 13:45:37 -0400 (EDT)
In-Reply-To: <20120613144758.GA2438@blackspire> (=?utf-8?B?IlJhZmHFgiBN?=
 =?utf-8?B?dcW8ecWCbyIncw==?= message of "Wed, 13 Jun 2012 16:47:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 95C435C6-B57F-11E1-BDA0-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199911>

Rafa=C5=82 Mu=C5=BCy=C5=82o <galtgendo@gmail.com> writes:

> I just stumbled upon this while checking a few mailing lists.
> I haven't found any mails about in in the archives yet, so I assume, =
that
> no mail have been written yet.
>
> The problem is described here:
> http://sourceforge.net/projects/sevenzip/forums/forum/45798/topic/532=
2604

Thanks.  It sounds a bit more than "slight inconvenience" to me ;-)

-- >8 --
Date: Wed, 13 Jun 2012 10:42:25 -0700
Subject: [PATCH] archive: ustar header checksum is computed unsigned

POSIX.1 (pax) is pretty clear on this:

  The chksum field shall be the ISO/IEC 646:1991 standard IRV
  representation of the octal value of the simple sum of all octets
  in the header logical record. Each octet in the header shall be
  treated as an unsigned value. These values shall be added to an
  unsigned integer, initialized to zero, the precision of which is
  not less than 17 bits. When calculating the checksum, the chksum
  field is treated as if it were all <space> characters.

so is GNU:

  http://www.gnu.org/software/tar/manual/html_node/Checksumming.html

=46ound by 7zip folks and reported by Rafa=C5=82 Mu=C5=BCy=C5=82o.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 archive-tar.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index dc91c6b..0ba3f25 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -139,13 +139,13 @@ static void strbuf_append_ext_header(struct strbu=
f *sb, const char *keyword,
=20
 static unsigned int ustar_header_chksum(const struct ustar_header *hea=
der)
 {
-	const char *p =3D (const char *)header;
+	const unsigned char *p =3D (const unsigned char *)header;
 	unsigned int chksum =3D 0;
-	while (p < header->chksum)
+	while (p < (const unsigned char *)header->chksum)
 		chksum +=3D *p++;
 	chksum +=3D sizeof(header->chksum) * ' ';
 	p +=3D sizeof(header->chksum);
-	while (p < (const char *)header + sizeof(struct ustar_header))
+	while (p < (const unsigned char *)header + sizeof(struct ustar_header=
))
 		chksum +=3D *p++;
 	return chksum;
 }
--=20
1.7.11.rc3.25.g4c2075b
