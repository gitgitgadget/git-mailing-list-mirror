From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/6] Advanced --oneline layout
Date: Sat, 22 Sep 2012 11:22:13 +0700
Message-ID: <1348287739-12128-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 22 06:23:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFHFQ-0003ew-6D
	for gcvg-git-2@plane.gmane.org; Sat, 22 Sep 2012 06:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146Ab2IVEWl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Sep 2012 00:22:41 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61105 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546Ab2IVEWM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2012 00:22:12 -0400
Received: by pbbrr4 with SMTP id rr4so3905556pbb.19
        for <git@vger.kernel.org>; Fri, 21 Sep 2012 21:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=eZCbIJfioR0PxpuI8jIICn7IhYnJv06uGm3uQCkR8Tw=;
        b=jtdCGwRIpuZOy9G57znmIu/vWXhG7y8iSLU8Ezz4bqOkd2EVYNHg6IqDgldDaOxXNg
         7J0gREvW52abqiu1GXvBc0moRpIYkdLH1XgwAexPErTdd97srGJ+fg5Z9B4A2HAcldLj
         Z+SZxRQlHSAh/Qh8/hYipo9MyqNpP2KYeYr2biIXgiXhoQ/USUfy+gLhFl0gTA0KHtlj
         55HrU0kMzqgxV5O0FAC2gGoJ4GwX1mk9Zv/xLw12xMVufcJGIZ7/YJTg7xPjab8I0Gpo
         VWpF0X6SFRYGrXQltsuECmTQcmOKwaUOGIkO38tvLJImLVmMgxwH9bdJj8iOPk/1AICP
         p/Fg==
Received: by 10.68.234.98 with SMTP id ud2mr20181671pbc.165.1348287731668;
        Fri, 21 Sep 2012 21:22:11 -0700 (PDT)
Received: from lanh ([115.74.43.144])
        by mx.google.com with ESMTPS id st6sm6091527pbc.58.2012.09.21.21.22.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 21 Sep 2012 21:22:11 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 22 Sep 2012 11:22:22 +0700
X-Mailer: git-send-email 1.7.12.1.384.g7b808e7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206185>

Still a toy series (previous discussion [1]) but it's getting close to
something useful.

This introduces three placeholders %<, %> and %<> for
left/right/center align the next placeholder. Any of them can be
followed by '|' to make the next placeholder use up to the Nth column.

It's pretty useful already. You should be able to do multi column
layout on your wiiide terminal. It might even be useful in multi-line
printouts (e.g. we can relayout the commit header)

There are a few things we can improve:

 - utf8-only support does not sound nice (even though I'm
   perfectly happy with it). At some point I think it'll be easier for
   us to declare all internal strings be in utf8 (or ascii in certain
   places), input/output routines are supposed to do the conversion.
   GNOME has gone this way since 2.0.
 - ellipsis to prevent too long text breaking layout
 - specifing "30% of my screen width" would be nice, but it could get
   complicated if users start to demand "30% width, but no less than 30
   columns and no more than 100 columns, and if blah blah"

[1] http://thread.gmane.org/gmane.comp.version-control.git/205922/focus=
=3D206049

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (6):
  pretty: share code between format_decoration and show_decorations
  pretty: split parsing %C into a separate function
  pretty: support %C(auto[,N]) to turn on coloring on next
    placeholder(s)
  utf8.c: move display_mode_esc_sequence_len() for use by other
    functions
  utf8.c: add utf8_strnwidth() with the ability to skip ansi sequences
  pretty: support padding placeholders, %< %> and %<>

 Documentation/pretty-formats.txt |   5 +
 log-tree.c                       |  59 ++++++-----
 log-tree.h                       |   3 +
 pretty.c                         | 211 +++++++++++++++++++++++++++++++=
--------
 t/t4207-log-decoration-colors.sh |   8 +-
 utf8.c                           |  48 +++++----
 utf8.h                           |   1 +
 7 files changed, 244 insertions(+), 91 deletions(-)

--=20
1.7.12.1.384.g7b808e7
