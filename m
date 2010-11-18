From: Lars Buitinck <larsmans@gmail.com>
Subject: git build failure with libssl (OpenSSL) in custom directory
Date: Thu, 18 Nov 2010 18:37:09 +0100
Message-ID: <AANLkTikQC9hncPZkeScWi7OsWw+Optbvxaygyn1p7_sN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 18 18:37:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ8QA-0005Zh-QU
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 18:37:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759954Ab0KRRhM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Nov 2010 12:37:12 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59803 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759929Ab0KRRhL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Nov 2010 12:37:11 -0500
Received: by fxm10 with SMTP id 10so147803fxm.19
        for <git@vger.kernel.org>; Thu, 18 Nov 2010 09:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        bh=M874x0g4teFkTG/SgK6uUBM9qLJxcmXLsedJ5leRnDs=;
        b=FbTxP37Ec+xt+rdMUB0ER2bw0yI4FaEp1Kyl8jv3jsDeMPydjhSeKq2sManXtNHhW9
         IohB4yr+NYVPYy3HSwxlmItTdn0vEWYcUwkoJVr2SUzh82toXZFpBONRSUOMFoxn+fdW
         xbHqrnIBFGXyllNUQflMdhcFOCvEu5j/MhITY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=DTcjHeTgc+3UmmkTtHFPXYygk5RrzPvOuEvg7c/AFX6vsfX67WABKhPiRjWdNN5uZy
         QYjQQHvEaDwKELHjSjY9VlDopKFL4XOGwQqjosaTXOyEIKA8R44CWE5rMDd1Kp26pGEu
         3wq/5jLcTlo1jgW6fmvuK3Gxy9UmmEP3ywuzU=
Received: by 10.223.93.204 with SMTP id w12mr826281fam.103.1290101829827; Thu,
 18 Nov 2010 09:37:09 -0800 (PST)
Received: by 10.223.101.132 with HTTP; Thu, 18 Nov 2010 09:37:09 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161691>

Hi all,

I've built Git on a Debian Linux box where I don't have root rights. I
first built OpenSSL 1.0.0b and Curl successfully, installing both in
$HOME/apps. I tried to do the same for Git, using

=C2=A0 CPPFLAGS=3D-I$HOME/apps/include LDFLAGS=3D-L$HOME/apps/lib make
prefix=3D$HOME/apps all doc info

but the build failed with the error

=C2=A0=C2=A0 =C2=A0=C2=A0 LINK git-fast-import
=C2=A0 /usr/bin/ld: cannot find -lcrypto
=C2=A0 collect2: ld returned 1 exit status
=C2=A0 make: *** [git-fast-import] Error 1

I checked the Makefile, and found

=C2=A0 # CFLAGS and LDFLAGS are for the users to override from the comm=
and line.

=C2=A0 CFLAGS =3D -g -O2 -Wall
=C2=A0 LDFLAGS =3D

I'm not a Makefile expert, but it seems to me that the last line
contradicts the comment. In any case, changing it to

=C2=A0 LDFLAGS =3D -L$(HOME)/apps/lib -lssl -lcrypto -ldl

worked, but only after also building and installing a shared library
version of OpenSSL.

I've got a working Git now, but I thought I'd let you know. I haven't
checked out the development version yet.

Regards,
Lars


PS.: I'm not a member of this list, but git-scm.com suggested I send
my question to you.
