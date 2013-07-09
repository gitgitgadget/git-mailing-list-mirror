From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: standarize mtime when git checkout
Date: Tue, 09 Jul 2013 05:54:14 +0200
Message-ID: <51DB8966.2060308@lsrfire.ath.cx>
References: <7D0754FFADBD2D4785C1D233C497C47B209AF2BC@SJEXCHMB06.corp.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Rick Liu <rickliu@broadcom.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 05:54:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwP0T-0002ie-Rp
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 05:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751960Ab3GIDyW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Jul 2013 23:54:22 -0400
Received: from india601.server4you.de ([85.25.151.105]:50376 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672Ab3GIDyV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 23:54:21 -0400
Received: from [192.168.2.102] (p579BE0AD.dip0.t-ipconnect.de [87.155.224.173])
	by india601.server4you.de (Postfix) with ESMTPSA id 74226416;
	Tue,  9 Jul 2013 05:54:19 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <7D0754FFADBD2D4785C1D233C497C47B209AF2BC@SJEXCHMB06.corp.ad.broadcom.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229904>

Am 08.07.2013 23:39, schrieb Rick Liu:
> Hi,
>
> Currently when doing "git checkout" (either for a branch or a tag),
> if the file doesn't exist before,
> the file will be created using current datetime.
>
> This causes problem while trying to tar the git repository source fil=
es (excluding .git folder).
> The tar binary can be different
> even all of file contents are the same (eg. from the same GIT commit)
> because the mtime for the files might be different due to different "=
git checkout" time.
>
> eg:
> User A checkout the commit at time A and then tarball the folder.
> User B checkout the same commit as time B and then tarball the folder=
=2E
> The result tarball are binary different
> even though all of tarball contents are the same
> except the mtime for each file.
>
>
> Can we use GIT's commit time as the mtime for all of files/folders wh=
en we do "git checkout"?

That would break tools like make which rely on a files mtime to build=20
them.  They wouldn't be able to detect switching between source file=20
versions that are older than the latest build.

You can use "git archive" to create tar files in which all entries have=
=20
their mtime set to the commit time.  Such archives only contain tracked=
=20
(committed) files, though.  And different versions of git can create=20
slightly different archives, but such changes have been rare.

Ren=E9
