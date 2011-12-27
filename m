From: Bill Zaumen <bill.zaumen+git@gmail.com>
Subject: Possible submodule or submodule documentation issue
Date: Tue, 27 Dec 2011 11:24:19 -0800
Message-ID: <1325013859.1987.65.camel@yos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 27 20:24:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rfcdh-0000TH-Cq
	for gcvg-git-2@lo.gmane.org; Tue, 27 Dec 2011 20:24:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121Ab1L0TYZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Dec 2011 14:24:25 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42000 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385Ab1L0TYY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2011 14:24:24 -0500
Received: by iaeh11 with SMTP id h11so20797301iae.19
        for <git@vger.kernel.org>; Tue, 27 Dec 2011 11:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:subject:from:to:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=Gtpmfap+tGaBcwiyg73nNBNdVJEcqMw3aTf4mCwcHT8=;
        b=N4J40uQrnJccN5GMy7T/ptXQgdJrYoHMEQAY/yfJvKq3VKN1+6WJFyFEf2wo/MEufM
         8DyQQfXZZogRg1vB1/4QoPJJcKdREQT3dHnjtkQzVqbrP3gdGJF+RwmfEblXNqW/uaNm
         RqlDq7NTgCeLePd8TqwebA8pHMvQR25amsMRw=
Received: by 10.50.161.135 with SMTP id xs7mr27412238igb.15.1325013863724;
        Tue, 27 Dec 2011 11:24:23 -0800 (PST)
Received: from [192.168.1.20] (adsl-209-233-20-69.dsl.snfc21.pacbell.net. [209.233.20.69])
        by mx.google.com with ESMTPS id b20sm93128287ibj.7.2011.12.27.11.24.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 27 Dec 2011 11:24:22 -0800 (PST)
X-Mailer: Evolution 2.30.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187724>

=46or the 'add' command, the man page for get-submodule states

"<repository> is the URL of the new submodule=E2=80=99s origin reposito=
ry. This
may be either an absolute URL, or (if it begins with ./ or ../), the
location relative to the superproject=E2=80=99s origin repository."

and

"In either case, the given URL is recorded into .gitmodules for use by
subsequent users cloning the superproject. If the URL is given relative
to the superproject=E2=80=99s repository, the presumption is the superp=
roject
and submodule repositories will be kept together in the same relative
location, and only the superproject=E2=80=99s URL needs to be provided:
git-submodule will correctly locate the submodule using the relative UR=
L
in .gitmodules."

Based on that documentation, I tried the following sequence of commands=
:

git init --bare library.git
git init --bare library-pkg.git
git clone library.git
cd library;
echo hello > hello
git add hello
git commit -m "initial"
git push origin master
cd ..
git clone library-pkg.git
echo goodbye > goodbye
git add goodbye
git submodule add ./library.git src   <FAILS>
git submodule add ../library.git src  <WORKS>
git commit -a -m "initial pkg"
git push origin master

The documentation as written suggests that the first use of=20
"git submodule add" is the one that should have worked because
library.git is in the same directory as the origin repository
library-pgk.git .  I didn't try moving the two .git directories
to a server to see if the behavior is the same in that case (my
test was using the local file system).

git --version  reports 1.7.1  (current version for my linux
distribution).
