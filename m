From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH 0/8] gitweb: Highlight interesting parts of diff
Date: Fri, 10 Feb 2012 10:18:06 +0100
Message-ID: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 10:19:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvmdA-0005f5-Oi
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 10:19:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758662Ab2BJJSX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 04:18:23 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:42215 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765Ab2BJJST (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 04:18:19 -0500
Received: by eekc14 with SMTP id c14so882729eek.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 01:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=7HECwqdrxqWMICH8ExALkJLZd2pR+a753m4BGG+cNvQ=;
        b=w7z61/i942vmsWGQICAN5xIUWsMKoyP5CZniaGOM7Uqrj0HOLoE9wvoTsziggYtxab
         UdLyWqKxzFP4arZNmfDBK4G1ngRQGx35JnnyiYco7ZzVMSDVEI5DOU0eTO8he/SpCY1J
         6N5KF217uOMvvmQBOFOH7AApkJZPLP71VSyTc=
Received: by 10.213.3.5 with SMTP id 5mr228057ebl.91.1328865498549;
        Fri, 10 Feb 2012 01:18:18 -0800 (PST)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id o49sm20034389eei.0.2012.02.10.01.18.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Feb 2012 01:18:18 -0800 (PST)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190394>

Reading diff output is sometimes very hard, even if it's colored,
especially if lines differ only in few characters. This is often true w=
hen
a commit fixes a typo or renames some variables or functions.

This patch series teaches gitweb to highlight fragments that are differ=
ent
between old and new line. This should mimic the same feature in Trac or
GitHub.

To achieve that, added and removed lines must be accumulated and compar=
ed.
The current code in print_sidebyside_diff_chunk() already does this, so
this patch series reuses it in commits:

  gitweb: Extract print_sidebyside_diff_lines()
  gitweb: Use print_diff_chunk() for both side-by-side and inline diffs

Next, HTML-formatting diff lines is pushed down to the place where they
are about to be printed. This is required because comparision must be
performened on raw git-diff output and not on HTML-formatted lines. Thi=
s
is done in commits:

  gitweb: Move HTML-formatting diff line back to process_diff_line()
  gitweb: Push formatting diff lines to print_diff_chunk()
  gitweb: Format diff lines just before printing

The last three commits implement the advertised feature. They could be
squashed together but that would make them harder to review (I think).

  gitweb: Highlight interesting parts of diff
  gitweb: Use different colors to present marked changes
  gitweb: Highlight combined diffs

This series is based on v1.7.9.

Micha=C5=82 Kiedrowicz (8):
  gitweb: Extract print_sidebyside_diff_lines()
  gitweb: Use print_diff_chunk() for both side-by-side and inline diffs
  gitweb: Move HTML-formatting diff line back to process_diff_line()
  gitweb: Push formatting diff lines to print_diff_chunk()
  gitweb: Format diff lines just before printing
  gitweb: Highlight interesting parts of diff
  gitweb: Use different colors to present marked changes
  gitweb: Highlight combined diffs

 gitweb/gitweb.perl       |  304 +++++++++++++++++++++++++++++++++++---=
--------
 gitweb/static/gitweb.css |    8 ++
 2 files changed, 238 insertions(+), 74 deletions(-)

--=20
1.7.3.4
