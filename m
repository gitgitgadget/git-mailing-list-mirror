From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 12/12] Teach Makefile to check header dependencies
Date: Sun, 31 Jan 2010 12:42:11 -0800
Message-ID: <7viqaic8gs.fsf@alter.siamese.dyndns.org>
References: <20100123144201.GA11903@progeny.tock>
 <7v3a1u6bfz.fsf@alter.siamese.dyndns.org>
 <20100126154357.GA4895@progeny.tock> <20100126155714.GM4895@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 31 21:42:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nbgct-0003hL-5a
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 21:42:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754192Ab0AaUm2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Jan 2010 15:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754182Ab0AaUm2
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jan 2010 15:42:28 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57181 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754169Ab0AaUm1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jan 2010 15:42:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B856B95D1C;
	Sun, 31 Jan 2010 15:42:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=kjR1po8fVtRh
	Bjz0M4IJs6wC6jk=; b=Lg1htE/cjLRPRYEBzJX8W0VeIzANFBJ5jkJu4kKddeQy
	T/wnPEYQxLRkmZbarv7tuq4wF3EaGz8Gute/I4yz2XaYnOpVthhCtwmzygPvzqxB
	/cA7w+O00B0ZlqWPXcbxjAr9QL7goK3Waz1ih/5c6Ym5gQmao0ENlECIG97NiFk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=MTi5kg
	Bj52p0Zp1eyaR3lnq3FI+RlgdbaUL2xDEOqXYcqWJIkmUichaxtj8e/geIcRwT5L
	awz8I0xugGbKysI6UQuJZq1lrzYNWWaI7DH4iuDFrQ+YQm6ia6RzBiCkzPc8yWPI
	zDJyVBuBMMpQoomREXei+xEm64cU2F0Ady9nA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FCA195CD7;
	Sun, 31 Jan 2010 15:42:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1C14295CD6; Sun, 31 Jan
 2010 15:42:12 -0500 (EST)
In-Reply-To: <20100126155714.GM4895@progeny.tock> (Jonathan Nieder's message
 of "Tue\, 26 Jan 2010 09\:57\:15 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 208FF88C-0EA9-11DF-B969-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138559>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Add a target to use the gcc-generated makefile snippets for
> dependencies on header files to check the hard-coded dependencies.
>
> With this patch applied, if any dependencies are missing, then
>
> 	make clean
> 	make COMPUTE_HEADER_DEPENDENCIES=3DYesPlease
> 	make CHECK_HEADER_DEPENDENCIES=3DYesPlease
>
> will produce an error message like the following:
>
> 	CHECK fast-import.o
> 	missing dependencies: exec_cmd.h
> 	make: *** [fast-import.o] Error 1
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> That=E2=80=99s the end of the series.  Thanks for reading.

Thanks.

Three observations:

 * "make distclean" should remove $(dep_files);

 * "deps/" should probably be ".depend/" or something less distracting;

 * I wish CHECK_HEADER_DEPENDENCIES pointed out unnecessary dependencie=
s
   hardcoded in the Makefile.

-- >8 --
Subject: [PATCH] Makefile: "make distclean" should remove dependency fi=
les

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 45b1f54..8578b31 100644
--- a/Makefile
+++ b/Makefile
@@ -2110,7 +2110,7 @@ dist-doc:
 ### Cleaning rules
=20
 distclean: clean
-	$(RM) configure
+	$(RM) configure $(dep_files)
=20
 clean:
 	$(RM) *.o block-sha1/*.o ppc/*.o compat/*.o compat/*/*.o xdiff/*.o \
--=20
1.7.0.rc1.141.gd3fd2
