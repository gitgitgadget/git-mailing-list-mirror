From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/6] i18n win32: add git-am eval_gettext variable prefix
Date: Thu, 26 May 2011 16:59:21 +0200
Message-ID: <4DDE6AC9.9090003@viscovery.net>
References: <1306365594-22061-1-git-send-email-avarab@gmail.com> <1306365594-22061-2-git-send-email-avarab@gmail.com> <4DDDF483.70805@viscovery.net> <7vlixtzh1q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 16:59:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPc27-0004lm-KE
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 16:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757800Ab1EZO70 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 May 2011 10:59:26 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:50049 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753670Ab1EZO70 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 May 2011 10:59:26 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QPc1y-0001Bw-3s; Thu, 26 May 2011 16:59:22 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id CAAE91660F;
	Thu, 26 May 2011 16:59:21 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <7vlixtzh1q.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174518>

Am 5/26/2011 16:13, schrieb Junio C Hamano:
> This started on windows that confuses between $path and $PATH, we wou=
ldn't
> be doing this, right?  In git-submodule.sh uses $path variable for
> something other than the search-path, and the definition updated by y=
ou
> would become in the larger picture:
>=20
> 	path=3D... ;# git-submodule uses the variable for not-a-search-path
>         _I18N__path=3D$path
>         export _I18N__path
>         git sh-i18n--envsubst "... $_I18N__path"
>=20
> Is the RHS of the second assignment safe on Windows?  Are environment
> variables case insane but normal variables are safe?

Yes, the second assignment is safe, because at this point everything is
internal to bash; it does the right thing.

Problems start only when exported variables are transported from bash t=
o
another process.

But ... wait a minute - I've another idea!

bash -c "path=3Dz env"

*does* list both 'path' and 'PATH'

=2E.. hack hack ...

and so does a home-grown equivalent of 'env', both for MinGW and Visual
Studio. It looks like the environment was transfered just fine, only th=
e
*lookup* by getenv() was case-insensitive. This means we would just hav=
e
to supply a POSIX conformant getenv() for sh-i18n--envsubst.

I can write one, no problem; and, =C6var, I'm awfully sorry for sending=
 you
in the wrong direction.

-- Hannes
