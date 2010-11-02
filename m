From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC/PATCH 1/5] gettext: fix bug in git-sh-i18n's eval_gettext()
 by using envsubst(1)
Date: Tue, 02 Nov 2010 09:33:12 +0100
Message-ID: <4CCFCCC8.7080603@viscovery.net>
References: <AANLkTikOgMGqw5fc95c2VGwXxKu9rmsA+=z5_jykD92=@mail.gmail.com> <1288524860-538-2-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 02 09:33:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDCJ7-00045q-GK
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 09:33:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644Ab0KBIdY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Nov 2010 04:33:24 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:25512 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751607Ab0KBIdW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Nov 2010 04:33:22 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PDCIw-0007KU-5K; Tue, 02 Nov 2010 09:33:18 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id DF1F01660F;
	Tue,  2 Nov 2010 09:33:17 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <1288524860-538-2-git-send-email-avarab@gmail.com>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160508>

Am 10/31/2010 12:34, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Change eval_gettext(1) in git-sh-i18n.sh to use a modified version of
> gettext's envsubst(1) program, instead of using a clever (but broken)
> printf + eval + printf trick.
>=20
> Our previous fallback would incorrectly handle cases where the
> variable being interpolated contained spaces. E.g.:
>=20
>     cmd=3D"git foo"; eval_gettext "command: \$cmd"
>=20
> Would emit "command: gitfoo", instead of the correct "command: git
> foo". This happened with a message in git-am.sh that used the $cmdlin=
e
> variable.
>=20
> To work around this, and to improve our variable expansion behavior
> (eval has security issues) I've imported a stripped-down version of
> gettext's envsubst(1) program.

Would this help the case mentioned above at all? To pass the value of
'cmd' to envsubst, you have to export it. But the code snippet above
doesn't do that.

Wouldn't it be much simpler to dodge variable substitutions in the
translated string entirely by rewriting such texts as (e.g.)

	gettext_printf "command: %s\n" "$cmd"

and use printf in the implementation. I don't know how compatible you c=
an
make this with existing gettext implementations, though.

-- Hannes
