From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] fix t1504 on Windows
Date: Fri, 06 Feb 2009 13:55:04 +0100
Message-ID: <498C3328.70804@viscovery.net>
References: <498A1E1E.8010901@lsrfire.ath.cx> <498B3F6B.5080002@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri Feb 06 13:56:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVQGH-00054c-Pp
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 13:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbZBFMzU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Feb 2009 07:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbZBFMzU
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 07:55:20 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:26405 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbZBFMzT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Feb 2009 07:55:19 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LVQEb-00010B-Fy; Fri, 06 Feb 2009 13:55:13 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 3F6744E4; Fri,  6 Feb 2009 13:55:05 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <498B3F6B.5080002@lsrfire.ath.cx>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108695>

Ren=E9 Scharfe schrieb:
> The test t1504 crashes on Windows due to a failed assertion in
> normalize_absolute_path() because this function expects absolute path=
s to
> start with a slash, while on Windows they can start with a drive lett=
er
> or a backslash.
=2E..
> diff --git a/t/t1504-ceiling-dirs.sh b/t/t1504-ceiling-dirs.sh
> index 91b704a..9c9c4c9 100755
> --- a/t/t1504-ceiling-dirs.sh
> +++ b/t/t1504-ceiling-dirs.sh
> @@ -96,7 +96,7 @@ test_prefix subdir_ceil_at_subdi_slash "sub/dir/"
>  GIT_CEILING_DIRECTORIES=3D"foo:$TRASH_ROOT/sub"
>  test_fail second_of_two
> =20
> -GIT_CEILING_DIRECTORIES=3D"$TRASH_ROOT/sub:bar"
> +GIT_CEILING_DIRECTORIES=3D"$TRASH_ROOT/sub:/bar"
>  test_fail first_of_two
> =20
>  GIT_CEILING_DIRECTORIES=3D"foo:$TRASH_ROOT/sub:bar"

I also need this to complete this test:

diff --git a/t/t1504-ceiling-dirs.sh b/t/t1504-ceiling-dirs.sh
index 9c9c4c9..e377d48 100755
--- a/t/t1504-ceiling-dirs.sh
+++ b/t/t1504-ceiling-dirs.sh
@@ -93,13 +93,13 @@ GIT_CEILING_DIRECTORIES=3D"$TRASH_ROOT/subdi"
 test_prefix subdir_ceil_at_subdi_slash "sub/dir/"


-GIT_CEILING_DIRECTORIES=3D"foo:$TRASH_ROOT/sub"
+GIT_CEILING_DIRECTORIES=3D"/foo:$TRASH_ROOT/sub"
 test_fail second_of_two

 GIT_CEILING_DIRECTORIES=3D"$TRASH_ROOT/sub:/bar"
 test_fail first_of_two

-GIT_CEILING_DIRECTORIES=3D"foo:$TRASH_ROOT/sub:bar"
+GIT_CEILING_DIRECTORIES=3D"/foo:$TRASH_ROOT/sub:/bar"
 test_fail second_of_three



That said, I'm in the process of preparing a series that includes your
patch and that does the proper cleanup and code moving that you again
didn't do :-/ But it turns out that this is non-trivial because of bash=
's
(MSYS's) I-know-better-what-is-a-path-and-what-not behavior. It will ta=
ke
some time...

-- Hannes
