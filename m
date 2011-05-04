From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH V2 0/5] Add PCRE support to git-grep
Date: Thu,  5 May 2011 00:00:16 +0200
Message-ID: <1304546421-25439-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	=?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 05 00:10:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHkH7-00072i-1R
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 00:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755842Ab1EDWKY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 May 2011 18:10:24 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:32900 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753579Ab1EDWKX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 18:10:23 -0400
Received: by wwa36 with SMTP id 36so1713118wwa.1
        for <git@vger.kernel.org>; Wed, 04 May 2011 15:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=FAwvn7Jc+Z8z+0QQ+ia2XNPq+AT0DsAS6YQTWWXsf40=;
        b=Lc76qu/FyPIWFogwhtSzA25IUOESj7+OKveMM27P4YUsjjtDNP+X0a7IBxIrlo4fYr
         a5eSDTIWdfkxVZk7wSJEuvCpm8gQwtNQ1fl00RhXki1burxfXDIjSyX1Fol0dv0OCK7i
         n6tz8M8w/Tvp6P5K0VI+9EOlGq17YRDh+Zpd0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=fLqZhqalfD0KGoTyffWMO2JobILK0MVeImbdtZ7S3j2XnXIK0C7UzlHHbhuMQR/xFA
         ydhwSUfnO3b4kTsV0wncOSdeeclMRg0SHxs3qj3Q9Zjrzq8+D/4ygh1ZwTASeeIxzYKW
         w/KL4ZQIrPJ7LBLVBOm1yGq/tGPQc+xYniHQg=
Received: by 10.216.235.33 with SMTP id t33mr890194weq.6.1304546451005;
        Wed, 04 May 2011 15:00:51 -0700 (PDT)
Received: from localhost (85-177-78-94.net.stream.pl [94.78.177.85])
        by mx.google.com with ESMTPS id c43sm799361weo.18.2011.05.04.15.00.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 04 May 2011 15:00:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172779>

This patch series attempts to add PCRE support to git-grep.

Changes from previous version:

* Now this series start from two patches which add the --line-number
  option to SYNOPSIS and bash completion; they can be treated
  separatedly from this series

* All patches have improved descriptions

* All patches have Signed-off-by

* libpcre specific code has been moved to a separate subsection to
  reduce number of #ifdefs; this addresses comments from Junio

* I noticed that even though I call pcre_study(), I didn't use its
  result in pcre_exec(); now this is fixed; this should improve
  git-grep --perl-regexp performance

* --perl-regexp has been added to bash-completion

* Added last patch which adds checks for libpcre to configure

* I repeated `make test` with and without pcre few more times and I
  cannot reproduce results from previous runs; possibly they were
  altered by current system load or cold cache. Now the difference
  is just few seconds. However, I'm still not convinced to link
  libgit.a with libpcre.

Micha=C5=82 Kiedrowicz (5):
  Documentation: Add --line-number to git-grep synopsis
  contrib/completion: --line-number to git grep
  grep: Put calls to fixmatch() and regmatch() into patmatch()
  git-grep: Learn PCRE
  configure: Check for libpcre

 Documentation/git-grep.txt             |    8 ++-
 Makefile                               |   16 +++++
 builtin/grep.c                         |    2 +
 config.mak.in                          |    1 +
 configure.ac                           |   26 ++++++++
 contrib/completion/git-completion.bash |    3 +-
 grep.c                                 |  100 ++++++++++++++++++++++++=
+++++---
 grep.h                                 |    9 +++
 8 files changed, 154 insertions(+), 11 deletions(-)

--=20
1.7.3.4
