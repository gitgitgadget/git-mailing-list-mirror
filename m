From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] gitk: Fix display of copyright symbol in non-utf-8 locales
Date: Sat, 20 Mar 2010 01:14:52 -0500
Message-ID: <20100320061452.GA26224@progeny.tock>
References: <1268418709-4998-1-git-send-email-patthoyts@users.sourceforge.net>
 <1268418709-4998-2-git-send-email-patthoyts@users.sourceforge.net>
 <1268418709-4998-3-git-send-email-patthoyts@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Mar 20 07:14:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nsrwp-0007ij-RF
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 07:14:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808Ab0CTGOG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Mar 2010 02:14:06 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:47043 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673Ab0CTGOD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 02:14:03 -0400
Received: by gwaa18 with SMTP id a18so150822gwa.19
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 23:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=VH3fik/0vm+31m2emtu4UiwjZgoyAIB4noGh8SuWA44=;
        b=eOmMElZZ8F9FY9egcTI0tmTcsoUA28ilx3vcZLE72GQPsv4xlTdTNebBJ4Ts0omFjk
         tNBnbtb01PDu9yeQxGNaiMppZIsDzoDWjPg7orCwbOLHpDxhAjP1ynDuvjg8JVOJJD4x
         aKcfc5QerPvHuVcVM90XoNCwUMVIhBaBLKCIY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=QyNpo9ibKT5U4dOVpHnKVsF91PtINKYpvh1jNLlDOHOd2fI0qObDyevkgL/pu653RR
         gzrhtn92ZZsLp9No4tjqcmMrwQBjwS6xxvUj8eQNeBOqk/h/xXRXDeeuMykPYb61d/3k
         Fn2nPzop9Xx1fQSuvtCtQpqJA5BvKt/19Bx3k=
Received: by 10.150.55.25 with SMTP id d25mr2521586yba.330.1269065642012;
        Fri, 19 Mar 2010 23:14:02 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm921157iwn.7.2010.03.19.23.14.00
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Mar 2010 23:14:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1268418709-4998-3-git-send-email-patthoyts@users.sourceforge.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142690>

Unless the =E2=80=98-encoding=E2=80=99 option is supplied, wish interpr=
ets source
files using the default system encoding, which depends on locale.
This can cause the copyright symbol to display incorrectly in gitk=E2=80=
=99s
about dialog.

The -encoding option was added to tcl in version 8.1.

Reported-by: Pat Thoyts <patthoyts@users.sourceforge.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi,

Pat Thoyts wrote:

> The script file uses utf-8 encoding but when sourced it will be read
> using the default system encoding which is never utf8 on windows. Thi=
s
> causes the copyright symbol to display incorrectly in the about dialo=
g.

I can reproduce this in Linux with LANG=3Dde_DE@euro ./gitk.

> Using the unicode escape sequence avoids incorrect decoding but does
> require a double escape in the .po files.

When I tried applying your patch, running =E2=80=9Cmake update-po=E2=80=
=9D seemed to
undo its effect on translations.  I am also worried about what would
happen in locales where ASCII is not a subset of the native character
set, or other uses of non-ASCII characters in the translated messages.

Maybe the following would be safer?  I haven=E2=80=99t looked at the ef=
fect on
translations yet.

 gitk |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 1f36a3e..a7c9a9a 100755
--- a/gitk
+++ b/gitk
@@ -1,6 +1,6 @@
 #!/bin/sh
 # Tcl ignores the next line -*- tcl -*- \
-exec wish "$0" -- "$@"
+exec wish -encoding utf-8 "$0" -- "$@"
=20
 # Copyright =C2=A9 2005-2009 Paul Mackerras.  All rights reserved.
 # This program is free software; it may be used, copied, modified
--=20
1.7.0.2
