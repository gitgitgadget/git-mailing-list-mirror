From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/5] en/object-list-with-pathspec (v3?)
Date: Wed,  8 Sep 2010 01:47:58 +1000
Message-ID: <1283874483-32017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 08 03:38:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot9cA-0004x0-Cm
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 03:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754916Ab0IHBiM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Sep 2010 21:38:12 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:45597 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016Ab0IHBiK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 21:38:10 -0400
Received: by pzk9 with SMTP id 9so1949994pzk.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 18:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=6NBqL44g1fuuW4LlFxCBqmpUDBZig+lKfwRoNgVBRks=;
        b=Xs/w0o+QKAcBloC/Euv5b4BGmHFw47F0PcWk3MYtwbqeAmQLK6MDVxUFmFgbM2QSma
         qZ3U3GaOlro3JbNe941t9Wy6fU5c7tiy1HMo8XA/lNQdwhR0+wg99Vblm1hH8fXjSWfd
         rQNKizGsbf3zxBp3dpE3c6egFA1Tgh0Hnu1Vs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=gNzy8Y2c/DbselAu1rJyqLdM7qVT5Y2abxVjBFRTgSYUzqCNZmOYW2BG6LR9ggCs9v
         qmIhWdR/CmCm/xqmdGQ+NRn9qNro7fmLfUZOVvs5EuMnuy/Yp/5aZ8wLzhKIiMhTNLyL
         0ocKRH+mxAIEGXX4bSVru/iaP3ZkgGVTSi+TI=
Received: by 10.142.211.7 with SMTP id j7mr419459wfg.20.1283909889955;
        Tue, 07 Sep 2010 18:38:09 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id q34sm6497543wfc.7.2010.09.07.18.38.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Sep 2010 18:38:06 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed,  8 Sep 2010 01:48:04 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155752>

Changes from last time is tree_entry_interesting() now takes
struct exclude * as the pathspecs.

I think there'll be a bit of performance loss because diff_options.el
is not initialized from the beginning. But that requires more changes
outside tree-diff.c (makes sure that diff_options.el is copied properly=
,
makes sure that diff_tree_setup_* is called ...) So one step at a time.
I'm working on it.

Elijah Newren (2):
  Add testcases showing how pathspecs are ignored with rev-list
    --objects
  Make rev-list --objects work together with pathspecs

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
  diff-no-index.c: rename read_directory() to read_dir()
  tree-walk: move tree_entry_interesting() from tree-diff.c
  tree_entry_interesting(): remove dependency on struct diff_options

 diff-no-index.c          |    6 +-
 diff.h                   |    3 +
 list-objects.c           |   25 ++++++++
 revision.c               |    8 ++-
 revision.h               |    3 +-
 t/t6000-rev-list-misc.sh |   51 ++++++++++++++++
 tree-diff.c              |  145 +++++++++-----------------------------=
--------
 tree-walk.c              |  111 +++++++++++++++++++++++++++++++++++
 tree-walk.h              |    4 +
 9 files changed, 233 insertions(+), 123 deletions(-)
 create mode 100755 t/t6000-rev-list-misc.sh
