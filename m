From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC v2 0/9] Subversion dump parsing library
Date: Thu, 24 Jun 2010 05:50:04 -0500
Message-ID: <20100624105004.GA12336@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <daniel@shahaf.name>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 24 12:50:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORk0u-0000LT-QN
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 12:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754697Ab0FXKuS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jun 2010 06:50:18 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55326 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754449Ab0FXKuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 06:50:16 -0400
Received: by iwn41 with SMTP id 41so729677iwn.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 03:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=eS8LpJbbJbSd6MkLBsQu/EopKk3wSiUIcKT/85ZOf10=;
        b=FrajeFLAZCa0pSYMwoFp8Lq6ey/iuJ7xmhXdSWtZuS9YNf/YVi3e+dbwKpXvOfZBOi
         7Oq1jE+c8rH5byswjdGNnm72qkIc9kzZ4eKVrE9Gvovns0q1vgkTr9cEU5RL1pptNOU8
         zMZy1DsLD1E9KkcnXR1wax9b8mro/k0LVtv8g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=eOn3lCAQaiNas1iE444a0RHoqMm2GeewXNzQ1ltrSHoevQAhy6c4/tZj/n8FGpJb+J
         EUcyr+PkrjktvHBK00n9Y7OWqBo1SCY7f0+vaEo+fgo7looE7rNYry+WB/hgBFrHDFHt
         cqN6GLW3/3jbvoBU78S6ZiWGIXYp8mbisHgQ8=
Received: by 10.42.2.18 with SMTP id 18mr3511444ici.24.1277376615442;
        Thu, 24 Jun 2010 03:50:15 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id b3sm14439705ibf.7.2010.06.24.03.50.14
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 24 Jun 2010 03:50:14 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149571>

Hi gitsters,

Ram last sent this series a couple of weeks ago[1], and it was
merged to pu then as rr/svn-export.  Here=E2=80=99s another iteration
of the same for discussion, now including David Barr=E2=80=99s program
that demonstrates the functionality.

Patch 1 is not so closely related; it just modifies
parse_date_toffset() to keep me a little saner while using it.

Patches 2-8 are very similar to the versions Ram sent.  I
expanded the commit messages, took the latest code from
git://github.com/barrbrain/svn-dump-fast-export where possible,
and added a simple example build system so one can see the
result of compiling with

 make vcs-svn/lib.a

Probably more interesting is what the patches do not do:

 - they do not include any tests

 - they do not remove the persistent object pool functionality.
   If you try this code out, be sure to remove all the .bin
   files from the current directory after each run.

 - they are not guaranteed to have fewer bugs than the version
   Ram sent.  In fact, the opposite is more likely, since the
   code is only lightly tested

You can try it out with

 ; cd contrib/svn-fe
 ; wget http://github.com/barrbrain/svn-dump-fast-export/raw/master/tes=
t.dump
 ; make svn-fe
 ; ./svn-fe <test.dump

or

 ; make svn-fe.1
 ; man ./svn-fe.1

and go from there.

Any feedback is appreciated, especially on how to make this fit better
with git.  I would be particularly interested in making vcs-svn/lib.a
self-sufficient --- that is, would there be a simple way to pull out
the required code from date.c?

David Barr (5):
  Add memory pool library
  Add string-specific memory pool
  Add stream helper library
  Add infrastructure to write revisions in fast-export format
  Add SVN dump parser

Jason Evans (1):
  Add treap implementation

Jonathan Nieder (3):
  Export parse_date_basic() to convert a date string to timestamp
  Introduce vcs-svn lib
  Add a sample user for the svndump library

 Makefile                  |   12 ++-
 cache.h                   |    1 +
 contrib/svn-fe/.gitignore |    3 +
 contrib/svn-fe/Makefile   |   63 +++++++++
 contrib/svn-fe/svn-fe.c   |   43 ++++++
 contrib/svn-fe/svn-fe.txt |   56 ++++++++
 date.c                    |   14 +-
 vcs-svn/LICENSE           |   33 +++++
 vcs-svn/fast_export.c     |   75 ++++++++++
 vcs-svn/fast_export.h     |   14 ++
 vcs-svn/line_buffer.c     |   93 +++++++++++++
 vcs-svn/line_buffer.h     |   14 ++
 vcs-svn/obj_pool.h        |   80 +++++++++++
 vcs-svn/repo_tree.c       |  335 +++++++++++++++++++++++++++++++++++++=
++++++++
 vcs-svn/repo_tree.h       |   26 ++++
 vcs-svn/string_pool.c     |  114 +++++++++++++++
 vcs-svn/string_pool.h     |   15 ++
 vcs-svn/svndump.c         |  289 +++++++++++++++++++++++++++++++++++++=
+
 vcs-svn/svndump.h         |    8 +
 vcs-svn/trp.h             |  220 +++++++++++++++++++++++++++++
 vcs-svn/trp.txt           |   90 ++++++++++++
 21 files changed, 1589 insertions(+), 9 deletions(-)
 create mode 100644 contrib/svn-fe/.gitignore
 create mode 100644 contrib/svn-fe/Makefile
 create mode 100644 contrib/svn-fe/svn-fe.c
 create mode 100644 contrib/svn-fe/svn-fe.txt
 create mode 100644 vcs-svn/LICENSE
 create mode 100644 vcs-svn/fast_export.c
 create mode 100644 vcs-svn/fast_export.h
 create mode 100644 vcs-svn/line_buffer.c
 create mode 100644 vcs-svn/line_buffer.h
 create mode 100644 vcs-svn/obj_pool.h
 create mode 100644 vcs-svn/repo_tree.c
 create mode 100644 vcs-svn/repo_tree.h
 create mode 100644 vcs-svn/string_pool.c
 create mode 100644 vcs-svn/string_pool.h
 create mode 100644 vcs-svn/svndump.c
 create mode 100644 vcs-svn/svndump.h
 create mode 100644 vcs-svn/trp.h
 create mode 100644 vcs-svn/trp.txt

[1] http://thread.gmane.org/gmane.comp.version-control.git/148866
