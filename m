From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 00/13] nd/pretty-formats
Date: Tue, 16 Apr 2013 18:24:49 +1000
Message-ID: <1366100702-31745-1-git-send-email-pclouds@gmail.com>
References: <1364636112-15065-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 16 10:25:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US1Cj-0004je-Ey
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 10:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935631Ab3DPIZW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Apr 2013 04:25:22 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:44588 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932147Ab3DPIZU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 04:25:20 -0400
Received: by mail-pd0-f180.google.com with SMTP id q11so165005pdj.39
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 01:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=XPadqIEf4ryQl+QToCY2GrDAknxOwzPYx/6v6e/osFo=;
        b=G7RECzR58E+y5XN2G28LsUTP3wIozXj5vl83WzGw28Tek/DHX6EP/wXGfJvQoyI7nV
         WuLMkpMsLFyFNFxoSgBpsTujvKccbrJhaKQ35I6KZRIu745GTzWynesGK2CVGp1ZFckd
         pc9n1HD1JHDRGJ7FbwKb+68vju0b/0BvraiuerPWNYlO7GDJCa8i2x71EG6Gq3kcp8UF
         dSl7drUXBr0mO+0Tgrh476JbDm88mgGwh4k66gw25R5c5fBHYZ6l+8SKfd9hv2yqaFKR
         rvttDTfj9V8XceVlRRpF3d28ZFvzwOcuwaTDa8Zdpx4sSRnlktIkVcb7HoKAbiELOQx7
         OEgQ==
X-Received: by 10.66.163.101 with SMTP id yh5mr2365093pab.22.1366100719733;
        Tue, 16 Apr 2013 01:25:19 -0700 (PDT)
Received: from pclouds@gmail.com (xinyep.lnk.telstra.net. [110.143.18.114])
        by mx.google.com with ESMTPS id w8sm1202888pbt.17.2013.04.16.01.25.15
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 16 Apr 2013 01:25:18 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 16 Apr 2013 18:25:05 +1000
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1364636112-15065-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221379>

I've been updating this series on and off over a long span of time, I
don't think I remember exactly what changes I've made. But basically
I think I have covered all comments from v2. The only semantics change
is %C(auto) now turns auto coloring on for all following placeholders
until another valid %C is encountered.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (13):
  pretty: save commit encoding from logmsg_reencode if the caller needs=
 it
  pretty: get the correct encoding for --pretty:format=3D%e
  pretty-formats.txt: wrap long lines
  pretty: share code between format_decoration and show_decorations
  utf8.c: move display_mode_esc_sequence_len() for use by other functio=
ns
  utf8.c: add utf8_strnwidth() with the ability to skip ansi sequences
  utf8.c: add reencode_string_len() that can handle NULs in string
  pretty: two phase conversion for non utf-8 commits
  pretty: split color parsing into a separate function
  pretty: add %C(auto) for auto-coloring
  pretty: support padding placeholders, %< %> and %><
  pretty: support truncating in %>, %< and %><
  pretty: support %>> that steal trailing spaces

 Documentation/pretty-formats.txt |  35 +++-
 builtin/blame.c                  |   2 +-
 builtin/commit.c                 |   2 +-
 commit.h                         |   1 +
 compat/precompose_utf8.c         |   2 +-
 log-tree.c                       |  48 ++++--
 log-tree.h                       |   1 +
 pretty.c                         | 349 +++++++++++++++++++++++++++++++=
+-------
 revision.c                       |   2 +-
 t/t4205-log-pretty-formats.sh    | 179 ++++++++++++++++++++
 t/t4207-log-decoration-colors.sh |   8 +-
 t/t6006-rev-list-format.sh       |  12 +-
 utf8.c                           | 104 +++++++++---
 utf8.h                           |  23 ++-
 14 files changed, 644 insertions(+), 124 deletions(-)

--=20
1.8.2.82.gc24b958
