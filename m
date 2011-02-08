From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/RFC 0/7] Column output
Date: Tue,  8 Feb 2011 22:22:14 +0700
Message-ID: <1297178541-31124-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 08 16:23:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmpQ6-0006Wm-0G
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 16:23:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754730Ab1BHPXw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Feb 2011 10:23:52 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:46828 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787Ab1BHPXv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Feb 2011 10:23:51 -0500
Received: by pwj3 with SMTP id 3so1171531pwj.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 07:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=0uaQGjA/uz7HAbDnh03ViRQe1VpkVUSmKPriPcPubug=;
        b=e3OF71fpAJAeP6eT5pCAj91lyoL3xJ3Ka5j60kqaqbm8NYHOb3InMxRcR16gbFafwW
         7t99YbRazZUTlu3gUlGDZ78k8EGFpNcuBdrQmp9EnfqFm293OHEAIngA772l1JmykWbx
         oT+B7ONCR+OsHcn7+ryPphSycBsQM6BhpTsro=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=nNYSuVz05n4ogDeiySGX2+Vnmdj1/BYVo6VdJCOoEsl4RjbToL8obE4Out6bAT6fzu
         EmSX9xDHMFCYdeBlqt4oXmZtCYgkaabgkNHb++JHVdrBovohgwZTS7Zay/jzZFbkfHES
         TNbrbEQmNcg7i18N/1c41Bw6f/4/JcaaJBknQ=
Received: by 10.142.126.9 with SMTP id y9mr2907680wfc.163.1297178630433;
        Tue, 08 Feb 2011 07:23:50 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.232.10])
        by mx.google.com with ESMTPS id y42sm7712514wfd.10.2011.02.08.07.23.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Feb 2011 07:23:49 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 08 Feb 2011 22:22:21 +0700
X-Mailer: git-send-email 1.7.3.4.878.g439c7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166352>

This series was made a year ago [1]. I'm quite happy with it so far
and also tired of maintaining off-tree. So here's another attempt to
clean it up and put it upstream.

In short, the series is very simple: give porcelain commands column
output, just like good old "ls". There could be a few more candidates,
I believe Ren=C3=A9 Scharfe mentioned other files in "git status".

Another thing is how you want to customize this. Currently it supports
two modes: equal columns, and dense mode, specified with
--column=3Dcolumn or --column=3Ddense. Obviously not very convenient.
There's core.column but I'm not sure how to specify modes there, and
if people like some more modes (fill rows before columns for example).

[1] http://mid.gmane.org/1267963785-473-1-git-send-email-pclouds@gmail.=
com

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (7):
  Move term_columns() to pager.c and save terminal width before pager
  Add column layout
  parseopt: OPT_COLUMN to set struct column_layout.mode
  add core.column
  help: reuse struct column_layout
  tag: support column output with --column
  branch: support column output with --column

 .gitignore                   |    1 +
 Documentation/config.txt     |    8 ++
 Documentation/git-branch.txt |    8 ++
 Documentation/git-tag.txt    |   11 ++-
 Makefile                     |    3 +
 builtin/branch.c             |   22 ++++-
 builtin/tag.c                |   19 ++++-
 cache.h                      |    2 +
 column.c                     |  195 ++++++++++++++++++++++++++++++++++=
++++++++
 column.h                     |   23 +++++
 config.c                     |   16 ++++
 environment.c                |    1 +
 help.c                       |   55 +++----------
 pager.c                      |   32 +++++++
 parse-options.h              |    2 +
 t/t9002-column.sh            |  108 +++++++++++++++++++++++
 test-column.c                |   59 +++++++++++++
 17 files changed, 514 insertions(+), 51 deletions(-)
 create mode 100644 column.c
 create mode 100644 column.h
 create mode 100755 t/t9002-column.sh
 create mode 100644 test-column.c

--=20
1.7.2.2
