From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/12] Layout control placeholders for pretty format
Date: Sat, 16 Mar 2013 09:24:31 +0700
Message-ID: <1363400683-14813-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 16 03:33:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGgvZ-0001jG-2z
	for gcvg-git-2@plane.gmane.org; Sat, 16 Mar 2013 03:32:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170Ab3CPCca convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 22:32:30 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:38464 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755389Ab3CPCc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 22:32:29 -0400
X-Greylist: delayed 457 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Mar 2013 22:32:29 EDT
Received: by mail-pd0-f182.google.com with SMTP id y10so342834pdj.41
        for <git@vger.kernel.org>; Fri, 15 Mar 2013 19:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=nshUzWLvulnBh4RStzR/lXwZ/ktWLcl8UZzpMtiVFs0=;
        b=RMc3Tj/azpWjVhKWc8Ue/NyLKIfkLcOliEV5m7d/HbrLKv6qjdw8mHsSsdWZ2djWRW
         iIcJtRO6m4JI64FxW8wDpzHYudsQYhKqUnLXW/y49l8f7bgTzbcxmLSN5Z5rAbZfIoVu
         j6g5Y2UQYeHGFwpLYNDOeBjngFody7FSDsBnI3Zavzpq4ytnargGM9MXICZ3hlIBm0c7
         c3G3T76v+nnz2nwxPQj8xMMkF4qPczedzaI7jaiS1pIYGsDGGhS2axVbCHKNbL0Y+Tkf
         NGI7n2Z33isygkg0e8XdgiK9OkUvtQzXBw9T6uzCm82Yuqm/lxlT70u6dwLfey03+IfV
         NTVQ==
X-Received: by 10.68.11.135 with SMTP id q7mr21196518pbb.5.1363400692135;
        Fri, 15 Mar 2013 19:24:52 -0700 (PDT)
Received: from lanh ([115.74.58.84])
        by mx.google.com with ESMTPS id qp13sm11519550pbb.3.2013.03.15.19.24.48
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 15 Mar 2013 19:24:51 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 16 Mar 2013 09:24:45 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218285>

This series was ejected out of pu some time ago due to gcc warnings. I
did not have time to look at it (and it worked ok for me so it was not
a pressing matter). This re-roll should fix that.

=46or demonstration, try

git log --pretty=3D'format:%C(auto)%h %<(80,trunc)%s%>>(10,ltrunc)%C(au=
to)%d%>(15,mtrunc)% an'

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (12):
  pretty-formats.txt: wrap long lines
  pretty: share code between format_decoration and show_decorations
  utf8.c: move display_mode_esc_sequence_len() for use by other functio=
ns
  utf8.c: add utf8_strnwidth() with the ability to skip ansi sequences
  pretty: save commit encoding from logmsg_reencode if the caller needs=
 it
  pretty: get the correct encoding for --pretty:format=3D%e
  utf8: keep NULs in reencode_string()
  pretty: two phase conversion for non utf-8 commits
  pretty: add %C(auto) for auto-coloring on the next placeholder
  pretty: support padding placeholders, %< %> and %><
  pretty: support truncating in %>, %< and %><
  pretty: support %>> that steal trailing spaces

 Documentation/pretty-formats.txt |  34 ++++-
 builtin/blame.c                  |   2 +-
 builtin/commit.c                 |   2 +-
 builtin/fast-export.c            |   3 +-
 builtin/mailinfo.c               |   3 +-
 commit.h                         |   1 +
 compat/precompose_utf8.c         |   2 +-
 log-tree.c                       |  60 +++++----
 log-tree.h                       |   3 +
 notes.c                          |   4 +-
 pretty.c                         | 282 +++++++++++++++++++++++++++++++=
+++-----
 revision.c                       |   2 +-
 sequencer.c                      |   5 +-
 t/t4207-log-decoration-colors.sh |   8 +-
 t/t6006-rev-list-format.sh       |  12 +-
 utf8.c                           | 104 +++++++++++----
 utf8.h                           |  14 +-
 17 files changed, 434 insertions(+), 107 deletions(-)

--=20
1.8.2.83.gc99314b
