From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC PATCH 09/19] completion: platform-specific helper function
 to get physical path
Date: Wed, 09 May 2012 09:37:43 +0200
Message-ID: <4FAA1EC7.5030200@viscovery.net>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de> <1336524290-30023-10-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed May 09 09:37:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SS1TA-0002wp-5F
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 09:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753466Ab2EIHhs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 May 2012 03:37:48 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:48920 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549Ab2EIHhr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2012 03:37:47 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SS1Tb-0000lA-6a; Wed, 09 May 2012 09:38:23 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id DB4751660F;
	Wed,  9 May 2012 09:37:43 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <1336524290-30023-10-git-send-email-szeder@ira.uka.de>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197456>

Am 5/9/2012 2:44, schrieb SZEDER G=C3=A1bor:
> I'm not sure how to check for MinGW; I just looked through the output=
 from
> 'set', and saw OSTYPE=3Dmsys there.

Ususally, we check uname -s for *MINGW* for "portability", but
since a subshell is counter-productive and we are sure that we have a
bash here, I think your check is OK.

> +# __git_pwd_p() stores the physical path of the current working dire=
ctory
> +# in the variable whose name is given as argument
> +if [ ${OSTYPE-} =3D "msys" ]; then
> +__git_pwd_p ()
> +{
> +	eval $1=3D"$PWD"
> +}
> +else
> +__git_pwd_p ()
> +{
> +	eval $1=3D\"$(pwd -P)\"
> +}
> +fi
> +

The following fixup of the quoting is needed at any rate to make the
eval'd commands resistent against directory names with blanks and
double-quotes.

--- >8 ---
=46rom: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] fixup! completion: platform-specific helper function t=
o get
 physical path

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 contrib/completion/git-completion.bash |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index bd7d39e..2cab4a0 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -75,12 +75,12 @@ esac
 if [ ${OSTYPE-} =3D "msys" ]; then
 __git_pwd_p ()
 {
-	eval $1=3D"$PWD"
+	eval "$1=3D\$PWD"
 }
 else
 __git_pwd_p ()
 {
-	eval $1=3D\"$(pwd -P)\"
+	eval "$1=3D\$(pwd -P)"
 }
 fi
=20
--=20
1.7.10.1.1689.gacdfbde
