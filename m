From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/4] Good bye fnmatch
Date: Sat, 15 Feb 2014 09:01:45 +0700
Message-ID: <1392429709-9237-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 15 03:02:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEUZs-0004HN-Oz
	for gcvg-git-2@plane.gmane.org; Sat, 15 Feb 2014 03:02:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbaBOCBp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Feb 2014 21:01:45 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:45850 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbaBOCBm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 21:01:42 -0500
Received: by mail-pa0-f47.google.com with SMTP id kp14so13045076pab.20
        for <git@vger.kernel.org>; Fri, 14 Feb 2014 18:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=vHDui7y40YgsCAz/9nAoXtF0jKXK/qJ/XDoOXXQQr60=;
        b=U3fq6uW78GS6IwWhZOuj+KuqESr4AwVboJtGpalRCaxqIkgrxxuD5+z4NU5asq6LK6
         qqkCLfPQ47DGrNLTIZYg4XhjhpcmSP3IzuWIOjR/RruFKJv1qI0tGOCujhotRFXoRFo0
         9Ldn2yndpuTYwn2a4E4Vjo8xxdeaIrNcpiBeq94vcPqDP/mDGXEs7xBGwyRIO9UxCPZS
         GlmwvHmu8RdgdZ6ii1Z61mD26e7OzqeOR6nKvFbwKXvkjoZN2g3ftzRp66iSSM2HK2IG
         IOv8IkplNifyYxePiMNugh+mmVDZyBZ7XXEOk5zm3CeJcwnTgdLSfcOpn9AUqcTGl7Q4
         UfXw==
X-Received: by 10.66.145.166 with SMTP id sv6mr12821097pab.31.1392429702416;
        Fri, 14 Feb 2014 18:01:42 -0800 (PST)
Received: from lanh ([115.73.215.60])
        by mx.google.com with ESMTPSA id q7sm21851921pbc.20.2014.02.14.18.01.39
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 14 Feb 2014 18:01:41 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 15 Feb 2014 09:01:52 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242171>

Long story short, we wanted globbing wildcard "**" so I ripped
wildmatch library from rsync to do it. And it opened a possibility
to replace fnmatch completely, which would provide consistent behavior
across platforms (native fnmatch behaves differently on many corner
cases), and some performance gains. I started fnmatch replacement with
4917e1e (Makefile: promote wildmatch to be the default fnmatch
implementation - 2013-05-30). This is the final step.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (4):
  Use wildmatch() directly without fnmatch() wrapper
  Revert "test-wildmatch: add "perf" command to compare wildmatch and f=
nmatch"
  Stop using fnmatch (either native or compat)
  Actually remove compat fnmatch source code

 Makefile                        |  22 --
 builtin/apply.c                 |   2 +-
 builtin/branch.c                |   2 +-
 builtin/describe.c              |   2 +-
 builtin/for-each-ref.c          |   2 +-
 builtin/ls-remote.c             |   2 +-
 builtin/name-rev.c              |   2 +-
 builtin/reflog.c                |   2 +-
 builtin/replace.c               |   2 +-
 builtin/show-branch.c           |   2 +-
 builtin/tag.c                   |   2 +-
 compat/fnmatch/fnmatch.c (gone) | 494 --------------------------------=
--------
 compat/fnmatch/fnmatch.h (gone) |  84 -------
 config.mak.uname                |  10 -
 configure.ac                    |  28 ---
 diffcore-order.c                |   2 +-
 dir.c                           |  11 +-
 git-compat-util.h               |  12 -
 refs.c                          |   2 +-
 revision.c                      |   2 +-
 t/t3070-wildmatch.sh            |  13 --
 test-wildmatch.c                |  79 -------
 22 files changed, 20 insertions(+), 759 deletions(-)

--=20
1.8.5.2.240.g8478abd
