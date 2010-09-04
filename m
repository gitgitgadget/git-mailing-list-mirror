From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] Mockup an svndiff version 0 parser
Date: Sat,  4 Sep 2010 13:13:33 +0530
Message-ID: <1283586214-31204-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 04 09:45:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrnRd-0005ae-4o
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 09:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753588Ab0IDHpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 03:45:44 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:37398 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459Ab0IDHpn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 03:45:43 -0400
Received: by pwi3 with SMTP id 3so451436pwi.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 00:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=gVXD/CRqfoOyrlLvrKcq63Zkjp6eKA7/9jbd2BgxwfQ=;
        b=eIw8xnhQzrwJ9KR40AFjVepCB5Om4RJbT6JOcQIe1iS82cBefp7xrEZdV8Dk3klkyt
         ukpCR6FaLZlYbM3Bose0dbxiVu8qCLrSwh96OMMuSuut2kO62jOhDCIiADguw3A+v4oK
         zeYqKPQ0iTpygX+qajzs5VgAx9sNgRXi7XmhI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=QDo/MZj6sPOKFjQ+8TspPAfBr458VZZwpuigagv4oJjsm4KyehU2pcq3MPeoTcewQ/
         GA2kT+CKhLpJmC9yBFnIfCspLySgRUdKNTcLXWjYRWAagqJe1Z7xGUGlDIYoAEtCB4CJ
         mfB7zDADdWUZCVt/QoSVwK10qwm0nIrvEonw8=
Received: by 10.114.127.18 with SMTP id z18mr495355wac.171.1283586343339;
        Sat, 04 Sep 2010 00:45:43 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id d38sm5551613wam.20.2010.09.04.00.45.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 00:45:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155310>

Hi,

I finally rolled up my sleeves and wrote that svndiff0 parser
yesterday. I've tested it with a few source-target combinations, and
it seems to work fine. It's based on `master`, now that `jn/svn-fe`
has graduated. It's not intended for inclusion yet- it's more of a
"here's what I've been upto, and I'd like some feedback".
TODO:
1. malloc, realloc and free calls: I should factor these out to use
the obj_pool library in vcs-svn/
2. line_buffer. Only operations on stdin are currently
buffered. Should we extend the line_buffer library to be more generic?
3. Performance: The applier I've written is VERY naively. I can't help
but think that there must be a better way to do it. I still don't have
a solution though- the main problem is copyfrom_target.
4. Using the context dumpfilev3. The svndiff0 itself has no end
markers and it's difficult to say when it's going to end. Instead of
unconditionally waiting for more data (which is a problem when the
connection breaks), limit the number of bytes to parse using the
Content-Length header in the dumpfile v3.

Thanks.

p.s- I'll be MIA for a few weeks; exams are coming up in a week.

Ramkumar Ramachandra (1):
  vcs-svn: Add an svndiff0 parser

 vcs-svn/Makefile      |    2 +
 vcs-svn/line_buffer.c |    7 +-
 vcs-svn/line_buffer.h |    2 +-
 vcs-svn/svndiff.c     |  240 +++++++++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/svndiff.h     |   41 +++++++++
 5 files changed, 288 insertions(+), 4 deletions(-)
 create mode 100644 vcs-svn/Makefile
 create mode 100644 vcs-svn/svndiff.c
 create mode 100644 vcs-svn/svndiff.h

-- 
1.7.2.2.409.gdbb11.dirty
