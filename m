From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/16] column output (v2) and git-ls
Date: Wed,  9 Feb 2011 19:24:28 +0700
Message-ID: <1297254284-3729-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 13:26:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pn97n-0006nV-TP
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 13:26:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754706Ab1BIM0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Feb 2011 07:26:16 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35859 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119Ab1BIM0P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 07:26:15 -0500
Received: by iyj8 with SMTP id 8so92702iyj.19
        for <git@vger.kernel.org>; Wed, 09 Feb 2011 04:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=aEBaDSscQ2nA53lAmeB+q8+HYD6TKmoeVzb5YFvi8jE=;
        b=xxrLmJ2Ts7wJdFmmXj5y1TkJACj+HBNn+mLbPJmxr0FP6hNtZT7fBWQ4O6dheojf3O
         w6ROyg3W3+YfaxGBeoPULC52DoUNklPLZv6sBL32y9LUZOsFnUd5fh6wtWnm8CdsXJem
         j/GZRi7v8lO/2uYyffBuBO7xykKLzxLHgW2EE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=j0D4xn3WqumvjBl8hKjJ88qPnwuP32/F9ua5Z73v/2Ooy0ma+ep83bQZjLiuyNhw1E
         MQxvL/xhYswGRDsQETKRsya5fIYxDk3+NNN76ddfFPsl9pVGzlyCW77XORqizQB+m1y4
         9C0Mgkfh9/jgzg1erWKVEJFJIwND+BvMNmKb8=
Received: by 10.231.199.77 with SMTP id er13mr20821009ibb.44.1297254375019;
        Wed, 09 Feb 2011 04:26:15 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.232.10])
        by mx.google.com with ESMTPS id 8sm252046iba.10.2011.02.09.04.26.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Feb 2011 04:26:14 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 09 Feb 2011 19:24:44 +0700
X-Mailer: git-send-email 1.7.3.4.878.g439c7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166405>

I have fixed most of things Jonathan mentioned in the previous series,
but that's not the focus. I resend column output series because it's
required for git-ls patches, a more interesting command.

Column output patches:

  Move term_columns() to pager.c and save terminal width before pager
  Add display_columns() to display in column layout
  display_columns: add COL_MODE_{COLUMN,ROW} mode
  display_columns: add COL_DENSE to do unequal column layout
  Add test-column for testing column layout
  Add core.column
  parseopt: OPT_COLUMN to set struct column_layout.mode
  help: reuse display_columns() for help -a
  tag: add --column
  branch: add --column

Changes:

 - struct column_layout is gone.
 - core.column and --column takes a list of options separated by
   space/comma, so you can customize your display.

Remaining problems:

 - perhaps column.<cmd> config is better than core.column.
 - ansi_length() might misunderstand utf-8/ansi escapes
 - the heuristics to make dense layout
 - --column can also take auto/never/always
 - tests

git-ls patches:

  Add ls command
  ls: add --column
  ls: add --recursive and turn default to non-recursive mode
  ls: immitate UNIX ls output style
  ls: strip common directory prefix from output
  ls: color output

In short, git-ls is supposed to work as close as possible to UNIX ls,
while still takes advantages of git-ls-files.

I split this into many patches for easier discussion. The code itself
is still WIP-quality. The design may not be 100% right.
Oh and I'm not sure how to do the color part right. Reading $LS_COLORS
is scary and does not really fit Git.

 .gitignore                   |    2 +
 Documentation/config.txt     |   11 ++
 Documentation/git-branch.txt |    6 +
 Documentation/git-tag.txt    |    9 +-
 Makefile                     |    3 +
 builtin.h                    |    1 +
 builtin/branch.c             |   23 +++-
 builtin/ls-files.c           |  295 +++++++++++++++++++++++++++++++++++++++++-
 builtin/tag.c                |   21 +++-
 cache.h                      |    1 +
 column.c                     |  287 ++++++++++++++++++++++++++++++++++++++++
 column.h                     |   18 +++
 command-list.txt             |    1 +
 config.c                     |    4 +
 environment.c                |    1 +
 git.c                        |    1 +
 help.c                       |   52 +------
 pager.c                      |   33 +++++
 parse-options.h              |    2 +
 t/t9002-column.sh            |  108 +++++++++++++++
 test-column.c                |   57 ++++++++
 21 files changed, 879 insertions(+), 57 deletions(-)
 create mode 100644 column.c
 create mode 100644 column.h
 create mode 100755 t/t9002-column.sh
 create mode 100644 test-column.c

-- 
1.7.2.2
