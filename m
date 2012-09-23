From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 0/9] Advanced --oneline layout
Date: Sun, 23 Sep 2012 16:10:24 +0700
Message-ID: <1348391433-11300-1-git-send-email-pclouds@gmail.com>
References: <1348287739-12128-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 23 11:17:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFiJc-00015h-8P
	for gcvg-git-2@plane.gmane.org; Sun, 23 Sep 2012 11:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753228Ab2IWJRT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Sep 2012 05:17:19 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35801 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752964Ab2IWJRS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2012 05:17:18 -0400
Received: by pbbrr4 with SMTP id rr4so5429111pbb.19
        for <git@vger.kernel.org>; Sun, 23 Sep 2012 02:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=zRht5xmOPfJVdy5sAtUP7S87EparMRULDyXgWmwbXr8=;
        b=HVEABSmYkMtUAPOeuCTqPZAlrKpFn8Yea4cETC19qp6j0OSYTHAMeIH87OQenT1izW
         wZfMWzTT+8HFuabyPrQESrYKLMhFoz4sPjG8f3qR33M04CgDz2W+hch8mAJ/UJ6qXy3k
         PByNwoxkjotA0fKGWgwd5VCFZM9+enizVY7vms0gusA4ehkoZ2aZWUTdy4yjfvf6+lp0
         NE7dQFmRJHD3XfNJnT8BuGjKXLyPd2c5+40ddiDIq1Y6mJLSvy/fRJ18PyH9CKfJbTWY
         rHG7uOxraKGWxur3cMVD5dVsIeHUBYQ7/sMiCwPG+702t6QzKEQbv80t807IfqD0W6Zc
         ouag==
Received: by 10.68.216.131 with SMTP id oq3mr50670pbc.147.1348391837748;
        Sun, 23 Sep 2012 02:17:17 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.47.110])
        by mx.google.com with ESMTPS id x8sm467635paw.16.2012.09.23.02.17.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 23 Sep 2012 02:17:17 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 23 Sep 2012 16:10:35 +0700
X-Mailer: git-send-email 1.7.12.1.406.g6ab07c4
In-Reply-To: <1348287739-12128-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206225>

The series is now feature complete from my usage pov. The syntax may
change though. No tests yet until we agree on the syntax and semantics.
Summary:

 - %C(auto) turns on coloring for the next placeholder
 - %C(auto,N) the same on the next N placeholders
 - %<(W) makes sure the next placeholder takes W columns, left aligned
 - %>(W) like %< but right aligned
 - %><(W) like %< but centered
 - %>|(W), %<|(W), %><|(W) are similar, except that W is calculated
   to reach the Nth column on screen. (We might want %>|< instead of
   %><|)
 - %>>(W) like %>(W) but it will try to steal trailing spaces if the
   placeholder uses more than "W" columns. Very useful in "%<%>"
   combination where the last placeholder may leave a lot of spaces
   unused
 - All the above may take trunc, ltrunc, mtrunc optios in the bracket
   to truncate the result string if exceeds the given width. It
   truncates on the right, left and middle respectively.
 - No support for $COLUMNS. If you want to fit your screen, bash's
   $(()) syntax is your friend to calculate columns.
 - We might want to support %<direction>(W,N), e.g. %<(40,3), where
   the next N placeholders are grouped and aligned together as a
   single placeholder.

Show off time:

6ab07c4 pretty: support %>> that steal trailing spaces     (HEAD, lanh/=
prettier) Nguy=E1=BB=85n..g=E1=BB=8Dc Duy
ee1c10e pretty: support truncating in %>, %< and %><                   =
          Nguy=E1=BB=85n..g=E1=BB=8Dc Duy
77aefae pretty: support padding placeholders, %< %> and %><            =
          Nguy=E1=BB=85n..g=E1=BB=8Dc Duy
8f81f6b pretty: two phase conversion for non utf-8 commits             =
          Nguy=E1=BB=85n..g=E1=BB=8Dc Duy
c3f1243 utf8.c: add utf8_strnwidth() with the ability to skip ansi sequ=
ences     Nguy=E1=BB=85n..g=E1=BB=8Dc Duy
1a4e9bb utf8.c: move display_mode_esc_sequence_len() for use by other f=
unctions  Nguy=E1=BB=85n..g=E1=BB=8Dc Duy
99aa0c2 pretty: support %C(auto[,N]) to turn on coloring on next placeh=
older(s)  Nguy=E1=BB=85n..g=E1=BB=8Dc Duy
1feaab6 pretty: split parsing %C into a separate function              =
          Nguy=E1=BB=85n..g=E1=BB=8Dc Duy
b2676ac pretty: share code between format_decoration and show_decoratio=
ns        Nguy=E1=BB=85n..g=E1=BB=8Dc Duy
6bdccbe graph: avoid infinite loop in graph_show_commit()              =
          Nguy=E1=BB=85n..g=E1=BB=8Dc Duy
16eed7c Merge branch 'mh/fetch-filter-refs'                      (origi=
n/master)  Junio C Hamano

Produced with "%C(auto,99)%h %<|(80,trunc)%s%>>|(80)%d%>(15,mtrunc)% an=
"

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (9):
  pretty: share code between format_decoration and show_decorations
  pretty: split parsing %C into a separate function
  pretty: support %C(auto[,N]) to turn on coloring on next placeholder(=
s)
  utf8.c: move display_mode_esc_sequence_len() for use by other functio=
ns
  utf8.c: add utf8_strnwidth() with the ability to skip ansi sequences
  pretty: two phase conversion for non utf-8 commits
  pretty: support padding placeholders, %< %> and %><
  pretty: support truncating in %>, %< and %><
  pretty: support %>> that steal trailing spaces

 Documentation/pretty-formats.txt |   7 +
 log-tree.c                       |  60 ++++---
 log-tree.h                       |   3 +
 pretty.c                         | 327 +++++++++++++++++++++++++++++++=
+-------
 t/t4207-log-decoration-colors.sh |   8 +-
 t/t6006-rev-list-format.sh       |  16 +-
 t/t6006/commit-msg.iso8859-1     |   5 +
 utf8.c                           |  94 ++++++++---
 utf8.h                           |   4 +
 9 files changed, 412 insertions(+), 112 deletions(-)
 create mode 100644 t/t6006/commit-msg.iso8859-1

--=20
1.7.12.1.406.g6ab07c4
