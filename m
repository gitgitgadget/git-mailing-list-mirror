From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH] Fix over-simplified documentation for 'git log -z'
Date: Mon, 23 Nov 2009 08:40:24 +0100
Message-ID: <4B0A3C68.3010000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 23 08:40:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCTXG-0004BA-ID
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 08:40:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754875AbZKWHkV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Nov 2009 02:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752884AbZKWHkV
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 02:40:21 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:52166 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752804AbZKWHkU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 02:40:20 -0500
Received: by ewy19 with SMTP id 19so1542458ewy.21
        for <git@vger.kernel.org>; Sun, 22 Nov 2009 23:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=ribRoSQHm9yoCes+fsvwnOcNYhTRlaYCYrK/f8Ab8VQ=;
        b=SKLK8JHEw11hsdXJAMUTtypMZ0FmA1lTiLI1ow3RFvdwNO5O0fEz1GN7gZ/zllVizm
         TA1tLIRa1BzlR06H110X+c0tLhZ8swYGgdd4DRnYqjceob9dfKma3qMhfpa/W6Le9lXk
         MmyO9/3ntiBPoF5TB3pO4tOhnCs36M8koFDWA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=VwNxQEFLJsiOOXP7SGpinfPBZn23yAFXGvGZNGlXTT6n6zDFUajf8z1aL+Nez/bJrY
         dmhTxV6ksmB5esBtQKmh41wZWL9P6XaRSZi+3BkZyVQapq5tRlULvPxr9quYwaBDiHZK
         rUMxOe9kf2cGahtYbjQ4TbWeYzGDx6aaHrH1I=
Received: by 10.216.90.65 with SMTP id d43mr1500635wef.41.1258962025705;
        Sun, 22 Nov 2009 23:40:25 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 5sm582839eyf.0.2009.11.22.23.40.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Nov 2009 23:40:25 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133487>

In commit 64485b4a, the documentation for 'git log -z' was
simplified too much. The -z option actually changes the behavior
of 'git log' in two ways: commits will be ended with a NUL
instead of a LF (correctly documented) and the --raw and
--numstat will have NUL as field terminators (omitted in
the documentation for 'git log').

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
I wrongly assumed that 'git log' ignores the --raw
and --numstat options, because I tested it in a repository
with only merge commits. They do have an effect for
plain commits, and consequently -z will modify their
behavior for 'git log' too.

This patch applies on 'next'.

 Documentation/diff-options.txt |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-option=
s.txt
index 18366b1..8707d0e 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -87,19 +87,21 @@ endif::git-format-patch[]
 ifndef::git-format-patch[]
=20
 -z::
+ifdef::git-log[]
+	Separate the commits with NULs instead of with new newlines.
++
+Also, when `--raw` or `--numstat` has been given, do not munge
+pathnames and use NULs as output field terminators.
+endif::git-log[]
 ifndef::git-log[]
 	When `--raw` or `--numstat` has been given, do not munge
 	pathnames and use NULs as output field terminators.
+endif::git-log[]
 +
 Without this option, each pathname output will have TAB, LF, double qu=
otes,
 and backslash characters replaced with `\t`, `\n`, `\"`, and `\\`,
 respectively, and the pathname will be enclosed in double quotes if
 any of those replacements occurred.
-endif::git-log[]
-
-ifdef::git-log[]
-	Separate the commits with NULs instead of with new newlines.
-endif::git-log[]
=20
 --name-only::
 	Show only names of changed files.
--=20
1.6.5.3.298.g39add
