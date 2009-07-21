From: Junio C Hamano <gitster@pobox.com>
Subject: Re: configure: is NEEDS_SSL_WITH_CRYPTO test correct?
Date: Tue, 21 Jul 2009 11:49:29 -0700
Message-ID: <7vk521g9c6.fsf@alter.siamese.dyndns.org>
References: <TV3HaUyeB7DH8euAZskzz1ryGof9Nj4sfUP9TBnI8xKT3cuwWrFLpQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Jul 21 20:51:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTKQm-0006R9-C8
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 20:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753787AbZGUStg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 14:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753564AbZGUStf
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 14:49:35 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55713 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752398AbZGUStf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 14:49:35 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 908F2E994;
	Tue, 21 Jul 2009 14:49:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D1401E991; Tue,
 21 Jul 2009 14:49:30 -0400 (EDT)
In-Reply-To: <TV3HaUyeB7DH8euAZskzz1ryGof9Nj4sfUP9TBnI8xKT3cuwWrFLpQ@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Tue\, 21 Jul 2009 10\:29\:32 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3BBE1AB4-7627-11DE-ACE1-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123683>

Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil> writes:

> From configure.ac, but re-nested:
>
> AC_CHECK_LIB([crypto], [SHA1_Init],
>    [NEEDS_SSL_WITH_CRYPTO=],
>    [AC_CHECK_LIB([ssl], [SHA1_Init],
>       [NEEDS_SSL_WITH_CRYPTO=YesPlease NEEDS_SSL_WITH_CRYPTO=],
>       [NO_OPENSSL=YesPlease])])

Yuck.

> should it rather be:
>
> AC_CHECK_LIB([crypto], [SHA1_Init],
>    [NEEDS_SSL_WITH_CRYPTO=],
>    [AC_CHECK_LIB([ssl], [SHA1_Init],
>       [NEEDS_SSL_WITH_CRYPTO=YesPlease],
>       [NEEDS_SSL_WITH_CRYPTO= NO_OPENSSL=YesPlease])])

We expect to find SHA1_Init in -lcrypto, and if we find it there we do not
do anything funky.  If we do not find it in -lcrypto, we try -lssl and if
we find it then we know we do need -lssl when saying -lcrypto.  Otherwise
we do not seem to have OpenSSL.

That is how I read your version, and it makes perfect sense to me.

> Notice the pairing of "action" parameters to the inner AC_CHECK_LIB().
> The first one seems to set, and then unset NEEDS_SSL_WITH_CRYPTO.  Not
> sure what is going on there.  Was the unsetting of NEEDS_SSL_WITH_CRYPTO
> supposed to go into the action-if-not-found section?

Thanks.
