From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/10] rr/svn-export reroll
Date: Mon, 9 Aug 2010 16:57:19 -0500
Message-ID: <20100809215719.GA4203@burratino>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <20100716101352.GA14374@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 09 23:58:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiaN1-0006gb-21
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 23:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756746Ab0HIV6x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Aug 2010 17:58:53 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:50125 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755337Ab0HIV6w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 17:58:52 -0400
Received: by qyk7 with SMTP id 7so6832068qyk.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 14:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=hDgKaARVurOmsiKHu4tG5vAhqgmDnmQA6s4e9m9S1Xk=;
        b=PlWIqxER9LBgrFy6N06yS+ooDDQwaQo5RjV8AdlTPUsawdJ6anTcvT/mCT5DRmhC24
         16/YkQXuGek/LEycvP6zOsuN4rsxaGKmn2k0PK7nv0bRW7d6DXWUADgHPZkM/fsU2N7q
         UgZmEkWP2n3RpVxFNWW/iMfFQeNa+qeXwFA2k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=LOHeXDj/pTuEwlCT2xkjtrrZJwcp/JZ4eaXUHD7Xu8iqFMXd0RkDQdhIgobS0IEt4j
         E0QACmopSykAdgJPwh4w74nNqPqAsfN383F8pyf+kTyMf/20l55Sa7AxBe4w4WeG+MXv
         tNu+jxf3Xt8z/MXM+dJNGsNpRJBQs/eY67GJg=
Received: by 10.220.124.211 with SMTP id v19mr2054528vcr.44.1281391131764;
        Mon, 09 Aug 2010 14:58:51 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id s29sm1136306vcr.47.2010.08.09.14.58.49
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Aug 2010 14:58:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100716101352.GA14374@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153031>

Hi!

svn-fe has some serious changes on the horizon.  As a preparation,
let=E2=80=99s round up what we have now.

The most controversial change is probably the new svn-fe test, which
takes about 15 seconds (for the =E2=80=9Csvnadmin load=E2=80=9D, not th=
e svn-fe
step :)).  It is in the t9* series, so hopefully that will not
dissuade people from running the earlier tests.

The main highlight in the changes is a new

	Input error

to stderr if a system call failed in reading in the dump file.
It still returns status 0 in this and other error situations,
though.

Based on maint (for no good reason; that=E2=80=99s just where I tried i=
t).
Intended to replace rr/svn-export in pu (only if Ram likes it, of
course).

Thoughts welcome.

David Barr (5):
  Add memory pool library
  Add string-specific memory pool
  Add stream helper library
  Infrastructure to write revisions in fast-export format
  SVN dump parser

Jason Evans (1):
  Add treap implementation

Jonathan Nieder (4):
  Export parse_date_basic() to convert a date string to timestamp
  Introduce vcs-svn lib
  Update svn-fe manual
  svn-fe manual: Clarify warning about deltas in dumpfiles

 .gitignore                |    5 +
 Makefile                  |   25 +++-
 cache.h                   |    1 +
 contrib/svn-fe/svn-fe.c   |    1 +
 contrib/svn-fe/svn-fe.txt |   19 ++--
 date.c                    |   14 +-
 t/t0080-vcs-svn.sh        |  171 +++++++++++++++++++++++
 t/t9010-svn-fe.sh         |   32 +++++
 test-line-buffer.c        |   46 +++++++
 test-obj-pool.c           |  116 ++++++++++++++++
 test-string-pool.c        |   31 +++++
 test-svn-fe.c             |   18 +++
 test-treap.c              |   65 +++++++++
 vcs-svn/LICENSE           |   33 +++++
 vcs-svn/fast_export.c     |   74 ++++++++++
 vcs-svn/fast_export.h     |   11 ++
 vcs-svn/line_buffer.c     |  102 ++++++++++++++
 vcs-svn/line_buffer.h     |   12 ++
 vcs-svn/line_buffer.txt   |   62 +++++++++
 vcs-svn/obj_pool.h        |   61 +++++++++
 vcs-svn/repo_tree.c       |  328 +++++++++++++++++++++++++++++++++++++=
++++++++
 vcs-svn/repo_tree.h       |   26 ++++
 vcs-svn/string_pool.c     |  102 ++++++++++++++
 vcs-svn/string_pool.h     |   11 ++
 vcs-svn/string_pool.txt   |   43 ++++++
 vcs-svn/svndump.c         |  302 +++++++++++++++++++++++++++++++++++++=
++++
 vcs-svn/svndump.h         |    9 ++
 vcs-svn/trp.h             |  236 ++++++++++++++++++++++++++++++++
 vcs-svn/trp.txt           |  103 ++++++++++++++
 29 files changed, 2040 insertions(+), 19 deletions(-)
 create mode 100755 t/t0080-vcs-svn.sh
 create mode 100644 t/t9010-svn-fe.sh
 create mode 100644 test-line-buffer.c
 create mode 100644 test-obj-pool.c
 create mode 100644 test-string-pool.c
 create mode 100644 test-svn-fe.c
 create mode 100644 test-treap.c
 create mode 100644 vcs-svn/LICENSE
 create mode 100644 vcs-svn/fast_export.c
 create mode 100644 vcs-svn/fast_export.h
 create mode 100644 vcs-svn/line_buffer.c
 create mode 100644 vcs-svn/line_buffer.h
 create mode 100644 vcs-svn/line_buffer.txt
 create mode 100644 vcs-svn/obj_pool.h
 create mode 100644 vcs-svn/repo_tree.c
 create mode 100644 vcs-svn/repo_tree.h
 create mode 100644 vcs-svn/string_pool.c
 create mode 100644 vcs-svn/string_pool.h
 create mode 100644 vcs-svn/string_pool.txt
 create mode 100644 vcs-svn/svndump.c
 create mode 100644 vcs-svn/svndump.h
 create mode 100644 vcs-svn/trp.h
 create mode 100644 vcs-svn/trp.txt

--=20
